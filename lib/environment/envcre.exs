defmodule EECOM do
  @moduledoc """
  EECOM (named for the NASA mission controller position) sets up and recognizes the local and remote systems' environment
  """

  @spec architecture() :: String.t()
  def architecture do
    :erlang.system_info(:system_architecture)
  end

  @spec sysmemory() :: String.t()
  def sysmemory do
    Application.ensure_all_started(:os_mon)
    :memsup.get_system_memory_data
  end
  
  @spec totalmemory() :: String.t()
  def totalmemory do
    :memsup.get_memory_data()
  end
end
