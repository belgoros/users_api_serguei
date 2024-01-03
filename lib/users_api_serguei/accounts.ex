defmodule UsersApiSerguei.Accounts do
  import Ecto.Query, warn: false
  alias UsersApiSerguei.Accounts.Preference
  alias UsersApiSerguei.Repo
  alias UsersApiSerguei.Accounts.User

  alias EctoShorts.Actions

  def find_user(params) do
    Actions.find(
      User,
      with_preferences_preloaded(params)
    )
  end

  def list_users(params \\ %{}) do
    Actions.all(User, %{
      preload: :preferences,
      preferences: params
    })
  end

  defp with_preferences_preloaded(params) do
    Map.put(params, :preload, [:preferences])
  end

  def create_user(attrs \\ %{}) do
    changeset = Map.put(attrs, :preferences, [attrs.preferences])

    %User{}
    |> User.changeset(changeset)
    |> Repo.insert()
  end

  def update_user(attrs \\ %{}) do
    with {:ok, user} <- find_user(attrs.id) do
      changeset = Map.put(attrs, :preferences, [attrs.preferences])

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
    case Repo.get_by(Preference, user_id: user_id) do
      nil -> {:error, "No Preference found for the user_id: #{user_id}"}
      preference -> {:ok, preference}
    end
  end

  defp check_preferences(user_preferences, filter_preferences) do
    Enum.all?(filter_preferences, fn {preference, value} ->
      Map.get(user_preferences, preference) == value
    end)
  end
end
