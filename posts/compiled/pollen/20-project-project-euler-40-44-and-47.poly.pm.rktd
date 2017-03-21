#hash((doc . (body (figure (img ((src "/posts/img/ProjectEuler29a.png") (alt ""))) (figcaption)) (p (a ((href "https://projecteuler.net/problem=29")) "Project Euler")) (p "Like the last problem I find it’s informative to start out with an inelegant solution and try to find an elegant one at the end.") (p "We start by generating an array of the form " (mathjax "$a^b$") " from " (b "a") " = " (mathjax "$2$") " to " (mathjax "$100$") " and " (b "b") " = " (mathjax "$2$") " to " (mathjax "$100$") ".") (figure (img ((src "/posts/img/ProjectEuler29b.png") (alt ""))) (figcaption)) (p (b "Problem 47")) (p "The first two consective numbers to have two distince prime factors are:") (p (mathjax "$14=2×7$") (br) (mathjax "$15=3×5$")) (p "The first three consective numbers to have three distinct prime factors are:") (p (mathjax "$644=2^2×7×23$") (br) (mathjax "$644=2^2×7×23$") (br) (mathjax "$644=2^2×7×23$")) (p "Find the first four consective numbers to have four distinct prime factors. What is the first of these numbers?") (div ((class "listing-filename")) 128196 " " "Mathematica") (pre ((class "code")) "prob47 = Flatten[Table[Length[FactorInteger[n]], {n, 1, 200000}]];" "\n" "prob47b = Table[Sum[prob47[[a + i]], {i,0,3}], {a, 1, 199997}];" "\n" "Position[prob47b, 16]") (p "=====================") (p (b "Problem 44")) (p "Pentagonal numbers are generated by the formula, " (mathjax "$P_n=n(3n-1)/2$") ". The first ten pentagonal numbers are:") (p (mathjax "$1, 5, 12, 22, 35, 51, 70, 92, 117, 145,$") " ...") (p "It can be seen that " (mathjax "$P_4 + P_7 = 22 + 70 = 92 = P_8$") ". However, their difference, 70 - 22 = 48, is not pentagonal.") (p "Find the pair of pentagonal numbers, " (mathjax "$P_j$") " and " (mathjax "$P_k$") ", for which their sum and difference are pentagonal and " (mathjax "$D = |P_k - P_j|$") " is minimised; what is the value of D?") (div ((class "listing-filename")) 128196 " " "Mathematica") (pre ((class "code")) "prob44a = Table[m×(m + 1)/2, {m, 1, 100000}];" "\n" "prob44b = Table[n×(3×n-1)/2, {n, 1, 100000}];" "\n" "prob44c = Table[o×(2×o-1), {o, 1, 100000}];" "\n" "Intersection[prob44a, prob44b, prob44c]") (p "=====================") (p (b "Problem 40")) (p "An irrational decimal fraction is created by concatenating the positive integers:") (p (mathjax "$\\large{0.123456789101}\\huge{1}\\large{12131415161718192021...}$")) (p "It can be seen that the " (mathjax "$12^{th}$") " digit of the fractional part is 1.") (p "If " (mathjax "$d_n$") " represents the n" (sup "th") " digit of the fractional part, find the value of the following expression.") (p (mathjax "$d_1 × d_{10} × d_{100} × d_{1000} × d_{10000} × d_{100000} × d_{1000000}$")) (div ((class "listing-filename")) 128196 " " "Mathematica") (pre ((class "code")) "prob40 = Flatten[IntegerDigits[Table[n, {n, 1, 200000}]]];" "\n" "Product[prob40[[10^a]], {a, 0, 6}]"))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\20-project-project-euler-40-44-and-47.poly.pm") (published . "2015-04-15") (title . "20% Project - ProjectEuler #40, 44, and 47") (topics . "Teaching Credential,20% Project,Project Euler"))))