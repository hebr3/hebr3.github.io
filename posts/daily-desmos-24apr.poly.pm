#lang pollen

◊(define-meta title "Daily Desmos - 24 April")
◊(define-meta published "2015-04-24")
◊(define-meta topics "Daily Desmos, 20% Project")

◊(require scribble-math)
◊(use-mathjax)
◊(define ($ . xs) 
  `(mathjax ,(apply string-append `("$" ,@xs "$"))))
◊(define ($$ . xs)
  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

◊figure["dd-24apr-a.gif"]
◊figure["dd-24apr-b.gif"]

◊link["http://dailydesmos.com/2015/04/24/warping-ellipse-1-advanced/"]{Daily Desmos} posted this challenge on the 24th of April.

Not an exact copy, but I feel that I touched on the important requirements. I'm still trying to figure out a good way to replicate the repeating nature of the example.

You can see my solution ◊link["https://www.desmos.com/calculator/g3njuaox3d"]{here}