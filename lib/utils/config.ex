defmodule Utils.ConfigFileToArray do
@moduledoc """
ConfigFileToArray
  The ConfigFileToArray module reads a file and returns a list containing each line of the file.
"""

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
 
  @doc """
  Reads the default config file and returns a list containing each node in the file.
  """
  def read_default_config() do
    read_lines("config.dynm")
  end

  @doc """
  Reads a non-default config file and returns a list containing each node in the file.
  """
  def read_non_default_config(file_path) do
    read_lines(file_path)
  end
end
