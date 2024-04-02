defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes.

  """
  # import EnvironmentUtils
  import Db.Management
  import Db.Utils
  import SampleModels.Tensor
  import Logger
  
  @spec tasking_reqs() :: map()
  defp tasking_reqs do
    %{:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  end

  def intake do
    info("Intake running, trying to connecting to database")
    try do
      {:ok, conn} = db_connect()
      info("Connected to database")
      for remote_host <- Utils.ConfigFileToArray.read_default_config() do
        {_x, _y, task} = make_a_tensor()
        warning("Host added to schema: #{remote_host}")
        {:ok, stage} = Map.fetch(tasking_reqs(), task)
        insert(conn, remote_host, 0, stage)
      end

    rescue
      e in Exqlite.Sqlite3.Error -> 
        log("ERROR", "Error connecting to database: #{inspect(e)}")
    end
  end

  def assign_functions_to_nodes do
  end

  def verify_uptime do
    {:ok, conn} = db_connect()
    get_uptime(conn, "test@testhost.org")
  end


  def test_uptime do
    {:ok, conn} = db_connect()
    update_uptime(conn, "test@testhost.org", 100)
  end


end
