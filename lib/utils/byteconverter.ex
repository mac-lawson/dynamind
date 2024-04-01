defmodule ByteConverter do
  @doc """
  Converts bytes to kilobytes.
  """
  def to_kilobytes(bytes) when is_integer(bytes) do
    bytes / 1024.0
  end

  @doc """
  Converts bytes to megabytes.
  """
  def to_megabytes(bytes) when is_integer(bytes) do
    bytes / 1024.0 / 1024.0
  end

  @doc """
  Converts bytes to gigabytes.
  """
  def to_gigabytes(bytes) when is_integer(bytes) do
    bytes / 1024.0 / 1024.0 / 1024.0
  end

  @doc """
  Converts bytes to terabytes.
  """
  def to_terabytes(bytes) when is_integer(bytes) do
    bytes / 1024.0 / 1024.0 / 1024.0 / 1024.0
  end
end
