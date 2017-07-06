defmodule ElhexDelivery.PostalCode.DataParserTest do
	use ExUnit.Case
	alias ElhexDelivery.PostalCode.DataParser
	doctest ElhexDelivery

	# Just check whether postal code file is not empty
	test "parse stuff" do
		data_rows = DataParser.parse_data
		first_row = Enum.at(data_rows, 0)
		IO.inspect(first_row)
	end
end