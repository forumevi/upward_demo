defmodule UpwardWeb.IntentLive do
  use UpwardWeb, :live_view
  alias Upward.Intents
  alias Phoenix.PubSub

  @topic "intents"

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe(Upward.PubSub, @topic)
    intents = Intents.list()
    {:ok, assign(socket, intents: intents, composer: "")}
  end

  def handle_event("compose", %{"intent" => %{"text" => text}}, socket) do
    intent = Intents.create(%{text: text})
    PubSub.broadcast(Upward.PubSub, @topic, {:new_intent, intent})
    {:noreply, assign(socket, composer: "", intents: [intent | socket.assigns.intents])}
  end

  def handle_info({:new_intent, intent}, socket) do
    {:noreply, update(socket, :intents, fn list -> [intent | list] end)}
  end
end
