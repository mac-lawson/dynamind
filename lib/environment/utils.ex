defmodule EnvironmentUtils do
  @moduledoc """
  EnvironmentUtils
    Performs utility calculations for the environment main module file.
  """
  import EECOM

  @doc """

  """
  def memory_free do
    sysmemory()[:free_memory] / sysmemory()[:total_memory]

    EECOM.__info__()
  end
end
