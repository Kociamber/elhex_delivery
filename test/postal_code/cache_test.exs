defmodule ElhexDelivery.PostalCode.CacheTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.Cache
  doctest ElhexDelivery

  test "get and set distance" do
    p1 = "12345"
    p2 = "98765"

    distance = 250.250

    Cache.set_distance(p1, p2, distance)
    retrieved_distance = Cache.get_distance(p1, p2)

    IO.inspect(Cache.set_distance(p1, p2, distance))
    assert distance == retrieved_distance
  end
end