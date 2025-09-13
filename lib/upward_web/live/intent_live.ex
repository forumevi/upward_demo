defmodule UpwardWeb.IntentLive do
  use Phoenix.LiveView,
    layout: false

  def render(assigns) do
    ~H"""
    <div id="live">
      <h1>Upward LiveView App</h1>
    </div>
    """
  end
end
