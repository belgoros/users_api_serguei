defmodule UsersApiSerguei.Accounts do
  import Ecto.Query, warn: false
  alias UsersApiSerguei.Accounts.Preference
  alias UsersApiSerguei.Repo
  alias UsersApiSerguei.Accounts.User

  def find_user(id) do
    User
    |> Repo.get(id)
    |> Repo.preload(:preferences)
    |> Repo.normalize_one()
  end

  def list_users(%{} = preferences) do
    filter_by_preferences(preferences)
  end

  def list_users(_) do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    changeset = Map.put(attrs, :preferences, serialize_preferences(attrs.preferences))

    %User{}
    |> User.changeset(changeset)
    |> Repo.insert()
  end

  def update_user(attrs \\ %{}) do
    with {:ok, user} <- find_user(attrs.id) do
      changeset = Map.put(attrs, :preferences, serialize_preferences(attrs.preferences))

      user
      |> User.changeset(changeset)
      |> Repo.update()
    end
  end

  def update_user_preferences(attrs \\ %{}) do
    with {:ok, preference} <- find_preference_by_user_id(attrs.user_id) do
      preference
      |> Preference.changeset(attrs)
      |> Repo.update()
    end
  end

  def filter_by_preferences(preferences) do
    Repo.all(User)
    |> Repo.preload(:preferences)
    |> Enum.filter(fn user ->
      check_preferences(hd(user.preferences), preferences)
    end)
  end

  defp find_preference_by_user_id(user_id) do
    Preference
    |> Repo.get_by(user_id: user_id)
    |> Repo.normalize_one()
  end

  defp check_preferences(user_preferences, filter_preferences) do
    Enum.all?(filter_preferences, fn {preference, value} ->
      Map.get(user_preferences, preference) == value
    end)
  end

  defp serialize_preferences(preferences \\ %{}) do
    [preferences]
  end
end
