defmodule UsersApiSergueiWeb.Graphql.Resolvers.HitsResolver do
  @moduledoc false

  alias UsersApiSerguei.HitsCounterAgent

  @accepted_request_types [:create_user, :list_users, :find_user, :create_user, :update_user]
  @accepted_request_type_strings Enum.map(@accepted_request_types, &to_string/1)

  def total_hits(_parent, %{key: request_to_store}, _resolution)
      when request_to_store in @accepted_request_type_strings do
    request_key = String.to_existing_atom(request_to_store)
    hits_number = HitsCounterAgent.resolver_hits(request_key)

    {:ok, hits_number}
  end

  def total_hits(_parent, %{key: request_to_store}, _resolution) do
    try do
      throw(request_to_store)
    catch
      request_to_store -> {:error, "Unknown value for request key: #{request_to_store}"}
    end
  end
end
