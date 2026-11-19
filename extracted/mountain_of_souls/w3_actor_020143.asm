?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

!player_actor                   039C

---------------------------------------------

code_020143 {
    COP [3B] ( #$00EA, &code_020159 ) ; {131395}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {131401}
    SEP #$20              ; {131405}
    LDA #$^engine_003005.code_00305F ; {131407}
    PHA                   ; {131409}
    REP #$20              ; {131410}
    LDA #$&engine_003005.code_00305F-1 ; {131412}
    PHA                   ; {131415}
    RTL                   ; {131416}
}

code_020159 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131417}
    COP [17] ( &code_02019A ) ; {131422}
    COP [15]              ; {131426}
    COP [91]              ; {131428}
    RTL                   ; {131430}
}

code_020167 {
    COP [B2] ( @engine_0026F3.code_00299D, #$0000, #$0010, #$0040 ) ; {131431}
    BRK #$4E              ; {131442}
    LDY $player_actor     ; {131444}
    LDA #$0100            ; {131447}
    STA $0000, Y          ; {131450}
    COP [03] ( #E1 )      ; {131453}
    COP [04]              ; {131456}
    BRK #$4E              ; {131458}
    LDY $player_actor     ; {131460}
    LDA #$0020            ; {131463}
    STA $0000, Y          ; {131466}
    LDA #$01A0            ; {131469}
    STA $0002, Y          ; {131472}
    COP [01] ( &asciistring_0201C8 ) ; {131475}
    COP [91]              ; {131479}
    RTL                   ; {131481}
}

code_02019A {
    COP [01] ( &asciistring_0201A2 ) ; {131482}
    COP [27] ( &code_020167 ) ; {131486}
}

asciistring_0201A2 |[10]Oh honey, I can still [N]use magic- [FIN]Look! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0201C8 |[10]You see? [JMP:&w3_shared_02249A.asciistring_02251E]|