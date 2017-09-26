    Title: Fibonacci in Prolog
    Date: 2017-09-26T00:00:00
    Tags: Prolog, Memoization
    Authors: Henry Brooks

I was looking over [Exercise 11.3](http://www.learnprolognow.org/lpnpage.php?pagetype=html&pageid=lpn-htmlse50) at [Learn Prolog Now](http://www.learnprolognow.org) and realized that the problem actually implements memoization to calculate its result. I thought I would try modifying the problem to see if it could be used to solve the fibonacci equation.

<!-- more -->

The sigma problem asks you to create a `sigmares(N,S)` result for every `sigma(N,S)` and `assert` this value to the database.

```prolog
:- dynamic sigmares/2.

sigmares(1, 1).

sigma(X, Y) :-
    sigmares(X, Y),
    !.
sigma(X, Y) :-
    Xp is X - 1,
    sigma(Xp, R),
    Y is R + X,
    assert(sigmares(X, Y)).
```

We can quickly check that this function properly updates the database.

```prolog
sigma(10,X), listing.
```

```
:- dynamic sigmares/2.

sigmares(1, 1).
sigmares(2, 3).
sigmares(3, 6).
sigmares(4, 10).
sigmares(5, 15).
sigmares(6, 21).
sigmares(7, 28).
sigmares(8, 36).
sigmares(9, 45).
sigmares(10, 55).
```

To solve the fibonacci problem I modified the code to match the fibonacci equations structure.

```prolog
:- dynamic fib/2.

fibs(0,1).
fibs(1,1).

fib(N,S):-
    fibs(N,S),
    !.

fib(N,S):-
    N1 is N-1,
    N2 is N-2,
    fib(N1,S1),
    fib(N2,S2),
    S is S1 + S2,
    assert(fibs(N,S)).
```

I then tested to see if the results looked correct.

```prolog
fib(15,X), listing.
```

```
:- dynamic fibs/2.

fibs(0, 1).
fibs(1, 1).
fibs(2, 2).
fibs(3, 3).
fibs(4, 5).
fibs(5, 8).
fibs(6, 13).
fibs(7, 21).
fibs(8, 34).
fibs(9, 55).
fibs(10, 89).
fibs(11, 144).
fibs(12, 233).
fibs(13, 377).
fibs(14, 610).
fibs(15, 987).
```

I was actually really suprised at how quickly the program ran given that I never really consider `Prolog` for numerical calculations.

I ended up timing `fib(10000)` to compare to `Racket`.

```prolog
get_time(T1),fib(10000,_),get_time(T2), T3 is T2 - T1, write(T3).

> 0.17243337631225586
```

```racket
#lang racket

(define (fib n)
  (define (iter a b c)
    (cond [(zero? c) a]
          [else (iter b (+ a b) (sub1 c))]))
  (iter 0 1 n))

(time (fib 10000))

> cpu time: 8 real time: 8 gc time: 8
```

Prolog ended up taking a little more than twice the time taken by `Racket` to calculate the same value. Considering that `Racket` wasn't creating a database of fib values that could be used again later I think the difference is actually remarkable.


### Note
I removed the `memoization` component from the `Prolog` code and ran `fib(40)` to see how much time was saved.

```prolog
:- use_module(library(clpfd)).

fib(N,S):-
    N1 is N-1,
    N2 is N-2,
    fib(N1,S1),
    fib(N2,S2),
    S is S1 + S2.
    %assert(fibs(N,S)).

get_time(T1),fib(40,_),get_time(T2), T3 is T2 - T1, write(T3).

> 50.405715465545654
```

```racket
#lang racket
(define (fib n)
  (cond [(<= n 1) 1]
        [else (+ (fib (- n 1)) (fib (- n 2)))]))

(time (fib 40))

> cpu time: 6320 real time: 6255 gc time: 32
```

The difference without `memoization` was effectively an order of magnitude. This really highlights for me the importance of `memoization` for `Prolog` programs.



