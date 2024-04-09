defmodule Db.Utils do
  @pull_all_query "SELECT * FROM hosts;"

  import Db.Statements

  @spec insert(reference(), any(), any(), any()) :: :done
  def insert(conn, id, memory, stage_number) do
    {:ok, statement} = new_node_statement(conn)

    :ok =
      Exqlite.Sqlite3.bind(conn, statement, [
        id,
        memory,
        stage_number,
        Node.connect(id),
        Node.ping(id)
      ])

    :done = Exqlite.Sqlite3.step(conn, statement)
  end

  @spec get(reference(), any()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
  def get(conn, id) do
    {:ok, statement} = get_node_statement(conn)
    :ok = Exqlite.Sqlite3.bind(conn, statement, [id])
    Exqlite.Sqlite3.step(conn, statement)
  end

  @spec pull_all(reference()) :: :busy | :done | {:error, atom() | binary()} | {:row, list()}
  def pull_all(conn) do
    {:ok, statement} = Exqlite.Sqlite3.prepare(conn, @pull_all_query)
    Exqlite.Sqlite3.step(conn, statement)
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
end
