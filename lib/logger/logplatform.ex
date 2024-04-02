defmodule DynaMind.Logger do
  @moduledoc """
  Module for logging messages with various severity levels.
  """

  @doc """
  Log a debug message.
  """
  def debug(message) do
    log("DEBUG", message)
  end

  @doc """
  Log an info message.
  """
  def info(message) do
    log("INFO", message)
  end

  @doc """
  Log a warning message.
  """
  def warning(message) do
    log("WARNING", message)
  end

  @doc """
  Log an error message.
  """
  def error(message) do
    log("ERROR", message)
  end

  @doc """
  Log a message with the specified severity level.
  """
  def log(severity, message) do
    timestamp = DateTime.utc_now() |> DateTime.to_iso8601()
    IO.puts("#{timestamp} [#{severity}] #{message}")
  end
end
