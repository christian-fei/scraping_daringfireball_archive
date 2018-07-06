defmodule Parser do
  def urls(html) do
    html
    |> Floki.find(".archive p a")
    |> Enum.filter(fn el ->
      case el do
        {"a", [{"href", _url}], [_text]} -> true
        _ -> false
      end
    end)
    |> Enum.map(fn item -> Floki.attribute(item, "href") |> List.first() end)
  end

  def words(html) do
    html
    |> Floki.find(".article")
    |> Floki.text()
    |> String.split(" ")
  end

  def count_words(words) do
    length(words)
  end
end
