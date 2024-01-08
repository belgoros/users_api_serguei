defmodule UsersApiSergueiWeb.Graphql.Types.PreferenceType do
  use Absinthe.Schema.Notation

  @desc "User preferences"
  object :preference do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
