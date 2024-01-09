defmodule UsersApiSerguei.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: UsersApiSerguei.Repo

  alias UsersApiSerguei.Accounts.{User, Preference}

  def user_factory do
    %User{
      email: sequence(:email, &"user-#{&1}@example.com"),
      name: sequence(:name, &"user-#{&1}")
    }
  end

  def preference_factory do
    %Preference{
      likes_emails: false,
      likes_phone_calls: false,
      likes_faxes: false,
      user: build(:user)
    }
  end
end
