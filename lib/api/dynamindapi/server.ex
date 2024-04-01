defmodule DynamindAPIServer do
  def start(port) do
    Agent.start_link(fn -> "Dynamind is running..." end, name: __MODULE__)
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

  defp get_state() do
    Agent.get(__MODULE__, fn state -> state end)
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
    data = get_state()

    case String.split(request, " ") do
      ["GET", path, _] ->
        response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\n#{data}\r\n"
        :gen_tcp.send(socket, response)

      _ ->
        response = "HTTP/1.1 400 Bad Request\r\n\r\n"
        :gen_tcp.send(socket, response)
    end

    :gen_tcp.close(socket)
  end
end
