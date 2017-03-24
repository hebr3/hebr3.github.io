#hash((doc . (body (p "I have been thinking about all of the boilerplate code that I keep writing in my assembly class and I decide to start looking into creating a simple " (a ((href "https://en.wikipedia.org/wiki/Domain-specific_language")) "DSL") " to assist with my code writing.") (p "Mostly I am looking to simplify code blocks that have easy c++ analogs. Specifically cin, cout, and assignment.") (p "Currently I am writing code like this") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "example.asm") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre " 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n13\n14"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "na")) "...") "\n" (span ((class "c")) "#------ cin " "<" "<" " $s0") "\n" (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "5") "\n        " (span ((class "nf")) "syscall") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n\n" (span ((class "c")) "#------ $s1 = $s0") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n\n" (span ((class "c")) "#------ cout " "<" "<" " $s1") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "1") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "syscall") "\n" (span ((class "na")) "...") "\n")) "\n")))))) (p "To get results for code like this in c++") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "example.cpp") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre "1\n2\n3\n4\n5\n6"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "p")) "...") "\n" (span ((class "kt")) "int") " " (span ((class "n")) "s0") (span ((class "p")) ",") " " (span ((class "n")) "s1") (span ((class "p")) ";") "\n" (span ((class "n")) "cin") " " (span ((class "o")) ">" ">") " " (span ((class "n")) "s0") (span ((class "p")) ";") "\n" (span ((class "n")) "s1") " " (span ((class "o")) "=") " " (span ((class "n")) "s0") (span ((class "p")) ";") "\n" (span ((class "n")) "cout") " " (span ((class "o")) "<" "<") " " (span ((class "n")) "s1") (span ((class "p")) ";") "\n" (span ((class "p")) "...") "\n")) "\n")))))) (p "I recognize that there are some actions that need a full compiler to implement however, I think that I can implement this much in typed/racket with what I already know. I’m choosing to use typed/racket because I want to experiment with using it and I think it will come in useful if I continue to expand the scope of the code.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "ASM-DSL.rkt") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre " 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19\n20\n21\n22\n23\n24\n25\n26\n27\n28\n29\n30\n31\n32\n33\n34\n35\n36\n37\n38\n39\n40\n41\n42\n43\n44\n45\n46\n47\n48\n49"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "kn")) "#lang ") (span ((class "nn")) "typed/racket") "\n\n" (span ((class "c1")) ";; Save register values") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "n")) "func") " " (span ((class "s2")) "\"" "$v0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "n")) "return") " " (span ((class "s2")) "\"" "$v0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "n")) "input") " " (span ((class "s2")) "\"" "$s0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "n")) "arg") " " (span ((class "s2")) "\"" "$a0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "n")) "zero") " " (span ((class "s2")) "\"" "$0" "\"") (span ((class "p")) ")") "\n\n" (span ((class "c1")) ";; Buildin MIPS instructions") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "comment") " " (span ((class "p")) "[") (span ((class "n")) "s") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "p")) "(") (span ((class "nb")) "string-append") " " (span ((class "s2")) "\"" "#------ " "\"") " " (span ((class "n")) "s") " " (span ((class "s2")) "\"") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) ")))") "\n\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "add") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "]") " " (span ((class "p")) "[") (span ((class "n")) "y") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "]") " " (span ((class "p")) "[") (span ((class "n")) "z") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "p")) "(") (span ((class "nb")) "string-append") " " (span ((class "s2")) "\"") (span ((class "se")) "\\t") (span ((class "s2")) "add") (span ((class "se")) "\\t") (span ((class "s2")) "\"") "\n                          " (span ((class "n")) "x") " " (span ((class "s2")) "\"" ", " "\"") "\n                          " (span ((class "n")) "y") " " (span ((class "s2")) "\"" ", " "\"") "\n                          " (span ((class "n")) "z") " " (span ((class "s2")) "\"") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) ")))") "\n\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "li") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "]") " " (span ((class "p")) "[") (span ((class "n")) "y") " " (span ((class "n")) ":") " " (span ((class "n")) "Integer") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "p")) "(") (span ((class "nb")) "string-append") " " (span ((class "s2")) "\"") (span ((class "se")) "\\t") (span ((class "s2")) "li") (span ((class "se")) "\\t") (span ((class "s2")) "\"") "\n                          " (span ((class "n")) "x") " " (span ((class "s2")) "\"" ", " "\"") "\n                          " (span ((class "p")) "(") (span ((class "nb")) "number-" ">" "string") " " (span ((class "n")) "y") (span ((class "p")) ")") " " (span ((class "s2")) "\"") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) ")))") "\n\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "syscall") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "s2")) "\"") (span ((class "se")) "\\t") (span ((class "s2")) "syscall") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) "))") "\n\n" (span ((class "c1")) ";; Macros I built") "\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "set-reg") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "]") " " (span ((class "p")) "[") (span ((class "n")) "y") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "n")) "add") " " (span ((class "n")) "x") " " (span ((class "n")) "y") " " (span ((class "n")) "zero") (span ((class "p")) "))") "\n\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "cout-int") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "n")) "comment") " " (span ((class "p")) "(") (span ((class "nb")) "string-append") " " (span ((class "s2")) "\"" "cout " "<" "<" " " "\"") " " (span ((class "n")) "x") (span ((class "p")) "))") "\n  " (span ((class "p")) "(") (span ((class "n")) "li") " " (span ((class "n")) "func") " " (span ((class "mi")) "1") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "n")) "set-reg") " " (span ((class "n")) "arg") " " (span ((class "n")) "x") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "n")) "syscall") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "s2")) "\"") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) "))") "\n\n" (span ((class "p")) "(") (span ((class "k")) "define") " " (span ((class "p")) "(") (span ((class "n")) "cin-int") " " (span ((class "p")) "[") (span ((class "n")) "x") " " (span ((class "n")) ":") " " (span ((class "n")) "String") (span ((class "p")) "])") "\n  " (span ((class "p")) "(") (span ((class "n")) "comment") " " (span ((class "p")) "(") (span ((class "nb")) "string-append") " " (span ((class "s2")) "\"" "cin " "<" "<" " " "\"") " " (span ((class "n")) "x") (span ((class "p")) "))") "\n  " (span ((class "p")) "(") (span ((class "n")) "li") " " (span ((class "n")) "func") " " (span ((class "mi")) "5") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "n")) "syscall") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "n")) "add") " " (span ((class "n")) "return") " " (span ((class "n")) "x") " " (span ((class "n")) "zero") (span ((class "p")) ")") "\n  " (span ((class "p")) "(") (span ((class "nb")) "display") " " (span ((class "s2")) "\"") (span ((class "se")) "\\n") (span ((class "s2")) "\"") (span ((class "p")) "))") "\n\n" (span ((class "c1")) ";; Mips code") "\n" (span ((class "p")) "(") (span ((class "n")) "cin-int") " " (span ((class "s2")) "\"" "$s0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "n")) "set-reg") " " (span ((class "s2")) "\"" "$s1" "\"") " " (span ((class "s2")) "\"" "$s0" "\"") (span ((class "p")) ")") "\n" (span ((class "p")) "(") (span ((class "n")) "cout-int") " " (span ((class "s2")) "\"" "$s1" "\"") (span ((class "p")) ")") "\n")) "\n")))))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "output.asm") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre " 1\n 2\n 3\n 4\n 5\n 6\n 7\n 8\n 9\n10"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "c")) "#------ cin " "<" "<" " $s0") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "5") "\n        " (span ((class "nf")) "syscall") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n" (span ((class "c")) "#------ cout " "<" "<" " $s1") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "1") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "syscall") "\n")) "\n")))))))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\asm-dsl.poly.pm") (published . "2017-03-11") (title . "ASM-DSL") (topics . "CS231,Assembly,DSL"))))