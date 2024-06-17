defmodule EnvironmentUtils do
  @moduledoc """
  EnvironmentUtils
    Performs utility calculations for the environment main module file.
  """

  @spec is_workspec(atom()) :: boolean
  def is_workspec(func) do
    case func do
      :one -> true
      :two -> true
      :three -> true
      :four -> true
      :five -> true
      _ -> false
    end
  end

  # Helper function to get the type of a value
  def typeof(value) do
    case value do
      _ when is_integer(value) -> :integer
      _ when is_float(value) -> :float
      _ when is_binary(value) -> :binary
      _ when is_atom(value) -> :atom
      _ when is_list(value) -> :list
      _ -> :unknown
    end
  end
end
