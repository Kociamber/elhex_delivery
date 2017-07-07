defmodule ElhexDelivery.PostalCode.Navigator do
  alias ElhexDelivery.PostalCode.DataStore
  alias :math, as: Math
  use GenServer

  @radius_km 6371
  # @radius_mi 3959

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :postal_code_navigator)
  end

  def get_distance(from, to) do
    GenServer.call(:postal_code_navigator, {:get_distance, from, to})
  end

  # Server API (Callbacks)

  def handle_call({:get_distance, from, to}, _from, state) do
    distance = do_get_distance(from, to)
    {:reply, distance, state}
  end

  defp do_get_distance(from, to) do
    {lat1, long1} = get_geolocation(from)
    {lat2, long2} = get_geolocation(to)

    calculate_distance({lat1, long1}, {lat2, long2})
  end

  # Ensure that postal code is string and get geo location.
  defp get_geolocation(postal_code) when is_integer(postal_code) do
    postal_code
    |> Integer.to_string
    |> get_geolocation
  end

  # If postal copde is string, get geo location.
  defp get_geolocation(postal_code) when is_binary(postal_code) do
    DataStore.get_geolocation(postal_code)
  end

  # Raise error in case of weird format. 
  defp get_geolocation(postal_code) do
    error = "Unexpected `postal_code`, received: #{inspect(postal_code)}"
    raise ArgumentError, error
  end

   defp calculate_distance({lat1, long1}, {lat2, long2}) do
    lat_diff = degrees_to_radians(lat2 - lat1)
    long_diff = degrees_to_radians(long2 - long1)

    lat1 = degrees_to_radians(lat1)
    lat2 = degrees_to_radians(lat2)

    cos_lat1 = Math.cos(lat1)
    cos_lat2 = Math.cos(lat2)

    sin_lat_diff_sq = Math.sin(lat_diff / 2) |> Math.pow(2)
    sin_long_diff_sq = Math.sin(long_diff / 2) |> Math.pow(2)

    a = sin_lat_diff_sq + (cos_lat1 * cos_lat2 * sin_long_diff_sq)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    @radius_km * c |> Float.round(2)
  end

  defp degrees_to_radians(degrees) do
    degrees * (Math.pi / 180)
  end

end