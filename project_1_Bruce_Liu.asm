# author: Bruce Liu
#	clock in times		break start		break end		Clock out times 
# 1)	11:45pm 9/4/2020	12:37pm 9/5/2020	12:46pm 9/5/2020
# 2)				1:00am 9/5/2020		1:05am 9/5/2020
# 3)										1:10am 9/5/2020	
# 4) 	5:13 pm 9/6/2020							6:35am 9/6/2020	
# 5)	3:00Pm 9/6/2020								3:30pm 9/6/2020
# 6)	4:00 pm 9/6/2020							9:03pm 9/6/2020		
# sources used:
#	textbook: computer organization and design fifth edition "David A. Patterson & John L.Hennessy" 
#		pg A-44 is most useful for syscall modes
#	  	index seeking branch if equal
#		pg 64 not good enough exprementation
#		pg A60
#		A48 Rs = register specfier Rt = register target Rd = destination register 
# test log:
# 	inquiry can I load text directly intro a register >> errored I was hoping to save some work
# 	test menu select with minimal text >> worked
#	test is \t works >> works
#	test full output of input_select text x5 for format
#	made and tested input_errorx3, input returnx2, next_line text areas
#	load comparision registers and return
#	break start 1
#	interger input return test 
#		failed 1 wrong syscall
#		failed wrong resister
#		test input suceeded
#		test return suceeded
#		changed move destitation register
# 		test failed missed register
#		failed wrong register x2
#		sucess
#	break start 2
#	test input_return failedfor got syscall
#	sucess
#	text new_line wrong name next_line
#	sucess
# 	break start 3
#	consideration guard vs potential error not in list of inputs
#	clock in 9/6/2020
#	branch making
#	branch testing failed x5 wrong format cannot function call is differnt branch call , also cannot call a string
#	branch testiing failed x6 R&D
#		failed infident loop  wrong order had to use task manager to kill the program
# 			may consider using the infdent loops later for perpetual menu selction
#		sucess exit placed at the botom of the program.
#			branch testing failed wrong exit location need to place in banched function not in the main
#		branch functions are like switch and case of c and java
#	banch testing infident loop sucess
#	clock out 9/6/2020 6:35am
#	exit on command
#	testing  action menu as a function
#	correcting text for exit on any other input accidental discovery
#	made first, sencond, third input text
#	made sum return text
#	tested first_input infdent loop needs b to exit x3
#	start sum_of_3_int function creation
#	wrong syscall for int input
# 	test move to $t0 
# 	test inputs 1-3 int
#	sum of 3 ints failed wrong registers
#	sum of 3 ints completed
# 	sum of 3 int function test completed
# 	test sum of 3 int in action menu completed
#	wrong text in third input
#	start request favorite place input and output
# 	error didnt branch to exit
#	text return error
#	wrong register x5
#	start int calculation
#	syscall not requesting # x2 forgot to move b exit
#	made and tested inputs 1-d
# 	failed wrong register for div
#	deleted test function
# process:
# 	test function in .text area then copy and paste to functions area

		.data
	

menu_select:  	.asciiz "Chose which function to run.. \n\t 1) Sum of 3 integer inputs.\n\t 2) Return favorite place from input \n\t 3) Output the formula x = (a*c) + (b/d) with 4 inputs. \n Input anything other for exit.\n Input the number of your selection:\n "
input_return:	.asciiz "Your input was:\n"
next_line:	.asciiz "\n"
first_input:	.asciiz "Input first value:"
second_input:	.asciiz "Input second value:"
third_input:	.asciiz "Input third value:"
sum_return:	.asciiz "The sum of your inputs is:"
text_test:	.asciiz "test\n"
input_fav_place:	.asciiz "Input your favorite place.\n"
input_inta:	.asciiz "Input int a.\n"
input_intb:	.asciiz "Input int b.\n"
input_intc:	.asciiz "Input int c.\n"
input_intd:	.asciiz "Input int d.\n"
computation_return: .asciiz "The computation return is:"
input_error:	.asciiz "Your input was not on the list try again."
		
		.text
#although it isn't required  I want to make a all in one with branch commands.

		top:		
		jal action_menu
		
	
# start functions
	# menu function
action_menu:
		#load comarision registers.
		la $s1 , 1
		la $s2 , 2
		la $s3 , 3

		# menu select output
		la $a0 , menu_select
		li $v0 , 4
		syscall
		# branch input
		#interger input
		li $v0, 5
		syscall
		#return interger input
		move $s0, $v0
		#output test
		li $v0,4
		la $a0, input_return
		syscall
		move $a0 ,$s0
		li   $v0, 1
		syscall
		li $v0,4
		la $a0, next_line
		syscall
		#branch instuctions
		beq $s0,$s1,sum_3_int
		
		beq $s0,$s2,request_favorite_place_input
			
		beq $s0,$s3,formula_output

		b exit

	#first function 
		# requests 3 inputs and sums them
sum_3_int:
		#request first input
		la $a0 , first_input
		li $v0 , 4
		syscall
		#stores first input
		la $v0, 5
		syscall
		move $t1, $v0
		#requests second input
		la $a0 , second_input
		li $v0 , 4
		syscall
		#stores second input
		la $v0, 5
		syscall
		move $t2, $v0
		#request thrid input
		la $a0 , third_input
		li $v0 , 4
		syscall
		#stores third input
		la $v0, 5
		syscall
		move $t3, $v0
		# sums 3 inputs
		add $t0,$t1,$t2
		add $t0,$t0,$t3
		#text for sum return
		la $a0 , sum_return
		li $v0 , 4
		syscall
		#outputs sum 3 ints
		move $a0,$s0
		la $v0, 1
		syscall
		b exit
	
	#second function
		#requests for user input of favourite place and outputs it
request_favorite_place_input:
		#request favorite place input
		li $v0, 4
		la $a0, input_fav_place
		syscall
		#store fav input
		li $v0,8
		li $a1,20000
		syscall
		move $s0,$a0
		#input return text
		la $a0,input_return
		li $v0, 4
		syscall
		# input return
		move $a0,$s0
		syscall
		b exit
	
	#third function
		#Requests 3 inputs and does the formula x = a*c + b/d
formula_output:
		#a input request
		li $v0,4
		la $a0,input_inta
		syscall
		#store a
		li $v0,5
		syscall
		move $s1,$v0
		#b input request
		li $v0,4
		la $a0,input_intb
		syscall
		#store b
		li $v0,5
		syscall
		move $s2,$v0
		#c input request
		li $v0,4
		la $a0,input_intc
		syscall
		#store c
		li $v0,5
		syscall
		move $s3,$v0
		#d input request
		li $v0,4
		la $a0,input_intd
		syscall
		#store d
		li $v0,5
		syscall
		move $s4,$v0
		#computation mult and div
		mult $s1,$s3
		mflo $t0
		div  $s2,$s4
		mflo $t1
		#text output for computation return
		li   $v0,4
		la   $a0,computation_return
		syscall
		#computation add
		add $a0,$t0,$t1
		#output computation as int
		li $v0,1
		syscall
		
		b exit

exit:
		
		
		
