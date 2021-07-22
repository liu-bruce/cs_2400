.data
#input: .word 15

.text

 

main:
	jal fun1
	jal exit


fun1:
	li $v0, 1
	lw $s0,input
	
	add $a0,$s0,$zero
	
	syscall
	jr $ra
exit:
	li $v0, 10
	syscall
