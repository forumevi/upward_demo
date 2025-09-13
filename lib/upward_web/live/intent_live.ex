defmodule UpwardWeb.IntentLive do
  use Phoenix.LiveView, layout: {UpwardWeb.LayoutView, :live}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="intent-page">
      <h2>Intent Live View</h2>
      <p>Bu sayfa prod-ready LiveView yapısına uygun olarak hazırlandı.</p>
    </div>
    """
  end
end
