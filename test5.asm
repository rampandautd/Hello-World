
.data


initbuffer: .space 1050

finalbuffer: .space 1050

emptyspace: .asciiz "\r\t"

example: .asciiz "aaabbbc\n\njjjdkkdkddd"



.text


###########GETS LENGTH OF STRING

la $t0, example

loop:
	lb $t1, 0($t0)
	beq $t1, $zero, end
	
	addi $t0, $t0, 1
	j loop
	
end:
	la $t1, example
	sub $t2, $t0, $t1
	
#########SIZE OF STRING IS STORED IN T2



###########LOADS BUFFERS INTO S1 AND S2


la $s0, example
#sw $s0, initbuffer	
la $s1, finalbuffer

#lw $s5, 1024
#lw $s6, 1024

################START OF OUTER LOOP
compressedloop:

li $t0, 1	
addi $s6, $s6, 1

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

#beq $t3,  make this detect newlines
bne $t1, $t3, diffcharacter
addi $s6, $s6, 1
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

 #li $v0, 1
 #move $a0, $t0
 #syscall 
 
 addi $t5, $t0, 48
 sb $t5, ($s1)

 
 #li $v0, 4
 #la $a0, emptyspace
 #syscall
 
 li $v0, 4
 la $a0, finalbuffer
 syscall
 
 #li $v0, 4
 #la $a0, finalbuffer
 #syscall
 
 
 
