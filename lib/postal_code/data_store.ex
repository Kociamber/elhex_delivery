defmodule ElhexDelivery.PostalCode.DataStore do
  use GenServer
  alias ElhexDelivery.PostalCode.DataParser

  ## GenServer client API

  # %{} is pointing at GenServer's state typ while name provides process name. Naming a process 
  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :data_store)
  end

  def get_geolocation(postal_code) do
    GenServer.call(:data_store, {:get_geolocation, postal_code})
  end

  ## GenServer server API / callbacks

  def init(_) do
    {:ok, DataParser.parse_data}
  end

  def handle_call({:get_geolocation, postal_code}, _from, geo_data) do
    geo_location = Map.get(geo_data, postal_code)
    {:reply, geo_location, geo_data}
  end
end