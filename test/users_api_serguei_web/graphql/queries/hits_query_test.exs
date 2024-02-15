defmodule UsersApiSergueiWeb.Graphql.Queries.HitsQueryTest do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.RepoCase

  alias UsersApiSerguei.HitsCounter

  setup [:init_user, :clear_hits]

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

  @create_user_mutation """
  mutation {
    createUser(name: "test-777", email: "test-777&example.com", preferences: {
      likesEmails: true,
      likesPhoneCalls: false,
      likesFaxes: true
    }) {
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
    setup do
      resolver_query_for(:list_users)
    end

    test "it displays zero hits", %{conn: _conn, resolver_query: resolver_query} do
      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 0
        }
      }

      assert expected === response
    end

    test "it displays 1 hit", %{conn: _conn, resolver_query: resolver_query} do
      Absinthe.run(@users_query, UsersApiSergueiWeb.Schema)

      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 1
        }
      }

      assert expected === response
    end
  end

  describe "resolver hits when finding a user" do
    setup do
      resolver_query_for(:find_user)
    end

    test "it displays zero hits", %{conn: _conn, resolver_query: resolver_query} do
      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 0
        }
      }

      assert expected === response
    end

    test "it displays 1 hit", %{conn: _conn, user: user, resolver_query: resolver_query} do
      Absinthe.run(find_user_query(user.id), UsersApiSergueiWeb.Schema)

      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 1
        }
      }

      assert expected === response
    end
  end

  describe "resolver hits when creating a User" do
    setup do
      resolver_query_for(:create_user)
    end

    test "it displays zero hits", %{conn: _conn, resolver_query: resolver_query} do
      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 0
        }
      }

      assert expected === response
    end

    test "it displays 1 hit", %{conn: _conn, resolver_query: resolver_query} do
      Absinthe.run(@create_user_mutation, UsersApiSergueiWeb.Schema)

      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 1
        }
      }

      assert expected === response
    end
  end

  describe "resolver hits when updating a User" do
    setup do
      resolver_query_for(:update_user)
    end

    test "it displays zero hits", %{conn: _conn, resolver_query: resolver_query} do
      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 0
        }
      }

      assert expected === response
    end

    test "it displays 1 hit", %{conn: _conn, resolver_query: resolver_query, user: user} do
      Absinthe.run(update_user_mutation(user.id), UsersApiSergueiWeb.Schema)

      {:ok, response} =
        Absinthe.run(resolver_query, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "resolverHits" => 1
        }
      }

      assert expected === response
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

  defp resolver_query_for(key)
       when key in [:list_users, :find_user, :create_user, :update_user] do
    query = """
    query {
      resolverHits(key: "#{key}")
    }
    """

    %{resolver_query: query}
  end

  defp update_user_mutation(id) do
    """
    mutation {
      updateUser(id: #{id}, name: "name-#{id}-updated", email: "new-email#{id}@example.com") {
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
  end
end
