#HOMEWORK 2 FOR ARCHITECTURE HOMEWORK 2

.data
name: .space 25
a: .word 0
b: .word 0
c: .word 0
ans1: .word 0
ans2: .word 0
ans3: .word 0
prompt1: .asciiz "Enter your name: "
prompt2: .asciiz "Enter an integer between 1-100: "
nameMsg: .asciiz "\n Your name is "
ans1Msg: .asciiz "\n a + b + c = "
ans2Msg: .asciiz "\n c + b - a = "
ans3Msg: .asciiz "\n (a + 2) + (b - 5) - (c - 1) = "

.text
#prompt and read string
li $v0, 4
la $a0, prompt1
syscall

#read string
li $v0, 8
la $a0, name
li $a1, 25
syscall

#prompt and read int a
li $v0, 4
la $a0, prompt2
syscall


#read int and store in a
li $v0, 5
syscall
sw $v0, a


#prompt and read int b
li $v0, 4
la $a0, prompt2
syscall


#read int and store in b
li $v0, 5
syscall
sw $v0, b

#prompt and read int c
li $v0, 4
la $a0, prompt2
syscall


#read int and store in c
li $v0, 5
syscall
sw $v0, c


#do the calculations

#get the values from memory into registers
lw $t0, a
lw $t1, b
lw $t2, c

#calculate a+b+c
add $t3, $t0, $t1 #a+b in t3
add $t3, $t3, $t2 #a+b+c in t3
sw $t3, ans1 #store result in ans1


#calculate c + b - a
add $t3, $t1, $t2 #c+b in t3
sub $t3, $t3, $t0 #c+b - a in t3
sw $t3, ans2 #store result in ans2


#calculate (a + 2) + (b - 5) - (c – 1)
add $t3, $t0, 2 #a+2 in t3
sub $t4, $t1, 5 #b-5 in t4
sub $t5, $t2, 1 #c-1 in $t5
add $t3, $t3, $t4 #(a+2) + (b-5) in t3
sub $t3, $t3, $t5 #(a+2) + (b-5) - (c-1) in t3
sw $t3, ans3 #store result in ans3


#display the values

#display name
li $v0, 4
la $a0, nameMsg
syscall

li $v0, 4
la $a0, name
syscall

#display ans1
li $v0, 4
la $a0, ans1Msg
syscall

li $v0, 1
lw $a0, ans1
syscall


#display ans2
li $v0, 4
la $a0, ans2Msg
syscall

li $v0, 1
lw $a0, ans2
syscall


#display ans3
li $v0, 4
la $a0, ans3Msg
syscall

li $v0, 1
lw $a0, ans3
syscall


#exit
li $v0, 10
syscall


#output


#Enter your name: John
#Enter an integer between 1-100: 3
#Enter an integer between 1-100: 8
#Enter an integer between 1-100: 15

#Your name is John

#a + b + c = 26
#c + b - a = 20
#(a + 2) + (b - 5) - (c - 1) = -6