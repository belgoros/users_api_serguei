defmodule UsersApiSergueiWeb.Schema.Queries.UserQueriesTest do
  use UsersApiSergueiWeb.ConnCase

  @users_query_with_three_preferences """
  query {
    users(likesEmails: false, likesPhoneCalls: true, likesFaxes: true) {
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

  test "list users by three preferences" do
    conn = build_conn()
    conn = post(conn, "/api", query: @users_query_with_three_preferences)

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "id" => "1",
                   "name" => "Bill",
                   "email" => "bill@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => false, "likesPhoneCalls" => true, "likesFaxes" => true}
                   ]
                 }
               ]
             }
           }
  end

  test "list users by two preferences" do
    conn = build_conn()
    conn = post(conn, "/api", query: @users_query_with_two_preferences)

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "id" => "3",
                   "name" => "Jill",
                   "email" => "jill@hotmail.com",
                   "preferences" => [
                     %{"likesEmails" => true, "likesPhoneCalls" => true, "likesFaxes" => false}
                   ]
                 }
               ]
             }
           }
  end

  test "list users by one preference" do
    conn = build_conn()
    conn = post(conn, "/api", query: @users_query_with_one_preference)

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "id" => "1",
                   "name" => "Bill",
                   "email" => "bill@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => false, "likesPhoneCalls" => true, "likesFaxes" => true}
                   ]
                 },
                 %{
                   "id" => "2",
                   "name" => "Alice",
                   "email" => "alice@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => true, "likesPhoneCalls" => false, "likesFaxes" => true}
                   ]
                 }
               ]
             }
           }
  end

  test "list users with no preference" do
    conn = build_conn()
    conn = post(conn, "/api", query: @users_query_with_no_preference)

    assert json_response(conn, 200) == %{
             "data" => %{
               "users" => [
                 %{
                   "id" => "1",
                   "name" => "Bill",
                   "email" => "bill@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => false, "likesPhoneCalls" => true, "likesFaxes" => true}
                   ]
                 },
                 %{
                   "id" => "2",
                   "name" => "Alice",
                   "email" => "alice@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => true, "likesPhoneCalls" => false, "likesFaxes" => true}
                   ]
                 },
                 %{
                   "id" => "3",
                   "name" => "Jill",
                   "email" => "jill@hotmail.com",
                   "preferences" => [
                     %{"likesEmails" => true, "likesPhoneCalls" => true, "likesFaxes" => false}
                   ]
                 },
                 %{
                   "id" => "4",
                   "name" => "Tim",
                   "email" => "tim@gmail.com",
                   "preferences" => [
                     %{"likesEmails" => false, "likesPhoneCalls" => false, "likesFaxes" => false}
                   ]
                 }
               ]
             }
           }
  end
end
