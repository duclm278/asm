.data
A:	.word		1, 2, 3, 4, 5, 6, 7, 8
.text
init:	addi		$s1, $zero, 0		# i = 0
	la		$s2, A
	addi		$s3, $zero, 7		# n = 7
	addi		$s4, $zero, 1		# step = 1
	addi		$s5, $zero, 0		# sum = 0
loop:	slt		$t2, $s3, $s1		# $t2 = n < i
	bne		$t2, $zero, endloop
	add		$t1, $s1, $s1		# $t1 = 2 * $s1
	add		$t1, $t1, $t1		# $t1 = 4 * $s1
	add		$t1, $t1, $s2		# $t1 store the address of A[i]
	lw		$t0, 0($t1)		# load value of A[i] in $t0
	add		$s5, $s5, $t0		# sum = sum + A[i]
	add		$s1, $s1, $s4		# i = i + step
	j		loop			# goto loop
endloop:
