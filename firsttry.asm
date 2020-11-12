.data

var1: .word 12

.text 

li $v0, 1
lw $a0, var1
syscall

