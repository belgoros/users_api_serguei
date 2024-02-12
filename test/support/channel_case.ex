defmodule UsersApiSergueiWeb.ChannelCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest

      # The default endpoint for testing
      @endpoint UsersApiSergueiWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(UsersApiSerguei.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(UsersApiSerguei.Repo, {:shared, self()})
    end

    :ok
  end
end
