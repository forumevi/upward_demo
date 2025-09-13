defmodule Upward.Application do
  use Application

  def start(_type, _args) do
    children = [
      UpwardWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Upward.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    UpwardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
