?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F9B8B {
    COP [14] ( #$008F, &code_0F9B92 )
    RTL 
}

code_0F9B92 {
    COP [30] ( #$008F, &code_0F9BED, #1F )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F9BB5 )

  loc_0F9BA2:
    COP [96]
    COP [81] ( #0E, #04 )
    COP [83]
    COP [97]
    COP [81] ( #0E, #04 )
    COP [83]
    BRL loc_0F9BA2
}

code_0F9BB5 {
    COP [18] ( #24, &code_0F9BD1 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9D86 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_0F9BD1 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F9C12 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$5E
    COP [0A] ( #24 )
    RTL 
}

code_0F9BED {
    COP [14] ( #$008C, &code_0F9BF7 )
    COP [01] ( &asciistring_0F9BFA )
}

code_0F9BF7 {
    COP [86]
    RTL 
}

asciistring_0F9BFA |[10][0E:3C]Hey, somebody help me![JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9C12 |[10]My name is Lue- [N]I used to live with [N]the inventor, Dr-Leo-[FIN]The Blue Stone I [N]received from him is [N]a strange jewel- [FIN]It attracts anyone who[N]looks at it and then [N]changes their [N]personality- [FIN]If that person has a [N]good mind, they will [N]become a great person-[FIN]If they have a evil [N]mind, they will become[N]a bad person- [FIN]One day, the Queen [N]found the jewel and [N]took it- Then she [N]placed me in prison- [FIN]Please save the Queen [N]and get the Blue Stone[N]back- [FIN]I know this ring will [N]help please take it- [FIN][02:2] received [N][03:24]the Thunder Ring- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9D86 |[10]I heard that Dr-Leo [N]was taken to the [N]Magridd Castle- [N]I wonder how he is- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|