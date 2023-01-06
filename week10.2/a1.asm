.eqv HEADING 0xffff8010                 # Integer: An angle between 0 and 359
                                        # 0 : North (up)
                                        # 90: East (right)
                                        # 180: South (down)
                                        # 270: West (left)
.eqv MOVING 0xffff8050                  # Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020              # Boolean (0 or non-0):
                                        # whether or not to leave a track
.eqv WHEREX 0xffff8030                  # Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040                  # Integer: Current y-location of MarsBot
.text
main:
triangle:
    jal     UNTRACK
    jal     GO

    li      $a0,        90
    jal     ROTATE

    li      $v0,        32
    li      $a0,        1000
    syscall 

    li      $a0,        180
    jal     ROTATE

    li      $v0,        32
    li      $a0,        1000
    syscall 

    li      $a0,        90
    jal     ROTATE

    li      $v0,        32
    li      $a0,        500
    syscall 

    li      $a0,        150
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        270
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        30
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK
square:
    li      $a0,        90
    jal     ROTATE

    li      $v0,        32
    li      $a0,        1000
    syscall 

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        180
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        270
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        0
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK
star:
    li      $a0,        90
    jal     ROTATE

    li      $v0,        32
    li      $a0,        2000
    syscall 

    li      $a0,        162
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        306
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        90
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        234
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        18
    jal     ROTATE

    jal     TRACK
    li      $v0,        32
    li      $a0,        1000
    syscall 
    jal     UNTRACK

    li      $a0,        90
    jal     ROTATE

    li      $v0,        32
    li      $a0,        1000
    syscall 
end_main:
    jal     STOP
    li      $v0,        10
    syscall 

# -----------------------------------------------------------
# GO procedure, to start running
# param[in] none
# -----------------------------------------------------------
GO:
    li      $at,        MOVING          # change MOVING port
    addi    $k0,        $zero,      1   # to logic 1,
    sb      $k0,        0($at)          # to start running
    jr      $ra

# -----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
# -----------------------------------------------------------
STOP:
    li      $at,        MOVING          # change MOVING port to 0
    sb      $zero,      0($at)          # to stop
    jr      $ra

# -----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
# -----------------------------------------------------------
TRACK:
    li      $at,        LEAVETRACK      # change LEAVETRACK port
    addi    $k0,        $zero,      1   # to logic 1,
    sb      $k0,        0($at)          # to start tracking
    jr      $ra

# -----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
# -----------------------------------------------------------
UNTRACK:
    li      $at,        LEAVETRACK      # change LEAVETRACK port to 0
    sb      $zero,      0($at)          # to stop drawing tail
    jr      $ra

# -----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
# -----------------------------------------------------------
ROTATE:
    li      $at,        HEADING         # change HEADING port
    sw      $a0,        0($at)          # to rotate robot
    jr      $ra
