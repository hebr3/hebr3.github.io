---
layout: post
title: Project Euler with Haskell
date: 2015-10-03T00:00:00
tags: Project Euler, Haskell
---

Teaching Algebra A has been more of a slog than I was expecting and I've been feeling like I need to stretch myself before I get bogged down in teaching. I enjoyed working on Project Euler problems last year and I thought it could provide a decent break again.

I decided to focus on Haskell this time around as it has a syntax that is close to mathematical set notation. I see a lot of design decisions within the Haskell language that align with my mathematic background. I feel that the list comprehensions and mapping functions for lists have a strong mathematical foundation and I think that I will be able to pick up the language quickly.

I'm going to try to work through all of the Project Euler problems I completed with [Mathematica][mathematica] last year and see if the process is easier or at least clearer this time around.

Problem 1
---

This problem, and it's solution, really highlight why I wanted to try my hand at learning Haskell. The list comprehension syntax I use in this solution are nearly identical to the mathematical notation I would use to describe this problems solution mathematically. We create a set of natural numbers less than `1000` that are congruent to `0 mod 3` or `5`, then we `sum` the elements of the set. **S** = `{x | x ∈ ℕ, x < 1000, x ≡ 0 mod 3 ⋁ x ≡  0 mod 5}`, `sum S`

<figcaption>ProjectEuler1.hs</figcaption>
```haskell
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    putStrLn "Problem1 - Sum of the natural numbers below 1000 that are multiplies of 3 or 5"
    print problem1

--Sum of the natural numbers below 1000 that are multiplies of 3 or 5
problem1 = sum [x | x <- [1..999], mod x 3 == 0 || mod x 5 == 0]
```

My solution ends up using the `x<-[1..999]` instead of `x<-[1..], x < 1000` because Haskell's methodology doesn't align perfectly the math notation. Specifically it keep checking numbers, even after `1000`, to see if `x < 1000, x ≡ 0 mod 3 ⋁ x ≡  0 mod 5`. The system doesn't know it should stop at `1000` naturally. I could still make use of [Haskell's infinite list](https://en.wikipedia.org/wiki/Lazy_evaluation#Working_with_infinite_data_structures) `[1..]` however, I would need to add `sum (takeWhile (<1000) [x | x <-[1..], ...])` to only take `x` values less than 1000. This is all a result of [lazy evaluation](https://en.wikipedia.org/wiki/Lazy_evaluation) and is a little more complicated than I can properly explain.

Still the solution works well and I feel that it matches how I would approach this problem from a math perspective if I was doing this problem on paper.

**Caveat**: I know this problem can also be solved using [sums](https://www.wolframalpha.com/input/?i=(sum+3i+from+i%3D0+to+(999%2F3))+%2B+(sum+5j+from+j%3D0+to+(999%2F5))+-+(sum+15k+from+k%3D0+to+(999%2F15))) by modifying the equation for [partial sums](https://en.wikipedia.org/wiki/1_%2B_2_%2B_3_%2B_4_%2B_%E2%8B%AF#Partial_sums).

`\sum_{i=0}^{\left\lfloor\frac{999}{3}\right\rfloor} 3i +`
` \sum_{j=0}^{\left\lfloor\frac{999}{5}\right\rfloor} 5j -`
` \sum_{k=0}^{\left\lfloor\frac{999}{15}\right\rfloor} 15k`

Problem 2
---

I didn't use the standard Haskell version of the Fibonacci equation for this problem.

```haskell
fib 0 = 1
fib 2 = 1
fib n = fib (n-1) + fib (n-2)}
```

This version will blow up in space and time complexity for large values of `n` and is generally less efficient.

I instead went with an [iterative version](https://www.ics.uci.edu/~eppstein/161/960109.html) of Fibonacci that takes n steps to calculate `fib n`.

There are some other versions of Fibonacci that bring the space and time complexity down further using recurrent patterns however, I felt like this code was good enough for my purposes here.

<figcaption>ProjectEuler2.hs</figcaption>
{% highlight haskell %}
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"

    putStrLn "\nProblem2 - Sum of the even Fibonacci numbers less than 4,000,000"
    print problem2

--Sum of the even Fibonacci numbers less than 4,000,000
problem2 = sum [fib x | x <- [1..100], mod (fib x) 2 == 0, (fib x) < 4000000]

fib n = fib_iter 1 0 n

fib_iter a b 0 = b
fib_iter a b count = fib_iter (a + b) a (count - 1)
{% endhighlight %}

While working on this problem I also found out that I could have asked Haskell to generate an infinite list of fibonacci numbers using this code and then used sume on the partial list.

```haskell
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)
sum (takeWhile (\x -> x < 4000000) fibs)
```

I'm finding that infinite lists are one of the aspects of Haskell that are really intriguing to me. They seem to provide a bridge between mathematics and programming that I am interested in exploring further.

[mathematica]: http://www.wolfram.com/mathematica/