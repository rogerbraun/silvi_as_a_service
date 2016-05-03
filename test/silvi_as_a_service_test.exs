defmodule SilviAsAServiceTest do
  use ExUnit.Case
  doctest SilviAsAService

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "parser parses" do
    html = File.read!("test/fixtures/silvi.html")
    monday = %{
      date: "02.05.2016",
      day: "Montag",
      menu: [
        %{
          name: "Rostbratwurst mit frischem Kartoffelpüree, dazu Sauerkraut",
          price: "€  4,00"
        },
        %{
          name: "Pangasiusfilet mit Gemüse und Kartoffelpüree (solange Vorrat reicht!)",
          price: "€  5,10"
        },
        %{
          name: "Pellkartoffeln mit Kräuterquark, dazu  Leinen Öl",
          price: "€  3,60"
        }
      ]
    }

    parsed_monday = SilviAsAService.parse(html) |> List.first

    assert parsed_monday == monday
  end
end
