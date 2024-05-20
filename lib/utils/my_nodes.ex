defmodule Utils.MyNodes do
  def table() do
    {:ok, conn} = Db.Management.db_connect(1)
    {:done, modules} = Db.Utils.pull_all(conn)
    Utils.Ascii.main_header("Modules")

    for node <- modules do
      IO.puts("")
      Utils.Ascii.header(String.length(Enum.at(node, 0)))
      IO.puts("")
      Enum.at(node, 0) |> IO.puts()
      Utils.Ascii.header(String.length(Enum.at(node, 0)))
    end
  end
end
