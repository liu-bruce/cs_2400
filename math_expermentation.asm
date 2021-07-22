		.data
input_request:  .asciiz "Input two numbers for computation. \n"
first_input:	.asciiz "Input first value: \n"
second_input:	.asciiz "Input second value: \n"
return_inputs:	.asciiz "Your inputs are: \n"
line_break:	.asciiz "\n"

sum_return:		.asciiz "The sum is :"
substact_return:	.asciiz "The differance is:"
multiply_return:	.asciiz "The product is:"
division_return:	.asciiz "The quotient is:"
remainder_return:	.asciiz "The remainer is:"
		
		.text
		#print input request
		
		#tells syscall to output a string
		li $v0,4
		#load text to output register
		la  $a0, input_request
		syscall
		
		#first input request
		
		#load next line to output
		la $a0, first_input
		syscall
		
		#read first input request
		
		#tells syscall to take in a input as interger
		li $v0,5
		syscall
		#move the input to a register
		move $t0,$v0
		
		#input request second value
		
		#tells syscall to output a string
		li $v0,4
		# load text to output register
		la $a0,second_input
		syscall
		
		#store second input request
		
		# tells syscall to take an interger as input
		li $v0,5
		syscall
		# moves the input to a register
		move $t1,$v0
		
		#input confurmation
		
		#tells sys call to output text
		li $v0, 4
		la $a0, return_inputs
		syscall
		
		#tells syscall to output intergers
		li $v0,1
		move $a0,$t0
		syscall
		
		#tells sys call to output text
		li $v0, 4
		la $a0,line_break
		syscall
		
		#tells syscall to output intergers
		li $v0,1
		move $a0,$t1
		syscall
		#tells syscall to output text
		li $v0, 4
		la $a0,line_break
		syscall
		
		# add
		#tells sys call to output text
		li $v0, 4
		la $a0, sum_return
		syscall
		
		#sum and store
		add $t3, $t0,$t1
		move $a0,$t3
		
		#tells syscall to output intergers
		li $v0,1
		move $a0,$t3
		syscall
		
		#tells syscall to output text
		li $v0, 4
		la $a0,line_break
		syscall
		
		# substact
	
		#tells syscall to output text
		li $v0, 4
		la $a0,substact_return
		syscall
		
		#substact computation and storage
		sub $t4, $t0, $t1
		move $a0,$t4
		
		# tells syscall to output an integer
		li $v0,1
		syscall
		#tells syscall to output text
		li $v0, 4
		la $a0,line_break
		syscall	
		
		# product
	
		#tells syscall to output text
		li $v0, 4
		la $a0,multiply_return
		syscall
		
		#multiply the inputs and move them to the output register
		mult $t0,$t1
		mflo $a0
		
		#tells syscall to output an interger
		li $v0,1
		syscall
		
		#tells syscall to output text
		li $v0, 4
		la $a0,line_break
		syscall	
		
		# quotient
		
		#tells syscall to output text
		li $v0, 4
		la $a0,division_return
		syscall	
		
		#computation
		div $t0,$t1
		mflo $a0
		#output result
		
		#tells syscall to output an interger 
		li $v0, 1
		syscall
		
		# remainder
		
				#tells syscall to output text
		li $v0, 4
		la $a0,line_break
		syscall	
		
		# quotient
		
		#tells syscall to output text
		li $v0, 4
		la $a0,remainder_return
		syscall	
		mfhi $a0
		#tells syscall to output an interger 
		li $v0, 1
		syscall