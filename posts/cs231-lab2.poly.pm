#lang pollen

◊(define-meta title "CS231-Labs")
◊(define-meta published "2017-02-03")
◊(define-meta topics "CS231,Assembly")

I am currently taking ◊link["https://www.csusm.edu/assessment/portfolios/cs/bs/2012_14/cs_course_info.pdf"]{CS231} at ◊link["https://www.csusm.edu/"]{CSUSM} which covers assembly programming for the ◊link["https://en.wikipedia.org/wiki/MIPS_instruction_set"]{MIPS} architecture.

We have been using ◊link["http://courses.missouristate.edu/KenVollmar/mars/"]{MARS} as the IDE for the class and it has been working out well so far.

My second assignment for the class was to write a simple calculator that would calculate the sum, difference, product, quotient, and remainder of two numbers.

One issue that I have been having with the language is that it seems to have a lot of boilerplate that needs to be repeated. I'm thinking that I will write a helper function or macro to help with some of the repeated code.

◊filebox-highlight["Lab2-Calculator.asm" 'asm]{
## Henry Brooks
## CS231 Lab2 basic calculator

		.data
space:  	.asciiz 	"\n"
header1:	.asciiz 	"=============================================================================\n"
header2:	.asciiz 	"Program Description: This program is written to mimic a very basic calculator\n"
header3:	.asciiz 	"Author:              Henry Brooks\n"
header4:	.asciiz 	"Creation Date:       02/01/2017\n"
header5:	.asciiz 	"=============================================================================\n"

nl:		.asciiz 	"\n"

query:		.asciiz 	"Please input two numbers?\n"
sum:		.asciiz 	"Sum is: "
dif:		.asciiz 	"Difference is: "
prod:		.asciiz 	"Product is: " 
quot:		.asciiz 	"Quotient is: "
remain:		.asciiz 	"Remainder is: "

		.text
main:	
################### Print header information
		li 			$v0, 4
		la 			$a0, header1
		syscall
		la 			$a0, header2
		syscall
		la 			$a0, header3
		syscall
		la 			$a0, header4
		syscall
		la 			$a0, header5
		syscall

################### Print question 
		la 			$a0, query
		syscall

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### Take two inputs from the user
################### and assign to $s0 and $s1
		li 			$v0, 5		#load take input program
		syscall					#take first input
		add 			$s0, $v0, $0	#store first input in $s0
					
		li 			$v0, 5		#load take input program again
		syscall					#take second input
		add 			$s1, $v0, $0	#store second input in $s1

################## Print newline
		li 			$v0, 4		
		la 			$a0, nl
		syscall
	
################### Print sum
		li 			$v0, 4
		la 			$a0, sum
		syscall

		li 			$v0, 1		#load print integer
		add 			$a0, $s0, $s1	#add first and second input
		syscall					#print integer

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### Print difference
		li 			$v0, 4
		la 			$a0, dif
		syscall

		li 			$v0, 1		#load print integer
		sub 			$a0, $s0, $s1	#subtract second input from first
		syscall					#print integer

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### Print product	
		li 			$v0, 4
		la 			$a0, prod
		syscall

		li 			$v0, 1		#load print integer
		mult 			$s0, $s1	#multiple first and second
		mflo 			$a0		#assign the product to the argument
		syscall					#print integer

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### Print quotient
		li 			$v0, 4
		la 			$a0, quot
		syscall

		li 			$v0, 1		#load print integer
		div 			$s0, $s1	#divide the first by the second
		mflo 			$a0		#assign the quotient to the argument
		syscall					#print integer

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### Print remainder
		li 			$v0, 4
		la 			$a0, remain
		syscall

		li 			$v0, 1		#load print integer
		div 			$s0, $s1	#divide first and second
		mfhi 			$a0		#assign the remainder to the argument
		syscall					#print integer

		li 			$v0, 4		#print newline
		la 			$a0, nl
		syscall

################### EOF
}