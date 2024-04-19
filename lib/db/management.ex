defmodule Db.Management do
  @std_node_db_path "dynamind.db"
  @test_db_path "test.db"
  @std_func_db_path "functions.db"

  @spec db_init() :: :ok
  def db_init() do
    {:ok, conn} = open_conn(@std_node_db_path)

    node_db_std_setup(conn)
  end

  # TODO
  # Remove the prefix Elixir_ from the table name
  @spec db_init(module :: module()) :: :ok
  def db_init(module) do
    {:ok, conn} = open_conn(@std_func_db_path)

    function_db_std_setup(conn, module)
  end

  @doc """
  Options:
      1- Node database
      2 - Function database
  """
  @spec db_connect(integer()) :: {:ok, reference()} | {:error, reference()}
  def db_connect(type_of_db) do
    case type_of_db do
      1 -> open_conn(@std_node_db_path)
      2 -> open_conn(@std_func_db_path)
    end
  end

  @spec db_clear(reference(), integer()) :: :ok
  def db_clear(conn, type_db) do
    clear_db(conn, type_db)
  end

  @spec db_init_test() :: :ok
  def db_init_test do
    {:ok, conn_test} = open_conn(@test_db_path)
    node_db_std_setup(conn_test)
  end

  @moduledoc """
  Db.Management
    The Db.Management module is responsible for managing the database.
  """
  @spec open_conn(String.t()) :: {:ok, reference()} | {:error, reference()}
  defp open_conn(db_name) do
    {:ok, conn} = Exqlite.Sqlite3.open(db_name)
    {:ok, conn}
  end

  defp node_db_std_setup(conn) do
    :ok =
      Exqlite.Sqlite3.execute(conn, """
      CREATE TABLE IF NOT EXISTS hosts (
        id INT,
        memory VARCHAR(255),
        stage_number INT,
        reference VARCHAR(255),
        uptime VARCHAR(255),
        functions_assigned VARCHAR(255)
      );
      """)
  end

  @spec function_db_std_setup(reference(), module()) :: :ok
  defp function_db_std_setup(conn, module) do
    table_name = String.replace(to_string(module), ".", "_")

    sql_query = """
      CREATE TABLE IF NOT EXISTS #{table_name} (
        function_name VARCHAR(255),
        work_req VARCHAR(255),
        memory VARCHAR(255),
        stage_number INT,
        reference VARCHAR(255)
      );
    """

    case Exqlite.Sqlite3.execute(conn, sql_query) do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        IO.puts("Error creating table: #{reason}")

      other ->
        IO.puts("Unexpected result: #{inspect(other)}")
    end
  end

  defp clear_db(conn, type_db) do
    function_db_clear_query = """
    PRAGMA writable_schema = 1;
    DELETE FROM sqlite_master WHERE type='table' OR type='index';
    PRAGMA writable_schema = 0;
    VACUUM;
    """

    case type_db do
      1 -> Exqlite.Sqlite3.execute(conn, "DELETE FROM hosts;")
      2 -> Exqlite.Sqlite3.execute(conn, function_db_clear_query)
    end
  end
end
