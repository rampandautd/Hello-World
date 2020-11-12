.include "Macros.asm"


.data

beforecomp: .asciiz "The size before compression was"

aftercomp: .asciiz "The size after compression was"


.text

main:
	userinput
	
	beqz userinput, exit
	
	openreadandclose(userinput)

	addzero($v0, buffer)
	
	compress(addzero)
	
	li $v0, 4
	la $a0, beforecomp
	syscall
	
	li $v0, 4
	la $a0, aftercomp
	syscall
	
	j main
	
exit:
