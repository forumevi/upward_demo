import Config

config :upward, UpwardWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: UpwardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Upward.PubSub,
  live_view: [signing_salt: "SECRET_SALT"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"
