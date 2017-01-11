#lang scribble/manual

Title: 20% Project - ProjectEuler #29
Date: 2015-04-11T18:00:00
Tags: 20% Project

@(require scribble-math)
@(use-mathjax)

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29a.png}

<!-- more -->

@hyperlink["https://projecteuler.net/problem=29" "Project Euler"]

Like the last problem I find it's informative to start out with an inelegant solution and try to find an elegant one at the end.

We start by generating an array of the form @math{a^b} from @bold{a} = @math{2} to @math{100} and @bold{b} = @math{2} to @math{100}.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29b.png}

As expected that got gigantic quickly, however we don't need to look at all of the data to work with it.

We can use @bold{Flatten} to compress the @math{99×99} array into a single vector @math{9,801} elements long.
We then use @bold{DeleteDuplicates} to remove all of the duplicated elements from the vector.
And finish with @bold{Length} to find the total number of elements left over.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29c.png}

And technically we are done. @bold{The answer to this ProjectEular problem is @math{9,183}.}

However I think that it's worth our time to consider why their are only @math{618} repeated numbers in this list.

First lets try to account for all of the numbers that are unique.

There are @math{25} prime numbers less than @math{100} and each of these numbers will generate @math{99} non-duplicated numbers since they will have only one number as their factor. So we have to have at least @math{25×99=2,475} unique numbers just from the primes under @math{100}.

However thinking about it we can also remove the numbers that are composed of primes like @math{6} and @math{15}. Observe that since @math{6=2×3} that @math{6^2=(2×3)^2=2^2×3^3}, and so on.

We could try to find the possible permutations of the @math{25} primes however, there are @math{2^25} ways that we can combine two pairs of primes and calculating which combinations have values less than @math{100} is rather time consuming.

Instead lets consider what numbers we know are going to show up more than once in the table?

Any number that is a power of a lower number of the list will definitely be a repeated.

The higher powers of @math{2} will show up in the powers of @math{4, 8, 16, 32,} and @math{64}.

Below I have generated a truncated list for the @math{2,4,} and @math{8} table. We can see that the @math{4} table repeats every second value on the @math{2} table and that the @math{8} table repeats the 3rd value. This corresponds to @math{4=2^2} and @math{8=2^3}.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29d.png}

I created the following two tables in @hyperlink["https://en.wikipedia.org/wiki/LaTeX" "LaTeX"] to highlight how the powers of @math{2} repeat at specific intervals in the @math{4} and @math{8} power tables. A similar pattern will occur for the powers of @math{3, 5,} and @math{7}.

Similarly the power table for @math{6} will be repeated in the power table for @math{36} and @math{10} in the power table for @math{100}.

The following Matrix and ArrayPlot were generated in Mathematica to show the repeated numbers in the table given above. Observe that @math{2^6} occurs the most often in this table and is represented in black in the @bold{ArrayPlot} to signify that it is a larger value.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29e.png}
@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29f.png}

Expanding the array to include all of the numbers we originally calculated we get the following @bold{ArrayPlot}. Here we see that most of the values that will have repeats are clustered around the top of the array corresponding to a values between @math{2} and @math{10}.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29g.png}

The dark band that shows up around the @math{2/3} mark on the array corresponds to the powers of @math{2^6}.  As you can see by the following table the values in the @math{2^6} power table show up repeatedly throughout the array.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29h.png}

For reference the number that shows up the most often in the table is @math{1,152,921,504,606,846,976} or @math{2^60}. Which makes sense when you remember that @math{60} has @math{12} divisors and would thus it will show up in the power table of @math{2^1, 2^2, 2^3, 2^4, 2^5, 2^6}.

Also you should notice that in a number of rows the values are high for half of the row and then drop down to 1 for the rest of the array. As an example the power table for @math{100} is at the bottom of the array window. Note that the first @math{50} values of this table occur in the @math{10} power table.

@image{C:\GitHub\hebr3.github.io\img\posts\2015-04-11-20-project-projecteuler-29\ProjectEuler29i.png}

It's not until @math{100^51} that we get the first value that doesn't show up in @math{10} power table.

@bold{Conclusion}

This problem is mechanically simple to calculate with a computer but is calculable by hand given time and planning. I wouldn't ask students to do the full table by hand but I feel that you could probably have an interesting discussion with students concerning this material.
