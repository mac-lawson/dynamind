defmodule EnvironmentUtils do
  @moduledoc """
  EnvironmentUtils
    Performs utility calculations for the environment main module file.
  """
  import EECOM
  import ByteConverter

  @doc """
  Returns the amount of free memory in the system in MB.
  """
  def memory_freeMB do
    to_megabytes(sysmemory()[:available_memory])
  end

  @spec is_workspec(atom()) :: boolean
  def is_workspec(func) do
    case func do
      :one -> true
      :two -> true
      :three -> true
      :four -> true
      :five -> true
      _ -> false
    end
  end

end
