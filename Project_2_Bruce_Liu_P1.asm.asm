#@author : Bruce Liu
#start date 9/14/2020
#clock in time:		exit time:
#7:00am	9/14/2020		7:35am
#
#@author : Bruce Liu
#start date 9/14/2020
#
#
#sources
# to convert to hex for id number
#https://runestone.academy/runestone/books/published/pythonds/BasicDS/ConvertingDecimalNumberstoBinaryNumbers.html
# from 2050 textbook 
#
#
#error log
#forgot : x3 for word label
#does word store hex values??
# changed label to fit instuctions forgot to change the .text label
# changed label to mask to M
# commented out n made error in values
	.data
# raw id Number 329125
#N: .word 329125
N: .word 0x505A5 #no need it will convertit for us. When stored
#32/4 	8 digits of hex target 12
#32-12 = 20-1  
#19/4 = 4 3/4
#1110 to hex e
#ffffe000
M:	.word 0xffffe002
Q:	.word 0

	.text
	lw $t9,Q
	#a
	lw $s0, N
	#b
	lw $s1, M
	and $s0,$s0,$s1
	#c
	srl $t0,$s0,2 #P
	#e
	sub $t1, $s0, $t0 #pre Q mult overflow
	sll $t9, $t1,1 #Q mult
	#f
	add $t3, $s0,$t0# pre q division
	srl $t9,$t3,1 # q division
	
	#end P1
	
	#start p2
	
	
	
	
	
	
	
