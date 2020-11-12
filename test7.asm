.data
list: .word 18,9,27,5,48,16,2,53,64

arraysize: .word 9	#.align 4
 	
 	
spaceBtwn : .asciiz " "

newLine : .asciiz "\n"

arrayAfter: .asciiz "The array after: \t\t   "

	
.text
# print the original array
           la $a0, list            
   	lw $a1,arraysize                  
   	jal print  
   	j sortarray
   
print:
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
   	addi $t0,$t0,1                
   	j secondLoop
   	
returnPrintFunct:
   	li $v0, 4                    
   	la $a0, newLine              
   	syscall
   	jr $ra   
   	
   	


sortarray:   
   	la $a0, list            
   	li $a1,9                  
   	jal selectionSort  
   	j exit   
   
selectionSort:
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
	#sll $t3,$t1,2
	sll $t4,$s1,2
	#add $t3,$t3,$a0
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
	
   
  



exit:
	la $a0, list           
	li $a1, 9                 
	jal print   	
	li $v0,10
	syscall 
