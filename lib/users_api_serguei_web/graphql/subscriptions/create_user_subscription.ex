defmodule UsersApiSergueiWeb.Graphql.Subscriptions.CreateUserSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :new_user_subscription do
    @desc "Subscription for the user creation"
    field :new_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)

      config(fn _args, _info ->
        {:ok, topic: "users-topic"}
      end)

      resolve(fn user, _, _ -> {:ok, user} end)
    end
  end
end
