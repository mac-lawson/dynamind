defmodule Environment.Process do
  @moduledoc """
  Environment.Process
    The Environment.Process module is responsible for processing modules.
    TODO: import everything else that involves function processing from env.tasking
  """
  @spec tasking_reqs() :: map()
  defp tasking_reqs do
    %{:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  end

  # TODO
  # Run functions that have an arity of >0 properly
  @spec process_module(module :: module()) :: map()
  def process_module(module) do
    work_requirements = %{}
    pub_fns = module.__info__(:functions)

    work_requirements =
      Enum.reduce(pub_fns, work_requirements, fn {function, arity}, acc ->
        IO.puts("Processing function #{function} with arity #{arity}")
        t = Function.capture(module, function, arity)
        tval = t.()

        if is_tuple(tval) do
          work_req = List.last(Tuple.to_list(tval))
          Map.put(acc, function, Map.fetch(tasking_reqs(), work_req))
        else
          Map.put(acc, function, tval)
        end
      end)

    work_requirements
  end
end
