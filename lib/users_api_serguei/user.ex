defmodule UsersApiSerguei.User do
  alias UsersApiSerguei.Preference
  defstruct [:id, :name, :email, preferences: %Preference{}]
end
