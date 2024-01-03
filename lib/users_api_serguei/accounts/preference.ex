defmodule UsersApiSerguei.Accounts.Preference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "preferences" do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
    belongs_to(:user, UsersApiSerguei.Accounts.User)
  end

  @available_attributes [:likes_emails, :likes_phone_calls, :likes_faxes, :user_id]

  @doc false
  def changeset(preference, attrs) do
    preference
    |> cast(attrs, @available_attributes)
  end
end
