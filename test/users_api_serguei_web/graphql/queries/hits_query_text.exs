defmodule UsersApiSergueiWeb.Graphql.Queries.HitsQueryText do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.RepoCase

  alias UsersApiSerguei.HitsCounter

  setup [:init_user, :clear_hits]

  @list_users_resolver_hits_query """
  query {
    resolverHits(key: "list_users")
  }
  """

  @find_user_resolver_hits_query """
  query {
    resolverHits(key: "find_user")
  }
  """

  @users_query """
  query {
    users {
      id
      name
      email

      preferences {
        likesEmails
        likesPhoneCalls
        likesFaxes
      }
    }
  }
  """

  describe "resolver hits when listing users" do
    test "it displays zero hits", %{conn: conn} do
      conn = post(conn, "/api", query: @list_users_resolver_hits_query)

      assert json_response(conn, 200) === %{
               "data" => %{
                 "resolverHits" => 0
               }
             }
    end

    test "it displays 1 hit", %{conn: conn} do
      conn = post(conn, "/api", query: @users_query)
      conn = post(conn, "/api", query: @list_users_resolver_hits_query)

      assert json_response(conn, 200) === %{
               "data" => %{
                 "resolverHits" => 1
               }
             }
    end
  end

  describe "resolver hits when finding a user" do
    test "it displays zero hits", %{conn: conn} do
      conn = post(conn, "/api", query: @find_user_resolver_hits_query)

      assert json_response(conn, 200) === %{
               "data" => %{
                 "resolverHits" => 0
               }
             }
    end

    test "it displays 1 hit", %{conn: conn, user: user} do
      conn = post(conn, "/api", query: find_user_query(user.id))

      conn = post(conn, "/api", query: @find_user_resolver_hits_query)

      assert json_response(conn, 200) === %{
               "data" => %{
                 "resolverHits" => 1
               }
             }
    end
  end

  defp init_user(_context) do
    user = insert(:user)
    insert(:preference, user: user)
    %{user: user}
  end

  defp clear_hits(_context) do
    HitsCounter.clear()
  end

  defp find_user_query(user_id) do
    """
    query {
      user(id: #{user_id}) {
        email
        id
        name
        preferences {
          likesEmails
          likesPhoneCalls
          likesFaxes
        }
      }
    }
    """
  end
end
