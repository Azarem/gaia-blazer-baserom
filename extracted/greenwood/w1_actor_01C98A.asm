?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

!joy_block_mask                 0326

---------------------------------------------

code_01C98A {
    COP [14] ( #$0061, &code_01C991 )
    RTL 
}

code_01C991 {
    COP [30] ( #$0061, &code_01CA7E, #03 )
    COP [07] ( #$9F02, &code_01C9C0 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [85] ( @code_01CA63 )
    COP [17] ( &code_01CA43 )
    COP [15]
    COP [91]
    COP [07] ( #$0402, &code_01C9BF )
    COP [17] ( &code_01CA5E )
    COP [80] ( #1A )
    COP [82]
}

code_01C9BF {
    RTL 
}

code_01C9C0 {
    LDA #$BFC0
    TSB $joy_block_mask
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [03] ( #65 )
    COP [04]
    COP [01] ( &asciistring_01CBA8 )
    COP [03] ( #79 )
    COP [04]
    COP [A1] ( #$0010, #$FFF0 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #27, #10 )
    COP [83]
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_01CC05 )
    COP [03] ( #79 )
    COP [04]
    COP [81] ( #24, #04 )
    COP [83]
    COP [03] ( #29 )
    COP [04]
    COP [81] ( #27, #10 )
    COP [83]
    COP [81] ( #28, #08 )
    COP [83]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [03] ( #79 )
    COP [04]
    LDA #$0020
    STA $03B4
    COP [10] ( #$0101, #03, #$03B0, #$01D8 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01CA43 {
    COP [19] ( #1C, &code_01CA59 )
    COP [01] ( &asciistring_01CAB9 )
    COP [3C] ( #04 )
    COP [10] ( #$0504, #03, #$0160, #$01C0 )
    RTL 
}

code_01CA59 {
    COP [01] ( &asciistring_01CAAF )
    RTL 
}

code_01CA5E {
    COP [01] ( &asciistring_01CADE )
    RTL 
}

code_01CA63 {
    COP [91]
    COP [0D] ( #00, #12, #2C, &code_01CA6D )
    RTL 
}

code_01CA6D {
    COP [01] ( &asciistring_01CA85 )
    COP [91]
    COP [0D] ( #00, #12, #2C, &code_01CA7D )
    BRL code_01CA63
}

code_01CA7D {
    RTL 
}

code_01CA7E {
    COP [01] ( &asciistring_01CB73 )
    COP [86]
    RTL 
}

asciistring_01CA85 |[10]Here lies Turbo, [N]builder of GreenWood- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CAAF |[10]Zzzzz [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CAB9 |[10][02:2] touched the [N]small bird with the [N]Dream Rod- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CADE |[10]The rafts will only [N]carry the residents of[N]GreenWood- [FIN]Maybe if you bring [N]something that used to[N]belong to Turbo, they [N]might help you- [FIN]There are some leaves [N]from GreenWood buried [N]with Turbo- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CB73 |[10][0E:3C]There is a bird [N]sleeping in front of [N]Turbo s grave stone- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CBA8 |[10][0F]Turbo s grave is [N]standing alone- [N][0E:5A]When [02:2] closed [N]his eyes, he tried to [N]imagine Turbo- [0E:78][JMP:&w1_shared_01EBC2.asciistring_01EC46+M]|

asciistring_01CC05 |[10][0F]Like good sleep comes [N]after hard work, good [N]rest comes after an [N]honest life- [N][0E:5A]I will rest well with [N]Dr-Leo- [0E:78][JMP:&w1_shared_01EBC2.asciistring_01EC46+M]|