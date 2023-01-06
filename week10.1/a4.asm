.eqv SCREEN	0x10010000
.eqv COLOR0	0x00FFFFFF
.eqv COLOR1	0x000000FF

.text
init:	li $k0, SCREEN
	li $s0, 0		# i = 0
	li $s1, 0		# j = 0
	li $s2, 0		# Current color
	li $s3, 0		# Current square
loop1:	beq $s0, 8, exitL	# Break if i == 8
loop2:	beq $s1, 8, incL1	# Break if j == 8
	sll $t0, $s0, 3		# t0 = 8 * i
	add $t0, $t0, $s1	# t0 = 8 * i + j

color:	# Get color
	add $t1, $t0, $s0	# t1 = 8 * i + j + i
	li $t2, 2
	div $t1, $t2
	mfhi $t2
	beq $t2, 0, setC0
	beq $t2, 1, setC1
setC0:	li $s2, COLOR0
	j square
setC1:	li $s2, COLOR1
	j square

square:	# Get square
	sll $t0, $t0, 2		# Offset bytes
	add $s3, $k0, $t0	# Update square
	sw $s2, 0($s3)
incL2:	add $s1, $s1, 1
	j loop2

incL1:	add $s0, $s0, 1		# i++
	li $s1, 0		# Reset j
	j loop1
exitL:
