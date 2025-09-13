defmodule UpwardWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :upward

  @session_options [
    store: :cookie,
    key: "_upward_key",
    signing_salt: "randomsalt"
  ]

  plug Plug.Static,
    at: "/",
    from: :upward,
    gzip: false

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options

  plug UpwardWeb.Router
end
