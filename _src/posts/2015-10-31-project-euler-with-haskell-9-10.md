    Title: Project Euler problem 9 and 10, with Haskell
    Date: 2015-10-31T00:00:00
    Tags: Project Euler, Haskell
    Authors: Henry Brooks

### Problem 9

I went through a number of different versions of this program before I was happy with the answer. 

<!-- more -->

`ProjectEuler9.hs`

```haskell
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    putStrLn "Problem9 - Special Pythogorean triplet"
    print problem9
    
problem9 = head triplet

triplet = [a*b*(1000-a-b) | a <- [1..1000], b <- [a..(1000-a)], a^2 + b^2 == (1000-a-b)^2]
```

### Problem 10

Another really straight forward problem using infinite lists.

`ProjectEuler10.hs`

```haskell
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    putStrLn "Problem9 - Summation of primes"
    print problem10
    
problem10 = sum (takeWhile (<2000000) primes)

primes = 2 : primes'
    where isPrime (p:ps) n = p*p > n || n `rem` p /= 0 && isPrime ps n
          primes' = 3 : filter (isPrime primes') [5,7..]
```
