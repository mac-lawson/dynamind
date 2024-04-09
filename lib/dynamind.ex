defmodule Dynamind do
  @moduledoc """
  Documentation for `Dynamind`.
  """

  @doc """
  Gathers information about system's architecture for EECOM

  ## Examples

      iex> Dynamind.envinitARCH()

  """
  @spec envinitARCH() :: String.t()
  def envinitARCH do
    EECOM.architecture()
  end

  @doc """
  Loads the .dynm configuration file for latter use by tasking.
  """
  @spec loadConfig() :: integer
  def loadConfig do
    0
  end

  @doc """
  Runs the API endpoint server. 
  """
  def pubApiServer() do
    DynamindAPIServer.start(8000)
  end

  @doc """
  Runs the *centralized* image classification example. 
  """
  def runic() do
    #StartImageClassification.run()
  end
end
