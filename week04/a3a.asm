.text
init:
	addi		$s1, $zero,-1
start:
	addu		$s0, $s1, $zero
	bgez		$s1, exit
	sub		$s0, $zero, $s1
exit:
