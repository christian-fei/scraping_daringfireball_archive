defmodule Parser do
  def links(html) do
    html
    |> Floki.find(".archive p a")
    |> Enum.take(5)
    |> Enum.filter(fn link ->
      case link do
        {"a", [{"href", _url}], [_text]} -> true
        _ -> false
      end
    end)
    |> Enum.map(fn item ->
      %{
        href: Floki.attribute(item, "href") |> List.first()
      }
    end)
  end
end
