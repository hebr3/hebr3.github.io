#lang pollen

◊(define-meta title "Project Euler problems 5, 6 and 7, with Haskell")
◊(define-meta published "2015-10-17")
◊(define-meta topics "Project Euler,Haskell")

◊section{Problem 5}

I have solved similar questions during math test so I went with a purely brute force solution to this problem as I wanted to test how long it would take to complete.

◊filebox-highlight["ProjectEuler5.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    
    putStrLn "\nProblem5 - Smallest multiple of the numbers 1-20"
    print problem5

--Smallest multiple of the numbers 1-20
problem5 = head [x | x <- [1..], mod x 5 == 0, mod x 7 == 0, mod x 9 == 0, mod x 11 == 0, mod x 13 == 0, mod x 16 == 0, mod x 17 == 0,mod x 19 == 0]
}

I was a little suprised that the program didn't crash considering how large a number it had to count up to. I'm not sure if this says more about the Haskell langauge or modern computers. I do know that Haskell supports Integers that can be as large as the memory space of the computer allows, so I feel like this might be a win for Haskell.

Solving this without programming is mostly an exercise in taking the prime factorization of the numbers from 1 to 20 and ◊link["http://www.wolframalpha.com/input/?i=232792560"]{combining them}.

◊section{Problem 6}

Rather straight foward solution to this problem. I am still suprised by how clean the code looks in haskell compared to ◊code{c++}. There is much less ◊link["https://en.wikipedia.org/wiki/Boilerplate_code"]{boilerplate} code required to get a solution printed on screen.

◊filebox-highlight["ProjectEuler6.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"    
    putStrLn "\nProblem6 - Sum sqaure difference for the first 100 natural numbers"
    print problem6

--Sum square difference
problem6 = sqSum - sumSq

sq x = x * x

sqSum = sq (sum [1..100])
sumSq = sum (map sq [1..100]) 
}

◊section{Problem 7}

Another really clean solution using infinite lists.

◊filebox-highlight["ProjectEuler7.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"    
    putStrLn "\nProblem7 - 10,001th Prime"
    print problem7

--10001th Prime
problem7 = primes!!10000 -- index starts at 0

primes = 2 : primes'
    where isPrime (p:ps) n = p*p > n || n `rem` p /= 0 && isPrime ps n
          primes' = 3 : filter (isPrime primes') [5,7..]
}

◊link["https://projecteuler.net/problem=8"]{Problem 8} from Project Euler is looking like a much more involved problem however, I'm hopeful that I will be able to get it finished this week.
