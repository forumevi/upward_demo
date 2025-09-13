defmodule Upward.Intents do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def list(), do: Agent.get(__MODULE__, & &1)

  def create(attrs) do
    id = :erlang.unique_integer([:positive])
    intent = Map.merge(%{
      id: id,
      text: Map.get(attrs, "text", Map.get(attrs, :text, "")),
      status: "pending",
      inserted_at: DateTime.utc_now() |> DateTime.to_iso8601()
    }, attrs)
    Agent.update(__MODULE__, fn list -> [intent | list] end)
    intent
  end

  def update_status(id, status) do
    Agent.update(__MODULE__, fn list ->
      Enum.map(list, fn i -> if i.id == id, do: Map.put(i, :status, status), else: i end)
    end)
  end
end
