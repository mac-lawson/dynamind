defmodule DynaMind.SystemInfo do
  @moduledoc """
  Module for checking system architecture and memory.
  """

  @doc """
  Get the system architecture.
  """
  def architecture do
    :erlang.system_info(:system_architecture)
  end

  @doc """
  Get the total available memory in bytes.
  """
  def total_memory do
    :erlang.system_info(:total_memory)
  end

  @doc """
  Calculate the maximum number of agents that can be hosted based on memory.
  """
  def max_agents(memory_per_agent) do
    total_memory = total_memory()
    # Assuming memory_per_agent is in bytes
    max_agents = div(total_memory, memory_per_agent)
    max_agents
  end
end

