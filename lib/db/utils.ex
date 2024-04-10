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

# TODO
#     Issue: line 56, cannot convert the map "work_reqs" to a string
@deprecated "do not use, still working on"
def insert_module_data(work_reqs, memory, stage_number, reference, uptime, functions_assigned, table_name) do
  {:ok, conn} = db_connect(2)
  work_reqs_string = to_string(inspect(Map.to_list(work_reqs)))
  {:ok, statement} = Exqlite.Sqlite3.prepare(
    conn,
    "INSERT INTO #{String.replace(to_string(table_name), ".", "_")} (work_reqs, memory, stage_number, reference, uptime, functions_assigned) VALUES (?1, ?2, ?3, ?4, ?5, ?6)"
  )
  :ok = Exqlite.Sqlite3.bind(
    conn,
    statement,
    [work_reqs_string, to_string(memory), stage_number, to_string(reference), to_string(uptime), to_string(functions_assigned)]
  )
  Exqlite.Sqlite3.step(conn, statement)
end

end
