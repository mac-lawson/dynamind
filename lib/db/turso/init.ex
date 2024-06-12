defmodule Db.Turso.Init do
  defmodule DatabaseInit do
    @url System.get_env("TURSO_DB_HOST")
    @auth_token System.get_env("TURSO_DB_TOKEN")

    def init_node_db do
      body =
        %{
          "requests" => [
            %{
              "type" => "execute",
              "stmt" => %{
                "sql" => """
                CREATE TABLE IF NOT EXISTS hosts (
                  id INT,
                  memory VARCHAR(255),
                  stage_number INT,
                  reference VARCHAR(255),
                  uptime VARCHAR(255),
                  functions_assigned VARCHAR(255)
                );
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

    def init_mod_db(module_name) do
      body =
        %{
          "requests" => [
            %{
              "type" => "execute",
              "stmt" => %{
                "sql" => """
                  CREATE TABLE IF NOT EXISTS #{String.replace(to_string(module_name), ".", "_")} (
                    function_name VARCHAR(255),
                    work_req VARCHAR(255),
                    memory VARCHAR(255),
                    stage_number INT,
                    reference VARCHAR(255)
                  );
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
  end
end
