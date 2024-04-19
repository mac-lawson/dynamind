defmodule Agent.Monitor do
  @moduledoc """
  Agent.Monitor
    The Agent.Monitor module is responsible for monitoring the agents registered in the database.
  """

  # import Db.Utils

  @spec monitor(reference()) :: :ok
  def monitor(conn) do
    {:done, values} = Db.Utils.pull_all(conn)

    Enum.each(values, fn [id, memory, stage_number, _node, ping] ->
      if ping == :ping do
        DynaMind.Logger.log("INFO", "Node #{id} is alive, making a connection")
        Db.Utils.insert(conn, id, memory, stage_number)
        Node.ping(String.to_atom(id))
      else
        # Log an error connecting to the node, append the errors list. 
        DynaMind.Logger.log("INFO", "Node #{id} is dead, cannot connect")
      end
    end)
  end

  @spec monitor(reference(), reference()) :: :ok
  def monitor(conn, statement) do
    :ok = Exqlite.Sqlite3.execute(conn, statement)
  end

  @spec ping_node(any()) :: atom()
  def ping_node(id) do
    Node.ping(id)
  end

  @spec is_node_alive(any()) :: boolean()
  def is_node_alive(id) do
    if ping_node(id) == :pong do
      true
    else
      false
    end
  end
end
