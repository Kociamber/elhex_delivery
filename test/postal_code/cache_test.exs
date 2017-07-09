defmodule ElhexDelivery.PostalCode.CacheTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.Cache
  doctest ElhexDelivery

  test "get and set distance" do
    p1 = "12345"
    p2 = "98765"
    p3 = "121212"
    p4 = 454545

    distance1 = 250.25
    distance2 = 220.20

    Cache.set_distance(p1, p2, distance1)
    Cache.set_distance(p3, p4, distance2)
    retrieved_distance1 = Cache.get_distance(p1, p2)
    retrieved_distance2 = Cache.get_distance(p3, p4)

    assert distance1 == retrieved_distance1
    assert distance2 == retrieved_distance2
  end
end