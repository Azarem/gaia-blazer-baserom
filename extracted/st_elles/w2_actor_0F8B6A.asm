?BANK 1F

?INCLUDE 'lib_027462_part1'
?INCLUDE 'w2_shared_0FA945'

!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_0F8B6A {
    COP [14] ( #$00A1, &code_0F8B71 ) ; {1018730}
    RTL                   ; {1018736}
}

code_0F8B71 {
    COP [30] ( #$00A1, &code_0F8BB5, #1F ) ; {1018737}
    COP [B0] ( @code_0F8C9A, #$2000 ) ; {1018744}
    COP [17] ( &code_0F8B8D ) ; {1018751}
    COP [15]              ; {1018755}
    COP [91]              ; {1018757}
    COP [80] ( #08 )      ; {1018759}
    COP [82]              ; {1018762}
    RTL                   ; {1018764}
}

code_0F8B8D {
    COP [07] ( #$8405, &code_0F8BA1 ) ; {1018765}
    COP [09] ( #$8405 )   ; {1018771}
    COP [01] ( &asciistring_0F8BF7 ) ; {1018775}
    BRK #$5E              ; {1018779}
    COP [0A] ( #0B )      ; {1018781}
    RTL                   ; {1018784}
}

code_0F8BA1 {
    LDA $player_hp        ; {1018785}
    CMP $player_max_hp    ; {1018788}
    BEQ loc_0F8BB0        ; {1018791}
    COP [01] ( &asciistring_0F8C60 ) ; {1018793}
    COP [37]              ; {1018797}
    RTL                   ; {1018799}

  loc_0F8BB0:
    COP [01] ( &asciistring_0F8C75 ) ; {1018800}
    RTL                   ; {1018804}
}

code_0F8BB5 {
    COP [01] ( &asciistring_0F8BBC ) ; {1018805}
    COP [86]              ; {1018809}
    RTL                   ; {1018811}
}

asciistring_0F8BBC |[10][0E:3C]You hear a mermaid-[FIN]Is there anyone who [N]needs to use the [N]Bubble Armor? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8BF7 |[10]Oh! I have not had a [N]human guest in a long [N]time- [FIN]I know you can t [N]breathe under water, [N]so please take this- [FIN][02:2] received [N][03:24]Bubble Armor- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C60 |[10]Have you been hurt? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C75 |[10]If you get hurt, [N]return to me and I [N]will heal you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

code_0F8C9A {
    COP [07] ( #$8A02, &code_0F8CC8 ) ; {1019034}
    COP [91]              ; {1019040}
    COP [18] ( #21, &code_0F8CA9 ) ; {1019042}
    BRA loc_0F8CAA        ; {1019047}
}

code_0F8CA9 {
    RTL                   ; {1019049}

  loc_0F8CAA:
    LDA #$02A0            ; {1019050}
    STA $16               ; {1019053}
    LDA #$0B80            ; {1019055}
    STA $18               ; {1019058}
    PHX                   ; {1019060}
    JSL $@lib_027462_part1.code_0272B8 ; {1019061}
    SEP #$20              ; {1019065}
    LDA #$FC              ; {1019067}
    STA $7E8000, X        ; {1019069}
    REP #$20              ; {1019073}
    PLX                   ; {1019075}
    COP [09] ( #$8A02 )   ; {1019076}
}

code_0F8CC8 {
    COP [86]              ; {1019080}
    RTL                   ; {1019082}
}