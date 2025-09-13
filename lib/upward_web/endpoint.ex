defmodule UpwardWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :upward

  plug Plug.Static,
    at: "/",
    from: :upward,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, store: :cookie, key: "_upward_key", signing_salt: "CHANGE_ME"

  plug UpwardWeb.Router
end
