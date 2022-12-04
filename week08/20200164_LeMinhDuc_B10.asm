.data
Message1:	.asciiz "Enter size: "
Message2:	.asciiz "Enter element: "
Message3:	.asciiz "Found satisfied odd: "
Message4:	.asciiz "Found no odds!\n"

.text
init:		li $s0, 0			# N = size
		li $s1, 0			# 4 * N = size in bytes
						# address(A[0]) = address($sp) = 0x7fffeffc
		li $s2, 0			# i
		li $s3, 0			# 4 * i
		li $s4, 0			# address(A[i])
main:		li $v0, 4			# print string
		la $a0, Message1
		syscall
		li $v0, 5			# input integer
		syscall
		add $s0, $zero, $v0		# update N
		sll $s1, $s0, 2			# 4 * N
		sub $sp, $sp, $s1		# expand stack
input:		beq $s2, $s0, endInput		# exit if i == n
		sll $s3, $s2, 2			# 4 * i
		add $s4, $s3, 0x7fffeffc		# address(A[i])
		li $v0, 4			# print string
		la $a0, Message2
		syscall
		li $v0, 5			# input integer
		syscall
		sw $v0, ($s4)			# push A[i] to address(A[i])
		add $s2, $s2, 1			# i++
		j input
endInput:	li $a0, 0x7fffeffc		# address of array
		add $a1, $zero, $s0		# length
		jal minEven
		li $a0, 0x7fffeffc
		add $a1, $zero, $s0		# length
		add $a2, $zero, $v0		# minEven
		jal maxOdd
		add $t0, $zero, $v0		# store result
		beq $t0, -100000, noOdds		# no odds found
		li $v0, 4			# print string
		la $a0, Message3
		syscall
		li $v0, 1			# print integer
		add $a0, $zero, $t0
		syscall
		li $v0, 11			# print character
		li $a0, '\n'
		syscall
		j endMain
noOdds:		li $v0, 4			# print string
		la $a0, Message4
		syscall
		j endMain

################################################################################
minEven:		add $sp, $sp, -24		# expand stack
		sw $ra, 20($sp)			# save
		sw $s0, 16($sp)			# save
		sw $s1, 12($sp)			# save
		sw $s2, 08($sp)			# save
		sw $s3, 04($sp)			# save
		sw $s4, 00($sp)			# save
minEvenInit:	li $s0, 0			# i
		li $s1, 0			# address(A[i])
		li $s2, 0			# A[i]
		li $s3, 0			# quotient
		li $s4, 0			# remainder
		li $v0, +100000			# result
minEvenLoop:	beq $s0, $a1, endMinEven		# exit if i == n
		add $s1, $s0, $s0		# 2 * i
		add $s1, $s1, $s1		# 4 * i
		add $s1, $s1, $a0		# address(A[i])
		lw $s2, 0($s1)			# A[i]
		div $s3, $s2, 2			# A[i] % 2
		mfhi $s4
		beq $s4, 1, minEvenLoopCon	# next loop if odd
		blt $v0, $s2, minEvenLoopCon	# next loop if result < A[i]
		add $v0, $zero, $s2		# else update result
minEvenLoopCon:	add $s0, $s0, 1			# i++
		j minEvenLoop
endMinEven:	lw $s4, 00($sp)			# load
		lw $s3, 04($sp)			# load
		lw $s2, 08($sp)			# load
		lw $s1, 12($sp)			# load
		lw $s0, 16($sp)			# load
		lw $ra, 20($sp)			# load
		add $sp, $sp, +24		# shrink stack
		jr $ra				# return

################################################################################
maxOdd:		add $sp, $sp, -24		# expand stack
		sw $ra, 20($sp)			# save
		sw $s0, 16($sp)			# save
		sw $s1, 12($sp)			# save
		sw $s2, 08($sp)			# save
		sw $s3, 04($sp)			# save
		sw $s4, 00($sp)			# save
maxOddInit:	li $s0, 0			# i
		li $s1, 0			# address(A[i])
		li $s2, 0			# A[i]
		li $s3, 0			# quotient
		li $s4, 0			# remainder
		li $v0, -100000			# result
maxOddLoop:	beq $s0, $a1, endMaxOdd		# exit if i == n
		add $s1, $s0, $s0		# 2 * i
		add $s1, $s1, $s1		# 4 * i
		add $s1, $s1, $a0		# address(A[i])
		lw $s2, 0($s1)			# A[i]
		div $s3, $s2, 2			# A[i] % 2
		mfhi $s4
		beq $s4, 0, maxOddLoopCon	# next loop if even
		bgt $v0, $s2, maxOddLoopCon	# next loop if result > A[i]
		bgt $s2, $a2, maxOddLoopCon	# next loop if A[i] > minEven
		add $v0, $zero, $s2		# else update result
maxOddLoopCon:	add $s0, $s0, 1			# i++
		j maxOddLoop
endMaxOdd:	lw $s4, 00($sp)			# load
		lw $s3, 04($sp)			# load
		lw $s2, 08($sp)			# load
		lw $s1, 12($sp)			# load
		lw $s0, 16($sp)			# load
		lw $ra, 20($sp)			# load
		add $sp, $sp, +24		# shrink stack
		jr $ra				# return

################################################################################
endMain:
