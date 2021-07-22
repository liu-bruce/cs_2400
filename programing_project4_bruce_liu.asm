# programing project 4
#@ author Bruce Liu
# start date: 11/22/2020 3:00 PM

# pseudo code hypothesis:

# check parity bit
# check zero bit for on and off state
# && with 1
# check if 1 or 0
# increment if count register if 1
# right shift
# loop until zero

# hypothesises for parity tracker

# mod 2 for even vs odd check || 
# check bit zero if on since it would be odd ||
# vari initial register with 1 or 0 set odd vs even

# ! the register per count "selected"

# extra might attempt hammington code with correction

# sources
# https://chortle.ccsu.edu/AssemblyTutorial/Chapter-11/ass11_11.html

.data

input_request:		 .asciiz "Input value for parity analysis:\n "		

mode_select:	 	 .ascii	"Input parity mode:\n"
			 .ascii	 "For odd 1 for even 2:\n"
 			 .asciiz "To exit anything else:\n"
		
even_mode:		.asciiz	"Parity mode even.\n"
odd_mode:		.asciiz	"Parity mode odd.\n"
error_mode:		.asciiz	"Input not on the list.\n"

error_return: 		.asciiz	"Parity return error.\n"
null_error:		.asciiz	"No parity error detected.\n"


input_selection_text:	.asciiz	"Your input is :"
new_line:		.asciiz	"\n"
debug:			.asciiz "test\n"

		
input_selection	:	.word	0
input_register:		.word	15
even_select:		.word	2
odd_select:		.word	1
parity_count:		.word	0
post_and:		.word 	0


.text
main:
	jal initial_register_alocation
	jal PECalc
	jal exit
	jr  $ra


initial_register_alocation:
	lw $s0,input_selection
	lw $s1,input_register
	lw $s2,even_select
	lw $s3,odd_select
	lw $s4,parity_count
	lw $t0,post_and
	jr $ra

PECalc:

	li $v0,4
	la $a0, input_request
	syscall
	
	li $v0,5
	syscall
	move $s1,$v0
	
	
	li $v0,4
	la $a0, mode_select
	syscall
	
	
	
	li $v0,5
	syscall
	move $s0,$v0
	
	beq $s0,$s2,parity_count_even
	beq $s0,$s3,parity_count_odd
	jal exit
	jr $ra

parity_count_even:
	li $v0,4
	la $a0, even_mode
	syscall
	
	j bit_count
bit_count:
	xor $t0, $s1, $s3 # I have a 1 stored I'm going to use it, the label is odd. 
	bne $t0,$s1,increment_parity_count 
	
	j bit_count
	
parity_count_odd:
	li $v0,4
	la $a0, odd_mode
	syscall
	j bit_count
	
results:
	li $v0,1
	move $a0, $s4
	syscall
	jal exit
increment_parity_count:
	addi $s4,$s4,1
	beqz $t0,results
	srl $s1,$s1,1

	j bit_count
exit:	
	li $v0,10
	syscall
