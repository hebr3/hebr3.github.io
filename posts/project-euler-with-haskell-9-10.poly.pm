#lang pollen

◊(define-meta title "Project Euler problem 9 and 10, with Haskell")
◊(define-meta published "2015-10-31")
◊(define-meta topics "Project Euler,Haskell")

◊section{Problem 9}

I went through a number of different versions of this program before I was happy with the answer. 

◊filebox-highlight["ProjectEuler9.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    putStrLn "Problem9 - Special Pythogorean triplet"
    print problem9
    
problem9 = head triplet

triplet = [a*b*(1000-a-b) | a <- [1..1000], b <- [a..(1000-a)], a^2 + b^2 == (1000-a-b)^2]
}

◊section{Problem 10}

Another really straight forward problem using infinite lists.

◊filebox-highlight["ProjectEuler10.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    putStrLn "Problem9 - Summation of primes"
    print problem10
    
problem10 = sum (takeWhile (<2000000) primes)

primes = 2 : primes'
    where isPrime (p:ps) n = p*p > n || n `rem` p /= 0 && isPrime ps n
          primes' = 3 : filter (isPrime primes') [5,7..]
}