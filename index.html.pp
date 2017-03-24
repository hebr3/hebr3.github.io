#lang pollen
◊(current-pagetree (dynamic-require "index.ptree" 'doc))
◊(require racket/list pollen/pagetree pollen/template pollen/private/version)
<!DOCTYPE html>
<html lang="en" class="gridded">
    <head>
        <meta charset="utf-8">
        <meta name="generator" content="Racket ◊(version) + Pollen ◊|pollen:version|">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Henry Brooks</title>
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
            <p><a href="/" class="home">Henry Brooks</a></p>
            <nav>
                <ul>
                    <li class="current-section"><a href="/topics.html">Topics</a></li>
                    <li><a href="/about.html">About</a></li>
                </ul>
            </nav>
        </header>
        
        ◊(let* ([top-ten (take (posts-by-date-desc) 10)]
                [top-ten-formed (map post-format top-ten)])
               (apply string-append 
                      (map ->html (add-between top-ten-formed '("\n\n" (hr)  "\n\n")))))

        <footer class="main">
            <ul>
                <li><a href="mailto:brook057@cougars.csusm.edu">brook057@cougars.csusm.edu</a></li>
                <li>Source code on<a href="https://github.com/hebr3/hebr3.github.io"> Github</a></li>
            </ul>
        </footer>
    </body>
</html>
