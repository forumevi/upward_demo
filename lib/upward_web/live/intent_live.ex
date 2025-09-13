defmodule UpwardWeb.IntentLive do
  use UpwardWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :intent, "")}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Intent Centric Web3 Demo</h1>
      <p>Your intent: <%= @intent %></p>
    </div>
    """
  end
end
