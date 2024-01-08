defmodule UsersApiSergueiWeb.Graphql.Resolvers.UserResolver do
  alias UsersApiSerguei.Accounts

  def list_users(_parent, args, _resolution) do
    {:ok, Accounts.list_users(args)}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    Accounts.find_user(%{id: id})
  end

  def create_user(_parent, args, _resolution) do
    case Accounts.create_user(args) do
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
    case Accounts.update_user(args) do
      {:ok, _user} = user_response -> user_response
    end
  end

  def update_user_preferences(_parent, args, _resolution) do
    case Accounts.update_user_preferences(args) do
      {:ok, preference} = preference_response ->
        Absinthe.Subscription.publish(UsersApiSergueiWeb.Endpoint, preference,
          updated_user_preferences: "users-topic"
        )

        preference_response
    end
  end
end
