?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F80A4 {
    COP [14] ( #$00B1, &code_0F80AB )
    RTL 
}

code_0F80AB {
    COP [30] ( #$00B1, &code_0F8108, #1F )
    COP [07] ( #$8701, &code_0F80D4 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F80DC )

  loc_0F80C1:
    COP [81] ( #14, #02 )
    COP [83]
    COP [87]
    COP [81] ( #13, #02 )
    COP [83]
    COP [87]
    BRL loc_0F80C1
}

code_0F80D4 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [86]
    RTL 
}

code_0F80DC {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F814A )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA $1B82
    ORA #$04
    STA $1B82
    REP #$20
    COP [09] ( #$8701 )
    BRK #$4E
    COP [27] ( &code_0F80D4 )
}

code_0F8108 {
    COP [01] ( &asciistring_0F810F )
    COP [86]
    RTL 
}

asciistring_0F810F |[10][0E:3C]I have the power to [N]stop the Magma Rain- [N]I will help you if you[N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F814A |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]I will protect you [N]from the Magma- [FIN]Please try and protect[N]all creatures- [FIN]Let s work together so[N]we may revive the [N]world! [FIN]The creature that [N]enables you to avoid [N]Magma has joined you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|