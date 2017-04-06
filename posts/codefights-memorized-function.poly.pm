#lang pollen

◊(define-meta title "CodeFights - totalOnes")
◊(define-meta published "2017-03-30")
◊(define-meta topics "CodeFights,Haskell,C++,Dynamic Programming,Memoization")

◊(require scribble-math)
◊(use-mathjax)
◊(define ($ . xs)  `(mathjax ,(apply string-append `("$" ,@xs "$"))))
◊(define ($$ . xs)  `(mathjax ,(apply string-append `("$$" ,@xs "$$"))))

I've been working through algorithm challenges on ◊link["https://codefights.com/"]{Code Fights} and I found a problem that forced me to learn some new techniques. Specifically I had to utilize ◊link["https://en.wikipedia.org/wiki/Memoization"]{memoization} to speed up a ◊link["https://en.wikipedia.org/wiki/Dynamic_programming"]{dynamic programming} problem. I have included the description  of the challenge below.

◊section{◊link["https://codefights.com/challenge/DgH5cQEgpfu82oBQS"]{Description }}
Given a positive integer ◊code{k}, calculate the total number of ◊code{1}s in the binary representations of all the numbers from ◊code{1} to ◊code{k}, inclusive.

Example

For ◊code{k = 5}, the output should be
◊code{totalOnes(k) = 7}.

1◊${_{10}} = 1◊${_2} => 1
2◊${_{10}} = 10◊${_2} => 1
3◊${_{10}} = 11◊${_2} => 2
4◊${_{10}} = 100◊${_2} => 1
5◊${_{10}} = 101◊${_2} => 2
Thus, the answer is ◊code{1 + 1 + 2 + 1 + 2 = 7}.

◊section{Version 1}
Initially I came at this problem utilizing a strictly brute force approach. I generated a list from ◊code{1 to n} and then mapped a function that converted ◊code{Integer -> Binary -> String}. Then I used concat to flatten the list ◊code{[String] -> String}. Finally I filtered the ◊code{0}s out of the ◊code{String} and took the ◊code{length} of the list.

◊filebox-highlight["totalOnes" 'haskell]{
import Numeric (showIntAtBase)
import Data.Char (intToDigit)

totalOnes k = length (filter (=='1') (concat (map intToBin [1..k])))

intToBin :: Int -> String
intToBin n = showIntAtBase 2 intToDigit n ""
}

This version worked on all of the sample tests however, it wasn't fast enough to pass the hidden tests. For this challenge we are given a time limit of ◊code{4000ms} and ◊code{k} is constrained ◊${0 \lt k \lt 2^{31}}.

If I was given ◊code{k = 2^31 - 1} I would have to compute each ◊code{Int -> String} in ◊code{1.863ns} just to have the list ready in less than ◊code{4000ms}.

At this point it was obvious that I needed to look for an equation that would either compute the value of ◊code{k} directly or that would generate a value near ◊code{k}.

◊section{Version 2}
To get a clue for where I needed to go next I generated the values for ◊code{totalOnes} for ◊code{k <- [1..10]}. This gave me ◊code{1,2,4,5,7,9,12,13,15,17} which I was able to plug into the ◊link["https://oeis.org/A000788"]{oeis} sequence encyclopedia. I was first shown this site while working on my B.S. and I have found it useful working on a number of algorithm problems.

They have a recursive formula for calculating the ◊code{totalOnes}
◊filebox-highlight["totalOnes" 'haskell]{
a(0) = 0
a(2n) = a(n) + a(n-1) + n-1
a(2n+1) = 2a(n) + n + 1
} 

Which can be converted into Haskell as
◊filebox-highlight["totalOnes" 'haskell]{
a n
  | n == 0 = 0
  | even n = (a n2) + (a (n2 -1)) + n2 - 1
  | otherwise = 2 * (a n2) + n2 + 1
    where n2 = div n 2
}

This formula is faster than the ◊code{Int -> Binary -> String} code I was using before however, it introduced a recursive element that branches similar to fibonacci. Looking for ways to speed up the recursive function I found comments suggesting that I take a dynamic programming approach to the problem and start memoizating the function.

Since I couldn't find a good method for memoization with Haskell I switched over to ◊code{C++} at this point.

◊filebox-highlight["totalOnes" 'c++]{
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
}

This version was able to pass the first hidden test however, it failed on the second.

◊section{Version 3}
I had effectively maxxed out the speed for directly calculating the value of ◊code{k} at this point. The next speed up came when I found another equation on the oeis site for calculating specific values of ◊code{k}.

◊filebox-highlight["totalOnes" 'haskell]{
a(2^m-1) = m*2^(m-1)
} 

This bit of code allows me to calculate the value of the nearest ◊${n \lt k \; | \; n = 2^m - 1} which I could use as a jumping off point to reach k.

◊filebox-highlight["totalOnes" 'c++]{
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
}

I still wasn't able to complete all of the hidden tests with this code however, it did much better than any of my previous examples.

Overall I thought that this was a very interesting problem that required a lot more out of the box thinking than most coding challenges I come across. I have never really been given a task that requires a trade off between storage space and calculation time before and I feel that this problem nicely illustrates that concept.

Going forward I'm planning to take another look at the Coin Change problem from SICP to see if it can similarly benefit from memoization.
