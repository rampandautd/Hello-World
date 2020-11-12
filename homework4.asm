.data

file: 
		.asciiz "/Downloads/input.txt"
		.word 0
	
buffer:		.space 80
		.align 2
	
thearray: 	.space 80
	
newline: 	.asciiz "\r\n"

min: 		.word 0




.text
main:

fileinput:
###OPENING FILE
	li $v0, 13
	la	$a0, file		# $a2 = name of file to read
	add	$a1, $0, $0		# $a1=flags=O_RDONLY=0
	add	$a2, $0, $0		# $a2=mode=0
	syscall				# Open FIle, $v0<-fd
	add	$s0, $v0, $0		# store fd in $s0
	
	
	
# Read 4 bytes from file, storing in buffer

	li	$v0, 14			# 14=read from  file
	add	$a0, $s0, $0		# $s0 contains fd
	la	$a1, buffer		# buffer to hold int
	li	$a2, 80			# Read 80 bytes
	syscall

	li	$v0, 1			# 1=print int
	lw	$a0, buffer		# buffer contains the int
	syscall				# print int

#closing file
done:
	li	$v0, 16			# 16=close file
	add	$a0, $s0, $0		# $s0 contains fd
	syscall				# close file

	
extractint:

	addi $t0,$zero,0
	lw $a0,thearray
	sw $a1, thearray($t0)
	
	
	lw $t3, newline
	addi $t1, $zero, 0
	addi $t7,$zero,0

	
while:

	beq $a0, $v0, selectionsort
	lw $t4 , buffer($a0)
	beq $t4, $t3, spacecase
	
	sll $t5, $t2, 3
	sll $t6, $t2, 1
	
	add $t2, $t5, $t6
	lw $t1, buffer($a0)
	add $t2, $t1, $t2
	subi $t2,$t2, 48
	addi $a0, $a0, 1
	j while
	
	
	


spacecase:
	addi $a1,$a1,1
	sw $t2, thearray($a1)
	addi $t1, $zero, 0
	addi $t1, $zero, 0
	addi $a0, $a0, 2
	addi $t7, $t7, 1
	j while

#continue:
#	move $t6, $zero
#	move $t7, $zero

#	addi $t7, $t7, 4
	
#	move $s0, $zero 
#	addi $s0, $s0, 1
	
#selectionsort:
#	beq $t3, $t4, calculate
#	beq $t3 , $t4, continue
	
#	lw $t8, thearray($t6)
#	lw $t9, thearray(
#	addi $t1, $zero, 0
#	lw $t6, thearray($t1)
#	lw min, $t6
	
#	addi $t8, $zero, 0
	
#	beq $t8, $t7, 
	
#	j selectionsort
	
#calculate: 

	

	


selectionsort:
   	li $t0,0                      
   	sub $s0,$a1,1              
     

loopj:
   	beq $t0,$s0,returnSorted
   	move $s1,$t0                  
   	add $t1,$t0,1                
  
    
loopi:
   	beq $t1,$a1,swapFunct
   	sll $t2,$t1,2
   	sll $t3,$s1,2
   	add $t2,$t2,$a0
   	add $t3,$t3,$a0
   	lw $t6,0($t2)                
   	lw $t7,0($t3)                
   	blt $t6,$t7,replacecounter          
   	j nextI

counter:  
	move $s1,$t1  

nextI:
   	add $t1,$t1,1
   	j loopi                    
   
swapFunct:
   	bne $s1,$t0,swap            
   	j nextJ
   

swap:
   	sll $t2,$t0,2
   	sll $t3,$s1,2
   	add $t2,$t2,$a0        
   	add $t3,$t3,$a0
   	lw $t6,0($t2)        
   	lw $t7,0($t3)        
   	sw $t6,0($t3)
   	sw $t7,0($t2)
   
nextJ:
   	add $t0,$t0,1
   	j loopj                  
   
returnSorted:    
   	jr $ra

# calculate and return the Mean
calcMean:
   	li $t0,0
   	mtc1 $t0,$f12                  
   	mtc1 $t0,$f0
   
meanLoop:
   	beq $t0,$a1,returnMean        
   	sll $t1,$t0,2
   	add $t1,$t1,$a0
   	lwc1 $f0,0($t1)                
   	add.s $f12,$f12,$f0            
   	add $t0,$t0,1                  
   j meanLoop                    
   
returnMean:
  	 mtc1 $a1,$f0                  
	   div.s $f12,$f12,$f0          
	   jr $ra                        
       
                       #calculates median                
calcMedian:
	   div $t0,$a1,2                
	   mfhi $t1
	   beqz $t1,calcAvg                              
	   sll $t2,$t0,2      
	   add $t2,$t2,$a0      
	   lw $v0,0($t2)                
	                             
  	 li $v1,0                      
  	 j returnMedian

calcAvg:    
   	sub $t1,$t0,1
	   sll $t2,$t0,2
	   sll $t3,$t1,2
	   add $t2,$t2,$a0        
	   add $t3,$t3,$a0
	   lw $t6,0($t2)                  
	   lw $t7,0($t3)
	   add $t6,$t6,$t7            
	   mtc1 $t6,$f12            
	   li $t7,2
	   mtc1 $t7,$f0                
	   div.s $f12,$f12,$f0          
	   li $v1,-1                    
                               
returnMedian:      
   	jr $ra                        # return to main

       
calcStdDev:
   	add $sp,$sp,-4
	   sw $ra,4($sp)                
	   jal calcMean                
	   mov.s $f0,$f12                  
	   li $t0,0
	   mtc1 $t0,$f12            
       
stdDevLoop:
   	   beq $t0,$a1,returnStdDev      
   	   sll $t1,$t0,2  
	   add $t1,$t1,$a0
	   lw $t2,0($t1)                  
	   mtc1 $t2,$f1              
	   cvt.s.w $f1,$f1            
	   sub.s $f2,$f1,$f0              
 	   mul.s $f3,$f2,$f2              
	   add.s $f12,$f12,$f3            
	   add $t0,$t0,1
  	 j stdDevLoop                  
   

returnStdDev:  
   	sub $t2,$a1,1                
   	mtc1 $t2,$f6                  
   	cvt.s.w $f6,$f6                
   	div.s $f12,$f12,$f6            
   	sqrt.s $f12,$f12              
   	lw $ra,4($sp)
   	add $sp,$sp,4                  
   	jr $ra           

	
	 




