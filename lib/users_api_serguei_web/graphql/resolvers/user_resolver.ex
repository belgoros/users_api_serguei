defmodule UsersApiSergueiWeb.Graphql.Resolvers.UserResolver do
  @moduledoc false
  alias UsersApiSerguei.Accounts
  alias UsersApiSerguei.HitsCounterAgent

  def list_users(_parent, args, _resolution) do
    HitsCounterAgent.increment_number(:list_users)
    {:ok, Accounts.list_users(args)}
  end

  def find_user(_parent, %{id: id}, _resolution) do
    HitsCounterAgent.increment_number(:find_user)
    Accounts.find_user(%{id: id})
  end

  def create_user(_parent, args, _resolution) do
    HitsCounterAgent.increment_number(:create_user)

    case Accounts.create_user(args) do
      {:error, _} = reason ->
        {:error, reason}

      {:ok, user} = user_response ->
        {:ok, user}

        Absinthe.Subscription.publish(UsersApiSergueiWeb.Endpoint, user, new_user: "users-topic")

        user_response
    end
  end

  def update_user(_parent, args, _resolution) do
    HitsCounterAgent.increment_number(:update_user)

    case Accounts.update_user(args) do
      {:ok, _user} = user_response -> user_response
    end
  end

  def update_user_preferences(_parent, args, _resolution) do
    HitsCounterAgent.increment_number(:update_user)

    case Accounts.update_user_preferences(args) do
      {:ok, preference} = preference_response ->
        Absinthe.Subscription.publish(UsersApiSergueiWeb.Endpoint, preference,
          update_user_preferences: "users-topic"
        )

        preference_response
    end
  end
end
