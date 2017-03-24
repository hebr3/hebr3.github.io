#lang pollen

◊(define-meta title "Daily Desmos - 24 April - Advanced Hyperbola")
◊(define-meta published "2015-04-24")
◊(define-meta topics "Daily Desmos,20% Project")

◊(require scribble-math)
◊(use-mathjax)
◊(define ($ . xs) 
  `(mathjax ,(apply string-append `("$" ,@xs "$"))))
◊(define ($$ . xs)
  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

◊figure["dd-24apr-adv-a.gif"]
◊figure["dd-24apr-adv-b.gif"]

◊link["http://http://dailydesmos.com/2015/04/24/warping-hyperbola-1-advanced/"]{Daily Desmos} posted this challenge on the 24th of April.

My solution is a little off however, it does hit on most of the important aspects. You can check out my version  ◊link["https://www.desmos.com/calculator/j4zcbsdwwi"]{here}.