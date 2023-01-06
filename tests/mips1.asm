.text
lui $s0, 0x65C8
ori $s0, $s0, 0xA810
sw $s0, 0($sp)
lb $s1, 3($sp)

#    65 C8 A8 10
# L:  3  2  1  0
# B:  0  1  2  3
