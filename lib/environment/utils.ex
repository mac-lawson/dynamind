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
end
