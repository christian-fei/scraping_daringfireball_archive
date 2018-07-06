defmodule Scraper do
  def scrape_urls(urls) do
    urls
    |> Enum.map(&scrape_url/1)
    |> Enum.map(&Task.await(&1, 30000))
  end

  def scrape_url(url) do
    Task.async(fn -> scrape_number_of_words(url) end)
  end

  def scrape_archive_links(url \\ "https://daringfireball.net/archive/") do
    IO.puts("started scraping for url #{url}")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("finished scraping for url #{url}")
        {:ok, Parser.urls(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

      {:error, :connect_timeout} ->
        {:error, :connect_timeout}

      _ ->
        IO.puts("unhandled")
        {:error, "unhandled"}
    end
  end

  def scrape_number_of_words(url) do
    IO.puts("started scraping for words #{url}")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        words = Parser.words(body)
        IO.puts("finished scraping for words #{url}")
        {:ok, url, words}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, url, reason}

      {:error, :connect_timeout} ->
        {:error, :connect_timeout}

      _ ->
        IO.puts("unhandled")
        {:error, url, "unhandled"}
    end
  end
end
