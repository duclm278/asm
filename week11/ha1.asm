# ------------------------------------------------------
# col 0x1    col 0x2    col 0x4     col 0x8

# row 0x1      0         1          2           3
# 0x11      0x21        0x41        0x81

# row 0x2      4         5          6           7
# 0x12      0x22        0x42        0x82

# row 0x4      8         9          a           b
# 0x14      0x24        0x44        0x84

# row 0x8      c         d          e           f
# 0x18      0x28        0x48        0x88
# -------------------------------------------------------
# command row number of hexadecimal keyboard (bit 0 to 3)
# Eg. assign 0x1, to get key button 0, 1, 2, 3
# assign 0x2, to get key button 4, 5, 6, 7
# NOTE must reassign value for this address before reading,
# eventhough you only want to scan 1 row
.eqv IN_ADDRESS_HEXA_KEYBOARD       0xFFFF0012
                                                            # receive row and column of the key pressed, 0 if not key pressed
                                                            # Eg. equal 0x11, means that key button 0 pressed.
                                                            # Eg. equal 0x28, means that key button D pressed.
.eqv OUT_ADDRESS_HEXA_KEYBOARD      0xFFFF0014
.text
main:
    li      $t1,        IN_ADDRESS_HEXA_KEYBOARD
    li      $t2,        OUT_ADDRESS_HEXA_KEYBOARD
init:
	li		$s0,		0									# Current char
	li		$s1,		0									# Lastest answer
	li		$s2, 		0									# Current operand
polling:
check1:
    li      $t3,        0x01                                # check 0, 1, 2, 3
    sb      $t3,        0($t1)                              # must reassign expected row
    lbu     $a0,        0($t2)                              # read scan code of key button
    beq		$a0,		0,							check2
    bne     $a0,        $s0,						update
    beq     $a0,        $s0,						back_to_polling
check2:
    li      $t3,        0x02                                # check 4, 5, 6, 7
    sb      $t3,        0($t1)                              # must reassign expected row
    lbu     $a0,        0($t2)                              # read scan code of key button
    beq		$a0,		0,							check3
    bne     $a0,        $s0,						update
    beq     $a0,        $s0,						back_to_polling
check3:
    li      $t3,        0x04                                # check 8, 9, a, b
    sb      $t3,        0($t1)                              # must reassign expected row
    lbu     $a0,        0($t2)                              # read scan code of key button
    beq		$a0,		0,							check4
    bne     $a0,        $s0,						update
    beq     $a0,        $s0,						back_to_polling
check4:
    li      $t3,        0x08                                # check c, d, e, f
    sb      $t3,        0($t1)                              # must reassign expected row
    lbu     $a0,        0($t2)                              # read scan code of key button
    beq		$a0,		0,							update
    bne     $a0,        $s0,						update
    beq     $a0,        $s0,						back_to_polling
update:
	add		$s0,		$a0,						$zero
	beq		$a0,		0,							back_to_polling
output:
    li      $v0,        34                                  # print integer (hexa)
    syscall 
sleep:
    li      $a0,        1000                                # sleep 1000ms
    li      $v0,        32
    syscall 
back_to_polling:
    j       polling                                         # continue polling
