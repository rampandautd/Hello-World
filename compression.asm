.data

example: .asciiz "AA"
output: .asciiz "finished processing "
newline: .asciiz "\n"
#count: .word 0


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
	

 li $v0,1
 move $a0, $t2
 syscall


la $s0, example

addi $t3, $zero,1
addi $t4, $zero,0 
addi $t5, $zero, 1

add $s1, $zero, $zero

#addi $s2, $zero, 1

add $t6, $s0, $s1

lb $t7, 0($t6)
for:
	
	add $t6, $s0, $s1 
	add $t8, $s0, $s2
	
	lb $t7, 0($t6)
	#lb $t9, 0($t8)
	move $t9,$t7
	addi $s1, $s1, 1
	
	li $v0, 11
	move $t7, 
	beq $t9, $zero, exit
	bne $t7, $t9, printout
	
	
	addi $s2, $s2, 1
	
	
	j for
	


printout:
	
	li $v0,11
	move $a0,$t7
 	syscall
 	
 	addi $a0, $zero,0
 	
 	li $v0,1
 	move $a0, $s2
 	syscall
 	
 	addi $s2, $zero, 1
 	addi $s1,$s1,1
 	
 	j for
	

exit:
	addi $a0, $zero, 0
	li $v0,4
	la $a0,output
	syscall