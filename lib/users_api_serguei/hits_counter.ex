defmodule UsersApiSerguei.HitsCounter do
  @moduledoc false

  use GenServer

  @default_name HitsCounter

  defmodule State do
    @moduledoc false
    defstruct create_user: 0, update_user: 0, find_user: 0, list_users: 0
  end

  # External API

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, @default_name)
    GenServer.start_link(__MODULE__, %State{}, opts)
  end

  def resolver_hits(name \\ @default_name, request_type) do
    GenServer.call(name, {:resolver_hits, request_type})
  end

  def increment_number(name \\ @default_name, request_type) do
    GenServer.cast(name, {:increment_number, request_type})
  end

  def clear(name \\ @default_name) do
    GenServer.cast(name, :clear)
  end

  # GenServer implementation

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_call(:next_number, _from, current_hits_number) do
    {:reply, current_hits_number, current_hits_number + 1}
  end

  @impl true
  def handle_call({:resolver_hits, request_type}, _from, state) do
    hits_number = Map.fetch!(state, request_type)

    {
      :reply,
      hits_number,
      state
    }
  end

  @impl true
  def handle_cast({:increment_number, request_type}, state) do
    new_state = Map.update!(state, request_type, &(&1 + 1))
    {:noreply, new_state}
  end

  def handle_cast(:clear, _state) do
    {:noreply, %State{}}
  end
end