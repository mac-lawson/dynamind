defmodule Db.Utils do
  @pull_all_query "SELECT * FROM hosts;"

  import Db.Statements
  import Db.Management

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
  Pulls the row for a specific host ID (i.e "test@testhost.org")
  {:row, ["test3@testhost.org", "0", 1, "ignored", "pang"]}
  """
  @spec get(reference(), any()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
  def get(conn, id) do
    {:ok, statement} = get_node_statement(conn)
    :ok = Exqlite.Sqlite3.bind(conn, statement, [id])
    Exqlite.Sqlite3.step(conn, statement)
  end

  # allows for the fetching of all rows from a statement, not just one
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

@doc """
 Pulls all rows from the hosts table. 
    {:done,
 [
   ["test@testhost.org", "0", 1, "ignored", "pang"],
   ["test1@testhost.org", "0", 1, "ignored", "pang"],
   ["test3@testhost.org", "0", 1, "ignored", "pang"]
 ]}
"""
@spec pull_all(reference()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
def pull_all(conn) do
  {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @pull_all_query)
  
  rows = fetch_all_rows(conn, statement, [])
  
  # Close the statement to release resources
  Exqlite.Sqlite3.step(conn, statement)
    Exqlite.Sqlite3.release(conn, statement)
  rows
end

  @spec update_uptime(reference(), any(), any()) :: :done
  def update_uptime(conn, id, uptime) do
    {:ok, statement} = set_uptime_statement(conn)
    Exqlite.Sqlite3.bind(conn, statement, [uptime, id])
    Exqlite.Sqlite3.step(conn, statement)
  end

  @spec get_uptime(reference(), any()) :: {:row, list()}
  def get_uptime(conn, id) do
    {:ok, statement} = get_uptime_statement(conn)
    :ok = Exqlite.Sqlite3.bind(conn, statement, [id])
    {:row, _data} = Exqlite.Sqlite3.step(conn, statement)
  end

# TODO
  # Need to re-integrate this back to the Db.Statements module. Fix the table issue.
def insert_module_data(func_name, work_req, memory, stage_num, reference, module_name) do
  {:ok, conn} = db_connect(2)
    # insert_query_module = "INSERT INTO Elixir_SampleModels_Tensor (function_name, work_req, memory, stage_number, reference) VALUES (?1, ?2, ?3, ?4, ?5)"
  {:ok, statement} = create_module_query(conn, module_name)
  Exqlite.Sqlite3.bind(conn, statement, [func_name, work_req, memory, stage_num, reference |> to_string()])
  Exqlite.Sqlite3.step(conn, statement)
end

# Takes a string and removes the "." and appends the front with "Elixir_"
  # TODO - Future item, remove the use of the "Elixir_" prefix from all Database tables.
@spec proper_module_table_name(binary()) :: binary()
defp proper_module_table_name(module_name) do
  String.replace(module_name, ".", "_")
end

# TODO
  # Need to clean this up
def insert_module_data(module_process_result, module_name) do
  for {key, value} <- module_process_result do
      if is_tuple(value) do
        value = Tuple.to_list(value)
        value |> IO.inspect()

        insert_module_data(key, List.last(value), 0, 0, key, proper_module_table_name(module_name))

        
      else
        value |> IO.inspect()
            insert_module_data(key, value, 0, 0, key, proper_module_table_name(module_name))
      
      end 
  end
end

end
