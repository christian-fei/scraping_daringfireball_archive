defmodule ScrapingDaringfireballArchive do
  def start_link do
    "https://daringfireball.net/archive/"
    |> scrape_archive_links

    # |> IO.inspect
  end

  def scrape_archive_links(url \\ "https://daringfireball.net/archive/") do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Parser.links(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      _ ->
        IO.puts("Shit")
        {:error, "unhandled"}
    end
  end

  def hello do
    :world
  end
end
