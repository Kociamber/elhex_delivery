defmodule ElhexDelivery.PostalCode.DataParser do
  @postal_code_filepath "data/codes.txt"

  def parse_data do
    [_header | data_rows ] = 
      File.read!(@postal_code_filepath) 
      |> String.split("\n")

    data_rows
    |> Stream.map(fn(row) -> String.split(row, "\t") end)
    |> Stream.filter_map(&row_filter(&1), &row_mapper(&1))
    |> Stream.map(&transform_to_tuples(&1))
    |> Enum.into(%{})
  end

  # Ensure we are procesing only non-empty rows in a correct format.
  defp row_filter(row) do
    case row do
      [_postal_code, _, _, _, _, _latitude, _longitude] -> true
      _ -> false
    end
  end

  # Re-format row lists.
  defp row_mapper(row) do
    [postal_code, _, _, _, _, latitude, longitude] = row 
    [postal_code, latitude, longitude]
  end

  # Re-format row lists to tuples before converting them to maps. 
  defp transform_to_tuples(row) do
    [postal_code, latitude, longitude] = row
    
    latitude =
      latitude 
      |> String.trim
      |> String.to_float

    longitude =
      longitude 
      |> String.trim
      |> String.to_float

    {postal_code, {latitude, longitude}}
  end
end