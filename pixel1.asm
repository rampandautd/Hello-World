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


.text
main:
	# draw a red  pixel in the center of the screen
	addi 	$a0, $0, WIDTH    # a0 = X = WIDTH/2
	sra 	$a0, $a0, 1
	addi 	$a1, $0, HEIGHT   # a1 = Y = HEIGHT/2
	sra 	$a1, $a1, 1

	addi	$a3, $0, 8 #number of pixel in one side
draw1:	
	addi	$a2, $0, GREEN # set color is green
	jal	draw_pixel 
	addi	$a0, $a0, 1 #increase column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw1 #if the number of pixel in one side is still greater than 0, keep drawing
	 

	addi	$a3, $0, 8 #number of pixel in one side
draw2:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a1, $a1, 1 #increase row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw2 #if the number of pixel in one side is still greater than 0, keep drawing

	addi	$a3, $0, 8 #number of pixel in one side
draw3:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a0, $a0, -1 #decrease column
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw3 #if the number of pixel in one side is still greater than 0, keep drawing
	
	addi	$a3, $0, 8 #number of pixel in one side
draw4:	
	#addi	$a2, $0, GREEN
	jal	draw_pixel
	addi	$a1, $a1, -1 #decrease row
	addi	$a3, $a3, -1 #decrease the number of pixel in one side that has to draw
	bgtz 	$a3,draw4 #if the number of pixel in one side is still greater than 0, keep drawing
		
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
	jr 	$ra