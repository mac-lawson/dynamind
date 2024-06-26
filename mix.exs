defmodule Dynamind.MixProject do
  use Mix.Project

  def project do
    [
      app: :dynamind,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  defp escript do
    [main_module: Dynamind.Startup]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      # Exqlite is a simple SQLite3 driver for Elixir
      {:exqlite, "~> 0.17"},
      {:luerl, "~> 1.2"},
      {:httpoison, "~> 1.8"},
      {:mox, "~> 1.0", only: :test}
    ]
  end
end
