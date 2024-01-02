defmodule UsersApiSerguei.Accounts do
  import Ecto.Query, warn: false
  alias UsersApiSerguei.Repo
  alias UsersApiSerguei.Accounts.User

  def find_user(id), do: Repo.get(User, id)

  def list_users(%{} = preferences) do
    filter_by_preferences(preferences)
  end

  def list_users(_) do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    case attrs do
      %{
        id: _id,
        name: _name,
        email: _email,
        preferences: %{
          likes_emails: _likes_emails,
          likes_phone_calls: _likes_phone_calls,
          likes_faxes: _likes_faxes
        }
      } ->
        create_or_update_user(attrs)

      _ ->
        {:error, "Wrong attributes provided to create/update user!"}
    end
  end

  def update_user(attrs \\ %{}) do
    case attrs do
      %{
        user_id: _id,
        likes_emails: _likes_emails,
        likes_phone_calls: _likes_phone_calls,
        likes_faxes: _likes_faxes
      } ->
        update_user_preferences(attrs)

      _ ->
        create_or_update_user(attrs)
    end
  end

  defp create_or_update_user(attrs) do
    {:ok, build_user(attrs)}
  end

  defp build_user(attrs) do
    struct(User, attrs)
  end

  defp update_user_preferences(attrs) do
    user = find_user(attrs.user_id)

    new_preferences = Map.delete(attrs, :user_id)
    updated_preferences = Map.merge(user.preferences, new_preferences)
    {:ok, struct(Preference, updated_preferences)}
  end

  def filter_by_preferences(preferences) do
    Repo.all(User)
    |> Enum.filter(fn user ->
      check_preferences(user[:preferences], preferences)
    end)
  end

  defp check_preferences(user_preferences, filter_preferences) do
    Enum.all?(filter_preferences, fn {preference, value} ->
      Map.get(user_preferences, preference) == value
    end)
  end
end
