defmodule Db.Statements do
  @insert_query "INSERT INTO hosts (id, memory, stage_number, reference) VALUES (?1, ?2, ?3, ?4);"
  @pull_query "SELECT * FROM hosts WHERE id = ?1;"


  @spec new_node_statement(reference()) :: {:ok, reference()}
  def new_node_statement(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @insert_query)
    {:ok, statement}
  end

  @spec get_node_statement(reference()) :: {:ok, reference()}
  def get_node_statement(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @pull_query)
    {:ok, statement}
  end


  @spec exec_statement(reference(), reference(), nil | list()) :: :ok
  def exec_statement(conn, statement, params) do
    :ok = Exqlite.Sqlite3.bind(conn, statement, params)
  end

end
