	.data
	
 filename: .space 100

 newline: .asciiz "\r\t"
 
 
 otherprompt: .asciiz "You didn't enter anything!"
 
	.text
	li $v0, 8
 	la $a0,filename #filepath
 	la $a1,100 
 	syscall
 	
 	
 	la $t0, filename
 	lb $t5, ($t0)
 	beq $t5,10, noenter
 	
 	
 eliminate:
 	lb $t4, ($t0)
 	beq $t4,10,removechar
 	addi $t0, $t0, 1
 	j eliminate 
 	#lb $t1, 0($t0
 
 removechar:
 	li $t5, 0
 	sb $t5,($t0)
	
	
 li $v0, 4
 la $a0, filename
 syscall
 
 li $v0,10
 syscall
 
 noenter:
 	li $v0,4
 	la $a0, otherprompt
 	syscall	