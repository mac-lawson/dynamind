defmodule Dynamind.MixProject do
  use Mix.Project

  def project do
    [
      app: :dynamind,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :os_mon]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bumblebee, "~> 0.5.3"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:phoenix, "1.7.10"},
      {:phoenix_live_view, "0.20.1"},
      # Bumblebee and friends
      {:nx, "~> 0.7.0"},
      # Exqlite is a simple SQLite3 driver for Elixir
      {:exqlite, "~> 0.17"},
      # Exla is a wrapper around the Google TensorFlow C API
      {:exla, "~> 0.7.1"},
      {:luerl, "~> 1.2"}
    ]
  end
end
