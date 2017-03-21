#lang pollen

◊(define-meta title "Project Euler problems 3 and 4, with Haskell")
◊(define-meta published "2015-10-10")
◊(define-meta topics "Project Euler,Haskell")

I have been looking into Haskell more this week and I thought I would continue on with this project for the time being. 

◊section{Problem 3}

I was finally able to use an infinite list in one of my programs. I'm honestly suprised that the code for this problem comes together this cleanly. Thinking about how I would complete this problem with an eager language and a non-infinite list I can only image the complexity of the code would increase considerably.

The code I have right now is nearly identical to the mathematical notation I would use to express this idea.

$$\textbf{S}= \left [ x \; | \; x \in Primes, x < \sqrt{600,851,475,143}, \;600,851,475,143 \equiv 0 \;(\textbf{mod}\; x) \right ]$$

$$\textbf{max} \left \{ \textbf{S} \right \}$$

◊filebox-highlight["ProjectEuler3.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"
    
    putStrLn "\nProblem3 - Largest prime factor of 600851475143"
    print problem3

--Largest prime factor of 600851475143
problem3 = last (factors 600851475143)

primes = 2 : primes'
    where isPrime (p:ps) n = p*p > n || n `rem` p /= 0 && isPrime ps n
          primes' = 3 : filter (isPrime primes') [5,7..]

floor_sqrt_int = floor . sqrt . fromIntegral

factors :: Int -> [Int]
factors n = [x | x <- (takeWhile (< (floor_sqrt_int n)) primes), mod n x == 0]
}


◊section{Problem 4}

Unfortunately Haskell doesn't seem to have a builtin function ◊link["https://reference.wolfram.com/language/ref/IntegerDigits.html"]{◊code{IntegerDigits}} like ◊link["http://www.wolfram.com/mathematica/"]{Mathematica} does.

Luckily I was able to find a decent solution for breaking an integer up into its component digits. From there the actual functions are rather straight forward.

◊filebox-highlight["ProjectEuler4.hs" 'haskell]{
main :: IO ()
main = do
    putStrLn "ProjectEuler.net"    
    putStrLn "\nProblem4 - Largest palindrome made from the product of two 3-digit numbers"
    print problem4

--Largest palindrome made from the product of two 3-digit numbers
problem4 = maximum productList

palindromeCheck :: Int -> Bool
palindromeCheck n = palindrome (digits n)

palindrome :: [Int] -> Bool
palindrome n
    | n == [] = True
    | length n == 1 = True
    | (head n) /= (last n) = False
    | otherwise = (palindrome (init (tail n)))

digits :: Int -> [Int]
digits n = map (\x -> read [x] :: Int) (show n)

productList = [x*y | x <- [999, 998..100], y <- [999, 998..100], (palindromeCheck (x*y))]
}

Thinking about how I would solve a problem in Haskell is turning out to be a welcome break from teaching. Having problems that have workable solutions is a nice change.