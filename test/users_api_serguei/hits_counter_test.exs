defmodule UsersApiSerguei.HitsCounterTest do
  use UsersApiSergueiWeb.ConnCase
  use UsersApiSergueiWeb.RepoCase

  alias UsersApiSerguei.HitsCounter

  setup do
    HitsCounter.clear()
  end

  test "the counter should increment by one " do
    HitsCounter.increment_number(:find_user)
    assert 1 == HitsCounter.resolver_hits(:find_user)

    HitsCounter.increment_number(:find_user)
    HitsCounter.increment_number(:find_user)
    assert 3 == HitsCounter.resolver_hits(:find_user)
  end

  test "the counter should be cleared " do
    HitsCounter.increment_number(:find_user)
    assert 1 == HitsCounter.resolver_hits(:find_user)

    HitsCounter.clear()
    assert 0 == HitsCounter.resolver_hits(:find_user)
  end
end
