import Config

config :upward, UpwardWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UpwardWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Upward.PubSub,
  live_view: [signing_salt: "SECRET_SALT"]

import_config "#{Mix.env()}.exs"
