.text
main:		li $s0, 100			# n
		li $s1, 1			# i
mainLoop:	bgt $s1, $s0, endMain		# exit if i > n
		add $a0, $zero, $s1
		jal isSquare
		beq $v0, 1, printSquare
afterPrint:	add $s1, $s1, 1			# i++
		j mainLoop
printSquare:	li $v0, 1
		add $a0, $zero, $s1
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		j afterPrint

################################################################################
isSquare:	add $sp, $sp, -12		# expand stack
		sw $ra, 08($sp)			# save
		sw $s0, 04($sp)			# save
		sw $s1, 00($sp)			# save
isSquareInit:	li $s0, 1			# i
		li $s1, 1			# i^2
		li $v0, 0			# 0 = false, 1 = true
isSquareLoop:	bgt $s0, $a0, endIsSquareLoop	# exit i > n
		mul $s1, $s0, $s0		# i * i, 32-bit result
		beq $s1, $a0, foundSquare	# exit if i^2 == n
		add $s0, $s0, 1			# i++
		j isSquareLoop
foundSquare:	li $v0, 1			# true
		j endIsSquareLoop
endIsSquareLoop:	lw $s1, 00($sp)			# load
		lw $s0, 04($sp)			# load
		lw $ra, 08($sp)			# load
		add $sp, $sp, +8			# shrink stack
		jr $ra				# return

################################################################################
endMain:
