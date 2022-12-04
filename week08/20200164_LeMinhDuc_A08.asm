.data
Message1:	.asciiz "Enter N (> 0): "
Message2:	.asciiz "Invalid input!\n"
Message3:	.asciiz "N is a perfect square!\n"
Message4:	.asciiz "N is not a perfect square!\n"

.text
init:		li $s0, 0			# N
main:		li $v0, 4			# print string
		la $a0, Message1
		syscall
		li $v0, 5			# input integer
		syscall
		add $s0, $zero, $v0		# update N
		ble $s0, $zero, printInvalid	# invalid if N <= 0
		add $a0, $zero, $s0		# pass N to isSquare()
		jal isSquare
		beq $v0, 1, printTrue
		beq $v0, 0, printFalse
		j endMain
printInvalid:	li $v0, 4			# print string
		la $a0, Message2
		syscall
		j endMain
printTrue:	li $v0, 4			# print string
		la $a0, Message3
		syscall
		j endMain
printFalse:	li $v0, 4			# print string
		la $a0, Message4
		syscall
		j endMain

################################################################################
# function isSquare:
# param[in]	$a0	the interger needed to be checked
# return		$v0	boolean
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
