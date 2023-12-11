defmodule UsersApiSergueiWeb.Schema do
  use Absinthe.Schema

  import_types(__MODULE__.ContentTypes)
  import_types(__MODULE__.Queries.UserQueries)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_queries)
  end

  subscription do
    import_fields(:user_queries)
  end
end
