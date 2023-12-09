defmodule UsersApiSergueiWeb.Router do
  use UsersApiSergueiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: UsersApiSergueiWeb.Schema,
      socket: UsersApiSergueiWeb.UserSocket

    forward "/", Absinthe.Plug, schema: UsersApiSergueiWeb.Schema
  end
end
