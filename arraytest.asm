.data
example: .asciiz "AAB"

message: .asciiz "String is done"
buffer: .space 20

emptyspace: "\r\n"

.text

la $s0, example

add $s1, $zero, $zero

loop:
 add $t0, $s0, $s1
 lb $t1, 0($t0)
 beq $t1, $zero, exit
 
 addi $s1, $s1,1
 
 li $v0, 11
 move $a0, $t1
 syscall
  
 li $v0, 4
 la $a0, emptyspace
 syscall 
 j loop
 
 exit:
  


#addi $t2, $zero, 0
#addi $t3, $zero, 0
#for: 

#li $v0,4
#la $a0,example($t4)
#syscall
#addi $t2, $t2,4

#blt $t3, 10, for


#li $v0, 4
#la $a0, message
#syscall
