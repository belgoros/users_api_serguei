defmodule UsersApiSergueiWeb.Graphql.Subscriptions.CreateUserSubscriptionTest do
  @moduledoc false

  use UsersApiSergueiWeb.SubscriptionCase

  @new_user_subscription """
  subscription {
    newUser {
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
  mutation($name: String!, $email: String!, $preferences: PreferenceInput!) {
    createUser(name: $name, email: $email, preferences: $preferences) {
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

  test "new user can be subscribed to", %{socket: socket} do
    # setup a subscription
    ref = push_doc(socket, @new_user_subscription)
    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    # run a mutation to trigger the subscription

    preferences = %{
      "likesEmails" => true
    }

    user_input = %{
      "name" => "user-1",
      "email" => "user-1@email.com",
      "preferences" => preferences
    }

    ref = push_doc(socket, @create_user_mutation, variables: user_input)
    assert_reply ref, :ok, reply

    assert %{data: %{"createUser" => %{"name" => "user-1"}}} = reply

    # check to see if we got subscription data
    expected = %{
      result: %{
        data: %{
          "newUser" => get_in(reply, [:data, "createUser"])
        }
      },
      subscriptionId: subscription_id
    }

    assert_push "subscription:data", push
    assert expected == push
  end
end
