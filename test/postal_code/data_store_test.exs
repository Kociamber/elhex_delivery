defmodule ElhexDelivery.PostalCode.DataStoreTest do
  use ExUnit.Case
  alias ElhexDelivery.PostalCode.DataStore
  doctest ElhexDelivery

  test "get geolocation" do
    DataStore.start_link

    {latitude, longitude} = DataStore.get_geolocation("00601")

    assert is_float(latitude)
    assert is_float(longitude)
  end

end