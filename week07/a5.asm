.data
Greatest:	.asciiz "Greatest: "
Smallest:	.asciiz "Smallest: "
Location:	.asciiz ", Register: "
.text
mainInit:	li $s0, 8
		li $s1, 7
		li $s2, 6
		li $s3, 5
		li $s4, 4
		li $s5, 3
		li $s6, 2
		li $s7, 9
push:		addi $sp, $sp, -32		# adjust the stack pointer
		sw $s0, 28($sp)			# push $s0 to stack
		sw $s1, 24($sp)			# push $s1 to stack
		sw $s2, 20($sp)			# push $s2 to stack
		sw $s3, 16($sp)			# push $s3 to stack
		sw $s4, 12($sp)			# push $s4 to stack
		sw $s5, 08($sp)			# push $s5 to stack
		sw $s6, 04($sp)			# push $s6 to stack
		sw $s7, 00($sp)			# push $s7 to stack
loopInit:	li $s0, -100000			# s0 stores the greatest value
		li $s1, -1			# s1 stores the location of the greatest value
		li $s2, +100000			# s2 stores the smallest value
		li $s3, -1			# s3 stores the location of the smallest value
		li $s4, 7			# current index of the stack's top
loop:		beq $sp, 0x7fffeffc, endLoop	# while stack isn't empty
		lw $t0, 00($sp)			# get the top of the stack
		blt $s0, $t0, update1
afterUpdate1:	bgt $s2, $t0, update2
afterUpdate2:	addi $sp, $sp, +4		# pop the top of the stack
		addi $s4, $s4, -1		# update the top's index
		j loop
update1:		add $s0, $zero, $t0		# update greatest
		add $s1, $zero, $s4
		j afterUpdate1
update2:		add $s2, $zero, $t0		# update smallest
		add $s3, $zero, $s4
		j afterUpdate2
endLoop:	
printGreatest:	li $v0, 4
		la $a0, Greatest
		syscall
		li $v0, 1
		add $a0, $zero, $s0
		syscall
		li $v0, 4
		la $a0, Location
		syscall
		li $v0, 1
		add $a0, $zero, $s1
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
printSmallest:	li $v0, 4
		la $a0, Smallest
		syscall
		li $v0, 1
		add $a0, $zero, $s2
		syscall
		li $v0, 4
		la $a0, Location
		syscall
		li $v0, 1
		add $a0, $zero, $s3
		syscall
		li $v0, 11
		li $a0, '\n'
		syscall
