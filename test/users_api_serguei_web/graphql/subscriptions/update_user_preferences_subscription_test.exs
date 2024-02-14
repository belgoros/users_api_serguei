defmodule UsersApiSergueiWeb.Graphql.Subscriptions.UpdateUserPreferencesSubscriptionTest do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.SubscriptionCase

  @update_user_preferences_subscription """
  subscription($userId: ID!, $likesEmails: Boolean = true, $likesPhoneCalls: Boolean, $likesFaxes: Boolean) {
    updateUserPreferences(userId: $userId, likesEmails: $likesEmails, likesPhoneCalls: $likesPhoneCalls, likesFaxes: $likesFaxes) {
      likesEmails
      likesPhoneCalls
      likesFaxes
    }
  }
  """

  @update_user_preferences_mutation """
  mutation($userId: ID!, $likesEmails: Boolean = true) {
    updateUserPreferences(userId: $userId, likesEmails: $likesEmails) {
      likesEmails
      likesPhoneCalls
      likesFaxes
    }
  }
  """

  test "updating a user can be subscribed to", %{socket: socket} do
    preference =
      insert(:preference, likes_faxes: true, likes_emails: true, likes_phone_calls: true)

    # setup a subscription
    ref =
      push_doc(socket, @update_user_preferences_subscription,
        variables: %{"userId" => preference.user.id}
      )

    assert_reply ref, :ok, %{subscriptionId: subscription_id}

    # run a mutation to trigger the subscription

    user_input = %{
      "userId" => preference.user.id,
      "likesEmails" => false
    }

    ref = push_doc(socket, @update_user_preferences_mutation, variables: user_input)
    assert_reply ref, :ok, reply

    assert %{
             data: %{
               "updateUserPreferences" => %{
                 "likesEmails" => false,
                 "likesFaxes" => true,
                 "likesPhoneCalls" => true
               }
             }
           } = reply

    # check to see if we got subscription data

    expected = %{
      result: %{
        data: %{
          "updateUserPreferences" => get_in(reply, [:data, "updateUserPreferences"])
        }
      },
      subscriptionId: subscription_id
    }

    assert_push "subscription:data", push
    assert expected == push
  end
end
