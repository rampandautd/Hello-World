# Bitmap Demo Program
# Karen Mazidi
# December 29, 2019
#
# no .data section is initialized
# Instructions: 
#         set pixel dim to 4x4
#         set display dim to 256x256
# Connect to MIPS and run

# set up some constants
# width of screen in pixels
# 256 / 4 = 64
.eqv WIDTH 64
# height of screen in pixels
.eqv HEIGHT 64
# memory address of pixel (0, 0)
.eqv MEM 0x10008000 

# colors
.eqv	RED 	0x00FF0000
.eqv	GREEN 	0x0000FF00
.eqv	BLUE	0x000000FF
.eqv    WHITE   0x00FFFFFF
.eqv    YELLOW  0x00FFFF00
.eqv    CYAN    0x0000FFFF
.eqv    MAGENTA 0x00FF00FF
.eqv    BLACK   0x00000000

.data 
colors: .word MAGENTA, CYAN, YELLOW, WHITE, BLUE, GREEN, RED

.text
main:
	# setup parameters to draw a red  pixel in the center of the screen
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1
	addi 	$a2, $0, RED  # a2 = RED
	
	la 	$t1, colors         # put address of colors into $t1
	li 	$t2, 6            # put the index into $t2

	#jal DRAW_COLORFUL
loop:
# check for input
	jal DRAW_COLORFUL
	lw $t0, 0xffff0000  #t1 holds if input available
    	beq $t0, 0, loop   #If no input, keep displaying
	
	# process input
	lw 	$s1, 0xffff0004
	beq	$s1, 32, exit	# input space
	beq	$s1, 119, up 	# input w
	beq	$s1, 115, down 	# input s
	beq	$s1, 97, left  	# input a
	beq	$s1, 100, right	# input d
	# invalid input, ignore
	j	loop
	
	# process valid input
	
up:	
	jal 	DRAW_BLACK #clear old box
	addi	$a1, $a1, -1 #set new start point of new box
	jal       DRAW_COLORFUL #draw new box
	j loop


down:	jal 	DRAW_BLACK #clear old box
	addi	$a1, $a1, 1 #set new start point of new box
	jal       DRAW_COLORFUL #draw new box
	j loop
	
left:	jal 	DRAW_BLACK
	addi	$a0, $a0, -1
	jal       DRAW_COLORFUL
	j loop
	
right:	jal 	DRAW_BLACK
	addi	$a0, $a0, 1
	jal      DRAW_COLORFUL
	j loop





DRAW_COLORFUL:	
	#li 	$t2, 6 #reset color index as 6
	#addi 	$a2, $0, RED  # init color is RED
	sub $sp,$sp,4	#store current $ra to jump back
	sw $ra,($sp)
	
	
	addi $t2,$t2,-1 #decrease index of colors array
	bltz 	$t2,reset #if index is -1, go to reset index
	j skipreset	#if not, go to skip reset
reset:	li 	$t2, 6 #reset index as 6
skipreset:
	sll $t3, $t2, 2    #change index into address by multiplying by 4
    	add $t3, $t1,$t3    #add address of index with address of colors array
    	lw $t4, 0($t3)       #get color from array
    	add	$a2, $0, $t4 #change color
    	
	
	addi	$a3, $0, 8 #number of pixel in one side
draw1:	
	jal	draw_pixel
	
	addi $t2,$t2,-1 #decrease index of colors array
	bltz 	$t2,reset1 #if index is -1, go to reset index
	j skipreset1	#if not, go to skip reset
reset1:	li 	$t2, 6 #reset index as 6
skipreset1:
	sll $t3, $t2, 2    #change index into address by multiplying by 4
    	add $t3, $t1,$t3    #add address of index with address of colors array
    	lw $t4, 0($t3)       #get color from array
    	add	$a2, $0, $t4 #change color
	
	addi	$a0, $a0, 1 #increase column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw1 #if the number of pixel in one side is still greater than 0, keep drawing
	
	
	addi	$a3, $0, 8 #number of pixel in one side
draw2:	
	jal	draw_pixel 
	
	addi $t2,$t2,-1 #decrease index of colors array
	bltz 	$t2,reset2 #if index is -1, go to reset index
	j skipreset2	#if not, go to skip reset
