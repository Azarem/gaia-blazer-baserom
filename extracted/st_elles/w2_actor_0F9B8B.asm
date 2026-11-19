?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9B8B {
    COP [14] ( #$008F, &code_0F9B92 ) ; {1022859}
    RTL                   ; {1022865}
}

code_0F9B92 {
    COP [30] ( #$008F, &code_0F9BED, #1F ) ; {1022866}
    COP [85] ( @engine_0026F3.code_00299D ) ; {1022873}
    COP [17] ( &code_0F9BB5 ) ; {1022878}

  loc_0F9BA2:
    COP [96]              ; {1022882}
    COP [81] ( #0E, #04 ) ; {1022884}
    COP [83]              ; {1022888}
    COP [97]              ; {1022890}
    COP [81] ( #0E, #04 ) ; {1022892}
    COP [83]              ; {1022896}
    BRL loc_0F9BA2        ; {1022898}
}

code_0F9BB5 {
    COP [18] ( #24, &code_0F9BD1 ) ; {1022901}
    LDA $0016, X          ; {1022906}
    AND #$FFEF            ; {1022909}
    STA $0016, X          ; {1022912}
    COP [01] ( &asciistring_0F9D86 ) ; {1022915}
    LDA $0016, X          ; {1022919}
    ORA #$0010            ; {1022922}
    STA $0016, X          ; {1022925}
    RTL                   ; {1022928}
}

code_0F9BD1 {
    LDA $0016, X          ; {1022929}
    AND #$FFEF            ; {1022932}
    STA $0016, X          ; {1022935}
    COP [01] ( &asciistring_0F9C12 ) ; {1022938}
    LDA $0016, X          ; {1022942}
    ORA #$0010            ; {1022945}
    STA $0016, X          ; {1022948}
    BRK #$5E              ; {1022951}
    COP [0A] ( #24 )      ; {1022953}
    RTL                   ; {1022956}
}

code_0F9BED {
    COP [14] ( #$008C, &code_0F9BF7 ) ; {1022957}
    COP [01] ( &asciistring_0F9BFA ) ; {1022963}
}

code_0F9BF7 {
    COP [86]              ; {1022967}
    RTL                   ; {1022969}
}

asciistring_0F9BFA |[10][0E:3C]Hey, somebody help me![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9C12 |[10]My name is Lue- [N]I used to live with [N]the inventor, Dr-Leo-[FIN]The Blue Stone I [N]received from him is [N]a strange jewel- [FIN]It attracts anyone who[N]looks at it and then [N]changes their [N]personality- [FIN]If that person has a [N]good mind, they will [N]become a great person-[FIN]If they have a evil [N]mind, they will become[N]a bad person- [FIN]One day, the Queen [N]found the jewel and [N]took it- Then she [N]placed me in prison- [FIN]Please save the Queen [N]and get the Blue Stone[N]back- [FIN]I know this ring will [N]help please take it- [FIN][02:2] received [N][03:24]the Thunder Ring- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9D86 |[10]I heard that Dr-Leo [N]was taken to the [N]Magridd Castle- [N]I wonder how he is- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|