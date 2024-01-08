defmodule UsersApiSergueiWeb.Graphql.Types.UserType do
  use Absinthe.Schema.Notation

  @desc "A User"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:preferences, list_of(:preference))
  end
end
