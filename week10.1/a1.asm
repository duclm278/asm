.eqv SEVENSEG_LEFT	0xFFFF0011
.eqv SEVENSEG_RIGHT	0xFFFF0010
.data
NUMS:	.word		0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text
main:	li	$a0, 6
	li	$a1, SEVENSEG_LEFT
	jal	draw
	li	$a0, 4
	li	$a1, SEVENSEG_RIGHT
	jal	draw
	j	exit
draw:	la	$t0, NUMS
	sll	$t1, $a0, 2		# i * 4
	add	$t0, $t0, $t1		# Address(NUMS[i])
	lw	$t0, 0($t0)		# NUMS[i]
	sb	$t0, 0($a1)		# Draw number
	jr	$ra
exit:
