
#Selection sort algorithm
#Name:Ram Panda
#Data: 4/26/20

		.data
array:	.word		19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
			19,-2,95,26,83,17,-5,69,-16,10,45,-17,88,27,-13,67,-48,6,-66,40
		.text
		.globl	main
main: 		
						
		addi	$s2,$zero, 500		
		sll	$s0, $v0, 2		
		sub	$sp, $sp, $s0		# This instruction creates a stackframe
										# the array					
               la $t9,array
		move	$s1, $zero		
for_get:	bge	$s1, $s2, exit_get	# if i>=n go to exit_for_get
		sll	$t0, $s1, 2		
		add	$t1, $t0, $sp		
		lw $v0,0($t9)				
		sw	$v0, 0($t1)		
		addi	$s1, $s1, 1	
		addi $t9,$t9,4	# i=i+1
		j	for_get
exit_get:	move	$a0, $sp		# $a0=base address af the array
		move	$a1, $s2		# $a1=size of the array
		jal	isort			
		li	$v0, 10			# EXIT
		syscall			
		
# swap routine
swap:		sll	$t1, $a1, 2		
		add	$t1, $a0, $t1	
		sll	$t2, $a2, 2		
		add	$t2, $a0, $t2		
		lw	$t0, 0($t1)	
		lw	$t3, 0($t2)	
		sw	$t3, 0($t1)	
		sw	$t0, 0($t2)	
		jr	$ra
		
		
# index_minimum routine
mini:		move	$t0, $a0		# base of the array
		move	$t1, $a1		
		move	$t2, $a2		
		sll	$t3, $t1, 2		
		add	$t3, $t3, $t0			
		lw	$t4, 0($t3)		
		addi	$t5, $t1, 1	
			
mini_for:	bgt	$t5, $t2, mini_end	# go to min_end

		sll	$t6, $t5, 2		
		add	$t6, $t6, $t0				
		lw	$t7, 0($t6)		

		bge	$t7, $t4, mini_if_exit	# skip the if when v[i] >= min
		
		move	$t1, $t5		
		move	$t4, $t7		

mini_if_exit:	addi	$t5, $t5, 1		
		j	mini_for

mini_end:	move 	$v0, $t1		# return mini
		jr	$ra


# selection_sort
isort:		addi	$sp, $sp, -20		# save values on stack
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		sw	$s3, 16($sp)
		move 	$s0, $a0		# base address of the array
		move	$s1, $zero		# i=0

		subi	$s2, $a1, 1		
isort_for:	bge 	$s1, $s2, isort_exit	# if i >= length-1 -> exit loop
		move	$a0, $s0		
		move	$a1, $s1		
		move	$a2, $s2		
		jal	mini
		move	$s3, $v0		
		move	$a0, $s0		
		move	$a1, $s1		
		move	$a2, $s3		
		jal	swap
		addi	$s1, $s1, 1		
		j	isort_for		
		
isort_exit:	lw	$ra, 0($sp)		# restore values from stack
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s2, 12($sp)
		lw	$s3, 16($sp)
		addi	$sp, $sp, 20		# restore stack pointer
		jr	$ra			# return



