.text
init:
	li		$s0, 0			# Used to store result
	li		$s1, 0x12
	li		$s2, 16
	li		$s3, 0			# Position of first 1
	li		$t1, 1			# Used to store number 1
count:
	beq		$s2, $t1, multiply	# Exit if $s2 == 1
	srl		$s2, $s2, 1		# Shift right by 1 bit
	addi		$s3, $s3, 1		# Count	shifting operations
	j		count
multiply:
	sllv		$s0, $s1, $s3		# Multiply by shifting
