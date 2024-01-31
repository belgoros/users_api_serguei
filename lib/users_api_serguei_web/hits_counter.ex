defmodule UsersApiSergueiWeb.HitsCounter do
  @moduledoc false

  use GenServer

  # External API

  def start_link(initial_hits_number) when is_integer(initial_hits_number) do
    GenServer.start_link(__MODULE__, initial_hits_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call(__MODULE__, :next_number)
  end

  def increment_number(new_hit) do
    GenServer.cast(__MODULE__, {:increment_number, new_hit})
  end

  # GenServer implementation

  @impl true
  def init(initial_hits_number) do
    {:ok, initial_hits_number}
  end

  @impl true
  def handle_call(:next_number, _from, current_hits_number) do
    {:reply, current_hits_number, current_hits_number + 1}
  end

  @impl true
  def handle_cast({:increment_number, new_hit}, current_hits_number) do
    {:noreply, current_hits_number + new_hit}
  end
end
