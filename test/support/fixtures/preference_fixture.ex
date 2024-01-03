defmodule UsersApiSerguei.PreferenceFixture do
  def preference_fixture(attrs \\ %{}) do
    {:ok, preference} =
      attrs
      |> Enum.into(%{
        likes_emails: true,
        likes_phon_calls: true,
        likes_faxes: true
      })
      |> UsersApiSerguei.Accounts.create_preference()

    preference
  end
end
