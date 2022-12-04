.data
String:		.space 21
Message:		.asciiz "\nReversed:\n"

.text
reverse:		la		$a0, String			# $a0 = address(string[0])
		add		$t0, $zero, $zero		# $t0 = i = 0
		li		$s0, 20				# maximum size of string
scanChar:	add		$t1, $a0, $t0			# $t1 = $a0 + $t0
								#     = address(string[i])
		li $v0, 12
		syscall
		sb		$v0, 0($t1)
		beq		$v0, '\n', endString		# stop if '\n' is inputted
		addi		$t0, $t0, 1
		beq		$t0, $s0, endString		# stop if maximum size is reached
		j		scanChar
endString:	add		$s1, $zero, $a0			# move address of string to $s1
								# $a0 will be used in reverse_string				
		li		$v0, 4
		la		$a0, Message			# print "\nReversed:\n"
		syscall		
printReversed:	addi		$t0, $t0, -1
		bltz		$t0, endReverse

		add		$t1, $s1, $t0			# $t1 = $s1 + $t0
								#     = address(string[i])
		li		$v0, 11
		lb		$a0, 0($t1)			# load string[i]
		syscall						# print string[i]
		j		printReversed
endReverse:
