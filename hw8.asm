.eqv WIDTH 64

.eqv HEIGHT 64

.eqv MEM 0x10008000 


.eqv    GREEN   0x0000FF00
.eqv    BLUE    0x000000FF
.eqv    WHITE   0x00FFFFFF
.eqv    YELLOW  0x00FFFF00

.eqv    MAGENTA 0x00FF00FF
.eqv    BLACK   0x00000000

.data 
colors: .word MAGENTA, YELLOW, WHITE, BLUE, GREEN

.text
main:

	addi 	$a0, $0, WIDTH   
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT  
	sra 	$a1, $a1, 1
	
	la 	$t1, colors      
	li 	$t2, 6           
	
loop:
	jal color
	lw $t0, 0xffff0000 
    	beq $t0, 0, loop   
	
	lw 	$s1, 0xffff0004
	beq	$s1, 32, exit	
	beq	$s1, 119, up 	
	beq	$s1, 115, down 	
	beq	$s1, 97, left  	
	beq	$s1, 100, right	
	j	loop
	colors
up:	
	jal 	blackbox
	addi	$a1, $a1, -1 
	jal       color
	j loop


down:	jal 	blackbox
	addi	$a1, $a1, 1 
	jal       color 
	j loop
	
left:	jal 	blackbox
	addi	$a0, $a0, -1
	jal       color
	j loop
	
right:	jal 	blackbox
	addi	$a0, $a0, 1
	jal      color
	j loop





color: 

	sub $sp,$sp,4	
	sw $ra,($sp)
	
	addi $t2,$t2,-1 	
	bltz 	$t2,resize 	
	j skipresize	
	
resize:	li 	$t2, 6 	

skipresize:
	sll $t3, $t2, 2    	
    	add $t3, $t1,$t3    	
    	lw $t4, 0($t3)       	
    	add $a2, $0, $t4	
	addi $a3, $0, 8 	
	
idx1:	
	jal	draw_pixel
	addi $t2,$t2,-1	
	bltz 	$t2,resize1 
	j cond1	
	
resize1:	li 	$t2, 6 	

cond1:
	sll $t3, $t2, 2   
    	add $t3, $t1,$t3 
    	lw $t4, 0($t3)
    	add $a2, $0, $t4 
	
	addi	$a0, $a0, 1
	addi	$a3, $a3, -1
	bgtz 	$a3,idx1
	addi	$a3, $0, 8
	
idx2:	
	jal	draw_pixel 
	addi $t2,$t2,-1 
	bltz 	$t2,resize2 
	j cond2
	
resize2:	li 	$t2, 6

cond2:
	sll $t3, $t2, 2  
    	add $t3, $t1,$t3
    	lw $t4, 0($t3) 
    	add	$a2, $0, $t4
	
	addi	$a1, $a1, 1
	addi	$a3, $a3, -1
	bgtz 	$a3,idx2
	addi	$a3, $0, 8
	
idx3:	
	jal	draw_pixel
	addi $t2,$t2,-1
	bltz 	$t2,resize3 
	j cond3
	
resize3:	li 	$t2, 6

cond3:
	sll $t3, $t2, 2 
    	add $t3, $t1,$t3 
    	lw $t4, 0($t3) 
    	add	$a2, $0, $t4
	addi	$a0, $a0, -1
	addi	$a3, $a3, -1
	bgtz 	$a3,idx3 
	addi	$a3, $0, 8 
	
idx4:	
	jal	draw_pixel
	addi $t2,$t2,-1
	bltz 	$t2,resize4
	j cond4
	
resize4:	li 	$t2, 6

cond4:
	sll $t3, $t2, 2
    	add $t3, $t1,$t3
    	lw $t4, 0($t3)
    	add	$a2, $0, $t4
	addi	$a1, $a1, -1 
	addi	$a3, $a3, -1
	bgtz 	$a3,idx4 
	
	lw $ra,($sp) 
	addiu $sp,$sp,4
	jr 	$ra
	
blackbox: 
	sub $sp,$sp,4
	sw $ra,($sp)
	addi	$a3, $0, 8
	
pixels1:	
	addi	$a2, $0, BLACK
	jal	draw_pixel 
	addi	$a0, $a0, 1
	addi	$a3, $a3, -1
	bgtz 	$a3,pixels1
	addi	$a3, $0, 8
	
pixels2:	
	
	jal	draw_pixel
	addi	$a1, $a1, 1
	addi	$a3, $a3, -1
	bgtz 	$a3,pixels2
	addi	$a3, $0, 8 
	
pixels3:	
	
	jal	draw_pixel
	addi	$a0, $a0, -1
	addi	$a3, $a3, -1
	bgtz 	$a3,pixels3
	addi	$a3, $0, 8
	
	
pixels4:	
	jal	draw_pixel
	addi	$a1, $a1, -1
	addi	$a3, $a3, -1
	bgtz 	$a3,pixels4		
	lw $ra,($sp)
	addiu $sp,$sp,4
	jr 	$ra
	
exit:	li	$v0, 10
	syscall


draw_pixel: 
	mul	$s1, $a1, WIDTH
	add	$s1, $s1, $a0
	mul	$s1, $s1, 4
	add	$s1, $s1, MEM
	sw	$a2, 0($s1)
	
	sub $sp,$sp,4
	sw $a0,($sp)

	lw $a0,($sp)
	addiu $sp,$sp,4
	
	jr 	$ra
