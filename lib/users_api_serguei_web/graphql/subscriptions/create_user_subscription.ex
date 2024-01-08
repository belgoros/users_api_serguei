defmodule UsersApiSergueiWeb.Graphql.Subscriptions.CreateUserSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias UsersApiSergueiWeb.Graphql.Resolvers.UserResolver

  object :new_user_subscription do
    @desc "Subscription for the user creation"
    field :created_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)

      resolve(&UserResolver.create_user/3)

      config(fn _args, _info ->
        {:ok, topic: "users-topic"}
      end)
    end
  end
end
