.eqv SCREEN	0x10010000
.eqv RED		0x00FF0000
.eqv GREEN	0x0000FF00

.text
init:	li $k0, SCREEN
	li $s2, 0		# Current color
	li $s3, 0		# Current square
	li $s4, 64		# Number of rows
	li $s5, 64		# Number of cols
	li $t6, 6		# i1
	li $t7, 4		# j1
	li $t8, 32		# i2
	li $t9, 60		# j2
	add $s0, $zero, $t6	# i = i1
	add $s1, $zero, $t7	# j = j1
loop1:	bgt $s0, $t8, exitL	# Break if i == i2
loop2:	bgt $s1, $t9, incL1	# Break if j == j2
	mul $t0, $s0, $s5	# t0 = numRols * i
	add $t0, $t0, $s1	# t0 = numRols * i + j

color:	# Get colour
	beq $s0, $t6, border	# Diff color for border
	beq $s0, $t8, border	# Diff color for border
	beq $s1, $t7, border	# Diff color for border
	beq $s1, $t9, border	# Diff color for border
	li $s2, GREEN
	j square
border:	li $s2, RED
	j square

square:	# Get square
	sll $t0, $t0, 2		# Offset bytes
	add $s3, $k0, $t0	# Update square
	sw $s2, 0($s3)
incL2:	add $s1, $s1, 1
	j loop2

incL1:	add $s0, $s0, 1		# i++
	add $s1, $zero, $t7	# Reset j
	j loop1
exitL:
