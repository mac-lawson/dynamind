defmodule Utils.Modules do
  @doc """
  Returns a table of modules that have been processed
  """
  def table() do
    {:ok, conn} = Db.Management.db_connect(2)
    {:done, module_table} = Db.Utils.pull_all_modules(conn)
    Utils.Ascii.main_header("Loaded Modules")

    for node <- module_table do
      IO.puts("")
      Utils.Ascii.header(String.length(Enum.at(node, 0)))
      IO.puts("")
      Enum.at(node, 0) |> IO.puts()
      Utils.Ascii.header(String.length(Enum.at(node, 0)))
    end
  end
end
