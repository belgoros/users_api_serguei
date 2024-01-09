defmodule UsersApiSerguei.Accounts do
  import Ecto.Query, warn: false
  alias UsersApiSerguei.Repo
  alias UsersApiSerguei.Accounts.{User, Preference}

  alias EctoShorts.Actions

  def find_user(params) do
    Actions.find(
      User,
      params
    )
  end

  def list_users(params \\ %{}) do
    Actions.all(User, %{
      preferences: params
    })
  end

  def create_user(attrs) do
    changeset = Map.put(attrs, :preferences, [attrs.preferences])

    %User{}
    |> User.changeset(changeset)
    |> Repo.insert()
  end

  def update_user(attrs) do
    %{id: id} = attrs

    with {:ok, user} <- find_user(%{id: id}) do
      user
      |> User.changeset(attrs)
      |> Repo.update()
    end
  end

  def update_user_preferences(attrs) do
    with {:ok, preference} <- find_preference_by_user_id(attrs.user_id) do
      preference
      |> Preference.changeset(attrs)
      |> Repo.update()
    end
  end

  defp find_preference_by_user_id(user_id) do
    case Repo.get_by(Preference, user_id: user_id) do
      nil -> {:error, "No Preference found for the user_id: #{user_id}"}
      preference -> {:ok, preference}
    end
  end

  # dataloader support
  def data, do: Dataloader.Ecto.new(Repo, query: &query/2)

  defp query(User, args), do: list_users(args)

  defp query(queryable, _params), do: queryable
end
