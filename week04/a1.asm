.text
init:
	j		case4
case1:
	addi		$s1, $zero, 1
	addi		$s2, $zero, 2
	j		start
case2:
	addi		$s1, $zero, 1
	addi		$s2, $zero, 0x7FFFFFFF	# 2^31 - 1
	j		start
case3:
	addi		$s1, $zero, -1
	addi		$s2, $zero, -2
	j		start
case4:
	addi		$s1, $zero, -1
	addi		$s2, $zero, 0x80000000	# -2^31
	j		start
case5:
	addi		$s1, $zero, 3
	addi		$s2, $zero, -2
	j		start
start:
	li		$t0, 0 			# No Overflow is default status
	addu		$s3, $s1, $s2		# s3 = s1 + s2
	xor		$t1, $s1, $s2		# Test if $s1 and $s2 have the same sign
	bltz		$t1, EXIT		# If not, exit
	slt		$t2, $s3, $s1
	bltz		$s1, NEGATIVE		# Test if $s1 and $s2 is negative?
	beq		$t2, $zero, EXIT		# s1 and $s2 are positive
		# If $s3 > $s1 then the result is not overflow
	j 		OVERFLOW
NEGATIVE:
	bne 		$t2, $zero, EXIT		# s1 and $s2 are negative
		# If $s3 < $s1 then the result is not overflow
OVERFLOW:
	li		$t0, 1			# The result is overflow
EXIT:
