    Title: Dynamic programming of recursive functions in Prolog
    Date: 2017-10-03T00:00:00
    Tags: Prolog, Memoization
    Authors: Henry Brooks

Last week I was able to successfully implementing `Fibonacci` with [memoization](https://en.wikipedia.org/wiki/Memoization) in `Prolog`. This time I thought I would try the [Hailstone](https://en.wikipedia.org/wiki/Collatz_conjecture) and [Ackermann](https://en.wikipedia.org/wiki/Ackermann_function) formulas to see if all recursive functions can benefit from `memoization`.

<!-- more -->

Hailstone
---

By itself the `Hailstone` function is not recursive however, trying to calculate the longest `Hailstone Sequence` is a highly recursive task.

I coded up this first `memoized` version of the `Hailstone` formula rather quickly by modifying the `Fibonacci` code from last week.

```prolog
:- use_module(library(clpfd)).

hailstone_(1,1).

hailstone(N,S):-
    hailstone_(N,S),
    !.
hailstone(N,S):-
    0 #= mod(N,2),
    N1 #= div(N,2),
    hailstone(N1,S1),
    S #= S1 + 1,
    assert(hailstone_(N,S)).
hailstone(N,S):-
    1 #= mod(N,2),
    N1 #= 3 * N + 1,
    hailstone(N1,S1),
    S #= S1 + 1,
    assert(hailstone_(N,S)).
```

Some quick testing showed that I was getting correct results.

```prolog
?- hailstone(12,X).
X = 10.

?- hailstone(19,X).
X = 21.

?- hailstone(27,X).
X = 112.
```

I then went looking around the web to see if I could improve my implementation and found an example on [Rosetta Code](http://rosettacode.org/wiki/Hailstone_sequence#Prolog) that generated the list of `hailstone` values while working through the equation instead of just the length.

I modified my code and then tested the `memoization` version vs the `non-memoization` version

```prolog
:- use_module(library(clpfd)).

hailstone1(1,[1]) :- !.
hailstone1(N,[N|S]) :- 
    0 is N mod 2,
    N1 is N / 2,
    hailstone1(N1,S).
hailstone1(N,[N|S]) :-
    1 is N mod 2,
    N1 is (3 * N) + 1,
    hailstone1(N1, S).

% memoization version
hailstone2_(1,[1]).

hailstone2(N,S) :-
    hailstone2_(N,S),
    !.
hailstone2(N,[N|S]) :- 
    0 is N mod 2,
    N1 is N / 2,
    hailstone2(N1,S),
    assert(hailstone2_(N,[N|S])).
hailstone2(N,[N|S]) :-
    1 is N mod 2,
    N1 is (3 * N) + 1,
    hailstone2(N1, S),
    assert(hailstone2_(N,[N|S])).

longestHailstoneSequence1(M, Seq, Len) :-
    longesthailstone1(M, 1, 1, Seq, Len).

longesthailstone1(1, Cn, Cl, Mn, Ml):-
    Mn = Cn,
	  Ml = Cl.
longesthailstone1(N, _, Cl, Mn, Ml) :-
    hailstone1(N, X),
    length(X, L),
    Cl < L,
    N1 is N-1,
    longesthailstone1(N1, N, L, Mn, Ml).
longesthailstone1(N, Cn, Cl, Mn, Ml) :-
    N1 is N-1,
    longesthailstone1(N1, Cn, Cl, Mn, Ml).

longestHailstoneSequence2(M, Seq, Len) :-
    longesthailstone2(M, 1, 1, Seq, Len).

longesthailstone2(1, Cn, Cl, Mn, Ml):-
    Mn = Cn,
    Ml = Cl.
longesthailstone2(N, _, Cl, Mn, Ml) :-
    hailstone2(N, X),
    length(X, L),
    Cl < L,
    N1 is N-1,
    longesthailstone2(N1, N, L, Mn, Ml).
longesthailstone2(N, Cn, Cl, Mn, Ml) :-
    N1 is N-1,
    longesthailstone2(N1, Cn, Cl, Mn, Ml).


main(Max,LongestHailstone1,Hailstone1,LongestHailstone2,Hailstone2):-
    get_time(T1),
    longestHailstoneSequence1(Max,_,LongestHailstone1),
    get_time(T2),
    longestHailstoneSequence2(Max,_,LongestHailstone2),
    get_time(T3),
    Hailstone1 is T2 - T1,
    Hailstone2 is T3 - T2.
```

I tested both versions to find the longest length less than `1,000,000`.

```prolog
?- main(1000000,RegularLength,RegularTime,MemoizedLength,MemoizedTime).
RegularLength = MemoizedLength, MemoizedLength = 525,
RegularTime = 45.83147144317627,
MemoizedTime = 13.176789045333862 .
```

And loo.king at the results it seems that `memoization` sped up the calculation by around a factor of `3`. Running the calculation again gives further evidence to the time saved through `memoization` techniques.

```prolog
?- main(1000000,RegularLength,RegularTime,MemoizedLength,MemoizedTime).
RegularLength = MemoizedLength, MemoizedLength = 525,
RegularTime = 45.660714626312256,
MemoizedTime = 1.4994690418243408 .
```

Running `main` again with a smaller value also gives us a chance to look at how `Prolog` is storing the values.

```prolog
?- main(25,RegularLength,RegularTime,MemoizedLength,MemoizedTime).
RegularLength = MemoizedLength, MemoizedLength = 24,
RegularTime = 0.0004966259002685547,
MemoizedTime = 0.00028586387634277344 .

?- listing.

hailstone2_(1, [1]).
hailstone2_(2, [2, 1]).
hailstone2_(4, [4, 2, 1]).
hailstone2_(8, [8, 4, 2, 1]).
hailstone2_(16, [16, 8, 4, 2, 1]).
hailstone2_(5, [5, 16, 8, 4, 2, 1]).
hailstone2_(10, [10, 5, 16, 8, 4, 2, 1]).
hailstone2_(20, [20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(40, [40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(13, [13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(26, [26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(52, [52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(17, [17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(34, [34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(11, [11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(22, [22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(44, [44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(88, [88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(29, [29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(58, [58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(19, [19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(38, [38, 19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(76, [76, 38, 19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(25, [25, 76, 38, 19, 58, 29, 88, 44, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(3, [3, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(6, [6, 3, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(12, [12, 6, 3, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(24, [24, 12, 6, 3, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(80, [80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(160, [160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(53, [53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(106, [106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(35, [35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(70, [70, 35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(23, [23, 70, 35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(32, [32, 16, 8, 4, 2, 1]).
hailstone2_(64, [64, 32, 16, 8, 4, 2, 1]).
hailstone2_(21, [21, 64, 32, 16, 8, 4, 2, 1]).
hailstone2_(7, [7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(14, [14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(28, [28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(9, [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(18, [18, 9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(46, [46, 23, 70, 35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
hailstone2_(15, [15, 46, 23, 70, 35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]).
```


Ackermann
---

I started with the code from [Rosetta Code](https://rosettacode.org/wiki/Ackermann_function#Prolog) and modified it to have a `memoization` version as I did for the `Hailstone` program.

```prolog
:- use_module(library(clpfd)).

ack1(0, N, Ans) :-
    Ans is N+1.
ack1(M, 0, Ans) :-
    M>0, X is M-1,
    ack1(X, 1, Ans).
ack1(M, N, Ans) :-
    M>0,
    N>0,
    X is M-1,
    Y is N-1,
    ack1(M, Y, Ans2),
    ack1(X, Ans2, Ans).

% memoization version
ack2_(0,0,1).
ack2_(0,1,2).
ack2_(1,0,2).
ack2_(1,1,3).

ack2(0, N, Ans) :-
    Ans #= N+1,
    assert(ack2_(0,N,Ans)).
ack2(M, 0, Ans) :-
    M>0,
    X is M-1,
    ack2(X, 1, Ans),
    assert(ack2_(M, 0, Ans)).
ack2(M, N, Ans) :-
    M>0,
    N>0,
    X is M-1,
    Y is N-1,
    ack2(M, Y, Ans2),
    ack2(X, Ans2, Ans),
    assert(ack2_(M, N, Ans)).

main(M, N, Ack1, Ack2):-
    get_time(T1),
    ack1(M, N, _Ans1),
    get_time(T2),
    ack2(M, N, _Ans2),
    get_time(T3),
    Ack1 is T2 - T1,
    Ack2 is T3 - T2.
```

Since I know that `Ackermann` will blow up in size quickly I tried calculating some small values of `Ackermann` to start with to compare the times.

```prolog
?- main(1,1,Ack1,Ack2).
Ack1 = 1.0013580322265625e-5,
Ack2 = 2.2411346435546875e-5 .

?- main(1,1,Ack1,Ack2).
Ack1 = 1.0013580322265625e-5,
Ack2 = 2.2411346435546875e-5 .

?- main(3,2,Ack1,Ack2).
Ack1 = 0.0004432201385498047,
Ack2 = 0.0014376640319824219 .

?- main(3,3,Ack1,Ack2).
Ack1 = 0.0027358531951904297,
Ack2 = 0.004640340805053711 .

?- main(3,4,Ack1,Ack2).
Ack1 = 0.02543926239013672,
Ack2 = 0.1792759895324707 .

?- main(3,5,Ack1,Ack2).
Ack1 = 0.23902654647827148,
Ack2 = 3.0773415565490723 .
```

Initially I figured that the `memoization` was taking up to much overhead for these small values however, after reading responses to a [stackoverflow](https://stackoverflow.com/questions/13086568/memoization-of-ackermann-function) thread I found that this function is so ill behaved that `memoization` doesn't really help with the calculations.

Example
---

To give show how quickly this problem gets out of hand. If I call `listing` before I have actually run `ack2` I get the following result.

```prolog
?- listing.

ack2_(0, 0, 1).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(1, 1, 3).
```

Running `Ackermann` with `2,1` blows the result up to this.

```prolog
?- main(2,1,Ack1,Ack2).
Ack1 = 1.6450881958007812e-5,
Ack2 = 6.270408630371094e-5 .

?- listing.

ack2_(0, 0, 1).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(1, 1, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
```

`Ackermann` `2,2` results in the following blow up again.

```prolog
?- main(2,2,Ack1,Ack2).
Ack1 = 4.363059997558594e-5,
Ack2 = 5.53131103515625e-5 .

?- listing.
ack2_(0, 0, 1).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(1, 1, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(2, 2, 7).
```

So we went from `18` `memoized` results to `45` by increasing `N` by `1`.

Going to `3,2` increases the results to `585`. Unlike the `Fibonacci` and `Hailstone` formulas, `Ackermann` doesn't seem to spend a lot of time recalculating old values. Instead it is expanding to calculate new values with each increase of `M` and `N`.

I have included `ack2(3,2)` saved results below, the jump to `ack2(3,3)` would be similar.

```prolog
?- main(3,2,Ack1,Ack2).
Ack1 = 0.0006780624389648438,
Ack2 = 0.00354766845703125 .

?- listing.
ack2_(0, 0, 1).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(1, 1, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(2, 2, 7).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(3, 0, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(2, 2, 7).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(2, 3, 9).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(2, 4, 11).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(2, 5, 13).
ack2_(3, 1, 13).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(2, 0, 3).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(2, 1, 5).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(2, 2, 7).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(2, 3, 9).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(2, 4, 11).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(2, 5, 13).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(2, 6, 15).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(2, 7, 17).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(2, 8, 19).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(0, 19, 20).
ack2_(1, 18, 20).
ack2_(0, 20, 21).
ack2_(1, 19, 21).
ack2_(2, 9, 21).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(0, 19, 20).
ack2_(1, 18, 20).
ack2_(0, 20, 21).
ack2_(1, 19, 21).
ack2_(0, 21, 22).
ack2_(1, 20, 22).
ack2_(0, 22, 23).
ack2_(1, 21, 23).
ack2_(2, 10, 23).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(0, 19, 20).
ack2_(1, 18, 20).
ack2_(0, 20, 21).
ack2_(1, 19, 21).
ack2_(0, 21, 22).
ack2_(1, 20, 22).
ack2_(0, 22, 23).
ack2_(1, 21, 23).
ack2_(0, 23, 24).
ack2_(1, 22, 24).
ack2_(0, 24, 25).
ack2_(1, 23, 25).
ack2_(2, 11, 25).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(0, 19, 20).
ack2_(1, 18, 20).
ack2_(0, 20, 21).
ack2_(1, 19, 21).
ack2_(0, 21, 22).
ack2_(1, 20, 22).
ack2_(0, 22, 23).
ack2_(1, 21, 23).
ack2_(0, 23, 24).
ack2_(1, 22, 24).
ack2_(0, 24, 25).
ack2_(1, 23, 25).
ack2_(0, 25, 26).
ack2_(1, 24, 26).
ack2_(0, 26, 27).
ack2_(1, 25, 27).
ack2_(2, 12, 27).
ack2_(0, 1, 2).
ack2_(1, 0, 2).
ack2_(0, 2, 3).
ack2_(1, 1, 3).
ack2_(0, 3, 4).
ack2_(1, 2, 4).
ack2_(0, 4, 5).
ack2_(1, 3, 5).
ack2_(0, 5, 6).
ack2_(1, 4, 6).
ack2_(0, 6, 7).
ack2_(1, 5, 7).
ack2_(0, 7, 8).
ack2_(1, 6, 8).
ack2_(0, 8, 9).
ack2_(1, 7, 9).
ack2_(0, 9, 10).
ack2_(1, 8, 10).
ack2_(0, 10, 11).
ack2_(1, 9, 11).
ack2_(0, 11, 12).
ack2_(1, 10, 12).
ack2_(0, 12, 13).
ack2_(1, 11, 13).
ack2_(0, 13, 14).
ack2_(1, 12, 14).
ack2_(0, 14, 15).
ack2_(1, 13, 15).
ack2_(0, 15, 16).
ack2_(1, 14, 16).
ack2_(0, 16, 17).
ack2_(1, 15, 17).
ack2_(0, 17, 18).
ack2_(1, 16, 18).
ack2_(0, 18, 19).
ack2_(1, 17, 19).
ack2_(0, 19, 20).
ack2_(1, 18, 20).
ack2_(0, 20, 21).
ack2_(1, 19, 21).
ack2_(0, 21, 22).
ack2_(1, 20, 22).
ack2_(0, 22, 23).
ack2_(1, 21, 23).
ack2_(0, 23, 24).
ack2_(1, 22, 24).
ack2_(0, 24, 25).
ack2_(1, 23, 25).
ack2_(0, 25, 26).
ack2_(1, 24, 26).
ack2_(0, 26, 27).
ack2_(1, 25, 27).
ack2_(0, 27, 28).
ack2_(1, 26, 28).
ack2_(0, 28, 29).
ack2_(1, 27, 29).
ack2_(2, 13, 29).
ack2_(3, 2, 29).
```


