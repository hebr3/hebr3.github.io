    Title: MCS521 Reading Assignment 1 - Can We Make Operating Systems Reliable and Secure?
    Date: 2017-09-10T00:00:00
    Tags: Reading Assignment, Cybersecurity, MCS511
    Authors: Henry Brooks

Reading Assignment 1
---

[Can We Make Operating Systems Reliable and Secure?](https://pdfs.semanticscholar.org/ee0c/f2be3c502575886abe01765f2e26f0a92713.pdf)

<!-- more -->

I feel that the author did a very good job of explaining the issues with current OS design and highlighting how a micro-kernel can address those issues. I have actually seen a lot of these same issues before when I was looking into Erlang programming. A design goal for Erlang software is fault recovery and tolerance. Erlang is designed for telecommunications work so it initially had the same requirements for uptime and recovery that the author is looking for. However Erlang is a general purpose language and the author wants to bring these concepts into the kernel arena.

I honestly think that it would be worthwhile for many companies to consider transferring to a micro-kernel model for their business products. While many small IoT devices run their own dedicated kernel, some are running a version of Linux or Windows 10 IoT. These OSes are overkill for many products and as the article stated, it opens up the product to many more security vulnerabilities than it should. As a specific example we know for the last black hat that many voting machines are actually run on applications running on top of Windows systems. These are the perfect example of a system where there should be clear boundaries between permissions.

The major issue I see with most companies implementing better security through a micro-kernel is legacy software. Legacy systems make up a significant portion of code that is currently being run. There are countless stories of programmers being tasked with maintenance or transition of these systems. The business side of the cost benefit analysis is weighted more in favor of fixing issues in the short term. The outlay of resources required to transition a decent sized application to a micro-kernel isn't economically feasible for many companies. Related to this is that since no one is really doing this type of work finding people who can is more difficult and costly that it should be.

Overall I agree with the desire to move more systems to a secure micro-kernel OS, I just recognize that there are major roadblocks that must be addressed on the business side of the equation.
