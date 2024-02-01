defmodule UsersApiSergueiWeb.Graphql.Resolvers.HitsResolver do
  @moduledoc false

  alias UsersApiSerguei.HitsCounter

  def total_hits(_parent, %{key: request_to_store}, _resolution) do
    request_key = String.to_atom(request_to_store)
    hits_number = HitsCounter.resolver_hits(request_key)

    {:ok, hits_number}
  end
end
