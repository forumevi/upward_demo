import Config

config :upward, UpwardWeb.Endpoint,
  http: [port: String.to_integer(System.get_env("PORT") || "4000")],
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true
