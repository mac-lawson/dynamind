defmodule ReqDeps do
@moduledoc """
Documentation for `ReqDeps`.

ReqDeps pull required files and compiles them.

Used mainly for iex.

Place the paths to the files that should be compiled here.
"""
  def pullFull do
    agents()
    eecom()
    apiserver()
    imgclass()
    decision()
  end
  def pull_agents do
    agents()
  end
  def pull_eecom do
    eecom()
  end
  defp agents do
    Code.require_file("lib/agents/agent.exs")
    Code.require_file("lib/agents/data.exs")
  end
  defp eecom do
    Code.require_file("lib/environment/envcre.exs")
    #utils
    Code.require_file("lib/environment/utils.exs")
  end
  defp apiserver do
    Code.require_file("lib/api/dynamindapi/server.exs")
  end
  @doc """
  Imports the required functions from the decision directory. 
  """
  defp decision do
    Code.require_file("lib/decision/distribution.exs")
  end
  @doc """
  Imports the required function(s) for the Image Classification. 
    For now it is mainly a demo of the OTP features of Dynamind.
  """
  defp imgclass do
    Code.require_file("lib/image_classification.exs") 
  end
end
