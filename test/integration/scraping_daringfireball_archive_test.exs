defmodule ScrapingDaringfireballArchiveTest do
  use ExUnit.Case
  doctest ScrapingDaringfireballArchive

  import Mock

  test "scrapes links from archive" do
    body =
      "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n\t<meta charset=\"UTF-8\" />\n\n\n\t<link rel=\"apple-touch-icon-precomposed\" href=\"/graphics/apple-touch-icon.png\" />\n\t<link rel=\"shortcut icon\" href=\"/graphics/favicon.ico?v=005\" />\n\t<link rel=\"mask-icon\" href=\"/graphics/dfstar.svg\" color=\"#4a525a\">\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  href=\"/css/fireball_screen.css?v1.8\" />\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  href=\"/css/ie_sucks.php\" />\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"print\"   href=\"/css/fireball_print.css?v01\" />\n\t<link rel=\"alternate\"  type=\"application/atom+xml\"     href=\"/feeds/main\" />\n\t<link rel=\"alternate\"  type=\"application/json\"         href=\"/feeds/json\" />\n\t<link href=\"https://micro.blog/gruber\" rel=\"me\" />\n\t<script src=\"/js/js-global/FancyZoom.js\" type=\"text/javascript\"></script>\n\t<script src=\"/js/js-global/FancyZoomHTML.js\" type=\"text/javascript\"></script>\n\t<link rel=\"shortcut icon\" href=\"/favicon.ico\" />\n\t<title>Daring Fireball: Archive</title>\n\t<script src=\"/mint/?js\" type=\"text/javascript\"></script>\n</head>\n<body>\n<div id=\"Box\">\n\n<div id=\"Banner\">\n<a href=\"/\" title=\"Daring Fireball: Home\"><img src=\"/graphics/logos/\" alt=\"Daring Fireball\" height=\"56\" /></a>\n</div>\n\n<div id=\"Sidebar\">\n<p>By <strong>John&nbsp;Gruber</strong></p>\n\n<ul><!--&#9733;-->\n<li><a href=\"/archive/\" title=\"Previous articles.\">Archive</a></li><li><script type=\"text/javascript\">\n// <![CDATA[\nfunction ReadCookie(name) {\n\tvar nameEQ = name + \"=\";\n\tvar ca = document.cookie.split(';');\n\tfor(var i=0; i < ca.length; i++) {\n\t\tvar c = ca[i];\n\t\twhile (c.charAt(0)==' ') c = c.substring(1, c.length);\n\t\tif (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);\n\t}\n\treturn null;\n}\nvar display_linked_list = ReadCookie('displayLinkedList');\nvar li_linked = '<a href=\"/linked/\" title=\"The Linked List.\">Linked List<\\/a>';\nif (display_linked_list == \"hide\") {\n\t// Linked List is off on home page, so show it in menu:\n\tdocument.write(li_linked + \"<\\/li>\\n<li>\");\n}\nelse {\n\t// Default to not putting separate LL item in sidebar:\n}\n// ]]>\n</script></li>\n<li><a href=\"/thetalkshow/\" title=\"The world’s most popular podcast.\">The Talk Show</a></li>\n<li><a href=\"/projects/\" title=\"Software projects, including SmartyPants and Markdown.\">Projects</a></li>\n<li><a href=\"/contact/\" title=\"How to send email regarding Daring Fireball.\">Contact</a></li>\n<li><a href=\"/colophon/\" title=\"About this site and the tools used to produce it.\">Colophon</a></li>\n<li><a href=\"/feeds/\">RSS Feed</a></li>\n<li><a href=\"https://twitter.com/daringfireball\">Twitter</a></li>\n<li><a href=\"/feeds/sponsors/\">Sponsorship</a></li>\n</ul>\n\n<?php\ninclude($dr . \"/martini/martini.inc\");\n?>\n\n</div> <!-- Sidebar -->\n\n<div id=\"Main\">\n<div class=\"archive\">\n\n<form id=\"SiteSearch\" action=\"/search\" method=\"get\" style=\"margin-bottom: 4em;\">\n<div>\n<input name=\"q\" type=\"text\" value=\"\" style=\"margin-right: 8px; width: 26em;\" />\n<input type=\"submit\" value=\"Search\" />\n</div>\n</form>\n<h1>Previously, on Daring Fireball</h1>\n\n<h2>June 2018</h2>\n\n\n<p><a href=\"https://daringfireball.net/2018/06/google_demos_duplex\">Google Demos Duplex</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>27&nbsp;Jun&nbsp;2018</small></p>\n\n<h2>May 2018</h2>\n\n\n<p><a href=\"https://daringfireball.net/2018/05/10_strikes_and_youre_out\">10 Strikes and You&#8217;re Out &#8212; the iOS Feature You&#8217;re Probably Not Using But Should</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>31&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/yammering_on_regarding_google_duplex\">Yammering on One More Time Regarding Google&#8217;s Duplex Recordings</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>22&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/duplex_booked_restaurant\">The Restaurant Where Google Claims to Have Booked an Actual Meal Via Duplex</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>17&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/the_end_of_third_party_twitter_clients\">The End of Third-Party Twitter Clients?</a>"

    with_mock HTTPoison,
      get: fn _url -> {:ok, %HTTPoison.Response{status_code: 200, body: body}} end do
      response = ScrapingDaringfireballArchive.start_link()

      assert called(HTTPoison.get("https://daringfireball.net/archive/"))

      assert(
        response ==
          {:ok,
           [
             {:ok, "https://daringfireball.net/2018/06/google_demos_duplex", [""]},
             {:ok, "https://daringfireball.net/2018/05/10_strikes_and_youre_out", [""]},
             {:ok, "https://daringfireball.net/2018/05/yammering_on_regarding_google_duplex",
              [""]},
             {:ok, "https://daringfireball.net/2018/05/duplex_booked_restaurant", [""]},
             {:ok, "https://daringfireball.net/2018/05/the_end_of_third_party_twitter_clients",
              [""]}
           ]}
      )
    end
  end
end
