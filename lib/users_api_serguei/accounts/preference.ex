defmodule UsersApiSerguei.Accounts.Preference do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "preferences" do
    field(:likes_emails, :boolean)
    field(:likes_phone_calls, :boolean)
    field(:likes_faxes, :boolean)
    belongs_to(:user, UsersApiSerguei.Accounts.User)
  end

  def from(query \\ Preference), do: from(query, as: :preference)

  def by_likes(query \\ from(), params) do
    conditions =
      Enum.reduce(params, query, fn {field, value}, acc ->
        may_be_filter(acc, field, value)
      end)

    conditions
  end

  @allowed_fields [:likes_emails, :likes_phone_calls, :likes_faxes]
  defp may_be_filter(query, _field, nil), do: query

  defp may_be_filter(query, field, value) when field in @allowed_fields do
    query
    |> where([preference: p], field(p, ^field) == ^value)
  end

  @available_attributes [:likes_emails, :likes_phone_calls, :likes_faxes, :user_id]

  @doc false
  def changeset(preference, attrs) do
    cast(preference, attrs, @available_attributes)
  end
end
