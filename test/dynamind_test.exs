defmodule DynamindTest do
  import EECOM
  import Db.Management
  use ExUnit.Case
  doctest Dynamind
  doctest Db.Management
  doctest Db.Statements

  """
  Environment Module Tests
  """

  test "Gets system architecture" do
    assert Dynamind.envinitARCH() == :erlang.system_info(:system_architecture)
  end

  """
  Database tests
  """

  test "Connect to Test Database" do
    assert db_init_test() == :ok
  end

  """
  Security tests
  """

  test "Clear database before commit" do
    {:ok, conn} = db_connect()
    assert db_clear(conn) == :ok
  end
end
