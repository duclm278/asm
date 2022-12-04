.data
A: 		.word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend:		.word
.text
main:
		lui		$s0, 0x1001		# A[0]
		li		$t0, 0			# i = 0
		li		$t1, 0			# j = 0
		li		$s1, 13			# n = A.length
		li		$s2, 13			# n - i for inner loop
		add		$t2, $zero, $s0		# For iterating addr by i
		add		$t3, $zero, $s0		# For iterating addr by j
		addi		$s1, $s1, -1
outer_loop:
		li		$t1, 0			# j = 0
 		addi		$s2, $s2, -1		# Decrease size for inner_loop
		add		$t3, $zero, $s0		# Reset addr itr j
inner_loop:
		lw		$s3, 0($t3)		# A[j]
		addi		$t3, $t3, 4		# Addr itr j += 4
		lw		$s4, 0($t3)		# A[j+1]
		addi		$t1, $t1, 1		# j++
		slt		$t4, $s3, $s4		# Set $t4 = 1 if $s3 < $s4
		bne		$t4, $zero, cond
swap:
		sw		$s3, 0($t3)
		sw		$s4, -4($t3)
		lw		$s4, 0($t3)
cond:
		bne		$t1, $s2, inner_loop	#j != n-i
		j		Print
EndPrt:
		addi		$t0, $t0, 1		#i++
		bne		$t0, $s1, outer_loop	#i != n
		li		$t0, 0
  		addi		$s1, $s1, 1
exit:
		li		$v0, 10
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
