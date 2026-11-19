?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

!player_actor                   039C

---------------------------------------------

code_020143 {
    COP [3B] ( #$00EA, &code_020159 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_020159 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02019A )
    COP [15]
    COP [91]
    RTL 
}

code_020167 {
    COP [B2] ( @engine_0026F3.code_00299D, #$0000, #$0010, #$0040 )
    BRK #$4E
    LDY $player_actor
    LDA #$0100
    STA $0000, Y
    COP [03] ( #E1 )
    COP [04]
    BRK #$4E
    LDY $player_actor
    LDA #$0020
    STA $0000, Y
    LDA #$01A0
    STA $0002, Y
    COP [01] ( &asciistring_0201C8 )
    COP [91]
    RTL 
}

code_02019A {
    COP [01] ( &asciistring_0201A2 )
    COP [27] ( &code_020167 )
}

asciistring_0201A2 |[10]Oh honey, I can still [N]use magic- [FIN]Look! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0201C8 |[10]You see? [JMP:&w3_shared_02249A.asciistring_02251E]|