    Title: CodeFights - teamFinder
    Date: 2017-08-17T00:00:00
    Tags: CodeFights, Dynamic Programming, Memoization, Python
    Authors: Henry Brooks

I have been working through problems from [codefights](https://codefights.com) and I found another problem that required [memoization](https://en.wikipedia.org/wiki/Memoization) to complete so I thought I would write up my process solving this problem.

<!-- more -->

[Description](https://codefights.com/challenge/af2y4DBXqibqmHyAN)
You just heard about a new Pokemon tournament. In order to compete in the tournament, you must follow these rules:

* You must use `2` Pokemon;
* Their combined attack power must be equal to `maxPower`.

You and your friends would like to compete, but there is limited time to enter! You need to pick the first `2` Pokemon in your list whose combined attack power is equal to maxPower and return their indices (`0`-based).
If there are no such pairs, return an empty array.

Some of your friends are true Pokemon masters, and have hundreds of thousands of Pokemon. Make sure to help them find their Pokemon fast too!

##### Example

For `pokemonList = [4, 3, 2, 3, 4]` and `maxPower = 6`, the output should be `teamFinder(pokemonList, maxPower) = [0, 2]`.

The pairs that add up to `maxPower` are: `(4, 2), (3, 3), (2, 4)`.

The pair that gets completed first is `(4, 2)` whose indices are `[0, 2]`.

### Version 1
I initially worked through the problem with racket to get an idea of how it should work and to check the test cases. Initially I wrote the program to recursively check all pairs starting with the first.

```racket
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
(printf "[0, 1]")
```

Unfortunately this ended up failing on test 3 and after reading the comments I found that the test actually checks based on the second element of the pair. Specifically, before you check a new pokemon in the list you must have checked all pairs of pokemon made with pokemon before it in the list.

### Version 2

```racket
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
(printf "[0, 1]")
```

It took me a couple minutes to rewrite the program to use `nextIndex` as the pivot but that was mostly due to some trial and error problems.

### Version 3

Currently my solution is running in **O(n^2)** however, looking over the comments I know that the solution needs to be close to **O(n)**.

We can achieve this speed up by memorizing the values as we work through the `pokemonList`. Since we are basing our search off of the second value in the pair we only need to keep a list of the differences between the previous values and the `maxPower` value.

If we were checking `(teamFinder '(10 5 2 3 7 5) 10)` we wouldn't want to check `maxPower = first + second` for every pair on each pass. Instead we want to build a list of `maxPower - first` and check if the `second` value is in the list.

```
(teamFinder '(10 5 2 3 7 5) 10)
difList = '(0),       value = 5
difList = '(0 5),     value = 2
difList = '(0 5 8),   value = 3
difList = '(0 5 8 7), value = 7
```

This leads us to the following code

```racket
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
(printf "[0, 1]")
```

The only further improvements would be checking that the values v are less than `maxPower`. I finally converted the code to Python as codefights doesn't support racket code submissions.

```python
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
```
