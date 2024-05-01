defmodule DynamindAPIServer do
  def start(port) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
    {:ok, listener} = :gen_tcp.listen(port, [:binary, packet: :line, active: false])
    loop_accept(listener)
  end

  def stop(listener) do
    :gen_tcp.close(listener)
    # Add any additional cleanup logic here if needed
  end

  defp loop_accept(listener) do
    {:ok, socket} = :gen_tcp.accept(listener)
    handle_request(socket)
    loop_accept(listener)
  end

  defp handle_request(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, request} ->
        handle_http_request(request, socket)

      {:error, _reason} ->
        :ok
    end
  end

  defp handle_http_request(request, socket) do
    case String.split(request, " ") do
      ["GET", "/modules", _] ->
        response = handle_modules_request()
        send_response(socket, response)

      ["GET", "/config", _] ->
        response = handle_config_request()
        send_response(socket, response)

      _ ->
        send_error_response(socket)
    end
  end

  defp handle_modules_request() do
    # Logic to fetch active modules
    modules = ["module1", "module2", "module3"]
    "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n#{inspect(modules)}\r\n"
  end

  defp handle_config_request() do
    # Logic to fetch config file
    config = %{}
    "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n#{inspect(config)}\r\n"
  end

  defp send_response(socket, response) do
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end

  defp send_error_response(socket) do
    response = "HTTP/1.1 400 Bad Request\r\n\r\n"
    :gen_tcp.send(socket, response)
    :gen_tcp.close(socket)
  end
end

