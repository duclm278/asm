.data
A:		.word 1, 2, 3, 4, 5, 6, 7, 8, 9

.text
test:
		li $s0, 1
		li $s1, 2
		li $s2, 3
		li $s3, 4
		li $s4, 5
		li $s5, 6
		li $s5, 7
		li $s6, 8
		li $s7, 9

init:		la $a0, A			# address of array
		li $a1, 9			# length
		jal arrayFunc
		j endMain

################################################################################
arrayFunc:	add $sp, $sp, -24		# expand stack
		sw $ra, 20($sp)			# save
		sw $s0, 16($sp)			# save
		sw $s1, 12($sp)			# save
		sw $s2, 08($sp)			# save
		sw $s3, 04($sp)			# save
		sw $s4, 00($sp)			# save
arrayFuncInit:	li $s0, 0			# i
		li $s1, 0			# address(A[i])
		li $s2, 0			# A[i]
arrayFuncLoop:	beq $s0, $a1, endArrayFunc	# exit if i == n
		add $s1, $s0, $s0		# 2 * i
		add $s1, $s1, $s1		# 4 * i
		add $s1, $s1, $a0		# address(A[i])
		lw $s2, 0($s1)			# A[i]
		add $v0, $v0, $s2		# sum = sum + A[i]
		add $s0, $s0, 1			# i++
		j arrayFuncLoop
endArrayFunc:	lw $s4, 00($sp)			# load
		lw $s3, 04($sp)			# load
		lw $s2, 08($sp)			# load
		lw $s1, 12($sp)			# load
		lw $s0, 16($sp)			# load
		lw $ra, 20($sp)			# load
		add $sp, $sp, +20		# shrink stack
		jr $ra				# return

################################################################################
endMain:
