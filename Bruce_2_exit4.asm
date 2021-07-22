		.data
intro:		.asciiz "Mips program for programing  z=a+(b/c)-2"
input_a: 	.asciiz "Input item a:\n"
input_b:	.asciiz "Input item b:\n"
input_c:	.asciiz "input item c:\n"
return_inputs: 	.asciiz "inputs are(a,b,c):\n" 
new_line:	.asciiz "\n"
equation:	.asciiz "The output of is z=a+(b/c)-2 interger is:\n"


		.text
main:
	jal text_load
	#text input a request
	li $v0,4
	move $a0,$s0
	syscall
	
	# read a interger store a
	li $v0, 5
	syscall
	move $t0,$v0
	
	#text input a request
	li $v0,4
	move $a0,$s1
	syscall
	
	# read a interger store b
	li $v0, 5
	syscall
	move $t1,$v0
		
	#text input a request
	li $v0,4
	move $a0,$s2
	syscall
	
	# read a interger store c
	li $v0, 5
	syscall
	move $t2,$v0
################################################################### end read area
	
	#return inputs
	li $v0,4
	move $a0,$s3
	syscall
	
	# return a
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	move $a0,$s4
	syscall
	
	#return b
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	move $a0,$s4
	syscall
	
	#return c
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	move $a0,$s4
	syscall
########################################### end return inputs area

	# start computation area
	
	#equation text output
	li $v0,4
	move $a0,$s5
	syscall
	
	div $t1,$t2
	mflo $t7
	subi $t7,$t7,2
	add $t7,$t7,$t0
	
	
	#return full computation
	li $v0,1
	move $a0,$t7
	syscall
	
	
	
	#exits the program
	li $v0,10
	syscall

#function experimentation
text_load:
	la $s0, input_a
	la $s1, input_b
	la $s2, input_c
	la $s3, return_inputs
	la $s4, new_line
	la $s5, equation
	
	
	jr $ra
# for a moment I had an issue that was painful for moving the interger read data since I was getting nonsence. 
# turns out I was reading from the wrong register.
# I was testing as I was going so I didn't get any major errors besides that. 