

.data

enterstring: .space 20

doesntwork: .asciiz "This string is empty"

emptyspace: .asciiz "\r\n"

good: .asciiz "You're good"

.text

li $v0,8
la $a0, enterstring
la $a1, 20
syscall 

la $t0, enterstring
la $t1, emptyspace

beq $t0,$t1, exit

li $v0, 4
la $a0, good
syscall

li $v0, 10
syscall

exit:
    li $v0, 4
    la $a0, doesntwork
    syscall