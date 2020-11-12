#.data
#prompt:	.asciiz "C:\\Users\\ramth\\Desktop\\test.txt"

#buffer: .space 1024

#.text 
 
 .macro printint(%x) #print int
 	li $v0,1
 	lw $a0, %x
 	syscall
 .end_macro 
 
 
 .macro printchar(%str) #prints char
 	li $v0,4
 	lw $a0, %str
 	syscall
 .end_macro 
 
 .macro printstr(%str) #print string
 	li $v0, 4
 	lw $a0, %str
 	syscall
 .end_macro 
 
 
 
 .macro userinput
 	
 	.data
 prompt: .asciiz "Please enter a file name or press <enter> to exit the program"
 
 emptyspace: "\r\n"
 
 otherprompt: .asciiz "You didn't enter anything!"
 
 filename: .space 20
 namespace: .word 20
 
 	.text
 	li $v0,4
 	la $a0, prompt
 	syscall
 	
 	li $v0, 8
 	la $a0,filename
 	la $a1, namespace
 	syscall
 	
 	la $t1, emptyspace
 	beq $a0, $t1, noenter
 	
 	li $v0, 4
 	syscall
 	
 	lw $ra, 1
 	jr $ra
 	
 	noenter:
 	li $v0,4
 	la $a0, otherprompt
 	syscall
 	
 	la $ra, $zero
 	jr $ra	
 	
 .end_macro 
 
 
 
 .macro openreadandclose(%str)
 
 	.data
#filepath: .asciiz "C:\\Users\\ramth\\Desktop\\MIPS files\\hello_art.txt"
filepath: .asciiz "hello_art.txt"
buffer: .space 1024

	.text
	li $v0, 13
	la $a0, filepath
	li $a1, 0
	syscall
	move $s6, $v0

	li $v0, 14
	move $a0, $s6
	la $a1, buffer
	la $a2, 1024
	syscall

	li $v0, 4
	la $a0, buffer
	syscall
	  
	 
	 #closing the file 
	 li $v0, 16
	 move $a0, $s6
	 syscall
 
 .end_macro 
 
 
 .macro addzero(%numchars, %buffer)
 	la $t0, %buffer
 	move $t1, %numchars
 	add $t0, $t0, $t1
 	lbu $t2, 0($t0)
 	li $t2, 0
 	sb $t2, 0($t0)
 	move $t2, 
 	
 	jr $ra
 .end_macro
 
 .macro compress(%buffer. %size)
 	
 .data
 finalbuffer: .space 1024
 
 initbuffer: .space %size
 .text
 
 
 la $a1, %buffer
 la $a2, finalbuffer
 move $s1, $a1
 move $s2, $a2
 lw $s6, 1024
 lw $s7, %size
 loop1:
 li $t2, 1
 addi $s7,$s7,1
 lb $t1, ($s1)
 beqz $t1, exitLoop
 addi $s1, $s1, 1
 loop2:
 lb $t3, ($s1)
 bne $t1, $t3, loop3
 addi $s7,$s7,1
 addi $t2,$t2,1
 addi $s1, $s1,1
 j nestedLoop
 loop3:
 sb $t1, ($s2)
 addi $s2, $s2,1
 sb $t2,($s2)
 addi $s6, $s6, 2
 addi $s2, $s2, 1
 j loop1
 
 
 la $ra, finalbuffer
 jr $ra
 .end_macro
 
 
 
