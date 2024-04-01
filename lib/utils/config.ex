defmodule ConfigFileToArray do

  import Db.Utils
  @doc """
  Reads a file and returns a list containing each line of the file.

  ## Examples

      iex> ConfigFileToArray.read_lines("data.txt")
      ["line1\n", "line2\n", "line3"]
  """


  defp read_lines(path) do
    with {:ok, contents} <- File.read(path) do
      contents |> String.split("\n", trim: true) 
    end
  end

  def read_default_config() do
    read_lines("config.dynm")
  end
end
