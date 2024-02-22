defmodule ReqDeps do
@moduledoc """
Documentation for `ReqDeps`.

ReqDeps pull required files and compiles them.

Used mainly for iex.

Place the paths to the files that should be compiled here.
"""
  def pull do
    agents()
    comm()
    eecom()
  end
  defp agents do
    Code.require_file("lib/agents/agent.exs")
  end
  defp comm do
    Code.require_file("lib/communication/comm.exs")
  end
  defp eecom do
    Code.require_file("lib/environment/envcre.exs")
  end
end
