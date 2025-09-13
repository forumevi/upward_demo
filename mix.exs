defmodule Upward.MixProject do
  use Mix.Project

  def project do
    [
      app: :upward,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      mod: {Upward.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7.8"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_view, "~> 0.19"},
      {:floki, ">= 0.34.0", only: :test},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.23"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.6"}
    ]
  end
end
