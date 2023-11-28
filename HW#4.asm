#Aryaman Tomer axt210052@UTDallas.edu
#CS 2340.004 Nhut Nguyen
.data
    round_text: .asciiz "What is the number of round pizzas sold: "
    square_text: .asciiz "What is the number of square pizzas sold: "
    estimate_text: .asciiz "Enter the estimate of total pizzas sold in square feet: "
    result_text: .asciiz "Woosh!"
    bummer_text: .asciiz "Bummer!"
    new_line: .asciiz "\n"
    total_result_text: .asciiz "Total square feet of pizzas sold: "
    total_square_text: .asciiz "Total square feet of square pizzas sold: "
    total_round_text: .asciiz "Total square feet of round pizzas sold: "
    pi_float: .float 3.14
    radius: .float 4.0
    ft_to_inch_sq: .word 144

.text
.globl main

main:
    # Ask for the number of round pizzas that were sold off
    li $v0, 4
    la $a0, round_text
    syscall

    # Reading the number of round pizzas sold
    li $v0, 5
    syscall
    # $s0 holds this number
    move $s0, $v0

    # Ask for the number of square pizzas that were sold off
    li $v0, 4
    la $a0, square_text
    syscall

    # Reading the number of square pizzas sold
    li $v0, 5
    syscall
    # $s1 holds this number
    move $s1, $v0

    # Asking the user for Joe's estimate of the total pizzas sold in square feet
    li $v0, 4
    la $a0, estimate_text
    syscall

    # Reading the Estimate that Joe has
    li $v0, 6
    syscall
    # Storing the estimate as a floating-point number
    mov.s $f4, $f0

    # Load the value of PI
    l.s $f5, pi_float
    #$f6 = radius $f1 = pi $f2 = area
    # Calculate the total square feet of round pizzas using floating-point arithmetic
    l.s $f6, radius     # Load the radiys which is 4 since the diameter is 8
    mul.s $f1, $f6, $f6 # Squaring the radius
    mul.s $f2, $f5, $f1 # Multiplying by PI
    mtc1 $s0, $f3
    cvt.s.w $f3 $f3 
    mul.s $f2, $f3, $f2
    # Displaying the total square feet of round pizzas
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, total_round_text
    syscall
    li $v0, 2
    mov.s $f12, $f2
    syscall
    # $t2 is the side length $t3 is the radius squared $t5 is the total area
    # Calculate the total square feet of square pizzas using integer arithmetic
    li $t2, 11 # Side length of square pizzas in inches
    mul $t3, $t2, $t2 # Calculate the area of the square pizzas in square inches
    lw $t4, ft_to_inch_sq # Loading 144 since I will convert to feet squared
    mtc1 $t4, $f10
    cvt.s.w $f10 $f10
    mtc1 $t3, $f11
    cvt.s.w $f11 $f11
    mtc1 $t5, $f7
    cvt.s.w $f7 $f7
    div.s $f7, $f11, $f10
     # Convert square inches to floating-point
    mtc1 $s1, $f8
    cvt.s.w $f8 $f8
    mul.s $f9, $f8, $f7 # Multiplying the area by the # of pizzas to get the # of square feet

    # Dis.w splaying the total square feet of square pizzas
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, total_square_text
    syscall
    li $v0, 2
    mov.s $f12, $f9
    syscall
    
    # Add the areas of round and square pizzas
    add.s $f1, $f9, $f2
    add.s $f1, $f1, $f12
    
    # Displaying the total square feet of pizzas sold
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, total_result_text
    syscall

    # Displaying the number of square feet
    li $v0, 2
    mov.s $f12, $f1
    syscall

    # Comparing the total pizzas sold to the estimate and if the total is greater than the estimate, it then prints out Woosh!
    c.le.s $f4, $f1
    bc1t woosh
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, bummer_text
    syscall
    j exit

woosh:
    li $v0, 4
    la $a0, new_line
    syscall
    li $v0, 4
    la $a0, result_text
    syscall

exit:
    li $v0, 10
    syscall
