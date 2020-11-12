.data

a: .word 
b: .word 
c: .word

output1: .word
output2: .word
output3: .word

username: .asciiz

nameask: .asciiz "What is your name?"
integerask: .asciiz "Enter an Integer that is between 1-100:"
finalmessage: .asciiz "your answers are" 
nameMsg: .asciiz "\n Your name is "

.text


main:  lw $a0, nameask
	li $v0, 4
	syscall 
	
	li $v0,5
	syscall 
	sw $v0, username

	lw $a0,integerask
	li $v0, 4
	syscall 
	
	li $v0,5
	syscall 
	sw $v0, a

	lw $a0,integerask
	li $v0, 4
	syscall 
	
	li $v0,6
	syscall 
	sw $v0, b
	
	lw $a0,integerask
	li $v0, 4
	syscall 
	
	li $v0,7
	syscall 
	sw $v0, c
	
	
	
	lw $t0, a
	add $t1, $t0, $t0
	
	lw $t2, b
	sub $t3, $t1, $t2
	
	addi $t4, $t3 ,9
	lw $t4, output1
	
	
	
	
	lw $t3, c
	
	sub $t4, $t3, $t2
	
	add $t5 , $t4 ,$t1
	
	addi $t6 , $t5 , 5
	lw $t6 , output2
	
	
	addi $t4 , $t1 , -3
	addi $t5 , $t2 , 4
	addi $t6 , $t3 , 7
	
	add $t7 , $t4 , $t5
	sub $t8 , $t7 , $t6
	lw $t8 , output3
	
	lw $a0, username
	li $v0, 4
	syscall 
	
	lw $a0, finalmessage
	li $v0, 4
	syscall 	
	
	lw $a0, output1
	li $v0, 4
	syscall 
	
	lw $a0, output2
	li $v0, 4
	syscall 
	
	lw $a0, output3
	li $v0, 4
	syscall 
	
	
	
	
	
	

# enter your code here 

#bge $t0 , $0, exit
#sub $t0, $0, exit


exit:  li $v0, 10
	syscall
	
