?BANK 1F

?INCLUDE 'lib_027462_part1'
?INCLUDE 'w2_shared_0FA945'

!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_0F8B6A {
    COP [14] ( #$00A1, &code_0F8B71 )
    RTL 
}

code_0F8B71 {
    COP [30] ( #$00A1, &code_0F8BB5, #1F )
    COP [B0] ( @code_0F8C9A, #$2000 )
    COP [17] ( &code_0F8B8D )
    COP [15]
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F8B8D {
    COP [07] ( #$8405, &code_0F8BA1 )
    COP [09] ( #$8405 )
    COP [01] ( &asciistring_0F8BF7 )
    BRK #$5E
    COP [0A] ( #0B )
    RTL 
}

code_0F8BA1 {
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_0F8BB0
    COP [01] ( &asciistring_0F8C60 )
    COP [37]
    RTL 

  loc_0F8BB0:
    COP [01] ( &asciistring_0F8C75 )
    RTL 
}

code_0F8BB5 {
    COP [01] ( &asciistring_0F8BBC )
    COP [86]
    RTL 
}

asciistring_0F8BBC |[10][0E:3C]You hear a mermaid-[FIN]Is there anyone who [N]needs to use the [N]Bubble Armor? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8BF7 |[10]Oh! I have not had a [N]human guest in a long [N]time- [FIN]I know you can t [N]breathe under water, [N]so please take this- [FIN][02:2] received [N][03:24]Bubble Armor- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C60 |[10]Have you been hurt? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C75 |[10]If you get hurt, [N]return to me and I [N]will heal you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

code_0F8C9A {
    COP [07] ( #$8A02, &code_0F8CC8 )
    COP [91]
    COP [18] ( #21, &code_0F8CA9 )
    BRA loc_0F8CAA
}

code_0F8CA9 {
    RTL 

  loc_0F8CAA:
    LDA #$02A0
    STA $16
    LDA #$0B80
    STA $18
    PHX 
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA #$FC
    STA $7E8000, X
    REP #$20
    PLX 
    COP [09] ( #$8A02 )
}

code_0F8CC8 {
    COP [86]
    RTL 
}