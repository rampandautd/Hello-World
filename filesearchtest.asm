.data
 prompt: .asciiz "Please enter a file name or press <enter> to exit the program "
 
 emptyspace: .asciiz ""
 
 newline: .asciiz "\r\n"
 
 newline1: .asciiz "\n"
 
 otherprompt: .asciiz "You didn't enter anything!"
 
 filename: .space 100
 
 namespace: .word 100
 
 buffer: .space 1024
 
 finalbuffer: .space 1024
 
 filepath: .asciiz "C:\\Users\\ramth\\Desktop\\MIPS files\\hello_art.txt"
 
 #filepath: .asciiz "test.txt"

 uncompressedprompt: "\nSize of uncompressed data in bytes: "
 compressedprompt: "\nSize of compressed data in bytes: "

 uncompressedmessage: "\n Original data: \n"
 compressedmessage: " \n Compressed data \n"
 
 secondprompt: .asciiz " \n Uncompressed Data: \n"


 	.text
 	
 	li $v0,4
 	la $a0, prompt
 	syscall
 	
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
	
	
 	
 	
	li $v0, 13
	la $a0, filename#filepath
	li $a1, 0
	li $a2, 0
	syscall
	
	move $s6, $v0

	li $v0, 14
	move $a0, $s6
	la $a1, buffer
	li $a2, 1024
	syscall

	
	#closing the file 
	li $v0, 16
	move $a0, $s6
	syscall
	 
	
	li $v0, 4
	la $a0, uncompressedmessage
	syscall
	
	li $v0, 4
	la $a0, buffer
	syscall
	
	li $v0, 4
	la $a0, emptyspace
	syscall
	
	
	
	
#########SIZE OF STRING IS STORED IN T2



###########LOADS BUFFERS INTO S1 AND S2


#la $s0, example
la $s0, buffer	
la $s1, finalbuffer

#lw $s5, 1024
#lw $s6, 1024

################START OF OUTER LOOP
compressedloop:

li $t0, 1	
#addi $s6, $s6, 1

lb $t1, 0($s0)
beqz $t1, exit 


#li $v0, 11
#move $a0, $t1
#syscall

sb $t1, ($s1)
addi $s1, $s1, 1

###############START OF INNER LOOP   aabbcc
nestedloop:
addi $s0, $s0, 1
lb $t3, 0($s0)
beqz $t3, exit

bne $t1, $t3, diffcharacter
addi $t0, $t0,1

#addi $s0, $s0,1

j nestedloop #jump back to the top of the nested loop if the next character is the same

############COME HERE IF THE CHARACTER IS DIFFERENT   
diffcharacter:


#li $v0, 1
#move $a0, $t0
#syscall 

addi $t5, $t0, 48
sb $t5, ($s1)
addi $s1, $s1, 1


#addi $s5, $s5, 2

j compressedloop

exit: 

 
 addi $t5, $t0, 48
 sb $t5, ($s1)

 
 #li $v0, 4
 #la $a0, emptyspace
 #syscall
 
 
 li $v0, 4
 la $a0, compressedmessage
 syscall 
 
 li $v0, 4
 la $a0, finalbuffer
 syscall
 
 
 li $v0, 4
 la $a0, secondprompt
 syscall
	
 li $v0, 4
 la $a0, buffer
 syscall
	 


	la $t0, buffer

loop:
	lb $t1, 0($t0)
	beq $t1, $zero, end
	
	addi $t0, $t0, 1
	j loop
	
end:
	la $t1, buffer
	sub $t2, $t0, $t1	
	
	
	li $v0, 4
	la $a0, uncompressedprompt
	syscall
	
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	
 	
 	la $t0, finalbuffer

loop1:
	lb $t1, 0($t0)
	beq $t1, $zero, end1
	
	addi $t0, $t0, 1
	j loop1
	
end1:
	la $t1, buffer
	sub $t2, $t0, $t1	
 	
 	
 	
 	li $v0, 4
	la $a0, compressedprompt
	syscall
 	
 	li $v0, 1
 	move $a0, $t2
 	syscall
 	
 	
 	li $v0, 10
 	syscall
 	
 	noenter:
 	li $v0,4
 	la $a0, otherprompt
 	syscall
 	