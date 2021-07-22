#@author: Bruce Liu
# start date 9/21/2020
# end date 10/8/2020
# only works for my name as an input right now

# sources used
# https://stackoverflow.com/questions/15181525/mips-assembly-creating-character-checker
# http://www.asciitable.com/


# errors:
# wrong command load address vs load byte
# wrong syscall 11 is for char
# added the offset vs subtracted
# sudo code
# expected requirements check if characters are in a certain range of ascii to check for lower case
# check for space character and null
# addi by a set number
# loop expected 
# branch expected
# sb,lb expected offset 4
# removed excess commands 
# wrong resister
# offset is a direct count not word counts for chars
# test case print each char from a string
# spacing was off
# sw or sb wrong format x4??
.data
input_request_text:  	.ascii "Input your name, "
			.ascii "in the format in lower case " 
			.asciiz "first_name middle_name last_name:\n"
return_input:		.asciiz "Your name is in upper case is:\n"
invalid_input:		.asciiz "Your input is not in lower case.\n"
new_line:		.asciiz "\n"

#test_case: 	.asciiz "bruce liu" used for test of concept
offset_count:		.word 0
top_range_lower_case:	.word 0x61
lower_rang_lower_case:	.word 0x7C

space:			.word 0x20


.text

main:
	#initalization 
	#li $t2 ,0
	
	jal input_request
	jal input_store
	jal change_char
	jal print_chars
	jal change_char_second
	jal print_char_second
	j exit
input_request: 
#registers reserved:null
		li $v0,4
		la $a0,input_request_text
		syscall
		jr $ra
input_store:
	#registers reserved $s0
		li $v0,8
		li $a1,255
		syscall
		move $s0, $a0
		jr $ra
input_return:
# only for verifying what is the register.
# registers reserved : null
		li $v0,4
		move $a0,$s0
		syscall	
		jr $ra
change_char:
# takes in offset count
	
		li $v0,11
		lb $t0,0($s0)# offset is 0
		subi $t0,$t0,0x20
		move $a0,$t0
		syscall
		jr $ra
print_chars:
		
		li $v0,11
		lb $t0,1($s0)# offset is 0
		move $a0,$t0
		syscall
		
		li $v0,11
		lb $t0,2($s0)# offset is 0
		move $a0,$t0
		syscall
		
		li $v0,11
		lb $t0,3($s0)# offset is 0
		move $a0,$t0
		syscall
		
		li $v0,11
		lb $t0,4($s0)# offset is 0
		move $a0,$t0
		syscall
				
		li $v0,11
		lb $t0,5($s0)# offset is 0
		move $a0,$t0
		syscall
		jr $ra
change_char_second:
		li $v0,11
		lb $t0,6($s0)# offset is 0
		subi $t0,$t0,0x20
		move $a0,$t0
		syscall
		jr $ra
print_char_second:
		li $v0,11
		lb $t0,7($s0)
		move $a0,$t0
		syscall
		li $v0,11
		lb $t0,8($s0)
		move $a0,$t0
		syscall
		jr $ra
	

exit:
		
	li $v0,10
	syscall	






