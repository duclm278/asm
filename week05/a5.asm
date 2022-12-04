.data
string:		.space 21
message:		.asciiz "\nReversed:\n"

.text
init:
		la		$a0, string			# $a0 = address(string[0])
		add		$t0, $zero, $zero		# $t0 = i = 0
		li		$s0, 20				# Maximum size of string
scan_char:
		add		$t1, $a0, $t0			# $t1 = $a0 + $t0
								#     = address(string[i])

		li $v0, 12
		syscall
		sb		$v0, 0($t1)
		beq		$v0, '\n', end_of_string		# Stop if '\n' is inputted

		addi		$t0, $t0, 1
		beq		$t0, $s0, end_of_string		# Stop if maximum size is reached
		j		scan_char
end_of_string:
		add		$s1, $zero, $a0			# Move address of string to $s1
								# $a0 will be used in reverse_string
								
		li		$v0, 4
		la		$a0, message			# Print "\nReversed:\n"
		syscall		
reverse_string:
		subi		$t0, $t0, 1
		bltz		$t0, exit

		add		$t1, $s1, $t0			# $t1 = $s1 + $t0
								#     = address(string[i])

		li		$v0, 11
		lb		$a0, 0($t1)			# Load string[i]
		syscall						# Print string[i]

		j		reverse_string
exit:
