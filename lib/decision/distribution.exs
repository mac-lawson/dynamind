defmodule Distribution_engine do
  @moduledoc """
Distribution_engine
  Distrubutes tasks to remote hosts based off of data from the environment module and tasking by user.
"""
  Code.require_file("lib/utils/reqdeps.exs")
  ReqDeps.pull_agents()

  def getconfig do
    length(ConfigFileLoader.rd())
    for host <- ConfigFileLoader.rd() do
      #Node.spawn("")
    end
  end
  @doc """
    taskreqs aka Task Requirements
    Organize the distributed tasks required based on Node enviormental test results 
    """
  defp taskreqs do
     
  end

  
end