reset2:	li 	$t2, 6 #reset index as 6
skipreset2:
	sll $t3, $t2, 2    #change index into address by multiplying by 4
    	add $t3, $t1,$t3    #add address of index with address of colors array
    	lw $t4, 0($t3)       #get color from array
    	add	$a2, $0, $t4 #change color
	
	addi	$a1, $a1, 1 #increase row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw2 #if the number of pixel in one side is still greater than 0, keep drawing
	
	addi	$a3, $0, 8 #number of pixel in one side
draw3:	
	jal	draw_pixel
	
	addi $t2,$t2,-1 #decrease index of colors array
	bltz 	$t2,reset3 #if index is -1, go to reset index
	j skipreset3	#if not, go to skip reset
reset3:	li 	$t2, 6 #reset index as 6
skipreset3:
	sll $t3, $t2, 2    #change index into address by multiplying by 4
    	add $t3, $t1,$t3    #add address of index with address of colors array
    	lw $t4, 0($t3)       #get color from array
    	add	$a2, $0, $t4 #change color
	
	addi	$a0, $a0, -1 #decrease column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw3 #if the number of pixel in one side is still greater than 0, keep drawing
	
	addi	$a3, $0, 8 #number of pixel in one side
draw4:	
	jal	draw_pixel
	
	addi $t2,$t2,-1 #decrease index of colors array
	bltz 	$t2,reset4 #if index is -1, go to reset index
	j skipreset4	#if not, go to skip reset
reset4:	li 	$t2, 6 #reset index as 6
skipreset4:
	sll $t3, $t2, 2    #change index into address by multiplying by 4
    	add $t3, $t1,$t3    #add address of index with address of colors array
    	lw $t4, 0($t3)       #get color from array
    	add	$a2, $0, $t4 #change color
	
	addi	$a1, $a1, -1 #decrease row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw4 #if the number of pixel in one side is still greater than 0, keep drawing
	
	lw $ra,($sp) #load r
	addiu $sp,$sp,4
	jr 	$ra      #RETURN
	#j	loop      #BACK TO LOOP
	
DRAW_BLACK:
	sub $sp,$sp,4	#store current $ra to jump back
	sw $ra,($sp)

	addi	$a3, $0, 8 #number of pixel in one side
drawb1:	
	addi	$a2, $0, BLACK # set color is green
	jal	draw_pixel 
	addi	$a0, $a0, 1 #increase column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,drawb1 #if the number of pixel in one side is still greater than 0, keep drawing
	 

	addi	$a3, $0, 8 #number of pixel in one side
drawb2:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a1, $a1, 1 #increase row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,drawb2 #if the number of pixel in one side is still greater than 0, keep drawing

	addi	$a3, $0, 8 #number of pixel in one side
drawb3:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a0, $a0, -1 #decrease column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,drawb3 #if the number of pixel in one side is still greater than 0, keep drawing
	
	addi	$a3, $0, 8 #number of pixel in one side
drawb4:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a1, $a1, -1 #decrease row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,drawb4 #if the number of pixel in one side is still greater than 0, keep drawing		
	
	lw $ra,($sp) #load ra that saved before
	addiu $sp,$sp,4
	jr 	$ra      #RETURN	
	
	
exit:	li	$v0, 10
	syscall

#################################################
# subroutine to draw a pixel
# $a0 = X
# $a1 = Y
# $a2 = color
draw_pixel:
	# s1 = address = MEM + 4*(x + y*width)
	mul	$s1, $a1, WIDTH   # y * WIDTH
	add	$s1, $s1, $a0	  # add X
	mul	$s1, $s1, 4	  # multiply by 4 to get word offset
	add	$s1, $s1, MEM	  # add to base address
	sw	$a2, 0($s1)	  # store color at memory location
	
	sub $sp,$sp,4	#store current a0
	sw $a0,($sp)

	li	$v0, 32 #use syscall 32 to make the delay
	li      $a0, 5 #delay 10ms set in a0
	syscall #call syscall to make delay
	
	lw $a0,($sp) #load a0 that saved before
	addiu $sp,$sp,4
	
	jr 	$ra
