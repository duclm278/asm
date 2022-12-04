.data
    x: .word 0x01020304
    message: .asciiz "hello, world"
.text
    la $a0, message
    li $v0, 4
    syscall
    addi $t1, $zero, 1
    addi $t2, $zero, 3
    add $t0, $t1, 5
