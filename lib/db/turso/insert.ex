defmodule Db.Turso.Insert do
  defmodule DatabaseInsert do
    require Logger
    @url System.get_env("TURSO_DB_HOST")
    @auth_token System.get_env("TURSO_DB_TOKEN")

    @create_table_query """
    CREATE TABLE IF NOT EXISTS hosts (
      id INT,
      memory VARCHAR(255),
      stage_number INT,
      reference VARCHAR(255),
      uptime VARCHAR(255),
      functions_assigned VARCHAR(255)
    );
    """

    # @insert_query """
    #     INSERT INTO hosts (id, memory, stage_number, reference, uptime) VALUES (?1, ?2, ?3, ?4, ?5);
    #    """
    def get_hosts() do
      body =
        %{
          "requests" => [
            %{
              "type" => "execute",
              "stmt" => %{
                "sql" => """
                SELECT * FROM hosts;
                """
              }
            },
            %{"type" => "close"}
          ]
        }
        |> Jason.encode!()

      headers = [
        {"Authorization", "Bearer #{@auth_token}"},
        {"Content-Type", "application/json"}
      ]

      case HTTPoison.post(@url, body, headers) do
        {:ok, %HTTPoison.Response{body: response_body}} ->
          response_body
          |> Jason.decode!()
          |> IO.inspect()

        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.puts("Error: #{reason}")
      end
    end

    def insert_func(module_name) do
      body =
        %{
          "requests" => [
            %{
              "type" => "execute",
              "stmt" => %{
                "sql" =>
                  "INSERT INTO #{module_name} (function_name, work_req, memory, stage_number, reference) VALUES (?1, ?2, ?3, ?4, ?5);",
                "args" => [
                  %{"type" => "text", "value" => "function_name"},
                  %{"type" => "integer", "value" => 1},
                  %{"type" => "text", "value" => "work_req"},
                  %{"type" => "integer", "value" => 8},
                  %{"type" => "text", "value" => "ref123"},
                  %{"type" => "text", "value" => "yes"}
                ]
              }
            },
            %{"type" => "close"}
          ]
        }
        |> Jason.encode!()

      headers = [
        {"Authorization", "Bearer #{@auth_token}"},
        {"Content-Type", "application/json"}
      ]

      case HTTPoison.post(@url, body, headers) do
        {:ok, %HTTPoison.Response{body: response_body}} ->
          response_body
          |> Jason.decode!()
          |> IO.inspect()

        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.puts("Error: #{reason}")
      end
    end
  end
end
