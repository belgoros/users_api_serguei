defmodule UsersApiSergueiWeb.Schema.Queries.UserQueries do
  use Absinthe.Schema.Notation

  alias UsersApiSergueiWeb.Resolvers

  object :user_queries do
    @desc "List of users"
    field :users, list_of(:user) do
      arg(:likes_emails, :boolean)
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&Resolvers.User.list_users/3)
    end

    @desc "Get a user by id"
    field :user, :user do
      arg(:id, non_null(:id))
      resolve(&Resolvers.User.find_user/3)
    end

    @desc "Create a user"
    field :create_user, type: :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)
      resolve(&Resolvers.User.create_user/3)
    end

    @desc "Update a user"
    field :update_user, type: :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)
      resolve(&Resolvers.User.update_user/3)
    end

    @desc "Update user preferences only"
    field :update_user_preferences, :preference do
      arg(:user_id, :id)
      arg(:likes_emails, non_null(:boolean))
      arg(:likes_phone_calls, :boolean)
      arg(:likes_faxes, :boolean)
      resolve(&Resolvers.User.update_user_preferences/3)
    end

    @desc "Subscription for the user creation"
    field :created_user, :user do
      arg(:id, :id)
      arg(:name, :string)
      arg(:email, :string)
      arg(:preferences, :preference_input)

      config(fn _args, _info ->
        {:ok, topic: "users-topic"}
      end)
    end
  end
end
