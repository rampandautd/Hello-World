.data 

userinput: .space 100 

spacecheck: .asciiz " "

words: .asciiz "words and"

prompt: .asciiz "Enter a text!" 

messages: .asciiz "characters"

goodbye: .asciiz "goodbye"

charactercount: .word 0

wordcount: .word 0

.text
	#prompting the user for their 
	li $v0, 54
	la $a0, prompt 
	la $a1, userinput
	li $a2, 99
	syscall
	
	#this loads the user input and integers initialized
	la $t1, userinput
	lw $t2, charactercount
	lw $t3, wordcount
	la $t4, spacecheck
	
while: #While loop parsing through the user's provided string
	lb $a0, 0($t1)
	beqz $a0, exit
	beq $a0,$t4, wordcounting
	addi $t1, $t1, 1
	j while
	

wordcounting: #the function
	addi $t2, $t2, 1
	j while
	
	
	
exit:	#the while loop exits to this if it gets to the end of parsing the string
	sw $t2, charactercount
	sw $t3, wordcount
	
	li $v0, 1
	lw $a0, wordcount
	syscall
	
	li $v0, 8
	la $t5, words
	syscall
	
	li $v0, 1
	lw $a0, charactercount
	syscall
	
	li $v0, 8
	la $t6, messages
	syscall
	
	li $v0, 59 
	la $a0, goodbye
	
	
	li $v0,10
	syscall
	