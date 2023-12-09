defmodule UsersApiSerguei.Repo do
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

  def list_users(
        %{
          likes_emails: _likes_emails,
          likes_phone_calls: _likes_phone_calls,
          likes_faxes: _likes_faxes
        } = preferences
      ) do
    Enum.filter(@users, fn user -> Map.equal?(user.preferences, preferences) end)
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
    create_or_update_user(attrs)
  end

  defp create_or_update_user(attrs) do
    {:ok, build_user(attrs)}
  end

  defp build_user(attrs) do
    struct(User, attrs)
  end
end
