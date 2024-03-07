defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes. 
  """
  Code.require_file("lib/environment/envcre.exs")
  Code.require_file("lib/environment/utils.exs")
  
  def doesSystemHaveSpace do
   if EnvironmentUtils.percentfree() > 100 do
      1
  end
  end
end
