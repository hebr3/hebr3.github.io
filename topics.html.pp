#lang pollen

◊(local-require "util-topics.rkt" pollen/template pollen/pagetree pollen/private/version)
◊(define main-pagetree (dynamic-require "index.ptree" 'doc))

<!DOCTYPE html>
<html lang="en" class="gridded">
    <head>
        <meta charset="utf-8">
        <meta name="generator" content="Racket ◊(version) + Pollen ◊|pollen:version|">
        <title>Topics</title>
        <link rel="stylesheet" href="/styles.css" media="screen">
		<script type="text/javascript" 
		  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
		</script>
		<script type="text/x-mathjax-config">
		  MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$']]}});
		</script>
                <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/default.min.css">
                <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.10.0/highlight.min.js"></script>
                <script>hljs.initHighlightingOnLoad()</script>
    </head>
    <body>
        <header class="main">
            <p><a href="/" class="home">Henry Brooks</a></p>
            <nav>
                <ul>
                    <li><a href="/topics.html">Topics</a></li>
                    <li><a href="/about.html">About</a></li>
                </ul>
            </nav>
        </header>
        <section class="main">
            ◊; Get two lists: one of all index links in the current pagetree,
            ◊; another of all the unique headings used in the first list.
            ◊(define tlinks (collect-index-links (children 'index.html main-pagetree)))
            ◊(define topics (index-headings tlinks))
            <dl class="topic-list">
                ◊(define (ddlink lnk) `(dd ,lnk))
                ◊(->html (apply append (for/list([topic topics])
                                         `((dt (a [[href ,(string-append "#" topic)]
                                                   [name ,topic]] ,topic))
                                           ,@(map ddlink (match-index-links topic tlinks))))))
            </dl>
        </section>
        <footer class="main">
            <ul>
                <li><a href="mailto:brook057@cougars.csusm.edu">brook057@cougars.csusm.edu</a></li>
                <li>Source code on <a href="https://github.com/hebr3/hebr3.github.io"> Github</a></li>
            </ul>
        </footer>
    </body>
</html>
