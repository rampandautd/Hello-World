.data
example: .asciiz "AAABBBBBCCCCC"

message: .asciiz "String is done"

.text

la $t0, example

loop:
	lb $t1, 0($t0)
	beq $t1, $zero, end
	
	addi $t0, $t0, 1
	j loop
	
end:
	la $t1, example
	sub $t2, $t0, $t1
	

la $s0, example

add $s1, $zero, $zero

addi $s2, $zero, 1

for:
	beq $s1, $t2, exit
	
	add $t3, $s0, $s1 #this accesses the registers in order
	lb $t4, 0($t3)
	beqz $t4, exit
	
	addi $s2, $s1, 1 #add 1 to s1 so we can access the register after s1
	add $t6, $s0,$s2
	lb $t7, 0($t6)
	bne $t7, $t4, ifnot # if the letters are not equal print out the letter and the count
	
	addi $s1, $s1, 1
	
	beq $s1, $t2, exit
	
	
	addi $a0, $zero,0
	
	addi $s2, $s2, 1
	j for
	
ifnot: 
	addi $a0, $zero, 0
	li $v0, 11
	move $a0,$t4
	syscall 
	
	
	addi $a0, $zero,0
	li $v0, 1
	move $a0,$s2
	syscall
	
	addi $s2, $zero, 1
	
	j for

exit:

	li $v0, 4
	la $a0,message
	syscall 
	
	
#	addi $a0, $zero,0
#	li $v0, 11
#	move $a0,$t7
#	syscall 
	
#	addi $a0, $zero,0
#	li $v0, 1
#	move $a0,$s1
#	syscall 
	 
	
