defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes.

  """
  import EECOM
  import EnvironmentUtils


  defp intake do
    for remote_host <- ConfigFileToArray.read_default_config() do

    end

  end
  @spec doesSystemHaveSpace() :: none()
  def doesSystemHaveSpace do
   if EnvironmentUtils.memory_free() > 100 do
      1
   end
  end
end
