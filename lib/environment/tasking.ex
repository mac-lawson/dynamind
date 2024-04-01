defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes.

  """
  import EnvironmentUtils
  import Db.Management
  import Db.Utils

  def intake do
    {:ok, conn} = db_connect()
    for remote_host <- ConfigFileToArray.read_default_config() do
      # :mem = memory_freeMB()
      insert(conn, remote_host, 0, 0)
    end
  end

end
