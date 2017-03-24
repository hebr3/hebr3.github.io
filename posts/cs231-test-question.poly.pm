#lang pollen

◊(define-meta title "CS231-Assignment1")
◊(define-meta published "2017-03-15")
◊(define-meta topics "CS231,Assembly")

I just took a test where I was asked to hand write the code for the following program. As soon as I got out of class I coded up my work to make sure that it worked.

I found that I forgot a lot of little helper functions, like printing spaces between array elements, however I feel that the overall code was correct.

The design spec for the problem was to create a program that would ask the user to input data into two arrays. You were then supposed to create a third array that was made by adding or subtracting the values of the two initial arrays based on the index number of the element.

◊code{C[i] = A[i] - B[i]}, if ◊code{i} is odd, else ◊code{C[i] = A[i] + B[i]}

To finish the program off you print the new array.

◊filebox-highlight["test.asm" 'asm]{
.data
A:	.space	40
B:	.space	40
C:	.space	40
space:	.asciiz " "
nl:	.asciiz "\n"

.text
main:
	la	$s0, A		# save pointers to A, B, C
	la	$s1, B
	la	$s2, C

	add	$a0, $s0, $0	# pass pointer to Create
	jal	Create

	add	$a0, $s1, $0
	jal	Create
	
	add	$a0, $s0, $0
	add	$a1, $s1, $0
	add	$a2, $s2, $0
	jal	Create_Array_C
	
	add	$a0, $s0, $0
	jal	Print
	add	$a0, $s1, $0
	jal	Print
	add	$a0, $s2, $0
	jal	Print
	
	
exit:
	li	$v0, 10
	syscall
	
#-------
Create:
	add	$t0, $a0, $0
	li	$t1, 4

	
Create_Loop:
	beq	$t1, $0, Create_Done
	li	$v0, 5
	syscall
	add	$t2, $v0, $0
		
	sw	$t2, 0($t0)
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	j	Create_Loop
	
Create_Done:
	jr	$ra
	
#-------
Print:
	add	$t0, $a0, $0
	li	$t1, 4
	
Print_Loop:
	beq	$t1, $0, Print_Done
	lw	$a0, 0($t0)
	li	$v0, 1
	syscall
	
	li	$v0, 4
	la	$a0, space
	syscall
	
	addi	$t0, $t0, 4
	addi	$t1, $t1, -1
	j	Print_Loop
	
Print_Done:
	li	$v0, 4
	la	$a0, nl
	syscall
	jr	$ra
	
#------
Create_Array_C:
	add	$t0, $a0, $0
	add	$t1, $a1, $0
	add	$t2, $a2, $0
	li	$t3, 4
	
Create_Array_C_Loop:
	beq	$t3, $0, Create_Array_C_Done
	lw	$t4, 0($t0)
	lw	$t5, 0($t1)
	sub	$t6, $t4, $t5
	sw	$t6, 0($t2)
	lw	$t4, 4($t0)
	lw	$t5, 4($t1)
	add	$t6, $t4, $t5
	sw	$t6, 4($t2)
	addi	$t0, $t0, 8
	addi	$t1, $t1, 8
	addi	$t2, $t2, 8
	addi	$t3, $t3, -2
	j	Create_Array_C_Loop
		
Create_Array_C_Done:
	jr	$ra

}