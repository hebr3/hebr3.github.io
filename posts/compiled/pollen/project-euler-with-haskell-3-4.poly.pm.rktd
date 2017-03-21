#hash((doc . (body (p "I have been looking into Haskell more this week and I thought I would continue on with this project for the time being.") (h2 "Problem 3") (p "I was finally able to use an infinite list in one of my programs. I’m honestly suprised that the code for this problem comes together this cleanly. Thinking about how I would complete this problem with an eager language and a non-infinite list I can only image the complexity of the code would increase considerably.") (p "The code I have right now is nearly identical to the mathematical notation I would use to express this idea.") (p "$$\\textbf{S}= \\left [ x \\; | \\; x \\in Primes, x < \\sqrt{600,851,475,143}, \\;600,851,475,143 \\equiv 0 \\;(\\textbf{mod}\\; x) \\right ]$$") (p "$$\\textbf{max} \\left \\{ \\textbf{S} \\right \\}$$") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "ProjectEuler3.hs") (div ((class "highlight")) (pre (code "main :: IO ()\nmain = do\n    putStrLn \"ProjectEuler.net\"\n\n    putStrLn \"\\nProblem3 - Largest prime factor of 600851475143\"\n    print problem3\n\n--Largest prime factor of 600851475143\nproblem3 = last (factors 600851475143)\n\nprimes = 2 : primes'\n    where isPrime (p:ps) n = p*p > n || n `rem` p /= 0 && isPrime ps n\n          primes' = 3 : filter (isPrime primes') [5,7..]\n\nfloor_sqrt_int = floor . sqrt . fromIntegral\n\nfactors :: Int -> [Int]\nfactors n = [x | x <- (takeWhile (< (floor_sqrt_int n)) primes), mod n x == 0]")))) (h2 "Problem 4") (p "Unfortunately Haskell doesn’t seem to have a builtin function " (a ((href "https://reference.wolfram.com/language/ref/IntegerDigits.html")) (code "IntegerDigits")) " like " (a ((href "http://www.wolfram.com/mathematica/")) "Mathematica") " does.") (p "Luckily I was able to find a decent solution for breaking an integer up into its component digits. From there the actual functions are rather straight forward.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "ProjectEuler4.hs") (div ((class "highlight")) (pre (code "main :: IO ()\nmain = do\n    putStrLn \"ProjectEuler.net\"\n    putStrLn \"\\nProblem4 - Largest palindrome made from the product of two 3-digit numbers\"\n    print problem4\n\n--Largest palindrome made from the product of two 3-digit numbers\nproblem4 = maximum productList\n\npalindromeCheck :: Int -> Bool\npalindromeCheck n = palindrome (digits n)\n\npalindrome :: [Int] -> Bool\npalindrome n\n    | n == [] = True\n    | length n == 1 = True\n    | (head n) /= (last n) = False\n    | otherwise = (palindrome (init (tail n)))\n\ndigits :: Int -> [Int]\ndigits n = map (\\x -> read [x] :: Int) (show n)\n\nproductList = [x*y | x <- [999, 998..100], y <- [999, 998..100], (palindromeCheck (x*y))]")))) (p "Thinking about how I would solve a problem in Haskell is turning out to be a welcome break from teaching. Having problems that have workable solutions is a nice change."))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\project-euler-with-haskell-3-4.poly.pm") (published . "2015-10-10") (title . "Project Euler problems 3 and 4, with Haskell") (topics . "Project Euler,Haskell"))))