defmodule Models.Lua do
  @moduledoc """
  Processing module for Lua functions.
  """

  def test do
    :luerl.dofile("lib/sample_models/tensor.lua", :luerl.init())
  end
end
