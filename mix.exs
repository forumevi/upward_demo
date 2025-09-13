defmodule Upward.MixProject do
  use Mix.Project

  def project do
    [
      app: :upward,
      version: "0.1.0",
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Upward.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.7.21"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.20.17"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:plug_cowboy, "~> 2.7"},
      {:esbuild, "~> 0.10", runtime: Mix.env() == :dev},
      {:gettext, "~> 0.26"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the project.
  defp aliases do
    [
      setup: ["deps.get", "cmd npm --prefix assets install"],
      "assets.deploy": ["cmd npm --prefix assets run deploy", "esbuild default --minify", "phx.digest"]
    ]
  end
end
