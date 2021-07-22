	.data

text: 	.asciiz "Bruce Liu 4"

	.text
	li $v0,4
	la $a0, text
	syscall
		
					