defmodule ScrapingDaringfireballArchive do
  def start_link() do
    case Scraper.scrape_archive_links("https://daringfireball.net/archive/") do
      {:ok, urls} ->
        result = Scraper.scrape_urls(urls)

        error_tasks = result |> Enum.filter(&only_error/1)

        error_urls =
          error_tasks
          |> Enum.map(fn {:error, url, _} -> url end)

        result = (result ++ Scraper.scrape_urls(error_urls)) |> Enum.filter(&only_ok/1)

        ok_tasks = result |> Enum.filter(&only_ok/1)

        word_count =
          ok_tasks |> Enum.reduce(0, fn {:ok, _url, words}, acc -> acc + length(words) end)

        {:ok, [word_count: word_count]}

      {:error, err} ->
        IO.inspect(err)
    end
  end

  defp only_ok({:ok, _url, _words}), do: true
  defp only_ok(_), do: false

  defp only_error({:error, _, _}), do: true
  defp only_error(_), do: false
end
