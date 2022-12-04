.text
	li		$s0, 0x12345678		# Load test value
	srl		$s1, $s0, 24		# Extract MSB
	andi		$s2, $s0, 0xFFFFFF00	# Clear LSB
	ori		$s3, $s0, 0x000000FF	# Set LSB
	xor		$s0, $s0, $s0		# Clear $s0
