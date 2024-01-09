defmodule UsersApiSergueiWeb.Graphql.Types.PreferenceType do
  use Absinthe.Schema.Notation

  import Absinthe.Resolution.Helpers, only: [dataloader: 2]

  @desc "User preferences"
  object :preference do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
    field(:user, :user, resolve: dataloader(UsersApiSerguei.Accounts, :user))
  end
end
