#Homework 1
#Aryaman Tomer

.data
    X: .word 0
    Y: .word 0
    Sum: .word 0
    xMag: .asciiz "Enter the values for X: "
    yMag: .asciiz "Enter the values for Y: "
    outMag: .asciiz "The sum of X and Y (X + Y) is: "
    
.text
#----------------------------------------------------

main:
    #Prompt user for X
    li $v0, 4
    la $a0, xMag
    syscall
    
    #Reading integer X
    li $v0, 5
    syscall
    sw $v0, X
    
    #Prompt user for Y
    li $v0, 4
    la $a0, yMag
    syscall
    
    #Reading integer Y
    li $v0, 5
    syscall
    sw $v0, Y
    
    #Loading values of X and Y into the registers
    lw $t0, X
    lw $t1, Y
    
    #Adding both of the values together
    add $t2, $t0, $t1

    #Storing the num into the memory location S
    sw $t2, Sum
    
    #Printing the result
    li, $v0, 4
    la $a0, outMag
    syscall
    
    #Print the sum values
    lw $a0, Sum
    li $v0, 1
    syscall
    
    #Exiting the programm
    
    li $v0, 10
    syscall
    
