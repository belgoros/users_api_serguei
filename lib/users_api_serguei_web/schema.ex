defmodule UsersApiSergueiWeb.Schema do
  use Absinthe.Schema
  import_types(__MODULE__.ContentTypes)

  alias UsersApiSergueiWeb.Resolvers

  query do
    @desc "Get a user by id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Content.find_user/3)
    end

    @desc "List of users"
    field :users, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&Resolvers.Content.list_users/3)
    end
  end
end
