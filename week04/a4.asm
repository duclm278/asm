.text
init:
	j		case2
case1:
	addi		$s1, $zero, 1
	addi		$s2, $zero, 2
	j		start
case2:
	addi		$s1, $zero, 1
	addi		$s2, $zero, 0x7FFFFFFF	# 2^31 - 1
	j		start
start:
	li		$t0, 0 			# No Overflow is default status
	addu		$s3, $s1, $s2		# s3 = s1 + s2
	xor		$t1, $s3, $s1		# Test if $s3 and $s1 have the same sign
	beq		$t1, $zero, EXIT
	j		OVERFLOW
OVERFLOW:
	li		$t0, 1			# The result is overflow
EXIT:
