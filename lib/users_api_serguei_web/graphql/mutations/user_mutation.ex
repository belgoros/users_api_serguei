defmodule UsersApiSergueiWeb.Graphql.Mutations.UserMutation do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias UsersApiSergueiWeb.Graphql.Resolvers.UserResolver

  object :create_user_mutation do
    @desc "Create a user"
    field :create_user, :user do
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)
      resolve(&UserResolver.create_user/3)
    end
  end

  object :update_user_mutation do
    @desc "Update a user"
    field :update_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)
      resolve(&UserResolver.update_user/3)
    end
  end
end
