defmodule Utils.ConfigFileToArray do
  @moduledoc """
  ConfigFileToArray
    The ConfigFileToArray module reads a file and returns a list containing each line of the file.
  """

  defp read_lines(path) do
    with {:ok, contents} <- File.read(path) do
      contents |> String.split("\n", trim: true)
    end
  end

  defp extract_nodes(contents) do
    contents
    |> Enum.drop_while(&(&1 != "- nodes"))
    |> Enum.take_while(&(&1 != "- modules"))
    |> Enum.filter(fn line -> String.match?(line, ~r/^\w+@\w+/) end)
  end

  defp extract_modules(contents) do
    contents
    |> Enum.drop_while(&(&1 != "- modules"))
    |> tl()
  end

  @doc """
  Reads nodes from a non-default config file and returns a list containing each node.
  """
  def read_nodes_from_config(file_path) do
    file_contents = read_lines(file_path)
    extract_nodes(file_contents)
  end

  @doc """
  Reads modules from a non-default config file and returns a list containing each module.
  """
  def read_modules_from_config(file_path) do
    file_contents = read_lines(file_path)
    extract_modules(file_contents)
  end
end
