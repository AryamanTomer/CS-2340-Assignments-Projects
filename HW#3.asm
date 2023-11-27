.data
     inputArray: .space 404
     prompt: .asciiz "\nEnter an integer from 0 to 100: "
     exit_message: .asciiz "You entered 0, program stops"
     input_error: .asciiz "You entered in a wrong number, please try again"
     result_message: .asciiz "The sum of quadruple integers from 0 to N is: "
.text
main:
    
    loop:
    	#User Input
    	li $t0, 0
    	#Storing Sum
    	li $t1, 0
    	#Loop Counter
    	li $t2, 0
    	#Array Indexing
    	li $t3, 0
    	#Asking for the input
    	li $v0, 4
    	la $a0, prompt
    	syscall
    	
    	#Reading the input
    	li $v0, 5
    	syscall
    	move $t0, $v0
    	
    	#Checking a 0 input
    	beqz $t0, exit
    	
    	#Check if the input is less than or equal to 100
    	li $t4, 100
    	bgt $t0, $t4, input_err
    	
    	#Determine the Size of the Array(N+1)
    	addi $t0, $t0, 1
    	
    	
    	
    	#Moving $v0 to the address of the array which is $t5
    	move $t5, $v0 
    	
    	#Initial Array 
    	li $t2, 0
    	la $t5, inputArray
        sll $t0, $t0, 2
    	loop_array:
    		sw $t2, ($t5)
    		addi $t5, $t5, 4
    		addi $t2, $t2, 4
    		addi $t3, $t3, 4
    		bne $t3, $t0, loop_array
    	#Summing the Array
    	li $t1, 0
    	move $t5, $v0 #Moving the address of the array
    	
    	#Setting up the loop counter and the total array count
    	la $t5, inputArray
    	#2nd array count
    	li $t7, 0
    	addi $v0, $v0, 1
    	loop_sum:
    	#$t1 us the sum and $t7 is the loop counter and we compare the $v0 with $t7 because $v0 is the total array count
    		lw $t6, ($t5)
    		add $t1, $t1, $t6
    		addi $t7, $t7, 1
    		addi $t5, $t5, 4
    		bne $v0, $t7, loop_sum
    	
    
    result:
        #Printing out the result
    	li $v0, 4
    	la $a0, result_message
    	syscall
    	move $a0, $t1
    	li $v0, 1
    	syscall
    	j loop
    	
    input_err:
    	#Printing the error message
    	li $v0, 4
    	la $a0, input_error
    	syscall
    	j loop
    exit:
    	#Exit the prigram
    	li $v0, 10
    	syscall