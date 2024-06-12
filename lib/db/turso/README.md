```elixir
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

```
