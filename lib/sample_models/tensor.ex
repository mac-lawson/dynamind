defmodule SampleModels.Tensor do
  @spec make_a_tensor() :: {any(), any(), Tasking.work_specs()}
  def make_a_tensor do
    t = Nx.tensor([[1, 2], [3, 4]])
    {x, y} = Nx.shape(t)
    {x, y, :one}
  end

  @spec model_creation() :: {Axon.model(), Tasking.work_specs()}
  def model_creation() do
    workspec = true

    if EnvironmentUtils.is_workspec(workspec) do
      {Axon.input("input", shape: {nil, 784})
       |> Axon.dense(128)
       |> Axon.dense(11, activation: :softmax), :two}
    end
  end
end
