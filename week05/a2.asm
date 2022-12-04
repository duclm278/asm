.data
string1:	.asciiz "The sum of "
string2:	.asciiz " and "
string3:	.asciiz " is "
.text
input:
	li		$v0, 5
	syscall
	add		$s0, $zero, $v0		# Store $s0
	li		$v0, 5
	syscall
	add		$s1, $zero, $v0		# Store $s1
sum:
	add		$s2, $s0, $s1		# $s2 = $s0 + $s1
output:
	li		$v0, 4
	la		$a0, string1
	syscall					# Print	"The sum of "
	li		$v0, 1
	add		$a0, $zero, $s0		# $a0 = $s0
	syscall					# Print (s0)
	li		$v0, 4
	la		$a0, string2
	syscall					# Print " and "
	li		$v0, 1
	add		$a0, $zero, $s1		# $a0 = $s1
	syscall					# Print (s1)
	li		$v0, 4
	la		$a0, string3
	syscall					# Print " is "
	li		$v0, 1
	add		$a0, $zero, $s2		# $a0 = sum
	syscall					# Print (sum)
