?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01EBC2'

!joy_block_mask                 0326
!scroll_bg1_y                   033C

---------------------------------------------

code_01BF32 {
    COP [14] ( #$0063, &code_01BF39 ) ; {114482}
    RTL                   ; {114488}
}

code_01BF39 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {114489}
    COP [AC] ( @code_01C261, #$0030, #$0200, #$2040 ) ; {114494}
    COP [17] ( &code_01BFED ) ; {114505}
    COP [07] ( #$0306, &code_01BF62 ) ; {114509}
    COP [17] ( &code_01C015 ) ; {114515}
    COP [AC] ( @code_01C0B0, #$00A0, #$00B0, #$0050 ) ; {114519}
}

code_01BF62 {
    COP [15]              ; {114530}
    COP [91]              ; {114532}
    RTL                   ; {114534}
}

code_01BF67 {
    COP [16]              ; {114535}
    COP [81] ( #16, #09 ) ; {114537}
    COP [83]              ; {114541}
    COP [9F] ( #$FFF8 )   ; {114543}
    COP [87]              ; {114547}
    COP [80] ( #17 )      ; {114549}
    COP [82]              ; {114552}
    COP [9F] ( #$0008 )   ; {114554}
    COP [80] ( #16 )      ; {114558}
    COP [82]              ; {114561}
    COP [15]              ; {114563}
    COP [17] ( &code_01C009 ) ; {114565}
    COP [91]              ; {114569}
    RTL                   ; {114571}
}

code_01BF8C {
    COP [09] ( #$8002 )   ; {114572}

  code_01BF90:
    COP [16]              ; {114576}
    COP [80] ( #25 )      ; {114578}
    COP [82]              ; {114581}
    COP [80] ( #26 )      ; {114583}
    COP [82]              ; {114586}
    BRK #$4A              ; {114588}
    LDA #$2F80            ; {114590}
    TSB $joy_block_mask   ; {114593}
    COP [03] ( #08 )      ; {114596}
    LDA $002E, X          ; {114599}
    CLC                   ; {114602}
    ADC $scroll_bg1_y     ; {114603}
    STA $scroll_bg1_y     ; {114606}
    COP [1B] ( &code_01BFB7, #$0002 ) ; {114609}
}

code_01BFB7 {
    COP [04]              ; {114615}
    LDA #$2F80            ; {114617}
    TRB $joy_block_mask   ; {114620}
    COP [07] ( #$0002, &code_01BF8C ) ; {114623}
    COP [AC] ( @code_01C08A, #$00A0, #$0010, #$0050 ) ; {114629}
    COP [1B] ( &code_01BFD6, #$005A ) ; {114640}
}

code_01BFD6 {
    COP [80] ( #12 )      ; {114646}
    COP [82]              ; {114649}
    COP [80] ( #15 )      ; {114651}
    COP [82]              ; {114654}
    COP [15]              ; {114656}
    COP [17] ( &code_01C015 ) ; {114658}
    COP [09] ( #$8306 )   ; {114662}
    COP [91]              ; {114666}
    RTL                   ; {114668}
}

code_01BFED {
    COP [14] ( #$006F, &code_01BFF8 ) ; {114669}
    COP [01] ( &asciistring_01C01A ) ; {114675}
    RTL                   ; {114679}
}

code_01BFF8 {
    COP [01] ( &asciistring_01C043 ) ; {114680}
    COP [17] ( &code_01C004 ) ; {114684}
    COP [27] ( &code_01BF67 ) ; {114688}
}

code_01C004 {
    COP [01] ( &asciistring_01C043 ) ; {114692}
    RTL                   ; {114696}
}

code_01C009 {
    COP [01] ( &asciistring_01C052 ) ; {114697}
    COP [17] ( #$0000 )   ; {114701}
    COP [27] ( &code_01BF90 ) ; {114705}
}

code_01C015 {
    COP [01] ( &asciistring_01C065 ) ; {114709}
    RTL                   ; {114713}
}

asciistring_01C01A |[10]If you help me [N]cross the river I will[N]give you something- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C043 |[10]Follow me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C052 |[10]Stand back and watch! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C065 |[10]What did you think? [N]I hope this helped- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C08A {
    JSL $@w0_shared_01B161.code_01B161 ; {114826}
    STZ $0014, X          ; {114830}
    COP [03] ( #28 )      ; {114833}
    LDA $0002, X          ; {114836}
    CLC                   ; {114839}
    ADC #$0004            ; {114840}
    STA $0002, X          ; {114843}
    COP [04]              ; {114846}
    COP [17] ( &code_01C0C4 ) ; {114848}
    SEP #$20              ; {114852}
    LDA #$^w0_shared_01B161.code_01B17C ; {114854}
    PHA                   ; {114856}
    REP #$20              ; {114857}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {114859}
    PHA                   ; {114862}
    RTL                   ; {114863}
}

code_01C0B0 {
    JSL $@w0_shared_01B161.code_01B161 ; {114864}
    COP [17] ( &code_01C0C4 ) ; {114868}
    SEP #$20              ; {114872}
    LDA #$^w0_shared_01B161.code_01B17C ; {114874}
    PHA                   ; {114876}
    REP #$20              ; {114877}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {114879}
    PHA                   ; {114882}
    RTL                   ; {114883}
}

code_01C0C4 {
    COP [18] ( #40, &code_01C0CE ) ; {114884}
    COP [01] ( &asciistring_01C224 ) ; {114889}
    RTL                   ; {114893}
}

code_01C0CE {
    COP [18] ( #2A, &code_01C118 ) ; {114894}
    COP [18] ( #2B, &code_01C118 ) ; {114899}
    COP [18] ( #2C, &code_01C118 ) ; {114904}
    COP [18] ( #2D, &code_01C118 ) ; {114909}
    COP [18] ( #2E, &code_01C118 ) ; {114914}
    COP [18] ( #2F, &code_01C118 ) ; {114919}
    COP [18] ( #30, &code_01C118 ) ; {114924}
    COP [18] ( #31, &code_01C118 ) ; {114929}
    COP [01] ( &asciistring_01C1D8 ) ; {114934}
    COP [0B] ( #2A )      ; {114938}
    COP [0B] ( #2B )      ; {114941}
    COP [0B] ( #2C )      ; {114944}
    COP [0B] ( #2D )      ; {114947}
    COP [0B] ( #2E )      ; {114950}
    COP [0B] ( #2F )      ; {114953}
    COP [0B] ( #30 )      ; {114956}
    COP [0B] ( #31 )      ; {114959}
    BRK #$5E              ; {114962}
    COP [0A] ( #40 )      ; {114964}
    RTL                   ; {114967}
}

code_01C118 {
    COP [01] ( &asciistring_01C11D ) ; {114968}
    RTL                   ; {114972}
}

asciistring_01C11D |[10]The Master s Emblems [N]are all over the [N]world------- [FIN]They are fairly [N]difficult to find- [FIN]Collect all 8 emblems,[N]will not require GEMs [N]when casting magic- [FIN]This will make [N]fighting much easier [N]If you collect all 8, [N]bring them to me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C1D8 |[10][02:2], [N]you collected all 8 [N]emblems- [FIN]I will now give you [N][03:24]the Magic Bell- [N][03:20]You have fought well! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C224 |[10]The Magic Bell [N]enables you to use [N]magic without GEMs- [FIN][02:2], good luck! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C261 {
    COP [17] ( &code_01C26D ) ; {115297}
    COP [91]              ; {115301}
    COP [80] ( #23 )      ; {115303}
    COP [82]              ; {115306}
    RTL                   ; {115308}
}

code_01C26D {
    COP [01] ( &asciistring_01C272 ) ; {115309}
    RTL                   ; {115313}
}

asciistring_01C272 |[10][0A]There█once█was█a█raft[N]made█from█the█bark█of[N]my█branches-[FIN]You█must█find█this[N]raft-█I█believe█it[N]might█be█able[N]help█you█in█some█way-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|