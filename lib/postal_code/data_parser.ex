defmodule ElhexDelivery.PostalCode.DataParser do
	@postal_code_filepath "data/codes.txt"

	def parse_data do
	  [_header | data_rows ] = 
      File.read!(@postal_code_filepath) 
      |> String.split("\n")

  	data_rows
  	|> Enum.map(fn(row) -> String.split(row, "\t") end)
  	|> Enum.filter_map(&row_filter(&1), &row_mapper(&1))
	end

	def row_filter(row) do
		case row do
			[_postal_code, _, _, _, _, _latitude, _longitude] -> true
			_ -> false
		end
	end

	def row_mapper(row) do
		[postal_code, _, _, _, _, latitude, longitude] = row 
  	[postal_code, latitude, longitude]
	end
end