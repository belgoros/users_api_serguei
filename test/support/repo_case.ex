defmodule UsersApiSergueiWeb.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias UsersApiSerguei.Repo

      import Ecto
      import Ecto.Query
      import UsersApiSergueiWeb.RepoCase

      # and any other stuff
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
