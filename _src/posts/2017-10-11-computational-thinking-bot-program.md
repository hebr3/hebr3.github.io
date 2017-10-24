    Title: Computational Thinking - Bot Program
    Date: 2017-10-11T00:00:00
    Tags: Computational Thinking, Robot Simulation, Racket, DRAFT
    Authors: Henry Brooks

This post will cover the creation of a simple robot simulation for elementart school students using [Racket](https://racket-lang.org/).

IMAGE

<!-- more -->

I have been teaching a class on computational thinking to elementary school students using the cirriculum from [code.org](https://code.org/) for a couple of weeks now and I decided that it would be nice to have an easy way to visualize and demonstrate examples of robots following instructions.

I initially started with Snap

```racket
#lang slideshow

(require 2htdp/image)

(define hex
  (regular-polygon 30 6 'outline 'blue))
  
hex
```

![](/img/hexa.png)

```racket
#lang slideshow

(require 2htdp/image)

(define hex
  (regular-polygon 30 6 'outline 'blue))

(define hex-column
  (foldr above hex (make-list 8 hex)))

(define hex-2column
  (underlay/offset hex-column 45 26 hex-column))

(define hex-field
  (foldr (λ (x y) (underlay/align/offset 'left 'middle x 90 0 y))
         hex-2column
         (make-list 5 hex-2column)))

hex-field
```

![](/img/hexb.png)

```racket
#lang slideshow

(require 2htdp/image)

(define (hex side)
  (regular-polygon side 6 'outline 'blue))

(define (hex-column side height)
  (foldr above (hex side) (make-list (- height 1) (hex side))))

(define (hex-column-offset side height)
  (above (square (* (sqrt 3) 1/2 side) 'outline 'transparent)
         (hex-column side height)))

(define (hex-field side height width)
  (let ([c (for/list ([i (- width 1)])
             (if (odd? i)
                 (hex-column side height)
                 (hex-column-offset side height)))])
    (foldr (λ (x y) (underlay/align/offset 'left 'top x 45 0 y))
           (hex-column side height)
           c)))

(hex-field 30 7 10)
```

![](/img/hexc.png)

```racket
#lang slideshow

(require 2htdp/image)

(define (hex-field side height width)
  (let* ([hex (regular-polygon side 6 'outline 'blue)]
         [hex-column
          (foldr above hex (make-list (- height 1) hex))]
         [offset-square (square (* (sqrt 3) 1/2 side) 'outline 'transparent)]
         [hex-column-offset (above offset-square hex-column)]
         [c (for/list ([i (- width 1)])
              (if (odd? i)
                  hex-column
                  hex-column-offset))])
    (foldr (λ (x y) (underlay/align/offset 'left 'top x (+ side (/ side 2)) 0 y))
           (if (even? width) hex-column hex-column-offset)
           c)))

(define field
  (hex-field 20 10 15))

field
```

![](/img/hexd.png)

```racket
#lang slideshow

(require 2htdp/image)

(define (square-field side height width)
  (let* ([sqr (square side 'outline 'blue)]
         [sqr-col (if (= 1 height)
                      sqr
                      (apply above (make-list height sqr)))]
         [sqr-field (if (= 1 width)
                        sqr-col
                        (apply beside (make-list width sqr-col)))])
    sqr-field))

(define field
  (square-field 30 6 8))

field
```

![](/img/sqra.png)