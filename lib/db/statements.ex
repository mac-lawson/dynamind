defmodule Db.Statements do
  @insert_query "INSERT INTO hosts (id, memory, stage_number, reference, uptime) VALUES (?1, ?2, ?3, ?4, ?5);"
  # @insert_query_module "INSERT INTO ?1 (function_name, work_req, memory, stage_number, reference) VALUES (?2, ?3, ?4, ?5, ?6);"
  @pull_query "SELECT * FROM hosts WHERE id = ?1;"
  @insert_uptime_query "UPDATE hosts SET uptime = ?1 WHERE id = ?2;"
  @pull_uptime_query "SELECT uptime FROM hosts WHERE id = ?1;"

  @spec new_node_statement(reference()) :: {:ok, reference()}
  def new_node_statement(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @insert_query)
    {:ok, statement}
  end

  def insert_query() do
    @insert_query
  end

  @spec get_node_statement(reference()) :: {:ok, reference()}
  def get_node_statement(conn) do
    Exqlite.Sqlite3.prepare(conn, @pull_query)
  end

  @spec exec_statement(reference(), reference(), nil | list()) :: :ok
  def exec_statement(conn, statement, params) do
    Exqlite.Sqlite3.bind(conn, statement, params)
  end

  @spec set_uptime_statement(reference()) :: {:ok, reference()}
  def set_uptime_statement(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @insert_uptime_query)
    {:ok, statement}
  end

  @spec get_uptime_statement(reference()) :: {:ok, reference()}
  def get_uptime_statement(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @pull_uptime_query)
    {:ok, statement}
  end

  def create_module_query(conn, module_name) do
    Exqlite.Sqlite3.prepare(
      conn,
      "INSERT INTO #{module_name} (function_name, work_req, memory, stage_number, reference) VALUES (?1, ?2, ?3, ?4, ?5);"
    )
  end

  def pull_module_query(conn, module_name) do
    Exqlite.Sqlite3.prepare(conn, "SELECT * FROM #{module_name};")
  end

  def pull_specific_function_from_module_query(conn, module_name) do
    Exqlite.Sqlite3.prepare(conn, "SELECT * FROM #{module_name} WHERE function_name = ?1;")
  end

  # TODO
  def pull_table_query(_table_name) do
    "SELECT name FROM sqlite_master WHERE type='table';"
  end
end
