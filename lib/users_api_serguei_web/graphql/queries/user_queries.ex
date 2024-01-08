defmodule UsersApiSergueiWeb.Graphql.Queries.UserQueries do
  use Absinthe.Schema.Notation

  alias UsersApiSergueiWeb.Graphql.Resolvers

  object :user_queries do
    @desc "List of users"
    field :users, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&Resolvers.UserResolver.list_users/3)
    end

    @desc "Get a user by id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.UserResolver.find_user/3)
    end
  end
end
