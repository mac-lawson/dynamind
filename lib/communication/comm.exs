defmodule Communicator do
  @moduledoc """
  Module for handling communication among agents.
  """

  @doc """
  Sends a message from one agent to another.
  """
  def send_message(sender, receiver, message) do
    IO.puts("Sending message from #{sender} to #{receiver}: #{message}")
    # Implement message sending logic here
  end

  @doc """
  Broadcasts a message to multiple agents.
  """
  def broadcast_message(sender, receivers, message) do
    for receiver <- receivers do
      send_message(sender, receiver, message)
    end
  end
end
