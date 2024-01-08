defmodule UsersApiSergueiWeb.Graphql.Subscriptions.UpdateUserPreferencesSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias UsersApiSergueiWeb.Graphql.Resolvers.UserResolver

  object :update_user_preferences_subscription do
    @desc "Subscription for the user preferences update"
    field :updated_user_preferences, :preference do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&UserResolver.update_user_preferences/3)

      config(fn _args, _info ->
        {:ok, topic: "users-topic"}
      end)
    end
  end
end
