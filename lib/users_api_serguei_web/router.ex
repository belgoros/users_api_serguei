defmodule UsersApiSergueiWeb.Router do
  use UsersApiSergueiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UsersApiSergueiWeb do
    pipe_through :api
  end
end
