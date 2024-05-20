defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.
  """
  alias TCP.TCPServer
  @type arguments :: [String.t()]

  require Logger
  require OptionParser
  @spec init() :: :ok
  def init() do
    Utils.Ascii.main_header("DYNAMIND")
    Logger.info("Dynamind starting up")
    Logger.warning("Initializing Databases...")
    Db.Management.db_init()
    Logger.warning("Reading from config file... (config.dynm)")
    Tasking.intake()
    Logger.info("Opening configuration file")
  end

  def init_test() do
    OptionParser.parse(System.argv())
    |> IO.inspect()
  end

  @doc """
  Mainly for testing. Runs the built in TCP server.

  Port is hardcoded to 4444.
  """
  @spec run_tcp_server() :: :ok
  def run_tcp_server() do
    TCPServer.start(4444)
  end
end
