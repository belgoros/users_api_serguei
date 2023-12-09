defmodule UsersApiSergueiWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:preferences, list_of(:preference))
  end

  object :preference do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end

  input_object :user_input do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:email, non_null(:string))
    field(:preferences, list_of(:preference_input))
  end

  input_object :preference_input do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
  end
end
