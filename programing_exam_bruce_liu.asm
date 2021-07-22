.data
input_request: 		.asciiz "Input a string to be analyzed.\n"
input_count_return_text: 	.asciiz "Length of string is = "
word_count:		.asciiz "Number of words in a sentence is = "
sentence_complete:	.asciiz "Yes a complete sentence.\n"
sentence_null:		.asciiz "Not a complete sentence\n"
capital_count_text:		.asciiz "Number of capital letters = "
letter_count_a_text:		.asciiz "Occurance of letter 'a' = "
new_line: 		.asciiz "\n"

lower_case_upper_bound: .word 0x61
lower_case_lower_bound: .word 0x7a
upper_case_upper_bound: .word 0x41
upper_case_lower_bound:	.word 0x5a
space: 			.word 0x20
null:			.word 0x00
.text

main:
	jal default_load
	jal input_request_output
	jal input_store
	jal input_count
	jal input_count_return

	jal exit
default_load:
	la $s2,sentence_null
	jr $ra
	
input_request_output:
	
	li $v0, 4
	la $a0, input_request
	syscall
	jr $ra
	
input_store:
	li $v0, 8
	li $a1, 256
	syscall
	addu  $s0,$a0,$zero
	jr $ra
input_return:
#used for testing
	li $v0,4
	addu $a0,$s0,$zero
	syscall
	jr $ra
	
input_count:

	lb $t0,($s0)
	
	addu $s0,$s0,1 #byte increment
	addu $t2,$t2,1 # character count
	beq  $t0,0x20, space_count 
	beq  $t0,0x61,letter_count_a
	beq  $t0,0x2e, punctuation_check
	beq  $t0,0x21, punctuation_check
	beq  $t0,0x3f, punctuation_check
	bge  $t0,0x41,  capital_count
	bne  $t0,0x00, input_count # loop if not null
	jr $ra
	
letter_count_a:
	addu $t5,$t5,1
	j input_count

capital_count:
	ble $t0,0x5a,capital_count_second_bound
	j input_count
capital_count_second_bound:
	addu $t4,$t4,1
	j input_count
punctuation_check:
	la $s2,sentence_complete
	j input_count

space_count:
	addu $t3,$t3,1
	j input_count
	
	
input_count_return:
	#constants error offset fix
	subiu $t2,$t2,2
	addiu $t3,$t3,1

	li $v0,4
	la $a0,input_count_return_text
	syscall
	move $a0,$t2
	li $v0,1
	syscall 
	li $v0,4 
	la $a0,new_line
	syscall
	
	li $v0,4
	la $a0,word_count
	syscall
	move $a0,$t3
	li $v0,1
	syscall 
	li $v0,4 
	la $a0,new_line
	syscall
	
	li $v0,4 
	move $a0,$s2
	syscall
	
	li $v0,4
	la $a0,capital_count_text
	syscall
	li $v0,1
	move $a0, $t4
	syscall
	
	li $v0 4
	la $a0,new_line
	syscall
	
	li $v0,4
	la $a0,letter_count_a_text
	syscall
	
	li $v0,1
	move $a0, $t5
	syscall
	
	li $v0 4
	la $a0,new_line
	jr $ra
	
exit:
	li $v0,10
	syscall
