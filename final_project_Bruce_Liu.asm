#author: Bruce Liu
# start date and time: 12/5/2020 2:22PM
# end date and time :	12/5/2020	5:13PM
# sources used 
# https://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
# https://courses.cs.vt.edu/~cs2505/fall2010/Notes/pdf/T23.MIPSArrays.pdf
#
#
.data
N:	 	.word 24 # 9 - 3 = 6 , 6 * 4 = 24 -4 b/c it starts at 0 not 4
array_A:   	.space	24	
array_B:	.space	24

new_line:	.asciiz	"\n"

upper_bound:	.word 	100
random_seed:	.word	6 # might as well use the 6 number for something
lowest_value:	.word	99999

.text
main:
	jal	initialze
	jal	load_array_A
	jal	load_array_B
	jal	print_array
	jal	low_odd_or_even
	jal	print_low
	#jal	swap
	jal	exit

initialze:
	lw	$t0,N
	lw	$a1,random_seed
	lw	$s7,lowest_value
	la	$v0,40 # random initalize
	syscall
	

load_array_A:
	lw	$a1,upper_bound #upper bound for random
	la	$v0,42  # random number generate
	syscall
	sw	$a0,array_A($s0)
	addi	$s0,$s0,4
	blt	$s0,$t0,load_array_A
	li	$s0,0
	jr	$ra
	
	
load_array_B:
	lw	$a1,upper_bound #upper bound for random
	la	$v0,42  # random number generate
	syscall
	sw	$a0,array_B($s2)
	addi	$s2,$s2,4
	blt	$s2,$t0,load_array_B
	li	$s2,0
	jr	$ra

swap:
	# cannot be generic 
	#lw	$t7,array_label($s?)
	#sw	$s?,($s?)
	#li	??
	#sw	$t7,($s?)


low_odd_or_even:
	lw	$t5,array_A($s0)
	addi	$s0,$s0,4
	blt	$t5,$s7,store_low
	blt	$s0,$t0,low_odd_or_even
	li	$s0,0
	jr	$ra
	
store_low:
	move	$s7,$t5
	j	low_odd_or_even

print_array:
	lw	$a0,array_A($s0)
	li	$v0,1
	syscall
	li	$v0,4
	la	$a0,new_line
	syscall
	addi	$s0,$s0,4
	blt	$s0,$t0,print_array
	li	$s0,0
	jr	$ra

print_low:
	li	$v0,4
	la	$a0,new_line
	syscall	
	li	$v0,4
	la	$a0,new_line
	syscall
	li 	$v0,1
	move	$a0,$s7
	syscall
	jr	$ra
exit:
	li $v0,10
	syscall 
