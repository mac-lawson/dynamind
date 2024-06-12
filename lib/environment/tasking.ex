defmodule Tasking do
  @moduledoc """
  Tasking
    The tasking module gives a score to required functions and actions to ensure proper distibution of functions across nodes.

  """
  # import EnvironmentUtils
  import Db.Management
  import Db.Utils
  import Logger
  # defines acceptable work levels, final return value of every function that is processed.
  @type work_specs :: :one | :two | :three | :four | :five

  @spec tasking_reqs() :: map()
  def tasking_reqs do
    %{:one => 1, :two => 2, :three => 3, :four => 4, :five => 5}
  end

  @doc """
  Urgent *Known issue*: Isn't converting the module names from config file to atoms properly.

  **TODO**
  - Allow user to object to module being procesed. 
  """
  def intake do
    info("Intake running, trying to connecting to database")

    try do
      {:ok, conn1} = db_connect(1)

      info("Connected to database")

      for remote_host <- Utils.ConfigFileToArray.read_nodes_from_config("config.dynm") do
        warning("Host added to schema: #{remote_host}")
        insert(conn1, remote_host, 0, 0)

        Db.Turso.Insert.DatabaseInsert.insert_node(
          0,
          100,
          1,
          remote_host,
          String.to_atom(remote_host) |> Node.ping()
        )

        "error here" |> IO.puts()
      end

      paths =
        Utils.ConfigFileToArray.read_dir_from_config("config.dynm")
        |> Path.wildcard()

      paths |> IO.inspect()

      for path <- paths do
        path |> IO.inspect()
        Environment.Modfinder.get_modules(path) |> IO.inspect()
        Enum.each(Environment.Modfinder.get_modules(path), &full_process/1)
        # Environment.Process.process_module(Environment.Modfinder.get_modules(path))
      end

      #     Utils.ConfigFileToArray.read_dir_from_config("config.dynm")
      # |> Path.wildcard()
      # |> Environment.Modfinder.get_modules()

      info("#{length(paths)} module directories found in config file.")

      # implement database storage of found files here
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

  @spec process_module(module :: module()) :: map()
  @doc """
  Migration in progress to Environment.Process

  *All function calls related to module processing will soon be movedd*
  """
  def process_module(module) do
    Environment.Process.process_module(module)
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

  @doc """
  **Use this for processing modules**
  *Full Process*
  The full process function takes a module and processes it, then inserts the data into the database.

  *Known issues*
  - Can not process modules that have functions with an arity of >0.
  """
  def full_process(module) do
    work_requirements = process_module(module)
    db_init(module)
    insert_module_data(work_requirements, to_string(module))
  end

  @spec multi_full_process(list()) :: list()
  def multi_full_process(modules) do
    Enum.map(modules, &full_process/1)
  end
end
