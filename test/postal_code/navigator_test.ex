defmodule ElhexDelivery.PostalCode.NavigatorTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.Navigator
  doctest ElhexDelivery

  describe "get_distance format tests" do
    test "postal codes are strings" do
      distance = Navigator.get_distance("00601", "94062")
    end

    test "postal codes are integers" do
      distance = Navigator.get_distance(00601, 94062)
    end

    test "postal codes are mixed types" do
      distance = Navigator.get_distance("00601", 94062)
    end

    test "postal codes are in unexpected format" do
      assert_raise ArgumentError, fn -> distance = Navigator.get_distance("Q%%%&*(*&", 94.062) end
    end
  end
end