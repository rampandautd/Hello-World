.data
example: .asciiz "AAABBBBBCCCCC\n"

message: .asciiz "String is done"

.text

la $s0, example

add $s1, $zero, $zero




for:
	
	add $t6, $s0, $s1
	
	lb $t7, 0($t6)
	
	beq $t7, $zero, exit
	
	addi $s1, $s1, 1
	
	

	#addi $a0, $zero,0
	#li $v0, 11
	#move $a0,$t7
	#syscall 
	
	#addi $a0, $zero,0
	#li $v0, 1
	#move $a0,$s1
	#syscall 
	
	j for
	
ifnot: 
	addi $a0, $zero,0
	li $v0, 11
	move $a0,$t0
	syscall 
	
	addi $a0, $zero,0
	li $v0, 1
	move $a0,$s1
	syscall
	
	#addi $s2, $zero, 1
	
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
	 
	
