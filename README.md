# ScrapingDaringfireballArchive

> inspiration from: http://www.akitaonrails.com/2015/11/18/ex-manga-downloader-an-exercise-with-elixir

for now, run it with:

```
mix deps.get
iex -S mix

ScrapingDaringfireballArchive.start_link
```

you should see something like:

```
...
finished scraping for words https://daringfireball.net/2012/01/ima_set_it_straight_this_watergate
finished scraping for words https://daringfireball.net/2012/09/iphone_5
finished scraping for words https://daringfireball.net/2011/10/iphone_4s
finished scraping for words https://daringfireball.net/2012/03/ipad_3
finished scraping for words https://daringfireball.net/2012/11/seriously_apple_is_doomed
finished scraping for words https://daringfireball.net/2012/08/pixel_perfect
finished scraping for words https://daringfireball.net/2012/02/walter_isaacson_steve_jobs
finished scraping for words https://daringfireball.net/2012/02/mountain_lion
{:ok, [word_count: 338145]}
iex(23)>
```