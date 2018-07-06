defmodule ScrapingDaringfireballArchive do
  def start_link do
    case scrape_archive_links("https://daringfireball.net/archive/") do
      {:ok, links} ->
        links
        |> Enum.map(&scrape_number_of_words/1)

        {:ok, links}

      {:error, err} ->
        IO.inspect(err)
    end
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

  def scrape_number_of_words(%{href: url}) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        words = Parser.words(body)
        IO.inspect words
        {:ok, words}

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
