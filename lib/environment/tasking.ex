defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes.

  """
  # import EnvironmentUtils
  import Db.Management
  import Db.Utils
  import SampleModels.Tensor
  import Logger
  # defines acceptable work levels, final return value of every function that is processed.
  @type work_specs :: :one | :two | :three | :four | :five

  @spec tasking_reqs() :: map()
  defp tasking_reqs do
    %{:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  end

  def intake do
    info("Intake running, trying to connecting to database")

    try do
      {:ok, conn} = db_connect(1)
      info("Connected to database")

      for remote_host <- Utils.ConfigFileToArray.read_default_config() do
        {_x, _y, task} = make_a_tensor()
        warning("Host added to schema: #{remote_host}")
        {:ok, stage} = Map.fetch(tasking_reqs(), task)
        insert(conn, remote_host, 0, stage)
      end
    rescue
      e in Exqlite.Sqlite3.Error ->
        warning("Error connecting to database: #{inspect(e)}")
    end
  end

  def verify_uptime do
    {:ok, conn} = db_connect(1)
    get_uptime(conn, "test@testhost.org")
  end

  def test_uptime do
    {:ok, conn} = db_connect(1)
    update_uptime(conn, "test@testhost.org", 100)
  end

# TODO add something to not actually run the functions, just get info about them. 
@spec process_module(module :: module()) :: map()
def process_module(module) do
  work_requirements = %{}
  pub_fns = module.__info__(:functions)
  work_requirements = Enum.reduce(pub_fns, work_requirements, fn {function, arity}, acc ->
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

@doc """
Identifies the functions in a module and returns a map of the functions WITHOUT their work requirements.
"""
@spec process_module_silent(module :: module()) :: map()
def process_module_silent(module) do
  module.__info__(:functions)
end


def full_process(module) do
  work_requirements = process_module(module)
  insert_module_data(work_requirements, "0", 0, module, 0, process_module_silent(module), module)
end

end
