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
