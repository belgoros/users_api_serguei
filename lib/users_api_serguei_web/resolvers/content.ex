defmodule UsersApiSergueiWeb.Resolvers.Content do
  alias UsersApiSerguei.Repo

  def list_users(_parent, _args, _resolution) do
    {:ok, Repo.list_users()}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case Repo.find_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end
end
