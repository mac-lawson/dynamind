defmodule Environment.Process do
  @moduledoc """
  Environment.Process
    The Environment.Process module is responsible for processing modules.
    TODO: import everything else that involves function processing from env.tasking
  """
  require Logger
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

    Enum.reduce(pub_fns, work_requirements, fn {function, arity}, acc ->
      if arity_check(arity) do
        IO.puts("Processing function #{function} with arity #{arity}")
        t = Function.capture(module, function, arity)
        tval = t.()

        if is_tuple(tval) do
          work_req = List.last(Tuple.to_list(tval))
          Map.put(acc, function, Map.fetch(tasking_reqs(), work_req))
        else
          Map.put(acc, function, tval)
        end
      else
        Logger.error("Cannot process #{function} because is has a non-zero arity.")
      end
    end)
  end

  @doc """
  **Use this for processing modules**
  *Full Process*
  The full process function takes a module and processes it, then inserts the data into the database.

  *Known issues*
  - Can not process modules that have functions with an arity of >0.
  """
  def full_process(module) do
    work_requirements = process_module(module)
    Db.Management.db_init(module)
    Db.Utils.insert_module_data(work_requirements, to_string(module))
  end

  @spec arity_check(integer) :: boolean
  defp arity_check(arity) do
    arity == 0
  end
end
