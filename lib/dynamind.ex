defmodule Dynamind do
  Code.require_file("lib/dep.exs")
  Dep.load()
  @moduledoc """
  Documentation for `Dynamind`.
  """


  @doc """
  Gathers information about system's architecture for EECOM

  ## Examples

      iex> Dynamind.envinitARCH()

  """
  def envinitARCH do
    EECOM.architecture()
  end

  def loadConfig do
    ConfigFileLoader.rd()
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
    StartImageClassification.run()
  end 
end
