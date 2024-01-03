defmodule UsersApiSerguei.Repo do
  use Ecto.Repo,
    otp_app: :users_api_serguei,
    adapter: Ecto.Adapters.Postgres
end
