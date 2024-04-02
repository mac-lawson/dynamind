defmodule Agent.Monitor do
  @moduledoc """
  Agent.Monitor
    The Agent.Monitor module is responsible for monitoring the agents registered in the database.
  """
  #import Db.Utils

  @spec monitor(reference()) :: :ok
  def monitor(conn) do
    :ok = Exqlite.Sqlite3.execute(conn, "SELECT * FROM hosts;")
  end

  @spec monitor(reference(), reference()) :: :ok
  def monitor(conn, statement) do
    :ok = Exqlite.Sqlite3.execute(conn, statement)
  end

  @spec ping_node(any()) :: :ok
  def ping_node(id) do
    Node.ping(id)
  end

  @spec is_node_alive(any()) :: boolean()
  def is_node_alive(id) do
    {result} = ping_node(id)
    if result == :pong do
      true
    else
      false
    end
  end
end
