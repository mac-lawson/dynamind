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
  def tasking_reqs do
    %{:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  end

  def intake do
    info("Intake running, trying to connecting to database")

    try do
      {:ok, conn} = db_connect(1)
      info("Connected to database")

      for remote_host <- Utils.ConfigFileToArray.read_default_config() do
        warning("Host added to schema: #{remote_host}")
        insert(conn, remote_host, 0, 0)
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

  @spec process_module_test(module :: module()) :: map()
  def process_module_test(module) do
    work_requirements = %{}
    pub_fns = module.__info__(:functions)

    work_requirements =
      Enum.reduce(pub_fns, work_requirements, fn {function, arity}, acc ->
        IO.puts("Processing function #{function} with arity #{arity}")
        t = &apply(&1, {module, function})
        tval = t.(arity)

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
    insert_module_data(work_requirements, to_string(module))
  end

  @spec multi_full_process(list()) :: list()
  def multi_full_process(modules) do
    Enum.map(modules, &full_process/1)
  end

  # TODO
  # Get stored functions from Func DB and nodes from Node DB and compare work_reqs and staging to begin creating an execution map. 
  def pair_function_modules() do
    # {:ok, nodes_conn} = db_connect(1)
    # {:ok, func_conn} = db_connect(2)
  end
end
