defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.
  """
  require Logger

@spec init() :: :ok
def init() do
    Logger.info("Dynamind starting up")
    Db.Management.db_init()
    Db.Management.db_init(SampleModels.Tensor)
    Tasking.intake()
end
end
