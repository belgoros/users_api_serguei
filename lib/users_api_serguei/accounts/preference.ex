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
        dynamic_condition({field, value}, acc)
      end)

    conditions
  end

  defp dynamic_condition({:likes_emails, value} = _preference, query) do
    where(query, [preference: p], p.likes_emails == ^value)
  end

  defp dynamic_condition({:likes_phone_calls, value} = _preference, query) do
    where(query, [preference: p], p.likes_phone_calls == ^value)
  end

  defp dynamic_condition({:likes_faxes, value} = _preference, query) do
    where(query, [preference: p], p.likes_faxes == ^value)
  end

  @available_attributes [:likes_emails, :likes_phone_calls, :likes_faxes, :user_id]

  @doc false
  def changeset(preference, attrs) do
    cast(preference, attrs, @available_attributes)
  end
end
