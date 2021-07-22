#@author: Bruce Liu
#date: 9/18/2020
# hypothesis div command beq 

#error log
# wrong order of commands for storing and moving
# wrong lw vs sw command x6
# 
.data
#odd_input_return: 	.asciiz "ODD\n"
#even_input_return:	.asciiz "EVEN\n"
#ascii vs asciiz experiment
input_value_request:	.ascii  "Input value "
			.ascii	"to be tested for "
			.asciiz	"odd or even.\n"

# experiment end
# useful for extremely long strings
odd_input_return: 	.asciiz "ODD\n"
even_input_return:	.asciiz "EVEN\n"
# return check
even_mod: 		.word 0
odd_mod: 		.word 1

# initaliztion declaration
input_value:		.word 0
mod_return_odd:		.word 0
mod_return_even:	.word 0
mod_base:		.word 2


.text
#initalization assignement
	
	lw $s0,input_value
	lw $t0,mod_return_odd
	lw $t1,mod_return_even
	lw $s1, even_mod
	lw $s2, odd_mod
	lw $s3,	mod_base
	
#input 
	
	li $v0,4
	la $a0,input_value_request
	syscall
	
# store to input value
	li $v0,5
	syscall
	move $s0,$v0
	
# computation
	#even check
	div $s0,$s3
	mfhi $t0
	#odd check
	div $s0,$s3
	mfhi $t1
# comparision 
	beq $t0,$s1,even_text_return
	beq $t0,$s2,odd_text_return

even_text_return:
	li $v0,4
	la $a0,even_input_return 
	syscall
	j exit

odd_text_return:
	li $v0,4
	la $a0,odd_input_return
	syscall
	j exit
exit:
	
	
	
	
