defmodule Agent.Monitor do
  @moduledoc """
  Agent.Monitor
    The Agent.Monitor module is responsible for monitoring the agents registered in the database.
  """
  import Db.Utils

  @spec monitor(reference()) :: :ok
  def monitor(conn) do
    :ok = Exqlite.Sqlite3.execute(conn, "SELECT * FROM hosts;")
  end

  @spec monitor(reference(), reference()) :: :ok
  def monitor(conn, statement) do
    :ok = Exqlite.Sqlite3.execute(conn, statement)
  end

  @spec ping_node(reference(), any()) :: :ok
  def ping_node(conn, id) do
    get(conn, id)
  end
end
