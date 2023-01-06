.eqv KEY_CODE 0xFFFF0004                            # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000                           # =1 if has a new keycode ?
                                                    # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C                        # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008                       # =1 if the display has already to do
                                                    # Auto clear after sw
.text
    li      $k0,        KEY_CODE
    li      $k1,        KEY_READY
    li      $s0,        DISPLAY_CODE
    li      $s1,        DISPLAY_READY
Loop:
    nop     
WaitForKey:
    lw      $t1,        0($k1)                      # $t1 = [$k1] = KEY_READY
    beq     $t1,        $zero,          WaitForKey  # if $t1 == 0 then Polling
ReadKey:
    lw      $t0,        0($k0)                      # $t0 = [$k0] = KEY_CODE
WaitForDis:
    lw      $t2,        0($s1)                      # $t2 = [$s1] = DISPLAY_READY
    beq     $t2,        $zero,          WaitForDis  # if $t2 == 0 then Polling
Check:
    add     $t8,        $zero,          $t7
    add     $t7,        $zero,          $t6
    add     $t6,        $zero,          $t5
    add     $t5,        $zero,          $t0
    bne     $t8,        'e',            NotExit
    bne     $t7,        'x',            NotExit
    bne     $t6,        'i',            NotExit
    bne     $t5,        't',            NotExit
    j       EndLoop
NotExit:
    sge     $t3,        $t0,            'a'
    sle     $t4,        $t0,            'z'
    and     $t3,        $t3,            $t4
    beq     $t3,        1,              IsLower
    sge     $t3,        $t0,            'A'
    sle     $t4,        $t0,            'Z'
    and     $t3,        $t3,            $t4
    beq     $t3,        1,              IsUpper
    sge     $t3,        $t0,            '0'
    sle     $t4,        $t0,            '9'
    and     $t3,        $t3,            $t4
    beq     $t3,        1,              ShowKey
    j       IsOther
IsLower:
    add     $t0,        $t0,            -32
    j       ShowKey
IsUpper:
    add     $t0,        $t0,            +32
    j       ShowKey
IsOther:
    li      $t0,        '*'
    j       ShowKey
ShowKey:
    sw      $t0,        0($s0)                      # show key
    nop     
    j       Loop
EndLoop:
