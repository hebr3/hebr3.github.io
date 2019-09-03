    Title: CodeFights - totalOnes
    Date: 2017-03-30T00:00:00
    Tags: CodeFights, Haskell, C++, Dynamic Programming, Memoization
    Authors: Henry Brooks

I've been working through algorithm challenges on [Code Fights](https://codefights.com/) and I found a problem that forced me to learn some new techniques. Specifically I had to utilize [memoization](https://en.wikipedia.org/wiki/Memoization) to speed up a [dynamic programming](https://en.wikipedia.org/wiki/Dynamic_programming) problem. I have included the description  of the challenge below.

[Description](https://codefights.com/challenge/DgH5cQEgpfu82oBQS)
---

Given a positive integer `k`, calculate the total number of `1`s in the binary representations of all the numbers from `1` to `k`, inclusive.

<!-- more -->

Example
---

For `k = 5`, the output should be `totalOnes(k) = 7`.

<code>1<sub>10</sub> = 1<sub>2</sub> &nbsp; &#8594; 1</code>

<code>2<sub>10</sub> = 10<sub>2</sub> &nbsp; &#8594; 1</code>

<code>3<sub>10</sub> = 11<sub>2</sub> &nbsp; &#8594; 2</code>

<code>4<sub>10</sub> = 100<sub>2</sub> &nbsp; &#8594; 1</code>

<code>5<sub>10</sub> = 101<sub>2</sub> &nbsp; &#8594; 2</code>

Thus, the answer is `1 + 1 + 2 + 1 + 2 = 7`.

Version 1
---

Initially I came at this problem utilizing a strictly brute force approach. I generated a list from `1 to n` and then mapped a function that converted `Integer -> Binary -> String`. Then I used concat to flatten the list `[String] -> String`. Finally I filtered the `0`s out of the `String` and took the `length` of the list.

```haskell
import Numeric (showIntAtBase)
import Data.Char (intToDigit)

totalOnes k = length (filter (=='1') (concat (map intToBin [1..k])))

intToBin :: Int -> String
intToBin n = showIntAtBase 2 intToDigit n ""
```

This version worked on all of the sample tests however, it wasn't fast enough to pass the hidden tests. For this challenge we are given a time limit of `4000ms` and `k` is constrained <code>0 &#8804; k &#8804; 2<sup>31</sup></code>.

If I was given `k = 2^31 - 1` I would have to compute each `Int -> String` in `1.863ns` just to have the list ready in less than `4000ms`.

At this point it was obvious that I needed to look for an equation that would either compute the value of `k` directly or that would generate a value near `k`.

Version 2
---

To get a clue for where I needed to go next I generated the values for `totalOnes` for `k <- [1..10]`. This gave me `1,2,4,5,7,9,12,13,15,17` which I was able to plug into the [oeis sequence encyclopedia](https://oeis.org/A000788). I was first shown this site while working on my B.S. and I have found it useful working on a number of algorithm problems.

They have a recursive formula for calculating the `totalOnes`

```haskell
a(0) = 0
a(2n) = a(n) + a(n-1) + n-1
a(2n+1) = 2a(n) + n + 1
``` 

Which can be converted into Haskell as

```haskell
a n
  | n == 0 = 0
  | even n = (a n2) + (a (n2 -1)) + n2 - 1
  | otherwise = 2 * (a n2) + n2 + 1
    where n2 = div n 2
```

This formula is faster than the `Int -> Binary -> String` code I was using before however, it introduced a recursive element that branches similar to Fibonacci. Looking for ways to speed up the recursive function I found comments suggesting that I take a dynamic programming approach to the problem and start memoizating the function.

Since I couldn't find a good method for memoization with Haskell I switched over to `C++` at this point.

```c++
std::vector<long long> lst = {0, 1, 2, 4, 5, 7};

long long ma(int k) {
    if (lst[k] != -1)
        return lst[k];
    int k2 = k / 2;
    if (k % 2 == 0)
        lst[k] = ma(k2) + ma(k2 - 1) + k2;
    if (k % 2 == 1)
        lst[k] = 2 * ma(k2) + k2 + 1;
    return lst[k];
}

long long totalOnes(int k) {
    int log2k = floor(log2(k));         // formula -> a(2^n - 1) = n*2^(n-1)
    int pow2sub1 = pow(2,log2k) - 1;    // so      -> a(pow2sub1) = log2k*2^(log2k-1)
    int passed = k - pow2sub1;          // counts how many more we need to reach k
    
    if (k < lst.size())
        return lst[k];
    
    for (int i = 0; i < passed; i++) {
        lst.push_back(-1);
        lst[i] = ma(i);
    }
        
    int lstKsub1 = log2k * pow(2,log2k-1) + passed + lst[k - pow2sub1 - 1];
    
    return lstKsub1;
}
```

This version was able to pass the first hidden test however, it failed on the second.

Version 3
---

I had effectively maxxed out the speed for directly calculating the value of `k` at this point. The next speed up came when I found another equation on the oeis site for calculating specific values of `k`.

```haskell
a(2^m-1) = m*2^(m-1)
```

This bit of code allows me to calculate the value of the nearest <code>n &#8804; k &#8739; n = 2<sup>m</sup> - 1</code> which I could use as a jumping off point to reach k.

```c++
std::vector<long long> lst = {0, 1, 2, 4, 5, 7};

long long ma(int k) {
    if (lst[k] != -1)
        return lst[k];
    int k2 = k / 2;
    if (k % 2 == 0)
        lst[k] = ma(k2) + ma(k2 - 1) + k2;
    if (k % 2 == 1)
        lst[k] = 2 * ma(k2) + k2 + 1;
    return lst[k];
}

long long totalOnes(int k) {
    int log2k = floor(log2(k));         // formula -> a(2^n - 1) = n*2^(n-1)
    int pow2sub1 = pow(2,log2k) - 1;    // so      -> a(pow2sub1) = log2k*2^(log2k-1)
    int passed = k - pow2sub1;          // counts how many more we need to reach k
    
    if (k < lst.size())
        return lst[k];
    
    for (int i = 0; i < passed; i++) {
        lst.push_back(-1);
        lst[i] = ma(i);
    }
        
    int lstKsub1 = log2k * pow(2,log2k-1) + passed + lst[k - pow2sub1 - 1];
    
    return lstKsub1;
}
```

I still wasn't able to complete all of the hidden tests with this code however, it did much better than any of my previous examples.

Overall I thought that this was a very interesting problem that required a lot more out of the box thinking than most coding challenges I come across. I have never really been given a task that requires a trade off between storage space and calculation time before and I feel that this problem nicely illustrates that concept.

Going forward I'm planning to take another look at the Coin Change problem from SICP to see if it can similarly benefit from memoization.
