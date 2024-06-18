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
    |> Enum.drop_while(&(&1 != "-nodes"))
    # Skip the "- nodes" line
    |> Enum.drop(1)
    |> Enum.take_while(&(&1 != "-projdir"))
    |> Enum.filter(fn line -> String.match?(line, ~r/^\w+@\w+/) end)
  end

  defp extract_projdir(contents) do
    contents
    |> Enum.drop_while(&(&1 != "-projdir"))
    # Skip the "- projdir" line
    |> Enum.drop(1)
    |> Enum.take_while(&(&1 != "-instdir"))
  end

  defp extract_instdir(contents) do
    contents
    |> Enum.drop_while(&(&1 != "-instdir"))

    # Skip the "- instdir" line
    |> Enum.drop(1)
  end

  @doc """
  Reads nodes from a non-default config file and returns a list containing each node.
  """
  def read_nodes_from_config(file_path) do
    file_contents = read_lines(file_path)
    extract_nodes(file_contents)
  end

  @doc """
  Reads project directory modules from a non-default config file and returns a list containing each module.
  """
  def read_projdir_from_config(file_path) do
    file_contents = read_lines(file_path)
    extract_projdir(file_contents)
  end

  @doc """
  Reads installation directory from a non-default config file and returns a list containing each directory.
  """
  def read_instdir_from_config(file_path) do
    file_contents = read_lines(file_path)
    extract_instdir(file_contents)
  end
end

