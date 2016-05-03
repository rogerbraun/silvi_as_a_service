defmodule SilviAsAService do
  def parse(html) do
    rows = html |> Floki.find("tr")

    rows |> Enum.map(fn(row) ->
      columns = row
      |> Floki.find("td")

      day = Enum.at(columns, 0)
      menu = Enum.at(columns, 1)
      price = Enum.at(columns, 2)

      [ day, date ] = parse_day(day)
      menu = parse_items(menu)
      price = parse_items(price)
      menu_length = Enum.count(menu)
      price_length = Enum.count(price)

      if menu_length > price_length do
        price = Enum.concat(price, List.duplicate("", menu_length - price_length))
      end

      menu = Enum.zip(menu, price)
      |> Enum.map(fn({name, price}) -> %{name: name, price: price} end)

      %{
        day: day,
        date: date,
        menu: menu
      }
    end
    )
  end

  defp filter_empty_paragraphs(doc) do
   doc
    |> Floki.find("p")
    |> Enum.filter(fn (p) ->
      p
      |> Floki.text
      |> String.strip
      != ""
    end)
  end

  defp reduce_menu_list("", []) do
    []
  end

  defp reduce_menu_list(text, []) do
    [text]
  end

  defp reduce_menu_list("", ["" | _tail] = acc) do
    acc
  end

  defp reduce_menu_list("", [_text | _tail] = acc) do
    [ "" | acc ]
  end

  defp reduce_menu_list(text, ["" | tail] ) do
    [text | tail ]
  end

  defp reduce_menu_list(text, [existing_text | tail] ) do
    ["#{existing_text} #{text}" | tail ]
  end

  defp to_stripped_strings(ps) do
    Enum.map(ps, fn(p) ->
      p
      |> Floki.text
      |> String.strip
    end)
  end

  defp parse_items(menu) do
    menu
    |> Floki.find("p")
    |> to_stripped_strings
    |> Enum.reduce([], &reduce_menu_list/2)
    |> Enum.reject(&(&1 == ""))
    |> Enum.reverse
  end

  defp parse_day(day) do
    day
    |> filter_empty_paragraphs
    |> Enum.map(fn (p) ->
      p
      |> Floki.text
      |> String.strip(?,)
    end
    )
  end
end
