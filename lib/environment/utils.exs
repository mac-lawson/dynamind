defmodule EnvironmentUtils do
  @moduledoc """
  EnvironmentUtils
    Performs utility calculations for the environment main module file. 
  """
  Code.require_file("lib/environment/envcre.exs")
  def percentfree do
    (EECOM.sysmemory()[:free_memory] / EECOM.sysmemory()[:total_memory])
  end
end
