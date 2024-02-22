defmodule UsersApiSergueiWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import UsersApiSergueiWeb.ChannelCase

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
