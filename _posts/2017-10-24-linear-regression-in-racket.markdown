---
layout: post
Title: Linear Regression in Racket - hackerrank - 10 Days of Statistics - Day 8
Date: 2017-09-26T00:00:00
Tags: Racket, Statistics
mathjax: true
---

Hackerrank is currently running a 10 Day challenge to introduce people to Statistical methods and computations. [Today's problem](https://www.hackerrank.com/challenges/s10-least-square-regression-line/problem) asks you to compute the [Least Square Regression Line](https://en.wikipedia.org/wiki/Linear_least_squares_(mathematics)) for a series of 5 points. I decided to roll my own implementation of the formulas in Racket as a practice problem.

The actual coding wasn't that bad for this problem. The `let*` sections seem a little long however, if you look at the actual equation they are rather straight forward translations.

$$
\begin{align}
b & = \frac{ n \sum x_iy_i - \left ( \sum x_i \right ) \left ( \sum y_i \right ) }
{ n \sum \left ( x^2_i \right ) - \left ( \sum \left ( x^2_i \right ) \right ) }
\\
a & = \bar y - b \bar x
\end{align}
$$

```racket
#lang racket

(define (b l)
  (let* ([n (length l)]
         [xs (map car l)]
         [ys (map cdr l)]
         [x*y (for/sum ([i xs][j ys]) (* i j))]
         [SxSy (* (apply + xs) (apply + ys))]
         [Sx2 (apply + (map sqr xs))]
         [Sx^2 (sqr (apply + xs))]
         [num (- (* n x*y) SxSy)]
         [dem (- (* n Sx2) Sx^2)])
    (/ num dem)))

(define (a l b)
  (let* ([n (length l)]
         [xs (map car l)]
         [ys (map cdr l)]
         [xbar (/ (apply + xs) n)]
         [ybar (/ (apply + ys) n)])
    (- ybar (* b xbar))))

(define (yhat l x)
  (let* ([b (b l)]
         [a (a l b)])
    (+ a (* b x))))

(let ([L (for/list ([i 5]) (cons (read) (read)))])
  (printf (~r (* 1.0 (yhat L 80)) #:precision 3)))
```

When I went searching to see if there was a built in method to achieve these same results I found a blog post by [Garrett Bluma](http://garrettbluma.com/post/110503535150/linear-regression-in-racket) that basically did the same thing only written better and using a different linear regression equations.