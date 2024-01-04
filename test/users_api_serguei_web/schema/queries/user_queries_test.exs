defmodule UsersApiSergueiWeb.Schema.Queries.UserQueriesTest do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.RepoCase

  import UsersApiSerguei.Factory

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
    test "list users by three preferences", %{conn: conn} do
      user = insert(:user)
      preference = insert(:preference, user: user)
      conn = post(conn, "/api", query: @users_query_with_three_preferences)

      assert json_response(conn, 200) == %{
               "data" => %{
                 "users" => [
                   %{
                     "id" => "#{user.id}",
                     "name" => "#{user.name}",
                     "email" => "#{user.email}",
                     "preferences" => [
                       %{
                         "likesEmails" => preference.likes_emails,
                         "likesPhoneCalls" => preference.likes_phone_calls,
                         "likesFaxes" => preference.likes_faxes
                       }
                     ]
                   }
                 ]
               }
             }
    end

    test "list users by two preferences", %{conn: conn} do
      preference = insert(:preference, likes_emails: true, likes_phone_calls: true)
      conn = post(conn, "/api", query: @users_query_with_two_preferences)

      assert json_response(conn, 200) == %{
               "data" => %{
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
    end

    test "list users by one preference", %{conn: conn} do
      preference1 = insert(:preference, likes_faxes: true)
      preference2 = insert(:preference, likes_faxes: true, likes_emails: true)

      conn = post(conn, "/api", query: @users_query_with_one_preference)

      assert json_response(conn, 200) == %{
               "data" => %{
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
    end

    test "list users with no preference", %{conn: conn} do
      preference1 = insert(:preference, likes_faxes: true)
      preference2 = insert(:preference, likes_faxes: true, likes_emails: true)

      preference3 =
        insert(:preference, likes_faxes: true, likes_emails: true, likes_phone_calls: true)

      preference4 = insert(:preference)

      conn = post(conn, "/api", query: @users_query_with_no_preference)

      assert json_response(conn, 200) == %{
               "data" => %{
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
    end
  end
end
