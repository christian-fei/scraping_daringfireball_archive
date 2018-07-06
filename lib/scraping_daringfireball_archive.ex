defmodule ScrapingDaringfireballArchive do
  def start_link do
    case scrape_archive_links("https://daringfireball.net/archive/") do
      {:ok, links} ->
        IO.inspect(links)

        result =
          links
          |> Enum.map(&Task.async(fn -> scrape_number_of_words(&1) end))
          |> Enum.map(&Task.await(&1, 30000))

        IO.inspect(result)

        result
        |> Enum.filter(&only_ok/1)
        |> IO.inspect()

        {:ok, result}

      {:error, err} ->
        IO.inspect(err)
    end
  end

  defp only_ok({:ok, _url, _words}), do: true
  defp only_ok(_), do: false

  defp only_error({:error, _, _}), do: true
  defp only_error(_), do: false

  def scrape_archive_links(url \\ "https://daringfireball.net/archive/") do
    IO.puts("started scraping for links #{url}")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("finished scraping for links #{url}")
        {:ok, Parser.links(body)}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}

        {:error, :connect_timeout}

      _ ->
        IO.puts("Shit")
        {:error, "unhandled"}
    end
  end

  def scrape_number_of_words(%{href: url}) do
    IO.puts("started scraping for words #{url}")

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        words = Parser.words(body)
        IO.puts("finished scraping for words #{url}")
        {:ok, url, words}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, url, reason}

      _ ->
        IO.puts("Shit")
        {:error, url, "unhandled"}
    end
  end
end
