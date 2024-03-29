defmodule UsersApiSerguei.Accounts.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    has_many(:preferences, UsersApiSerguei.Accounts.Preference)
  end

  def with_preferences(query \\ User) do
    join(query, :inner, [u], p in assoc(u, :preferences), as: :preference)
  end

  @available_attributes [:name, :email]
  @required_attributes [:name, :email]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @available_attributes)
    |> validate_required(@required_attributes)
    |> cast_assoc(:preferences)
  end
end
