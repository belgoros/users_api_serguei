defmodule UsersApiSergueiWeb.Graphql.Subscriptions.UpdateUserPreferencesSubscription do
  @moduledoc false

  use Absinthe.Schema.Notation

  object :update_user_preferences_subscription do
    @desc "Subscription for the user preferences update"
    field :update_user_preferences, :preference do
      arg(:user_id, :id)
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)

      config(fn _args, _info ->
        {:ok, topic: "users-topic"}
      end)

      resolve(fn preference, _, _ -> {:ok, preference} end)
    end
  end
end
