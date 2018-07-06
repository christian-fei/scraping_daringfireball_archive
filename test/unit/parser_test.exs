defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "extracts links from html" do
    html = """
    <!DOCTYPE html>\n<html lang=\"en\">\n<head>\n\t<meta charset=\"UTF-8\" />\n\n\n\t<link rel=\"apple-touch-icon-precomposed\" href=\"/graphics/apple-touch-icon.png\" />\n\t<link rel=\"shortcut icon\" href=\"/graphics/favicon.ico?v=005\" />\n\t<link rel=\"mask-icon\" href=\"/graphics/dfstar.svg\" color=\"#4a525a\">\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  href=\"/css/fireball_screen.css?v1.8\" />\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  href=\"/css/ie_sucks.php\" />\n\t<link rel=\"stylesheet\" type=\"text/css\" media=\"print\"   href=\"/css/fireball_print.css?v01\" />\n\t<link rel=\"alternate\"  type=\"application/atom+xml\"     href=\"/feeds/main\" />\n\t<link rel=\"alternate\"  type=\"application/json\"         href=\"/feeds/json\" />\n\t<link href=\"https://micro.blog/gruber\" rel=\"me\" />\n\t<script src=\"/js/js-global/FancyZoom.js\" type=\"text/javascript\"></script>\n\t<script src=\"/js/js-global/FancyZoomHTML.js\" type=\"text/javascript\"></script>\n\t<link rel=\"shortcut icon\" href=\"/favicon.ico\" />\n\t<title>Daring Fireball: Archive</title>\n\t<script src=\"/mint/?js\" type=\"text/javascript\"></script>\n</head>\n<body>\n<div id=\"Box\">\n\n<div id=\"Banner\">\n<a href=\"/\" title=\"Daring Fireball: Home\"><img src=\"/graphics/logos/\" alt=\"Daring Fireball\" height=\"56\" /></a>\n</div>\n\n<div id=\"Sidebar\">\n<p>By <strong>John&nbsp;Gruber</strong></p>\n\n<ul><!--&#9733;-->\n<li><a href=\"/archive/\" title=\"Previous articles.\">Archive</a></li><li><script type=\"text/javascript\">\n// <![CDATA[\nfunction ReadCookie(name) {\n\tvar nameEQ = name + \"=\";\n\tvar ca = document.cookie.split(';');\n\tfor(var i=0; i < ca.length; i++) {\n\t\tvar c = ca[i];\n\t\twhile (c.charAt(0)==' ') c = c.substring(1, c.length);\n\t\tif (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);\n\t}\n\treturn null;\n}\nvar display_linked_list = ReadCookie('displayLinkedList');\nvar li_linked = '<a href=\"/linked/\" title=\"The Linked List.\">Linked List<\\/a>';\nif (display_linked_list == \"hide\") {\n\t// Linked List is off on home page, so show it in menu:\n\tdocument.write(li_linked + \"<\\/li>\\n<li>\");\n}\nelse {\n\t// Default to not putting separate LL item in sidebar:\n}\n// ]]>\n</script></li>\n<li><a href=\"/thetalkshow/\" title=\"The world’s most popular podcast.\">The Talk Show</a></li>\n<li><a href=\"/projects/\" title=\"Software projects, including SmartyPants and Markdown.\">Projects</a></li>\n<li><a href=\"/contact/\" title=\"How to send email regarding Daring Fireball.\">Contact</a></li>\n<li><a href=\"/colophon/\" title=\"About this site and the tools used to produce it.\">Colophon</a></li>\n<li><a href=\"/feeds/\">RSS Feed</a></li>\n<li><a href=\"https://twitter.com/daringfireball\">Twitter</a></li>\n<li><a href=\"/feeds/sponsors/\">Sponsorship</a></li>\n</ul>\n\n<?php\ninclude($dr . \"/martini/martini.inc\");\n?>\n\n</div> <!-- Sidebar -->\n\n<div id=\"Main\">\n<div class=\"archive\">\n\n<form id=\"SiteSearch\" action=\"/search\" method=\"get\" style=\"margin-bottom: 4em;\">\n<div>\n<input name=\"q\" type=\"text\" value=\"\" style=\"margin-right: 8px; width: 26em;\" />\n<input type=\"submit\" value=\"Search\" />\n</div>\n</form>\n<h1>Previously, on Daring Fireball</h1>\n\n<h2>June 2018</h2>\n\n\n<p><a href=\"https://daringfireball.net/2018/06/google_demos_duplex\">Google Demos Duplex</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>27&nbsp;Jun&nbsp;2018</small></p>\n\n<h2>May 2018</h2>\n\n\n<p><a href=\"https://daringfireball.net/2018/05/10_strikes_and_youre_out\">10 Strikes and You&#8217;re Out &#8212; the iOS Feature You&#8217;re Probably Not Using But Should</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>31&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/yammering_on_regarding_google_duplex\">Yammering on One More Time Regarding Google&#8217;s Duplex Recordings</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>22&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/duplex_booked_restaurant\">The Restaurant Where Google Claims to Have Booked an Actual Meal Via Duplex</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<small>17&nbsp;May&nbsp;2018</small></p>\n\n<p><a href=\"https://daringfireball.net/2018/05/the_end_of_third_party_twitter_clients\">The End of Third-Party Twitter Clients?</a>
    """

    assert(
      Parser.links(html) == [
        %{
          href: "https://daringfireball.net/2018/06/google_demos_duplex"
        },
        %{
          href: "https://daringfireball.net/2018/05/10_strikes_and_youre_out"
        },
        %{
          href: "https://daringfireball.net/2018/05/yammering_on_regarding_google_duplex"
        },
        %{
          href: "https://daringfireball.net/2018/05/duplex_booked_restaurant"
        },
        %{
          href: "https://daringfireball.net/2018/05/the_end_of_third_party_twitter_clients"
        }
      ]
    )
  end

  test "extracts words from html" do
    html = """
    <!DOCTYPE html><html lang="en"><head> <meta charset="UTF-8"/> <title>Daring Fireball: Google Demos Duplex</title> <meta name="twitter:card" content="summary"/> <meta name="twitter:site" content="@daringfireball"/> <meta name="twitter:creator" content="@gruber"/> <meta name="twitter:title" content="Google Demos Duplex"/> <meta name="twitter:description" content="Google’s breakthrough isn’t how smart Duplex is, but how human-like it sounds."/> <meta name="twitter:image" content="https://daringfireball.net/graphics/df-square-1024"/> <meta property="og:site_name" content="Daring Fireball"/> <meta property="og:title" content="Google Demos Duplex"/> <meta property="og:url" content="https://daringfireball.net/2018/06/google_demos_duplex"/> <meta property="og:description" content="Google’s breakthrough isn’t how smart Duplex is, but how human-like it sounds."/> <meta property="og:image" content="https://daringfireball.net/graphics/df-square-1024"/> <meta property="og:type" content="article"/> <meta name="viewport" content="width=500, minimum-scale=0.45"/> <link rel="apple-touch-icon-precomposed" href="/graphics/apple-touch-icon.png"/> <link rel="shortcut icon" href="/graphics/favicon.ico?v=005"/> <link rel="mask-icon" href="/graphics/dfstar.svg" color="#4a525a"> <link rel="stylesheet" type="text/css" media="screen" href="/css/fireball_screen.css?v1.8"/> <link rel="stylesheet" type="text/css" media="screen" href="/css/ie_sucks.php"/> <link rel="stylesheet" type="text/css" media="print" href="/css/fireball_print.css?v01"/> <link rel="alternate" type="application/atom+xml" href="/feeds/main"/> <link rel="alternate" type="application/json" href="/feeds/json"/> <link href="https://micro.blog/gruber" rel="me"/> <script src="/js/js-global/FancyZoom.js" type="text/javascript"></script> <script src="/js/js-global/FancyZoomHTML.js" type="text/javascript"></script> <link rel="home" href="/" title="Home"/> <link rel="shorturl" href="http://df4.us/qz9"/> <link rel="prev" href="https://daringfireball.net/2018/05/10_strikes_and_youre_out" title="10 Strikes and You&#8217;re Out &#8212; the iOS Feature You&#8217;re Probably Not Using But Should"/></head><body onload="setupZoom()"><div id="Box"><div id="Sidebar">"Daring Fireball: Home"><img src="/graphics/logos/" alt="Daring Fireball" height="56"/></a><p>By <strong>John&nbsp;Gruber</strong></p><ul><li><a href="/archive/" title="Previous articles.">Archive</a></li><li><script type="text/javascript">//<![CDATA[function ReadCookie(name){var nameEQ=name + "="; var ca=document.cookie.split(';'); for(var i=0; i < ca.length; i++){var c=ca[i]; while (c.charAt(0)==' ') c=c.substring(1, c.length); if (c.indexOf(nameEQ)==0) return c.substring(nameEQ.length, c.length);}return null;}var display_linked_list=ReadCookie('displayLinkedList');var li_linked='<a href="/linked/" title="The Linked List.">Linked List</a>';if (display_linked_list=="hide"){// Linked List is off on home page, so show it in menu: document.write(li_linked + "</li>\n<li>");}else{// Default to not putting separate LL item in sidebar:}//]]></script></li><li><a href="/thetalkshow/" title="The world’s most popular podcast.">The Talk Show</a></li><li><a href="/projects/" title="Software projects, including SmartyPants and Markdown.">Projects</a></li><li><a href="/contact/" title="How to send email regarding Daring Fireball.">Contact</a></li><li><a href="/colophon/" title="About this site and the tools used to produce it.">Colophon</a></li><li><a href="/feeds/">RSS Feed</a></li><li><a href="https://twitter.com/daringfireball">Twitter</a></li><li><a href="/feeds/sponsors/">Sponsorship</a></li></ul><div id="SidebarMartini"><a href="https://fieldnotesbrand.com/?utm_source=df&utm_medium=Referral"> <img alt="Field Notes" src="/martini/2018/07/fn_capsules.jpg" height="90"></a><p>One small step for notebooks. The “Three Missions” Edition from Field Notes.</p></div></div><div id="Main"><div class="article"><h1>Google Demos Duplex</h1><h6 class="dateline">Wednesday, 27 June 2018</h6><p>Google has finally done what they should&#8217;ve done initially: let a group of journalists (two groups actually, one on each coast) actually listen to and participate in live Duplex calls.</p><p><a href="https://money.cnn.com/2018/06/27/technology/google-duplex-demos/index.html">Heather Kelly, writing for CNN</a>:</p><blockquote> <p>For one minute and ten seconds on Tuesday, I worked in a trendyhummus shop and took a reservation from a guy who punctuated hissentences with &#8220;awesome&#8221; and &#8220;um.&#8221;</p><p>&#8220;Hi, I&#8217;m calling to make a reservation,&#8221; the caller said, soundinga lot like a stereotypical California surfer. Then he came clean:&#8220;I&#8217;m Google&#8217;s automated booking service, so I&#8217;ll record the call.Um, can I book a table for Saturday?&#8221;</p><p>The guy was Google Duplex, the AI-assisted assistant that made astir in May when CEO Sundar Pichai unveiled it at its Google I/Odeveloper conference. That demo, shown in a slick video, was soimpressive that some people said it had to be fake.</p><p>Not so, says Google, which invited clusters of reporters to Oren&#8217;sHummus Shop near its campus in Mountain View, for a hands-ondemonstration. Each of us got to field an automated call and testthe system&#8217;s limits.</p></blockquote>
    """

    assert(
      Parser.words(html) == [
        "Google",
        "Demos",
        "DuplexWednesday,",
        "27",
        "June",
        "2018Google",
        "has",
        "finally",
        "done",
        "what",
        "they",
        "should’ve",
        "done",
        "initially:",
        "let",
        "a",
        "group",
        "of",
        "journalists",
        "(two",
        "groups",
        "actually,",
        "one",
        "on",
        "each",
        "coast)",
        "actually",
        "listen",
        "to",
        "and",
        "participate",
        "in",
        "live",
        "Duplex",
        "calls.Heather",
        "Kelly,",
        "writing",
        "for",
        "CNN:For",
        "one",
        "minute",
        "and",
        "ten",
        "seconds",
        "on",
        "Tuesday,",
        "I",
        "worked",
        "in",
        "a",
        "trendyhummus",
        "shop",
        "and",
        "took",
        "a",
        "reservation",
        "from",
        "a",
        "guy",
        "who",
        "punctuated",
        "hissentences",
        "with",
        "“awesome”",
        "and",
        "“um.”“Hi,",
        "I’m",
        "calling",
        "to",
        "make",
        "a",
        "reservation,”",
        "the",
        "caller",
        "said,",
        "soundinga",
        "lot",
        "like",
        "a",
        "stereotypical",
        "California",
        "surfer.",
        "Then",
        "he",
        "came",
        "clean:“I’m",
        "Google’s",
        "automated",
        "booking",
        "service,",
        "so",
        "I’ll",
        "record",
        "the",
        "call.Um,",
        "can",
        "I",
        "book",
        "a",
        "table",
        "for",
        "Saturday?”The",
        "guy",
        "was",
        "Google",
        "Duplex,",
        "the",
        "AI-assisted",
        "assistant",
        "that",
        "made",
        "astir",
        "in",
        "May",
        "when",
        "CEO",
        "Sundar",
        "Pichai",
        "unveiled",
        "it",
        "at",
        "its",
        "Google",
        "I/Odeveloper",
        "conference.",
        "That",
        "demo,",
        "shown",
        "in",
        "a",
        "slick",
        "video,",
        "was",
        "soimpressive",
        "that",
        "some",
        "people",
        "said",
        "it",
        "had",
        "to",
        "be",
        "fake.Not",
        "so,",
        "says",
        "Google,",
        "which",
        "invited",
        "clusters",
        "of",
        "reporters",
        "to",
        "Oren’sHummus",
        "Shop",
        "near",
        "its",
        "campus",
        "in",
        "Mountain",
        "View,",
        "for",
        "a",
        "hands-ondemonstration.",
        "Each",
        "of",
        "us",
        "got",
        "to",
        "field",
        "an",
        "automated",
        "call",
        "and",
        "testthe",
        "system’s",
        "limits."
      ]
    )
  end
end
