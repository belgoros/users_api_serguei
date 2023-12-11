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
      {:error, _} = reason ->
        {:error, reason}

      {:ok, user} = user_response ->
        Absinthe.Subscription.publish(UsersApiSergueiWeb.Endpoint, user,
          created_user: "users-topic"
        )

        user_response
    end
  end

  def update_user(_parent, args, _resolution) do
    case Repo.update_user(args) do
      {:ok, _user} = user_response -> user_response
    end
  end

  def update_user_preferences(_parent, args, _resolution) do
    case Repo.update_user(args) do
      {:ok, _} = preferences -> preferences
    end
  end
end
