defmodule ElhexDelivery.PostalCode.DataParserTest do
	use ExUnit.Case
	alias ElhexDelivery.PostalCode.DataParser
	doctest ElhexDelivery

	# Just check whether postal code file is not empty
	test "parse stuff" do
		geo_data = DataParser.parse_data
		{latitude, longitude} = Map.get(geo_data, "00601")
		
		assert is_float(latitude)
		assert is_float(longitude)
	end
end