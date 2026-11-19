?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

!joy_block_mask                 0326

---------------------------------------------

code_01C98A {
    COP [14] ( #$0061, &code_01C991 ) ; {117130}
    RTL                   ; {117136}
}

code_01C991 {
    COP [30] ( #$0061, &code_01CA7E, #03 ) ; {117137}
    COP [07] ( #$9F02, &code_01C9C0 ) ; {117144}
    COP [85] ( @engine_0026F3.code_00299D ) ; {117150}
    COP [85] ( @code_01CA63 ) ; {117155}
    COP [17] ( &code_01CA43 ) ; {117160}
    COP [15]              ; {117164}
    COP [91]              ; {117166}
    COP [07] ( #$0402, &code_01C9BF ) ; {117168}
    COP [17] ( &code_01CA5E ) ; {117174}
    COP [80] ( #1A )      ; {117178}
    COP [82]              ; {117181}
}

code_01C9BF {
    RTL                   ; {117183}
}

code_01C9C0 {
    LDA #$BFC0            ; {117184}
    TSB $joy_block_mask   ; {117187}
    LDA $0016, X          ; {117190}
    ORA #$2000            ; {117193}
    STA $0016, X          ; {117196}
    COP [03] ( #65 )      ; {117199}
    COP [04]              ; {117202}
    COP [01] ( &asciistring_01CBA8 ) ; {117204}
    COP [03] ( #79 )      ; {117208}
    COP [04]              ; {117211}
    COP [A1] ( #$0010, #$FFF0 ) ; {117213}
    LDA $0016, X          ; {117219}
    AND #$DFFF            ; {117222}
    STA $0016, X          ; {117225}
    COP [81] ( #28, #08 ) ; {117228}
    COP [83]              ; {117232}
    COP [81] ( #27, #10 ) ; {117234}
    COP [83]              ; {117238}
    COP [03] ( #5B )      ; {117240}
    COP [04]              ; {117243}
    COP [01] ( &asciistring_01CC05 ) ; {117245}
    COP [03] ( #79 )      ; {117249}
    COP [04]              ; {117252}
    COP [81] ( #24, #04 ) ; {117254}
    COP [83]              ; {117258}
    COP [03] ( #29 )      ; {117260}
    COP [04]              ; {117263}
    COP [81] ( #27, #10 ) ; {117265}
    COP [83]              ; {117269}
    COP [81] ( #28, #08 ) ; {117271}
    COP [83]              ; {117275}
    LDA $0016, X          ; {117277}
    ORA #$2000            ; {117280}
    STA $0016, X          ; {117283}
    COP [03] ( #79 )      ; {117286}
    COP [04]              ; {117289}
    LDA #$0020            ; {117291}
    STA $03B4             ; {117294}
    COP [10] ( #$0101, #03, #$03B0, #$01D8 ) ; {117297}
    LDA #$BFC0            ; {117306}
    TRB $joy_block_mask   ; {117309}
    COP [91]              ; {117312}
    RTL                   ; {117314}
}

code_01CA43 {
    COP [19] ( #1C, &code_01CA59 ) ; {117315}
    COP [01] ( &asciistring_01CAB9 ) ; {117320}
    COP [3C] ( #04 )      ; {117324}
    COP [10] ( #$0504, #03, #$0160, #$01C0 ) ; {117327}
    RTL                   ; {117336}
}

code_01CA59 {
    COP [01] ( &asciistring_01CAAF ) ; {117337}
    RTL                   ; {117341}
}

code_01CA5E {
    COP [01] ( &asciistring_01CADE ) ; {117342}
    RTL                   ; {117346}
}

code_01CA63 {
    COP [91]              ; {117347}
    COP [0D] ( #00, #12, #2C, &code_01CA6D ) ; {117349}
    RTL                   ; {117356}
}

code_01CA6D {
    COP [01] ( &asciistring_01CA85 ) ; {117357}
    COP [91]              ; {117361}
    COP [0D] ( #00, #12, #2C, &code_01CA7D ) ; {117363}
    BRL code_01CA63       ; {117370}
}

code_01CA7D {
    RTL                   ; {117373}
}

code_01CA7E {
    COP [01] ( &asciistring_01CB73 ) ; {117374}
    COP [86]              ; {117378}
    RTL                   ; {117380}
}

asciistring_01CA85 |[10]Here lies Turbo, [N]builder of GreenWood- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CAAF |[10]Zzzzz [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CAB9 |[10][02:2] touched the [N]small bird with the [N]Dream Rod- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CADE |[10]The rafts will only [N]carry the residents of[N]GreenWood- [FIN]Maybe if you bring [N]something that used to[N]belong to Turbo, they [N]might help you- [FIN]There are some leaves [N]from GreenWood buried [N]with Turbo- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CB73 |[10][0E:3C]There is a bird [N]sleeping in front of [N]Turbo s grave stone- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CBA8 |[10][0F]Turbo s grave is [N]standing alone- [N][0E:5A]When [02:2] closed [N]his eyes, he tried to [N]imagine Turbo- [0E:78][JMP:&w1_shared_01EBC2.asciistring_01EC46+M]|

asciistring_01CC05 |[10][0F]Like good sleep comes [N]after hard work, good [N]rest comes after an [N]honest life- [N][0E:5A]I will rest well with [N]Dr-Leo- [0E:78][JMP:&w1_shared_01EBC2.asciistring_01EC46+M]|