#hash((doc . (body (p "I have been looking into Haskell more this week and I thought I would continue on with this project for the time being.") (h2 "Problem 3") (p "I was finally able to use an infinite list in one of my programs. I’m honestly suprised that the code for this problem comes together this cleanly. Thinking about how I would complete this problem with an eager language and a non-infinite list I can only image the complexity of the code would increase considerably.") (p "The code I have right now is nearly identical to the mathematical notation I would use to express this idea.") (p "$$\\textbf{S}= \\left [ x \\; | \\; x \\in Primes, x < \\sqrt{600,851,475,143}, \\;600,851,475,143 \\equiv 0 \\;(\\textbf{mod}\\; x) \\right ]$$") (p "$$\\textbf{max} \\left \\{ \\textbf{S} \\right \\}$$") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "ProjectEuler3.hs") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre " 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n13\n14\n15\n16\n17\n18"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "nf")) "main") " " (span ((class "ow")) "::") " " (span ((class "kt")) "IO") " " (span ((class "nb")) "()") "\n" (span ((class "nf")) "main") " " (span ((class "ow")) "=") " " (span ((class "kr")) "do") "\n    " (span ((class "n")) "putStrLn") " " (span ((class "s")) "\"" "ProjectEuler.net" "\"") "\n\n    " (span ((class "n")) "putStrLn") " " (span ((class "s")) "\"") (span ((class "se")) "\\n") (span ((class "s")) "Problem3 - Largest prime factor of 600851475143" "\"") "\n    " (span ((class "n")) "print") " " (span ((class "n")) "problem3") "\n\n" (span ((class "c1")) "--Largest prime factor of 600851475143") "\n" (span ((class "nf")) "problem3") " " (span ((class "ow")) "=") " " (span ((class "n")) "last") " " (span ((class "p")) "(") (span ((class "n")) "factors") " " (span ((class "mi")) "600851475143") (span ((class "p")) ")") "\n\n" (span ((class "nf")) "primes") " " (span ((class "ow")) "=") " " (span ((class "mi")) "2") " " (span ((class "kt")) ":") " " (span ((class "n")) "primes" 39) "\n    " (span ((class "kr")) "where") " " (span ((class "n")) "isPrime") " " (span ((class "p")) "(") (span ((class "n")) "p") (span ((class "kt")) ":") (span ((class "n")) "ps") (span ((class "p")) ")") " " (span ((class "n")) "n") " " (span ((class "ow")) "=") " " (span ((class "n")) "p") (span ((class "o")) "*") (span ((class "n")) "p") " " (span ((class "o")) ">") " " (span ((class "n")) "n") " " (span ((class "o")) "||") " " (span ((class "n")) "n") " " (span ((class "p")) "`") (span ((class "n")) "rem") (span ((class "p")) "`") " " (span ((class "n")) "p") " " (span ((class "o")) "/=") " " (span ((class "mi")) "0") " " (span ((class "o")) "&" "&") " " (span ((class "n")) "isPrime") " " (span ((class "n")) "ps") " " (span ((class "n")) "n") "\n          " (span ((class "n")) "primes" 39) " " (span ((class "ow")) "=") " " (span ((class "mi")) "3") " " (span ((class "kt")) ":") " " (span ((class "n")) "filter") " " (span ((class "p")) "(") (span ((class "n")) "isPrime") " " (span ((class "n")) "primes" 39) (span ((class "p")) ")") " " (span ((class "p")) "[") (span ((class "mi")) "5") (span ((class "p")) ",") (span ((class "mi")) "7") (span ((class "o")) "..") (span ((class "p")) "]") "\n\n" (span ((class "nf")) "floor_sqrt_int") " " (span ((class "ow")) "=") " " (span ((class "n")) "floor") " " (span ((class "o")) ".") " " (span ((class "n")) "sqrt") " " (span ((class "o")) ".") " " (span ((class "n")) "fromIntegral") "\n\n" (span ((class "nf")) "factors") " " (span ((class "ow")) "::") " " (span ((class "kt")) "Int") " " (span ((class "ow")) "-" ">") " " (span ((class "p")) "[") (span ((class "kt")) "Int") (span ((class "p")) "]") "\n" (span ((class "nf")) "factors") " " (span ((class "n")) "n") " " (span ((class "ow")) "=") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "o")) "|") " " (span ((class "n")) "x") " " (span ((class "ow")) "<" "-") " " (span ((class "p")) "(") (span ((class "n")) "takeWhile") " " (span ((class "p")) "(") (span ((class "o")) "<") " " (span ((class "p")) "(") (span ((class "n")) "floor_sqrt_int") " " (span ((class "n")) "n") (span ((class "p")) "))") " " (span ((class "n")) "primes") (span ((class "p")) "),") " " (span ((class "n")) "mod") " " (span ((class "n")) "n") " " (span ((class "n")) "x") " " (span ((class "o")) "==") " " (span ((class "mi")) "0") (span ((class "p")) "]") "\n")) "\n")))))) (h2 "Problem 4") (p "Unfortunately Haskell doesn’t seem to have a builtin function " (a ((href "https://reference.wolfram.com/language/ref/IntegerDigits.html")) (code "IntegerDigits")) " like " (a ((href "http://www.wolfram.com/mathematica/")) "Mathematica") " does.") (p "Luckily I was able to find a decent solution for breaking an integer up into its component digits. From there the actual functions are rather straight forward.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "ProjectEuler4.hs") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre " 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19\n20\n21\n22\n23"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "nf")) "main") " " (span ((class "ow")) "::") " " (span ((class "kt")) "IO") " " (span ((class "nb")) "()") "\n" (span ((class "nf")) "main") " " (span ((class "ow")) "=") " " (span ((class "kr")) "do") "\n    " (span ((class "n")) "putStrLn") " " (span ((class "s")) "\"" "ProjectEuler.net" "\"") "\n    " (span ((class "n")) "putStrLn") " " (span ((class "s")) "\"") (span ((class "se")) "\\n") (span ((class "s")) "Problem4 - Largest palindrome made from the product of two 3-digit numbers" "\"") "\n    " (span ((class "n")) "print") " " (span ((class "n")) "problem4") "\n\n" (span ((class "c1")) "--Largest palindrome made from the product of two 3-digit numbers") "\n" (span ((class "nf")) "problem4") " " (span ((class "ow")) "=") " " (span ((class "n")) "maximum") " " (span ((class "n")) "productList") "\n\n" (span ((class "nf")) "palindromeCheck") " " (span ((class "ow")) "::") " " (span ((class "kt")) "Int") " " (span ((class "ow")) "-" ">") " " (span ((class "kt")) "Bool") "\n" (span ((class "nf")) "palindromeCheck") " " (span ((class "n")) "n") " " (span ((class "ow")) "=") " " (span ((class "n")) "palindrome") " " (span ((class "p")) "(") (span ((class "n")) "digits") " " (span ((class "n")) "n") (span ((class "p")) ")") "\n\n" (span ((class "nf")) "palindrome") " " (span ((class "ow")) "::") " " (span ((class "p")) "[") (span ((class "kt")) "Int") (span ((class "p")) "]") " " (span ((class "ow")) "-" ">") " " (span ((class "kt")) "Bool") "\n" (span ((class "nf")) "palindrome") " " (span ((class "n")) "n") "\n    " (span ((class "o")) "|") " " (span ((class "n")) "n") " " (span ((class "o")) "==") " " (span ((class "kt")) "[]") " " (span ((class "ow")) "=") " " (span ((class "kt")) "True") "\n    " (span ((class "o")) "|") " " (span ((class "n")) "length") " " (span ((class "n")) "n") " " (span ((class "o")) "==") " " (span ((class "mi")) "1") " " (span ((class "ow")) "=") " " (span ((class "kt")) "True") "\n    " (span ((class "o")) "|") " " (span ((class "p")) "(") (span ((class "n")) "head") " " (span ((class "n")) "n") (span ((class "p")) ")") " " (span ((class "o")) "/=") " " (span ((class "p")) "(") (span ((class "n")) "last") " " (span ((class "n")) "n") (span ((class "p")) ")") " " (span ((class "ow")) "=") " " (span ((class "kt")) "False") "\n    " (span ((class "o")) "|") " " (span ((class "n")) "otherwise") " " (span ((class "ow")) "=") " " (span ((class "p")) "(") (span ((class "n")) "palindrome") " " (span ((class "p")) "(") (span ((class "n")) "init") " " (span ((class "p")) "(") (span ((class "n")) "tail") " " (span ((class "n")) "n") (span ((class "p")) ")))") "\n\n" (span ((class "nf")) "digits") " " (span ((class "ow")) "::") " " (span ((class "kt")) "Int") " " (span ((class "ow")) "-" ">") " " (span ((class "p")) "[") (span ((class "kt")) "Int") (span ((class "p")) "]") "\n" (span ((class "nf")) "digits") " " (span ((class "n")) "n") " " (span ((class "ow")) "=") " " (span ((class "n")) "map") " " (span ((class "p")) "(") (span ((class "nf")) "\\") (span ((class "n")) "x") " " (span ((class "ow")) "-" ">") " " (span ((class "n")) "read") " " (span ((class "p")) "[") (span ((class "n")) "x") (span ((class "p")) "]") " " (span ((class "ow")) "::") " " (span ((class "kt")) "Int") (span ((class "p")) ")") " " (span ((class "p")) "(") (span ((class "n")) "show") " " (span ((class "n")) "n") (span ((class "p")) ")") "\n\n" (span ((class "nf")) "productList") " " (span ((class "ow")) "=") " " (span ((class "p")) "[") (span ((class "n")) "x") (span ((class "o")) "*") (span ((class "n")) "y") " " (span ((class "o")) "|") " " (span ((class "n")) "x") " " (span ((class "ow")) "<" "-") " " (span ((class "p")) "[") (span ((class "mi")) "999") (span ((class "p")) ",") " " (span ((class "mi")) "998") (span ((class "o")) "..") (span ((class "mi")) "100") (span ((class "p")) "],") " " (span ((class "n")) "y") " " (span ((class "ow")) "<" "-") " " (span ((class "p")) "[") (span ((class "mi")) "999") (span ((class "p")) ",") " " (span ((class "mi")) "998") (span ((class "o")) "..") (span ((class "mi")) "100") (span ((class "p")) "],") " " (span ((class "p")) "(") (span ((class "n")) "palindromeCheck") " " (span ((class "p")) "(") (span ((class "n")) "x") (span ((class "o")) "*") (span ((class "n")) "y") (span ((class "p")) "))]") "\n")) "\n")))))) (p "Thinking about how I would solve a problem in Haskell is turning out to be a welcome break from teaching. Having problems that have workable solutions is a nice change."))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\project-euler-with-haskell-3-4.poly.pm") (published . "2015-10-10") (title . "Project Euler problem 3 and 4, with Haskell") (topics . "Project Euler,Haskell"))))