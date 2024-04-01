defmodule Db.Management do
  @std_db_path "dynamind.db"
  @test_db_path "test.db"



  @spec db_init() :: :ok
  def db_init() do
    {:ok, conn} = open_conn(@std_db_path)
    db_std_setup(conn)
end

  @spec db_connect() :: {:ok, reference()}
  def db_connect() do
    open_conn(@std_db_path)
  end

  @spec db_clear(reference()) :: :ok
  def db_clear(conn) do
    clear_db(conn)
  end


  @spec db_init_test() :: :ok
  def db_init_test do
    {:ok, conn_test} = open_conn(@test_db_path)
    db_std_setup(conn_test)
  end

  @moduledoc """
  Db.Management
    The Db.Management module is responsible for managing the database.
  """
  defp open_conn(db_name) do
    {:ok, conn} = Exqlite.Sqlite3.open(db_name)
    {:ok, conn}
  end

  @doc """
  db_std_setup
    Sets up the database for the application using the standard Dynamind configuration.
  """
  defp db_std_setup(conn) do
    :ok =
      Exqlite.Sqlite3.execute(conn, """
      CREATE TABLE IF NOT EXISTS hosts (
        id INT,
        memory VARCHAR(255),
        stage_number INT,
        reference VARCHAR(255)
      );
      """)
  end

  defp clear_db(conn) do
    :ok = Exqlite.Sqlite3.execute(conn, "DELETE FROM hosts;")
    :ok
  end


end
