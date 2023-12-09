defmodule UsersApiSergueiWeb.Resolvers.User do
  alias UsersApiSerguei.Repo

  def list_users(_parent, args, _resolution) do
    {:ok, Repo.list_users(args)}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    case Repo.find_user(id) do
      nil ->
        {:error, "User ID #{id} not found"}

      user ->
        {:ok, user}
    end
  end

  def create_user(_parent, args, _resolution) do
    case Repo.create_user(args) do
      {:error, _} = reason -> {:error, reason}
      {:ok, _} = user -> user
    end
  end

  def update_user(_parent, args, _resolution) do
    case Repo.update_user(args) do
      {:error, _} = reason -> {:error, reason}
      {:ok, _} = user -> user
    end
  end

  def update_user_preferences(_parent, args, _resolution) do
    case Repo.update_user(args) do
      {:error, _} = reason -> {:error, reason}
      {:ok, _} = preferences -> preferences
    end
  end
end
