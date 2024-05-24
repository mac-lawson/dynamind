defmodule EECOM do
  @moduledoc """
  EECOM (named for the NASA mission controller position) sets up and recognizes the local and remote systems' environment.
  This module provides functions to retrieve system architecture and memory information.
  """

  @doc """
  Returns the system architecture as a charlist.

  This function retrieves the system architecture information from the Erlang runtime system.
  """
  @spec architecture() :: charlist()
  def architecture do
    :erlang.system_info(:system_architecture)
  end

  @doc """
  Returns the system memory information as a string.

  This function ensures that the `:os_mon` application is started, which is necessary to access system memory data. 
  It then retrieves and returns the system memory data using `:memsup.get_system_memory_data()`.
  """
  @spec sysmemory() :: tuple()
  def sysmemory do
    case Application.ensure_all_started(:os_mon) do
      {:ok, _} -> :memsup.get_system_memory_data()
      {:error, reason} -> {:error, reason}
    end
  end
end

