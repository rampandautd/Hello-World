.data
prompt: .asciiz "Enter some text: "
len: .word 100
str: .space 100 #maximum 100 characters
charCount: .word 0
wordCount: .word 0
wordsmsg: .asciiz " words "
charsmsg: .asciiz " characters \n"
goodbye: .asciiz "Good Bye!"
progEnd: .asciiz "Message: "
.text

Loop:
#show a dialog box to user to get string input
la $a0, prompt
la $a1, str
lw $a2, len
li $v0, 54
syscall
#check status in a1
beq $a1, -2, EndLoop #cancel choosen
beq $a1, -3, EndLoop #blank input and ok choosen
#we can process now, call function count by passing address and lenght in a0 and a1 respectively
la $a0, str
lw $a1, len
jal count
#we receive count of chars and words in v0 and v1 respectively. store in memory
sw $v0, charCount
sw $v1, wordCount
#display the string and counts
la $a0, str #displaying string
li $v0, 4
syscall
#display word count
lw $a0, wordCount
li $v0, 1
syscall
la $a0, wordsmsg
li $v0, 4
syscall
#display char count
lw $a0, charCount
li $v0, 1
syscall
la $a0, charsmsg
li $v0, 4
syscall
b Loop
EndLoop:
#display goodbye message dialog
la $a0, progEnd
la $a1, goodbye
li $v0, 59
syscall
#exit
li $v0, 10
syscall
#-------------------------------------------
#function count receives addrss of string in a0 and length in a1
#returns charcount in v0 and word count in v1
#-------------------------------------------
count:

#save s0 on stack by allocating 4 bytes
addi $sp, $sp, -4
sw $s0, 0($sp) #save value of s0 on stack
move $s0, $a0
li $t1, 0 #char count
li $t2, 1 #word count
Loop2:
lb $t3, ($s0)
beq $t3, '\n', EndLoop2 #goto endloop on seeing newline or null terminator
beq $t3, '\0', EndLoop2
add $t1, $t1, 1 #increment char count
beq $t3, ' ', IncrWord
b NextLoc
IncrWord:
addi $t2, $t2, 1
NextLoc:
addi $s0, $s0, 1
b Loop2
EndLoop2:
#restore back s0 from stack
lw $s0, 0($sp)
add $sp, $sp, 4
#return values in v0 and v1
move $v0, $t1
move $v1, $t2
jr $ra