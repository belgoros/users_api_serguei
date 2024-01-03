defmodule UsersApiSerguei.UserFixture do
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "a name",
        email: "test@example.com"
      })
      |> UsersApiSerguei.Accounts.create_user()

    user
  end
end
