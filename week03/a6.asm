.data
A:	.word		-2, 3, -5, -9, 4, -1, 0
.text
init:	addi		$s1, $zero, 0		# i = 0
	la		$s2, A
	addi		$s3, $zero, 7		# n = 7
	addi		$s4, $zero, 1		# step = 1
	addi		$s5, $zero, 0		# sum = 0
	lw		$s6, 0($s2)		# load value of A[0] in $s6
	abs		$s6, $s6			# max = abs(A[0])
	addi		$s7, $s7, 0		# max_id = 0
loop:	slt		$t2, $s1, $s3		# $t2 = i < n ? 1 : 0
	beq		$t2, $zero, endloop
	add		$t1, $s1, $s1		# $t1 = 2 * $s1
	add		$t1, $t1, $t1		# $t1 = 4 * $s1
	add		$t1, $t1, $s2		# $t1 store the address of A[i]
	lw		$t0, 0($t1)		# load value of A[i] in $t0
	abs		$t0, $t0			# abs(A[i])
	slt		$t6, $s6, $t0		# if max < abs(A[i])
	bne		$t6, $zero, update	# update if True
	add		$s1, $s1, $s4		# i = i + step
	j		loop			# goto loop
update:
	add		$s6, $zero, $t0		# update max
	add		$s7, $zero, $s1		# update max_id
	add		$s1, $s1, $s4		# i = i + step
	j		loop
endloop:
