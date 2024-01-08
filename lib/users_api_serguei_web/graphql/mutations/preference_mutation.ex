defmodule UsersApiSergueiWeb.Graphql.Mutations.PreferenceMutation do
  use Absinthe.Schema.Notation

  alias UsersApiSergueiWeb.Graphql.Resolvers.UserResolver

  object :update_preference_mutation do
    @desc "Update user preferences"
    field :update_user_preferences, :preference do
      arg(:user_id, :id)
      arg(:likes_emails, non_null(:boolean))
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&UserResolver.update_user_preferences/3)
    end
  end
end
