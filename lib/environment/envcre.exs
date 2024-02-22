defmodule EECOM do
  @moduledoc """
  EECOM (named for the NASA mission controller position) sets up and recognizes the local and remote systems' environment
  """

  @spec architecture() :: String.t()
  def architecture do
    :erlang.system_info(:system_architecture)
  end

  def free_memory do
    Application.ensure_all_started(:os_mon)
    :memsup.get_system_memory_data
  end

  @spec network_connections() :: [Map.t()]
  def network_connections do
    :inet.i4_list_connections()
  end
end
