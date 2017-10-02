    Title: MCS511 Reading Assignment 2 - Enclaves for Operation System Protection
    Date: 2017-09-25T00:00:00
    Tags: Reading Assignment, Cybersecurity, MCS511
    Authors: Henry Brooks

Reading Assignment 2
---

[Enclaves for Operation System Protection](http://ieeexplore.ieee.org/document/7490626/)

<!-- more -->

I feel that the authors were successful in presenting enclaves as an important element of a security framework. They presented the pros and cons of utilizing enclaves as part of an OS security design. They also highlighted different attacks that would have been stopped or at least partially mitigated through the use of enclaving system processes.

I first learned about this type of software in relation to web browsers. Years ago Chrome and Firefox started heavily marketing their browsers for having sand-boxed tabs. At the time I was happy to have tabs that wouldn’t cause cascading crashes however, I can now see how enclaving different browser sessions could definitely improve security. Earlier this year it was shown that malicious coders could use the auto-complete function of chrome to retrieve more information through the api than the user was shown on the web page. I feel that proper enclaving of the user data and the api would have mitigated that problem. 

Concerning the operating system, I have experience running virtual machines and dual booting my own computers. I understand the benefits of having an abstraction layer to ensure that tests and processes run on one system do not damage another. I hadn’t really considered the benefits of enclaving system processes until I read this paper. Considering my experience coding for the JVM and other interpreted languages I feel like the benefits of having a secure sandbox should have been more apparent to me.

Overall I think the authors are correct in their assessment of the use of enclaves to secure operating system processes. IEEE now suggests that most systems move towards two factor authentication and I feel like a strong argument can be made to include enclaving as another layer of system protection. While it can’t stop all attacks it definitely increases the difficulty of attacking the system and makes it easier for other defenses to identify malicious activity. 

