.data
example: .asciiz "AABBBCCC"

initbuffer: .space 1050

finalbuffer: .space 1050

emptyspace: .asciiz "\r\n"

test1: .asciiz "test"


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

li $v0,1
move $a0, $t0
syscall

li $v0, 4
la $a0, test1
syscall

addi $s6, $s6, 1
lb $t1, 0($s0)
beqz $t1, exit 
#sb $t1, ($s1)

li $v0, 11
move $a0, $t1
syscall

###############START OF INNER LOOP
nestedloop:
addi $s0, $s0, 1
lb $t3, 0($s0)
beqz $s1, exit
bne $t1, $t3, diffcharacter
addi $s6, $s6, 1
addi $t0, $t0,1


addi $s0, $s0,1

j nestedloop #jump back to the top of the nested loop if the next character is the same

############COME HERE IF THE CHARACTER IS DIFFERENT
diffcharacter:
sb $t1, ($s1)
addi $s1, $s1, 1
#sb $t0, ($s1)

li $v0, 1
move $a0, $t0
syscall 

addi $s5, $s5, 2
addi $s1,$s1,1

j compressedloop

exit: 

 li $v0, 4
 la $a0, emptyspace
 syscall
 
 #li $v0, 4
 #la $a0, finalbuffer
 #syscall
 
 