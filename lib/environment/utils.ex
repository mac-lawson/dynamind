defmodule EnvironmentUtils do
  @moduledoc """
  EnvironmentUtils
    Performs utility calculations for the environment main module file.
  """
  import ByteConverter

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
end
