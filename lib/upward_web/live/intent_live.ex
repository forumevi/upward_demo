defmodule UpwardWeb.IntentLive do
  use Phoenix.LiveView

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :intent, "Type your intent...")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1>Upward Intent Demo</h1>
      <p><%= @intent %></p>
    </div>
    """
  end
end
