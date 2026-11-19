?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA4F4 {
    COP [14] ( #$00B8, &code_0FA4FB ) ; {1025268}
    RTL                   ; {1025274}
}

code_0FA4FB {
    JSL $@w0_shared_01B161.code_01B161 ; {1025275}
    COP [17] ( &code_0FA50F ) ; {1025279}
    SEP #$20              ; {1025283}
    LDA #$^w2_shared_0FA945.code_0FA945 ; {1025285}
    PHA                   ; {1025287}
    REP #$20              ; {1025288}
    LDA #$&w2_shared_0FA945.code_0FA945-1 ; {1025290}
    PHA                   ; {1025293}
    RTL                   ; {1025294}
}

code_0FA50F {
    COP [01] ( &asciistring_0FA516 ) ; {1025295}
    BRL w2_shared_0FA46D.code_0FA46D ; {1025299}
}

asciistring_0FA516 |[10]The monuments on this [N]island are lightning [N]pyramids- [FIN]If you wear the [N]Thunder Ring and touch[N]them, [FIN]the Master will send [N]down lightning to [N]destroy the monsters- [FIN][END]|