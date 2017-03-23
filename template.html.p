◊(define path-prefix (if (string-contains (symbol->string here) "/") "../" ""))
◊(define source-file (select-from-metas 'here-path metas))
◊(define pollen-source-listing
    (regexp-replace #px"(\\.html$)" (symbol->string here) ".pollen.html"))
◊(local-require pollen/private/version)
<!DOCTYPE html>
<html lang="en" class="gridded">
    <head>
        <meta charset="utf-8">
        <meta name="generator" content="Racket ◊(version) + Pollen ◊|pollen:version|">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>◊(select-from-metas 'title here)</title>
        <link rel="stylesheet" href="/styles.css" media="screen">
		<script type="text/javascript" 
		  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
		</script>
		<script type="text/x-mathjax-config">
		  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$']]}});
		</script>
    </head>
    <body>
        <header class="main">
            <p><a href="/index.html" class="home">Henry Brooks</a></p>
            <nav>
                <ul>
                    <li><a href="/topics.html">Topics</a></li>
                    <li><a href="/about.html">About</a></li>
                </ul>
            </nav>
        </header>

        <article>
            <header>
                <h1>◊(select-from-metas 'title here)</h1>
                <p>◊when/splice[(select-from-metas 'published here)]{Scribbled <a href="/◊(symbol->string here)" class="permlink"><time datetime="◊(select-from-metas 'published here)">◊(pubdate->english (select-from-metas 'published here))</time></a>}
                ◊when/splice[(select-from-metas 'updated here)]{&middot; <em>Updated <time datetime="◊(select-from-metas 'updated here)">◊(pubdate->english (select-from-metas 'updated here))</time></em>}</p>
                ◊when/splice[(select-from-metas 'topics here)]{<ul>
                    ◊(map (λ(t-str)(->html `(li (a [[href ,(string-append "/topics.html#" t-str)]] "#" ,t-str))))
                          (string-split (select-from-metas 'topics here) ","))</ul>}
            </header>

◊(map ->html (select-from-doc 'body here))
        </article>
        <footer class="main">
            <ul>
                <li><a href="mailto:brook057@cougars.csusm.edu">brook057@cougars.csusm.edu</a></li>
                <li>Source code on <a href="https://github.com/hebr3/hebr3.github.io"> <b>Github</b></a></li>
            </ul>
        </footer>
    </body>
</html>
