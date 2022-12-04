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

main:		li $a0, 67			# n
		li $v0, 0			# 0 = false, 1 = true
		jal isPrime
		j endMain

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

################################################################################
endMain:
