#hash((doc . (body (figure (img ((src "/posts/img/ProjectEuler29a.png") (alt ""))) (figcaption)) (p (a ((href "https://projecteuler.net/problem=29")) "Project Euler")) (p "Like the last problem I find it’s informative to start out with an inelegant solution and try to find an elegant one at the end.") (p "We start by generating an array of the form " (mathjax "$a^b$") " from " (b "a") " = " (mathjax "$2$") " to " (mathjax "$100$") " and " (b "b") " = " (mathjax "$2$") " to " (mathjax "$100$") ".") (figure (img ((src "/posts/img/ProjectEuler29b.png") (alt ""))) (figcaption)) (p "As expected that got gigantic quickly, however we don’t need to look at all of the data to work with it.") (p "We can use " (b "Flatten") " to compress the " (mathjax "$99×99$") " array into a single vector " (mathjax "$9,801$") " elements long." (br) "We then use " (b "DeleteDuplicates") " to remove all of the duplicated elements from the vector." (br) "And finish with " (b "Length") " to find the total number of elements left over.") (figure (img ((src "/posts/img/ProjectEuler29c.png") (alt ""))) (figcaption)) (p "And technically we are done. " (b "The answer to this ProjectEular problem is " (mathjax "$9,183$") ".")) (p "However I think that it’s worth our time to consider why their are only " (mathjax "$618$") " repeated numbers in this list.") (p "First lets try to account for all of the numbers that are unique.") (p "There are " (mathjax "$25$") " prime numbers less than " (mathjax "$100$") " and each of these numbers will generate " (mathjax "$99$") " non-duplicated numbers since they will have only one number as their factor. So we have to have at least " (mathjax "$25×99=2,475$") " unique numbers just from the primes under " (mathjax "$100$") ".") (p "However thinking about it we can also remove the numbers that are composed of primes like " (mathjax "$6$") " and " (mathjax "$15$") ". Observe that since " (mathjax "$6=2×3$") " that " (mathjax "$6^2=(2×3)^2=2^2×3^3$") ", and so on.") (p "We could try to find the possible permutations of the " (mathjax "$25$") " primes however, there are " (mathjax "$2^25$") " ways that we can combine two pairs of primes and calculating which combinations have values less than " (mathjax "$100$") " is rather time consuming.") (p "Instead lets consider what numbers we know are going to show up more than once in the table?") (p "Any number that is a power of a lower number of the list will definitely be a repeated.") (p "The higher powers of " (mathjax "$2$") " will show up in the powers of " (mathjax "$4, 8, 16, 32,$") " and " (mathjax "$64$") ".") (p "Below I have generated a truncated list for the " (mathjax "$2,4,$") " and " (mathjax "$8$") " table. We can see that the " (mathjax "$4$") " table repeats every second value on the " (mathjax "$2$") " table and that the " (mathjax "$8$") " table repeats the 3rd value. This corresponds to " (mathjax "$4=2^2$") " and " (mathjax "$8=2^3$") ".") (figure (img ((src "/posts/img/ProjectEuler29d.png") (alt ""))) (figcaption)) (p "I created the following two tables in " (a ((href "https://en.wikipedia.org/wiki/LaTeX")) "LaTeX") " to highlight how the powers of " (mathjax "$2$") " repeat at specific intervals in the " (mathjax "$4$") " and " (mathjax "$8$") " power tables. A similar pattern will occur for the powers of " (mathjax "$3, 5,$") " and " (mathjax "$7$") ".") (p "Similarly the power table for " (mathjax "$6$") " will be repeated in the power table for " (mathjax "$36$") " and " (mathjax "$10$") " in the power table for " (mathjax "$100$") ".") (p "The following Matrix and ArrayPlot were generated in Mathematica to show the repeated numbers in the table given above. Observe that " (mathjax "$2^6$") " occurs the most often in this table and is represented in black in the " (b "ArrayPlot") " to signify that it is a larger value.") (figure (img ((src "/posts/img/ProjectEuler29e.png") (alt ""))) (figcaption)) (figure (img ((src "/posts/img/ProjectEuler29f.png") (alt ""))) (figcaption)) (p "Expanding the array to include all of the numbers we originally calculated we get the following " (b "ArrayPlot") ". Here we see that most of the values that will have repeats are clustered around the top of the array corresponding to a values between " (mathjax "$2$") " and " (mathjax "$10$") ".") (figure (img ((src "/posts/img/ProjectEuler29g.png") (alt ""))) (figcaption)) (p "The dark band that shows up around the " (mathjax "$2/3$") " mark on the array corresponds to the powers of " (mathjax "$2^6$") ".  As you can see by the following table the values in the " (mathjax "$2^6$") " power table show up repeatedly throughout the array.") (figure (img ((src "/posts/img/ProjectEuler29h.png") (alt ""))) (figcaption)) (p "For reference the number that shows up the most often in the table is " (mathjax "$1,152,921,504,606,846,976$") " or " (mathjax "$2^60$") ". Which makes sense when you remember that " (mathjax "$60$") " has " (mathjax "$12$") " divisors and would thus it will show up in the power table of " (mathjax "$2^1, 2^2, 2^3, 2^4, 2^5, 2^6$") ".") (p "Also you should notice that in a number of rows the values are high for half of the row and then drop down to 1 for the rest of the array. As an example the power table for " (mathjax "$100$") " is at the bottom of the array window. Note that the first " (mathjax "$50$") " values of this table occur in the " (mathjax "$10$") " power table.") (figure (img ((src "/posts/img/ProjectEuler29i.png") (alt ""))) (figcaption)) (p "It’s not until " (mathjax "$100^51$") " that we get the first value that doesn’t show up in " (mathjax "$10$") " power table.") (p (b "Conclusion")) (p "This problem is mechanically simple to calculate with a computer but is calculable by hand given time and planning. I wouldn’t ask students to do the full table by hand but I feel that you could probably have an interesting discussion with students concerning this material.") (p "Using the above code I found that " (mathjax "$280,607$") " times the second number tested was non-Prime. Since there are only " (mathjax "$336,000$") " entries in the array that means that " (mathjax "$83.5%$") " of the time while generating the original array I could have stopped after calculating the second value.") (p "This was a longer write up than I originally expected, but it was a rather involved problem that benefited greatly from optimization."))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\20-project-project-euler-29.poly.pm") (published . "2015-04-11") (title . "20% Project - ProjectEuler #29") (topics . "Teaching Credential,20% Project,Project Euler"))))