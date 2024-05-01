defmodule Db.Utils do
  @pull_all_query "SELECT * FROM hosts;"

  import Db.Statements
  import Db.Management

  @doc """
  Inserts data into the database.
  """
  @spec insert(reference(), any(), any(), any()) :: :done
  def insert(conn, id, memory, stage_number) do
    {:ok, statement} = new_node_statement(conn)

    :ok =
      Exqlite.Sqlite3.bind(conn, statement, [
        id,
        memory,
        stage_number,
        Node.connect(String.to_atom(id)),
        Node.ping(String.to_atom(id))
      ])

    :done = Exqlite.Sqlite3.step(conn, statement)
  end

  @doc """
  Fetches a specific row for a given host ID.
  """
  @spec get(reference(), any()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
  def get(conn, id) do
    {:ok, statement} = get_node_statement(conn)
    :ok = Exqlite.Sqlite3.bind(conn, statement, [id])
    Exqlite.Sqlite3.step(conn, statement)
  end

  @doc """
  Pulls all rows from the hosts table.
  """
  @spec pull_all(reference()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
  def pull_all(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @pull_all_query)
    rows = fetch_all_rows(conn, statement, [])
    Exqlite.Sqlite3.release(conn, statement)
    rows
  end

  def pull_all_modules(conn) do
    {:ok, statement} =
      Exqlite.Sqlite3.prepare(conn, "SELECT name FROM sqlite_master WHERE type='table';")

    rows = fetch_all_rows(conn, statement, [])
    Exqlite.Sqlite3.release(conn, statement)
    rows
  end

  @doc """
  Dosen't work, something wrong with the map. 
  """
  def pull_all_module_data(conn) do
    {:done, modules} = pull_all_modules(conn)

    Enum.map(modules, fn {_, module_name} ->
      get_module_functions(conn, module_name)
    end)
  end

  @doc """
  Updates the uptime for a specific host.
  """
  @spec update_uptime(reference(), any(), any()) :: :done
  def update_uptime(conn, id, uptime) do
    {:ok, statement} = set_uptime_statement(conn)
    Exqlite.Sqlite3.bind(conn, statement, [uptime, id])
    Exqlite.Sqlite3.step(conn, statement)
  end

  @doc """
  Retrieves the uptime for a specific host.
  """
  @spec get_uptime(reference(), any()) :: {:row, list()}
  def get_uptime(conn, id) do
    {:ok, statement} = get_uptime_statement(conn)
    :ok = Exqlite.Sqlite3.bind(conn, statement, [id])
    {:row, _data} = Exqlite.Sqlite3.step(conn, statement)
  end

  @doc """
  Gets all the processed functions from a module. 
    {:done,
     [
   ["make_a_tensor", "1", "0", 0, "make_a_tensor"],
   ["model_creation", nil, "0", 0, "model_creation"]
  ]}
  """
  @spec get_module_functions(reference(), any()) :: {:done, list()}
  def get_module_functions(conn, module_name) do
    {:ok, statement} = pull_module_query(conn, proper_module_table_name(module_name))
    # Exqlite.Sqlite3.step(conn, statement)
    rows = fetch_all_rows(conn, statement, [])
    Exqlite.Sqlite3.release(conn, statement)
    rows
  end

  def get_function_from_module(conn, module_name, function_name) do
    {:ok, statement} =
      pull_specific_function_from_module_query(conn, proper_module_table_name(module_name))

    :ok = Exqlite.Sqlite3.bind(conn, statement, [function_name])
    # Exqlite.Sqlite3.step(conn, statement)
    rows = fetch_all_rows(conn, statement, [])
    Exqlite.Sqlite3.release(conn, statement)
    rows
  end

  def insert_module_data(func_name, work_req, memory, stage_num, reference, module_name) do
    {:ok, conn} = db_connect(2)

    # insert_query_module = "INSERT INTO Elixir_SampleModels_Tensor (function_name, work_req, memory, stage_number, reference) VALUES (?1, ?2, ?3, ?4, ?5)"
    {:ok, statement} = create_module_query(conn, module_name)

    Exqlite.Sqlite3.bind(conn, statement, [
      func_name,
      work_req,
      memory,
      stage_num,
      reference |> to_string()
    ])

    Exqlite.Sqlite3.step(conn, statement)
  end

  @doc """
  Inserts module data into the database.
  """
  def insert_module_data(module_process_result, module_name) do
    for {key, value} <- module_process_result do
      if is_tuple(value) do
        value = Tuple.to_list(value)
        value |> IO.inspect()

        insert_module_data(
          key,
          List.last(value),
          0,
          0,
          key,
          proper_module_table_name(module_name)
        )
      else
        value |> IO.inspect()
        insert_module_data(key, value, 0, 0, key, proper_module_table_name(module_name))
      end
    end
  end

  # Private functions

  defp proper_module_table_name(module_name) do
    String.replace(to_string(module_name), ".", "_")
  end

  defp fetch_all_rows(conn, statement, acc) do
    case Exqlite.Sqlite3.step(conn, statement) do
      {:row, row} ->
        fetch_all_rows(conn, statement, [row | acc])

      :done ->
        {:done, Enum.reverse(acc)}

      error ->
        error
    end
  end
end
