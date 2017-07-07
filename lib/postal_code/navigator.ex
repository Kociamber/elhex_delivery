defmodule ElhexDelivery.PostalCode.Navigator do
  alias ElhexDelivery.PostalCode.DataStore

  def get_distance(from, to) do
    do_get_distance(from, to)
  end

  defp do_get_distance(from, to) do
    {lat1, long1} = get_geolocation(from)
    {lat2, long2} = get_geolocation(to)

    calculate_distance({lat1, long1}, {lat2, long2})
  end

  # If postal copde is string, get geo location.
  defp get_geolocation(postal_code) when is_binary(postal_code) do
    DataStore.get_geolocation(postal_code)
  end

  # Ensure that postal code is string and get geo location.
  defp get_geolocation(postal_code) when is_integer(postal_code) do
    postal_code
    |> Integer.to_string
    |> get_geolocation
  end

  # Raise error in case of weird format. 
  defp get_geolocation(postal_code) do
    error = "Unexpected `postal_code`, received: #{inspect(postal_code)}"
    raise ArgumentError, error
  end

  defp calculate_distance({lat1, long1}, {lat2, long2}) do
    
  end
end