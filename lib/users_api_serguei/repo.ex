defmodule UsersApiSerguei.Repo do
  use Ecto.Repo,
    otp_app: :users_api_serguei,
    adapter: Ecto.Adapters.Postgres

  alias UsersApiSerguei.Preference
  alias UsersApiSerguei.User

  @users [
    %{
      id: 1,
      name: "Bill",
      email: "bill@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: true,
        likes_faxes: true
      }
    },
    %{
      id: 2,
      name: "Alice",
      email: "alice@gmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: false,
        likes_faxes: true
      }
    },
    %{
      id: 3,
      name: "Jill",
      email: "jill@hotmail.com",
      preferences: %{
        likes_emails: true,
        likes_phone_calls: true,
        likes_faxes: false
      }
    },
    %{
      id: 4,
      name: "Tim",
      email: "tim@gmail.com",
      preferences: %{
        likes_emails: false,
        likes_phone_calls: false,
        likes_faxes: false
      }
    }
  ]

  def find_user(id) do
    user_id = String.to_integer(id)
    Enum.filter(@users, &(&1.id == user_id)) |> hd()
  end

  def list_users(%{} = preferences) do
    filter_by_preferences(preferences)
  end

  def list_users(_) do
    @users
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
    Enum.filter(@users, fn user ->
      check_preferences(user[:preferences], preferences)
    end)
  end

  defp check_preferences(user_preferences, filter_preferences) do
    Enum.all?(filter_preferences, fn {preference, value} ->
      Map.get(user_preferences, preference) == value
    end)
  end
end
