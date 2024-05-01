defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.
  """
  require Logger
  @spec init() :: :ok
  def init() do
    Logger.info("Dynamind starting up")
    Logger.warning("Initializing Databases...")
    Db.Management.db_init()
    Logger.warning("Reading from config file... (config.dynm)")
    Tasking.intake()
    Logger.info("Opening configuration file")
  end
end
