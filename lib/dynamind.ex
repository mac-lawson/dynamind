defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.
  """
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
end
