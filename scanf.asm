		.data
text_request:	.asciiz "Input your name and the last digit of your school id number. \n"
text_return:	.asciiz "Your input is: "
next_line:	.asciiz "\n"
		.text
		# tells sys call to output text
		li $v0, 4
		# a0 is the output register. So I am loading the contents of text_output in the output register
		la $a0, text_request
		#syscall or system call does something basied on what is stored in v0
		syscall
		# change syscall or system call to recive data as a string
		li $v0, 8
		# set length of input to be 255
		li $a1, 255
		
		syscall
		# storing the input from the buffer register
		move $t0, $a0
		# loading return text interface
		la $a0,text_return
		# telling syscall to read strings from the buffer register
		li $v0,4
		syscall
		#moving the input back into the buffer register 
		move $a0,$t0
		syscall
		
		
		
