#lang pollen

◊(define-meta title "CodeFights - teamFinder")
◊(define-meta published "2017-08-17")
◊(define-meta topics "CodeFights, Dynamic Programming, Memoization, Python")

◊(require scribble-math)
◊(use-mathjax)
◊(define ($ . xs)  `(mathjax ,(apply string-append `("$" ,@xs "$"))))
◊(define ($$ . xs)  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

I have been working through codefights and I found another problem that required memoization to complete so I thought I would write up my process solving this problem.

◊section{◊link["https://codefights.com/challenge/af2y4DBXqibqmHyAN"]{Description}}
You just heard about a new Pokemon tournament. In order to compete in the tournament, you must follow these rules:

You must use ◊code{2} Pokemon;
Their combined attack power must be equal to ◊code{maxPower}.
You and your friends would like to compete, but there is limited time to enter! You need to pick the first ◊code{2} Pokemon in your list whose combined attack power is equal to maxPower and return their indices (◊code{0}-based).
If there are no such pairs, return an empty array.

Some of your friends are true Pokemon masters, and have hundreds of thousands of Pokemon. Make sure to help them find their Pokemon fast too!

Example
For ◊code{pokemonList = [4, 3, 2, 3, 4]} and ◊code{maxPower = 6},
the output should be
◊code{teamFinder(pokemonList, maxPower) = [0, 2]}.
The pairs that add up to ◊code{maxPower} are:
◊code{(4, 2), (3, 3), (2, 4)}.
The pair that gets completed first is ◊code{(4, 2)} whose indices are ◊code{[0, 2]}.

◊section{Version 1}
I initially worked through the problem with racket to get an idea of how it should work and to check the test cases. Initially I wrote the program to recursively check all pairs starting with the first.

◊filebox-highlight["teamFinder" 'racket]{
 #lang racket
 (define (teamFinder pokemonList maxPower)
   (define listLength (length pokemonList))
   (define (check-maxPower headIndex nextIndex)
     (cond [(= headIndex listLength)
            (printf "[]\n")]
           [(= nextIndex listLength)
            (check-maxPower (add1 headIndex) (+ 2 headIndex))]
           [(= maxPower (+ (list-ref pokemonList headIndex)
                           (list-ref pokemonList nextIndex)))
            (printf "[~a, ~a]\n" headIndex nextIndex)]
           [else
            (check-maxPower headIndex (add1 nextIndex))]))
   (check-maxPower 0 1))

 (teamFinder '(4 3 2 3 4) 6) ; [0, 2]
 (printf "[0, 2]\n")
 (teamFinder '(1 4 8 7 3 15) 8) ; [0, 3]
 (printf "[0, 3]\n")
 (teamFinder '(10 5 2 3 7 5) 10) ; [1, 5]
 (printf "[3, 4]\n")
 (teamFinder '(33 17 21 31 15 27 29 35 23 25 19) 27) ; []
 (printf "[]\n")
 (teamFinder '(1 1) 2) ; [0, 1]
 (printf "[0, 1]")}

Unfortunately this ended up missing on test 3 and after reading the comments I found that the test effectively checks based on the second element of the pair. Specifically, before you check a new pokemon in the list you must have checked all pairs of pokemon made with pokemon before it in the list.

◊section{Version 2}

◊filebox-highlight["teamFinder-v2" 'racket]{
 #lang racket
 (define (teamFinder pokemonList maxPower)
  (define listLength (length pokemonList))
  (define (check-maxPower headIndex nextIndex)
    (cond [(= nextIndex listLength)
           (printf "[]\n")]
          [(= headIndex nextIndex)
           (check-maxPower 0 (add1 nextIndex))]
          [(= maxPower (+ (list-ref pokemonList headIndex)
                          (list-ref pokemonList nextIndex)))
           (printf "[~a, ~a]\n" headIndex nextIndex)]
          [else
           (check-maxPower (add1 headIndex) nextIndex)]))
  (check-maxPower 0 1))

(teamFinder '(4 3 2 3 4) 6) ; [0, 2]
(printf "[0, 2]\n")
(teamFinder '(1 4 8 7 3 15) 8) ; [0, 3]
(printf "[0, 3]\n")
(teamFinder '(10 5 2 3 7 5) 10) ; [3, 4]
(printf "[3, 4]\n")
(teamFinder '(33 17 21 31 15 27 29 35 23 25 19) 27) ; []
(printf "[]\n")
(teamFinder '(1 1) 2) ; [0, 1]
(printf "[0, 1]")}

It took me a couple minutes to rewrite the program to use ◊code{nextIndex} as the pivot but that was mostly due to some trial and error problems.

◊section{Version 3}

Currently my solution is running in ◊${O \left ( \frac{n^2}{2} \right )} however, looking over the comments I know that the solution needs to be close to ◊${O \left ( n \right )}.

We can achieve this speed up by memorizing the values as we work through the ◊code{pokemonList}. Sense we are basing our search off of the second value in the pair we only need to keep a list of the differences between the previous values and the ◊code{maxPower} value.

If we were checking ◊code{(teamFinder '(10 5 2 3 7 5) 10)} we wouldn't want to check ◊code{maxPower = first + second} for every pair on each pass. Instead we want to build a list of ◊code{maxPower - first} and check if the ◊code{second} value is in the list.

◊filebox-highlight["Example" 'racket]{
(teamFinder '(10 5 2 3 7 5) 10)
difList = '(0),       value = 5
difList = '(0 5),     value = 2
difList = '(0 5 8),   value = 3
difList = '(0 5 8 7), value = 7
}

This leads us to the following code

◊filebox-highlight["teamFinder-v3" 'racket]{
(define (teamFinder pokemonList maxPower)
  (define ht (make-hash))
  (define flag #t)
  (for ([i (length pokemonList)]
        [v pokemonList])
    (define diff (- maxPower v))
    #:break (and (hash-ref ht v #f)
                 (printf "[~a, ~a]\n" (hash-ref ht v) i)
                 (set! flag #f))    
    (hash-ref! ht diff i))
  (when flag (printf "[]\n")))

(teamFinder '(4 3 2 3 4) 6)
(printf "[0, 2]\n")
(teamFinder '(1 4 8 7 3 15) 8)
(printf "[0, 3]\n")
(teamFinder '(10 5 2 3 7 5) 10)
(printf "[3, 4]\n")
(teamFinder '(33 17 21 31 15 27 29 35 23 25 19) 27)
(printf "[]\n")
(teamFinder '(1 1) 2)
(printf "[0, 1]")}

The only further improvements would be checking that the values v are less than ◊code{maxPower}. I finally converted the code to Python as codefights doesn't support racket code submissions.

◊filebox-highlight["teamFinder.py" 'python]{
def teamFinder(pokemonList, maxPower):
    loc = {}
    for i, v in enumerate(pokemonList):
        if (v >= maxPower):
            continue
        if maxPower - v in loc.keys():
            return [loc[maxPower - v], i]
        if v in loc.keys():
            continue
        loc[v] = i
    return []
}
