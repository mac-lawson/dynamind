defmodule DynamindTest do
  use ExUnit.Case
  doctest Dynamind

  test "Gets system architecture" do
    assert Dynamind.envinitARCH() == :erlang.system_info(:system_architecture)
  end
end
