
##### YOU MUST PUT FULL FILEPATH INTO THE VARIABLE "filename" #############
.data
floatval: .align 2
          .float 2.0

filename: .asciiz "C:\\Users\\ramth\\Desktop\\MIPS files\\input (1).txt"

buffer: .space 80 #Stores all the numbers in the 

errormsg: .asciiz "There is an error with the data" 

arrayBefore: .asciiz "The array before:\t\t   "
	
arrayAfter: .asciiz "The array after: \t\t   "
		
meanResult: .asciiz "The mean is:   \t\t   "
		
medianResult: .asciiz "The median is: \t\t   "
		
stdevResult: .asciiz "The standard deviation is: "	

 # input and formatting variables 
newLine : .asciiz "\n"
				
spaceBtwn : .asciiz " "
						
arrayOfInts: .word 20	


.text

########################OPENING FILE AND READ INTO BUFFER
	#open the file
	
	li $v0, 13
	la $a0, filename
	li $a1, 0
	syscall
	
	
	#checking if the $v0 register is 0
	beq $v0, $zero, error
	
	move $s6, $v0

	#read ints into a buffer
	li $v0, 14
	move $a0, $s6
	la $a1, buffer
	li $a2, 80
	syscall
	move $t9, $v0

	
	#closing the file 
	li $v0, 16
	move $a0, $s6
	syscall
	
	
##################################	Reads in file to array
	addi $t0, $zero, 0
	addi $v0, $v0, -1
	addi $t4, $zero, 0

top:
	beq $t0, $t9, printints
	lb $t2, buffer($t0)

	beq $t2, '\n', skip
	addi $t2, $t2, -48
	sll $t7,$t4,2
	jal checkifdoubledigit
	sw $t2,arrayOfInts($t7)
	addi $t4,$t4, 1

skip:
	addi $t0, $t0,1
	j top


checkifdoubledigit:
	addi $t0, $t0, 1
	beq $t0, $t9, printints
	lb $t5, buffer($t0)  
	bne $t5,'\n', multby10
	jr $ra

multby10:
	li $t6, 10
	addi $t5, $t5, -48
	mult $t2,$t6 
	mflo $t3
	add $t2, $t3, $t5
	jr $ra


##############################PRINT INTEGERS TO SCREEN	
#Prompt for array before and print the original array
printints:
	la $a0, arrayBefore
	li $v0, 4
	syscall             
   	jal print  
   	jal selectionSort
   	j nextthing
                                        
print:
	la $a0,arrayOfInts            
   	li $a1,20  
   	move $s0,$a0
   	li $t0,0
   	
secondLoop:
   	beq $t0,$a1,returnPrintFunct      
  	li $v0,1
   	sll $t1,$t0,2
	add $t1,$t1,$s0
   	lw $a0,0($t1)            
   	syscall                
   	li $v0, 4                    
   	la $a0, spaceBtwn            
  	syscall
   	add $t0,$t0,1                
   	j secondLoop
   
   
returnPrintFunct:
   	li $v0, 4                    
   	la $a0, newLine              
   	syscall
   	jr $ra    
   	
 
 
######################### SORT ARRAY USING SELECTION SORT AND PRINT
   
selectionSort:
	la $a0, arrayOfInts
	li $t1,0
	addi $s0,$a1,-1

iLoop:
   	beq $t1,$s0,returnsorted
   	move $s1,$t1
   	addi $t2,$t1,1

jLoop:             
	beq $t2, $a1, nextI
	sll $t3,$t1,2
	sll $t4,$t2,2
	add $t3,$t3,$a0
	add $t4,$t4,$a0
	lw $t7, 0($t3)
	lw $t8,0($t4)
	blt $t8,$t7, replaceCounter 
	j nextJ

replaceCounter:
	move $s1,$t2

swapFunct:
	bne $s1, $t1, swap
	j nextJ
	
swap:
	sll $t4,$s1,2
	add $t4,$t4,$a0
	lw $t8,0($t4)
	sw $t7,0($t4)
	sw $t8,0($t3)

nextJ:
	addi $t2,$t2,1
	j jLoop
	
nextI:
	addi $t1,$t1,1
	j iLoop

returnsorted:
	jr $ra
	

         
                           
nextthing:
   	li $v0,4                
   	la $a0,arrayAfter  
   	syscall               
   	jal print  
   	j mean                    

      	
###############################################CALCULATE MEAN, STANDARD DEVIATION, AND MEDIAN

mean:
   	la $a0,meanResult              
   	li $v0,4
   	syscall
   	la $a0,arrayOfInts            
   	li $a1,20                  
   	jal calcMean
   	li $v0,2                
   	syscall
   	la $a0,newLine  
   	li $v0,4
   	syscall
   	la $a0,medianResult          
   	li $v0,4
   	syscall
				# calculate and print the Median 
   	la $a0,arrayOfInts            
   	li $a1, 20                 
   	jal calcMedian   
   	    
   	li $v0,2
   	syscall 
     
   	j stdDev         
   
printfloatingVal:
   	li $v0,2
   	syscall                  
   
stdDev:
   	li $v0,4
   	la $a0,newLine  
   	syscall
   	li $v0,4              
   	la $a0,stdevResult    
   	syscall                
   	la $a0,arrayOfInts            
   	li $a1,20                  
   	jal calcStdDev
   	li $v0,2
   	syscall                                               
	#jr $ra
	j exit


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
 

	               
calcMedian:
   	#div $t0,$a1,2                
   	#mfhi $t1
   	#li $a2, 36
   	#li $a3, 40
   	
   	lwc1 $f1, 36($a0)
   	cvt.s.w $f1,$f1
   	lwc1 $f2, 40($a0)
   	cvt.s.w $f2, $f2
   	
  
   	#beqz $t1,calcAvg
   	add.s $f3, $f2, $f1
   	l.s $f4, floatval  
   	div.s $f12, $f3, $f4 
   	
   	
   	                             
   	#sll $t2,$t0,2      
   	#add $t2,$t2,$a0      
   	#lw $v0,0($t2)                
                             
   	li $v1,0                      
   	#j returnMedian
   	jr $ra

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
   
   
#########################################EXIT

exit:	
	li $v0, 10
	syscall
	
	
	
	
	



error: 
	li $v0, 4
	la $a0, errormsg
	syscall
	
	li $v0, 10
	syscall
	
	
	
