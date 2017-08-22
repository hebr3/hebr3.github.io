#hash((doc . (body (p "I just took a test where I was asked to hand write the code for the following program. As soon as I got out of class I coded up my work to make sure that it worked.") (p "I found that I forgot a lot of little helper functions, like printing spaces between array elements, however I feel that the overall code was correct.") (p "The design spec for the problem was to create a program that would ask the user to input data into two arrays. You were then supposed to create a third array that was made by adding or subtracting the values of the two initial arrays based on the index number of the element.") (p (code "C[i] = A[i] - B[i]") ", if " (code "i") " is odd, else " (code "C[i] = A[i] + B[i]")) (p "To finish the program off you print the new array.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "test.asm") (div ((class "highlight")) (table ((class "sourcetable")) (tbody (tr (td ((class "linenos")) (div ((class "linenodiv")) (pre "  1\n  2\n  3\n  4\n  5\n  6\n  7\n  8\n  9\n 10\n 11\n 12\n 13\n 14\n 15\n 16\n 17\n 18\n 19\n 20\n 21\n 22\n 23\n 24\n 25\n 26\n 27\n 28\n 29\n 30\n 31\n 32\n 33\n 34\n 35\n 36\n 37\n 38\n 39\n 40\n 41\n 42\n 43\n 44\n 45\n 46\n 47\n 48\n 49\n 50\n 51\n 52\n 53\n 54\n 55\n 56\n 57\n 58\n 59\n 60\n 61\n 62\n 63\n 64\n 65\n 66\n 67\n 68\n 69\n 70\n 71\n 72\n 73\n 74\n 75\n 76\n 77\n 78\n 79\n 80\n 81\n 82\n 83\n 84\n 85\n 86\n 87\n 88\n 89\n 90\n 91\n 92\n 93\n 94\n 95\n 96\n 97\n 98\n 99\n100\n101\n102\n103\n104\n105\n106"))) (td ((class "code")) (div ((class "source")) (pre (span) (span ((class "na")) ".data") "\n" (span ((class "nl")) "A:") "\t" (span ((class "na")) ".space") "\t" (span ((class "mi")) "40") "\n" (span ((class "nl")) "B:") "\t" (span ((class "na")) ".space") "\t" (span ((class "mi")) "40") "\n" (span ((class "nl")) "C:") "\t" (span ((class "na")) ".space") "\t" (span ((class "mi")) "40") "\n" (span ((class "nl")) "space:") "\t" (span ((class "na")) ".asciiz") " " (span ((class "s")) "\"" " " "\"") "\n" (span ((class "nl")) "nl:") "\t" (span ((class "na")) ".asciiz") " " (span ((class "s")) "\"" "\\n" "\"") "\n\n" (span ((class "na")) ".text") "\n" (span ((class "nl")) "main:") "\n        " (span ((class "nf")) "la") "\t" (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "A") "\t\t" (span ((class "c")) "# save pointers to A, B, C") "\n        " (span ((class "no")) "la") "\t" (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "B") "\n        " (span ((class "nf")) "la") "\t" (span ((class "no")) "$s2") (span ((class "p")) ",") " " (span ((class "no")) "C") "\n\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\t" (span ((class "c")) "# pass pointer to Create") "\n        " (span ((class "no")) "jal") "\t" (span ((class "no")) "Create") "\n\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "jal") "\t" (span ((class "no")) "Create") "\n\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a1") (span ((class "p")) ",") " " (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a2") (span ((class "p")) ",") " " (span ((class "no")) "$s2") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "jal") "\t" (span ((class "no")) "Create_Array_C") "\n\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "jal") "\t" (span ((class "no")) "Print") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "jal") "\t" (span ((class "no")) "Print") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$s2") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "jal") "\t" (span ((class "no")) "Print") "\n\n\n" (span ((class "nl")) "exit:") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "10") "\n        " (span ((class "nf")) "syscall") "\n\n" (span ((class "c")) "#-------") "\n" (span ((class "nl")) "Create:") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n\n\n" (span ((class "nl")) "Create_Loop:") "\n        " (span ((class "nf")) "beq") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$0") (span ((class "p")) ",") " " (span ((class "no")) "Create_Done") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "5") "\n        " (span ((class "nf")) "syscall") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t2") (span ((class "p")) ",") " " (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n\n        " (span ((class "nf")) "sw") "\t" (span ((class "no")) "$t2") (span ((class "p")) ",") " " (span ((class "mi")) "0") (span ((class "p")) "(") (span ((class "no")) "$t0") (span ((class "p")) ")") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "p")) "-") (span ((class "mi")) "1") "\n        " (span ((class "nf")) "j") "\t" (span ((class "no")) "Create_Loop") "\n\n" (span ((class "nl")) "Create_Done:") "\n        " (span ((class "nf")) "jr") "\t" (span ((class "no")) "$ra") "\n\n" (span ((class "c")) "#-------") "\n" (span ((class "nl")) "Print:") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n\n" (span ((class "nl")) "Print_Loop:") "\n        " (span ((class "nf")) "beq") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$0") (span ((class "p")) ",") " " (span ((class "no")) "Print_Done") "\n        " (span ((class "nf")) "lw") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "mi")) "0") (span ((class "p")) "(") (span ((class "no")) "$t0") (span ((class "p")) ")") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "1") "\n        " (span ((class "nf")) "syscall") "\n\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n        " (span ((class "nf")) "la") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "space") "\n        " (span ((class "nf")) "syscall") "\n\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "p")) "-") (span ((class "mi")) "1") "\n        " (span ((class "nf")) "j") "\t" (span ((class "no")) "Print_Loop") "\n\n" (span ((class "nl")) "Print_Done:") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$v0") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n        " (span ((class "nf")) "la") "\t" (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "nl") "\n        " (span ((class "nf")) "syscall") "\n        " (span ((class "nf")) "jr") "\t" (span ((class "no")) "$ra") "\n\n" (span ((class "c")) "#------") "\n" (span ((class "nl")) "Create_Array_C:") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$a0") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$a1") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t2") (span ((class "p")) ",") " " (span ((class "no")) "$a2") (span ((class "p")) ",") " " (span ((class "no")) "$0") "\n        " (span ((class "nf")) "li") "\t" (span ((class "no")) "$t3") (span ((class "p")) ",") " " (span ((class "mi")) "4") "\n\n" (span ((class "nl")) "Create_Array_C_Loop:") "\n        " (span ((class "nf")) "beq") "\t" (span ((class "no")) "$t3") (span ((class "p")) ",") " " (span ((class "no")) "$0") (span ((class "p")) ",") " " (span ((class "no")) "Create_Array_C_Done") "\n        " (span ((class "nf")) "lw") "\t" (span ((class "no")) "$t4") (span ((class "p")) ",") " " (span ((class "mi")) "0") (span ((class "p")) "(") (span ((class "no")) "$t0") (span ((class "p")) ")") "\n        " (span ((class "nf")) "lw") "\t" (span ((class "no")) "$t5") (span ((class "p")) ",") " " (span ((class "mi")) "0") (span ((class "p")) "(") (span ((class "no")) "$t1") (span ((class "p")) ")") "\n        " (span ((class "nf")) "sub") "\t" (span ((class "no")) "$t6") (span ((class "p")) ",") " " (span ((class "no")) "$t4") (span ((class "p")) ",") " " (span ((class "no")) "$t5") "\n        " (span ((class "nf")) "sw") "\t" (span ((class "no")) "$t6") (span ((class "p")) ",") " " (span ((class "mi")) "0") (span ((class "p")) "(") (span ((class "no")) "$t2") (span ((class "p")) ")") "\n        " (span ((class "nf")) "lw") "\t" (span ((class "no")) "$t4") (span ((class "p")) ",") " " (span ((class "mi")) "4") (span ((class "p")) "(") (span ((class "no")) "$t0") (span ((class "p")) ")") "\n        " (span ((class "nf")) "lw") "\t" (span ((class "no")) "$t5") (span ((class "p")) ",") " " (span ((class "mi")) "4") (span ((class "p")) "(") (span ((class "no")) "$t1") (span ((class "p")) ")") "\n        " (span ((class "nf")) "add") "\t" (span ((class "no")) "$t6") (span ((class "p")) ",") " " (span ((class "no")) "$t4") (span ((class "p")) ",") " " (span ((class "no")) "$t5") "\n        " (span ((class "nf")) "sw") "\t" (span ((class "no")) "$t6") (span ((class "p")) ",") " " (span ((class "mi")) "4") (span ((class "p")) "(") (span ((class "no")) "$t2") (span ((class "p")) ")") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "no")) "$t0") (span ((class "p")) ",") " " (span ((class "mi")) "8") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "no")) "$t1") (span ((class "p")) ",") " " (span ((class "mi")) "8") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t2") (span ((class "p")) ",") " " (span ((class "no")) "$t2") (span ((class "p")) ",") " " (span ((class "mi")) "8") "\n        " (span ((class "nf")) "addi") "\t" (span ((class "no")) "$t3") (span ((class "p")) ",") " " (span ((class "no")) "$t3") (span ((class "p")) ",") " " (span ((class "p")) "-") (span ((class "mi")) "2") "\n        " (span ((class "nf")) "j") "\t" (span ((class "no")) "Create_Array_C_Loop") "\n\n" (span ((class "nl")) "Create_Array_C_Done:") "\n        " (span ((class "nf")) "jr") "\t" (span ((class "no")) "$ra") "\n")) "\n")))))))) (metas . #hasheq((here-path . "/media/henry/Steam/Github/hebr3.github.io/posts/cs231-test-question.poly.pm") (published . "2017-03-15") (title . "CS231-Assignment1") (topics . "CS231,Assembly"))))