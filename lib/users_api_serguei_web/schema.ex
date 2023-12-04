defmodule UsersApiSergueiWeb.Schema do
  use Absinthe.Schema
  import_types UsersApiSergueiWeb.Schema.ContentTypes

  alias UsersApiSergueiWeb.Resolvers

  query do
    @desc "List all users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Content.list_users/3)
    end

    @desc "Get a user by id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Content.find_user/3)
    end
  end
end
