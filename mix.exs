defmodule Upward.MixProject do
  use Mix.Project

  def project do
    [
      app: :upward,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      mod: {Upward.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.8.0"},
      {:phoenix_live_view, "~> 0.20.0"},
      {:phoenix_html, "~> 3.4"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 0.7"},
      {:telemetry_poller, "~> 1.0"},
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.6"}
    ]
  end
end
