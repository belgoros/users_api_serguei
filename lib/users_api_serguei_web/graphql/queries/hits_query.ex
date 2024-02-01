defmodule UsersApiSergueiWeb.Graphql.Queries.HitsQuery do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias UsersApiSergueiWeb.Graphql.Resolvers

  object :hits_query do
    @desc "Number of requests"
    field :resolver_hits, :integer do
      arg(:key, :string)
      resolve(&Resolvers.HitsResolver.total_hits/3)
    end
  end
end
