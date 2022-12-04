.data
A:		.word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend:		.word
.text
init:		la		$s0, A		# Array A
		li		$s1, 13		# Length of A
		li		$s2, 1		# i
		li		$s3, 0		# j
		li		$s4, 0		# v
		li		$t0, 0		# Address of A[i]
		li		$t1, 0		# Address of A[j]
		li		$t2, 0		# Value of A[i]
		li		$t3, 0		# Value of A[j]

Loop1:		sll		$t0, $s2, 2	# $t0 = 4 * i
		add		$t0, $t0, $s0	# Address(A[i])
		lw		$s4, 0($t0)	# v = A[i]
		addi		$s3, $s2, -1	# j = i - 1
		sll		$t1, $s3, 2	# $t1 = 4 * j
		add		$t1, $t1, $s0	# Address(A[j])

Loop2:		lw		$t3, 0($t1)	# Load A[j]
		blt		$t3, $s4, EndL2	# Continue looping if A[j] >= v
		sw		$t3, 4($t1)	# A[j+1] = A[j]
		addi		$s3, $s3, -1	# --j
		addi		$t1, $t1, -4	# Keep memory access consistent with j
		bge		$s3, $0, Loop2	# Loop if j >= 0

EndL2:		sw		$s4, 4($t1)	# A[j+1] = v
		addi		$s2, $s2, 1	# ++i
		j		Print

EndPrt:		blt		$s2, $s1, Loop1	# Loop while i < A.length

Exit:		li		$v0, 10 # Load exit operation
		syscall 

#------------------------------------------------------------------------
# Procedure Print
#------------------------------------------------------------------------
Print:		add		$s7, $v0, $zero		# Save
		add		$s6, $a0, $zero		# Save
		la		$t8, A			# $t8 = Address(A[0])
		la		$t9, Aend
		addi		$t9, $t9, -4		# $t9 = Address(A[n-1])

LoopPrt: 	blt		$t9, $t8, EndLoopPrt	# Exit if Aend < A[i]

		li		$v0, 1			# Service 01: print integer
		lw		$a0, 0($t8)		# Value of A[i]
		syscall
		li		$v0, 11
		li		$a0, ' '			# Print space
		syscall
		addi		$t8, $t8, 4		# Move to A[i+1]
		j		LoopPrt

EndLoopPrt:	li		$v0, 11
		li		$a0, '\n'		# Print enter
		syscall
		add		$v0, $s7, $zero		# Load
		add		$a0, $s6, $zero		# Load
		j		EndPrt
