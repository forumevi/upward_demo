# mix.exs
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
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Compilation paths
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # OTP Application
  def application do
    [
      mod: {Upward.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Dependencies
  defp deps do
    [
      {:phoenix, "~> 1.7.21"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.20.17"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:plug_cowboy, "~> 2.7"},
      {:esbuild, "~> 0.10", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.26"},
      {:jason, "~> 1.4"},
      {:telemetry, "~> 1.3"},
      {:websock, "~> 0.5"},
      {:websock_adapter, "~> 0.5"}
    ]
  end

  # Aliases for setup and assets
  defp aliases do
    [
      setup: ["deps.get", "assets.setup"],
      "assets.setup": ["cmd npm install --prefix assets"],
      "assets.deploy": ["cmd npm run deploy --prefix assets", "esbuild default --minify"]
    ]
  end
end
