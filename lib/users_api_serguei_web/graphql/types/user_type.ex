defmodule UsersApiSergueiWeb.Graphql.Types.UserType do
  @moduledoc false
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  @desc "A User"
  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)

    field(:preferences, list_of(:preference),
      resolve: dataloader(UsersApiSerguei.Accounts, :preferences)
    )
  end
end
