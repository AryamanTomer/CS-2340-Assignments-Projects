
.data
	question: .asciiz "Give me your zip code (0 to stop): "
	iterative: .asciiz "ITERATIVE: "
	recursive: .asciiz "RECURSIVE: "
	newline: .asciiz "\n"
	

.text
.globl main

main:
	#Asking the question
	li $v0, 4
	la $a0, question
	syscall
	
	#Reading the zip code
	li $v0, 5
	syscall
	
	#Moving the zipcode as an argument
	move $a0, $v0
	move $a1, $v0
	
	#If there is an input of 0, exit the program
	beqz $a0, exit
	
	#Calculating the sum and output of the iterative way
	jal iterative_init
	
	#Saving the result for later on
	move $t0, $v0
	
	#Printing the ITERATIVE statement
	li $v0, 4
	la $a0, iterative
	syscall
	
	#Printing the value of the Iterative Function
	move $a0, $t0
	li $v0, 1
	syscall
	
	#Printing a newline
	li $v0, 4
	la $a0, newline
	syscall
	
	#Calculating the sum and output of the recursive way
	jal recursive_calc
	
	# Saving the result for later on
    	move $t1, $v0
    	
	#Printing the RECURSIVE statement
	li $v0, 4
	la $a0, recursive
	syscall
	
	#Printing the value of the Recursive Function
	move $a0, $t1
	li $v0, 1
	syscall
	
	#Printing a newline
	li $v0, 4
	la $a0, newline
	syscall
	
	#Repeat until the input is 0
	j main
#Exit the program on this call
exit:
	li $v0, 10
	syscall

iterative_init:
	#Saving the registers that will be modified
	subu $sp, $sp, 8
    	sw $a0, 0($sp)
    	sw $t1, 4($sp)
	#Initializing variables
	li $v0, 0
	la $t1, 10
	j iterative_calc
	
	# Restore saved registers
    	lw $a0, 0($sp)
    	lw $t1, 4($sp)
    	addu $sp, $sp, 8
    	jr $ra
iterative_calc:
	#Dividing the zipcode by 10 
	divu $a0, $a0, $t1
	#Getting the remainder
	mfhi $t0
	#Adding the digits to the sum
	add $v0, $v0, $t0
	#If the quotient is 0, then this loop closes
	beqz $a0, iterative_return
	j iterative_calc
	
iterative_return:
	#Return
	jr $ra
#This is to calculate the sum in a recursive fashion
recursive_calc:
	# Save registers that will be modified
    	subu $sp, $sp, 8
    	sw $a1, 0($sp)
    	sw $t1, 4($sp)
    	
	#Initialization
	li $v0, 0
	li $t1, 10
	
	#Jump and link to the extended Function for better code quality and getting the full result
	j recursive_calc_extend
	
	# Restore saved registers
      lw $a1, 0($sp)
      lw $t1, 4($sp)
      addu $sp, $sp, 8
      jr $ra

recursive_calc_extend:
	#If the value of the remaining number is 0, then end the loop
	beqz $a1, recursive_final
	#Dividing the code by 10 and getting the remainder
	divu $a1, $a1, $t1
	mfhi $t0
	#Adding up all the digits as a sum repeatedly until the quotient is 0
	add $v0, $v0, $t0
	j recursive_calc_extend
recursive_final:
	jr $ra
