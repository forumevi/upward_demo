defmodule UpwardWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :upward

  # Prod server port
  @impl true
  def init(_key, config) do
    {:ok, config}
  end

  # Static files
  plug Plug.Static,
    at: "/",
    from: :upward,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Request logger
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
