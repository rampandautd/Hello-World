.data 

example1: .asciiz "this is an example"

loadhere: .space 100


.text

li $v0, 54
la $a0, example1
la $a1, loadhere
li $a2, 99
syscall

li $v0, 4
la $a0, loadhere
syscall
