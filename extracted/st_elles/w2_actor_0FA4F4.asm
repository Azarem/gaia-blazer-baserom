?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA4F4 {
    COP [14] ( #$00B8, &code_0FA4FB )
    RTL 
}

code_0FA4FB {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_0FA50F )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA50F {
    COP [01] ( &asciistring_0FA516 )
    BRL w2_shared_0FA46D.code_0FA46D
}

asciistring_0FA516 |[10]The monuments on this [N]island are lightning [N]pyramids- [FIN]If you wear the [N]Thunder Ring and touch[N]them, [FIN]the Master will send [N]down lightning to [N]destroy the monsters- [FIN][END]|