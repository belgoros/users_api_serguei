defmodule UsersApiSergueiWeb.Graphql.Queries.UserQueriesTest do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.RepoCase

  @users_query_with_three_preferences """
  query {
    users(likesEmails: false, likesPhoneCalls: false, likesFaxes: false) {
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

  @users_query_with_two_preferences """
  query {
    users(likesEmails: true, likesPhoneCalls: true) {
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

  @users_query_with_one_preference """
  query {
    users(likesFaxes: true) {
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

  @users_query_with_no_preference """
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

  describe "List users" do
    test "list users by three preferences", %{conn: _conn} do
      user = insert(:user)
      _preference = insert(:preference, user: user)

      {:ok, response} =
        Absinthe.run(@users_query_with_three_preferences, UsersApiSergueiWeb.Schema)

      expected =
        %{
          data: %{
            "users" => [
              %{
                "email" => user.email,
                "id" => Integer.to_string(user.id),
                "name" => user.name,
                "preferences" => [
                  %{
                    "likesEmails" => false,
                    "likesFaxes" => false,
                    "likesPhoneCalls" => false
                  }
                ]
              }
            ]
          }
        }

      assert expected === response
    end

    test "list users by two preferences", %{conn: _conn} do
      preference = insert(:preference, likes_emails: true, likes_phone_calls: true)

      {:ok, response} =
        Absinthe.run(@users_query_with_two_preferences, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "users" => [
            %{
              "id" => "#{preference.user.id}",
              "name" => "#{preference.user.name}",
              "email" => "#{preference.user.email}",
              "preferences" => [
                %{"likesEmails" => true, "likesPhoneCalls" => true, "likesFaxes" => false}
              ]
            }
          ]
        }
      }

      assert expected === response
    end

    test "list users by one preference", %{conn: _conn} do
      preference1 = insert(:preference, likes_faxes: true)
      preference2 = insert(:preference, likes_faxes: true, likes_emails: true)

      {:ok, response} =
        Absinthe.run(@users_query_with_one_preference, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "users" => [
            %{
              "id" => "#{preference1.user.id}",
              "name" => "#{preference1.user.name}",
              "email" => "#{preference1.user.email}",
              "preferences" => [
                %{"likesEmails" => false, "likesPhoneCalls" => false, "likesFaxes" => true}
              ]
            },
            %{
              "id" => "#{preference2.user.id}",
              "name" => "#{preference2.user.name}",
              "email" => "#{preference2.user.email}",
              "preferences" => [
                %{"likesEmails" => true, "likesPhoneCalls" => false, "likesFaxes" => true}
              ]
            }
          ]
        }
      }

      assert expected === response
    end

    test "list users with no preference", %{conn: _conn} do
      preference1 = insert(:preference, likes_faxes: true)
      preference2 = insert(:preference, likes_faxes: true, likes_emails: true)

      preference3 =
        insert(:preference, likes_faxes: true, likes_emails: true, likes_phone_calls: true)

      preference4 = insert(:preference)

      {:ok, response} =
        Absinthe.run(@users_query_with_no_preference, UsersApiSergueiWeb.Schema)

      expected = %{
        data: %{
          "users" => [
            %{
              "id" => "#{preference1.user.id}",
              "name" => "#{preference1.user.name}",
              "email" => "#{preference1.user.email}",
              "preferences" => [
                %{"likesEmails" => false, "likesPhoneCalls" => false, "likesFaxes" => true}
              ]
            },
            %{
              "id" => "#{preference2.user.id}",
              "name" => "#{preference2.user.name}",
              "email" => "#{preference2.user.email}",
              "preferences" => [
                %{"likesEmails" => true, "likesPhoneCalls" => false, "likesFaxes" => true}
              ]
            },
            %{
              "id" => "#{preference3.user.id}",
              "name" => "#{preference3.user.name}",
              "email" => "#{preference3.user.email}",
              "preferences" => [
                %{"likesEmails" => true, "likesPhoneCalls" => true, "likesFaxes" => true}
              ]
            },
            %{
              "id" => "#{preference4.user.id}",
              "name" => "#{preference4.user.name}",
              "email" => "#{preference4.user.email}",
              "preferences" => [
                %{
                  "likesEmails" => false,
                  "likesPhoneCalls" => false,
                  "likesFaxes" => false
                }
              ]
            }
          ]
        }
      }

      assert expected === response
    end
  end
end
