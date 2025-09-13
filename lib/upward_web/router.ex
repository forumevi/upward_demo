defmodule UpwardWeb.Router do
  use UpwardWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", UpwardWeb do
    pipe_through :browser
    live "/", IntentLive, :index
  end
end
