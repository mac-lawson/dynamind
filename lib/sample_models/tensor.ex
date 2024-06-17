defmodule SampleModels.Tensor do
  @moduledoc """
  This module is key to a few tests. Do not modify it.
  """
  @spec simple_math() :: {any(), Tasking.work_specs()}
  def simple_math do
    t = [1, 2]
    {Enum.map(t, fn x -> :math.cos(x) end), :one}
  end
end
