defmodule UsersApiSerguei.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:email, :string)
    has_many(:preferences, UsersApiSerguei.Accounts.Preference)
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
