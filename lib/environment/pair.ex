defmodule Environment.Pair do
  def pair_modules_functions() do
    # database connections to nodes (1) and functions (1) database
    {:ok, conn} = Db.Management.db_connect(1)
    {:ok, conn1} = Db.Management.db_connect(2)
  end
end
