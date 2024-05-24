defmodule SampleModels.Tensor do
  @moduledoc """
  This module is key to a few tests. Do not modify it.
  """
  @spec make_a_tensor() :: {any(), any(), Tasking.work_specs()}
  def make_a_tensor do
    t = Nx.tensor([[1, 2], [3, 4]])
    {x, y} = Nx.shape(t)
    {x, y, :one}
  end

  @spec model_creation() :: {Axon.model(), Tasking.work_specs()}
  def model_creation() do
    t =
      {Axon.input("input", shape: {nil, 784})
       |> Axon.dense(128)
       |> Axon.dense(11, activation: :softmax)}

    {t, :one}
  end
end
