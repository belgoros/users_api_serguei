defmodule UsersApiSerguei.HitsCounterAgent do
  @moduledoc false

  use Agent

  @default_name HitsCounterAgent

  defmodule State do
    @moduledoc false
    defstruct create_user: 0, update_user: 0, find_user: 0, list_users: 0
  end

  def start_link(opts) do
    opts = Keyword.put_new(opts, :name, @default_name)
    Agent.start_link(fn -> %State{} end, opts)
  end

  def increment_number(name \\ @default_name, request_type) do
    Agent.update(name, fn state -> Map.update!(state, request_type, &(&1 + 1)) end)
  end

  def clear(name \\ @default_name) do
    Agent.update(name, fn _state -> %State{} end)
  end

  def resolver_hits(name \\ @default_name, request_type) do
    Agent.get(name, fn state -> Map.fetch!(state, request_type) end)
  end
end
