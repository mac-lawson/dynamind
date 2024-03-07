defmodule DynamindTest do
  Code.require_file("lib/utils/reqdeps.exs")
  ReqDeps.pull_eecom()
  use ExUnit.Case
  doctest Dynamind

  """
  Environment Module Tests
  """

  test "Gets system architecture" do
    assert Dynamind.envinitARCH() == :erlang.system_info(:system_architecture)
  end

  test "Gets system memory data" do
    assert EECOM.sysmemory() == :memsup.get_system_memory_data
  end 

  """
  Agent module tests
  """

end
