.text
main:		li $s0, 100			# n
		li $s1, 2			# i
mainLoop:	bgt $s1, $s0, endMain		# exit if i > n
		add $a0, $zero, $s1
		jal isPrime
		beq $v0, 1, printPrime
afterPrint:	add $s1, $s1, 1			# i++
		j mainLoop
printPrime:	li $v0, 1
		add $a0, $zero, $s1
		syscall
		li $v0, 11
		li $a0, ' '
		syscall
		j afterPrint

################################################################################
isPrime:		add $sp, $sp, -12		# expand stack
		sw $ra, 08($sp)			# save
		sw $s0, 04($sp)			# save
		sw $s1, 00($sp)			# save
isPrimeInit:	li $s0, 2			# i
		li $s1, 0			# n % i
		li $v0, 1			# 0 = false, 1 = true
isPrimeLoop:	beq $s0, $a0, endIsPrimeLoop	# exit i == n
		div $a0, $s0			# n / i
		mfhi $s1				# n % i
		beq $s1, 0, isNotPrime		# exit if n % i == 0
		add $s0, $s0, 1			# i++
		j isPrimeLoop
isNotPrime:	li $v0, 0			# false
		j endIsPrimeLoop
endIsPrimeLoop:	lw $s1, 00($sp)			# load
		lw $s0, 04($sp)			# load
		lw $ra, 08($sp)			# load
		add $sp, $sp, +8			# shrink stack
		jr $ra				# return

###############################################################################
endMain:
