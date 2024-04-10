defmodule DynamindTest do
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
    {:ok, conn_1} = db_connect(1)
    {:ok, conn_2} = db_connect(2)
    assert (db_clear(conn_1, 1) == :ok) && (db_clear(conn_2, 2) == :ok)
  end
end
