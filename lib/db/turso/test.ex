defmodule Db.Turso.Url do
  defmodule DatabaseClient do
    @moduledoc false
    @url System.get_env("TURSO_DB_HOST")
    @auth_token System.get_env("TURSO_DB_TOKEN")
    def send_request do
      body =
        %{
          "requests" => [
            %{"type" => "execute", "stmt" => %{"sql" => "SELECT * FROM users"}},
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
