defmodule Dynamind do
  Code.require_file("lib/dep.exs")
  Dep.load()
  @moduledoc """
  Documentation for `Dynamind`.
  """

  @doc """
  Gathers information about system's memory for EECOM

  ## Examples

      iex> Dynamind.envinitMEMORY()

  """
  def envinitMEMORY do
    EECOM.free_memory
  end

  @doc """
  Gathers information about system's architecture for EECOM

  ## Examples

      iex> Dynamind.envinitARCH()

  """
  def envinitARCH do
    EECOM.architecture()
  end
end
