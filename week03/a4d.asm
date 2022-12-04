.text
init:	addi		$s1, $zero, 1		# i = 1
	addi		$s2, $zero, 2		# j = 2
	addi		$s3, $zero, 3		# m = 3
	addi		$s4, $zero, 4		# n = 4
	add		$s5, $s1, $s2		# $s5 = i + j
	add		$s6, $s3, $s4		# $s6 = m + n
if:	slt		$t0, $s6, $s5		# m + n < i + j
	beq		$t0, $zero, else		# branch to else if m + n >= i + j
	addi		$t1, $t1, 1		# then part: x = x + 1
	addi		$t3, $zero, 1		# z = 1
	j		endif			# skip “else” part
else:	addi		$t2, $t2, -1		# begin else part: y = y - 1
	add		$t3, $t3, $t3		# z = 2 * z
endif:
