defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.

  ## Dynamind.init/0
  Required functionality:
  - Initialize databases
  - Read/import configuration file
  """
  @type arguments :: [String.t()]

  require Logger
  require OptionParser
  @spec init() :: :ok
  def init() do
    Logger.warning("Initializing Databases...")
    Db.Management.db_init()
    Logger.warning("Reading from config file... (config.dynm)")
    Tasking.intake()
    # Logger.warning(
    #  "\n\n\t\tDynamind is currently still in development and the init module has not been fully implemented."
    # )

    Logger.info("Opening configuration file")
  end

  def init_test() do
    OptionParser.parse(System.argv())
    |> IO.inspect()
  end
end
