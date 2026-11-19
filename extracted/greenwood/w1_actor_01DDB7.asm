?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DDB7 {
    COP [14] ( #$0072, &code_01DDBE ) ; {122295}
    RTL                   ; {122301}
}

code_01DDBE {
    COP [07] ( #$8307, &code_01DE5D ) ; {122302}
    COP [85] ( @engine_0026F3.code_00299D ) ; {122308}
    COP [17] ( &code_01DE60 ) ; {122313}
    COP [15]              ; {122317}
    COP [91]              ; {122319}
    RTL                   ; {122321}
}

code_01DDD2 {
    COP [17] ( &code_01DE68 ) ; {122322}
    COP [16]              ; {122326}

  code_01DDD8:
    COP [27] ( &code_01DDDC ) ; {122328}
}

code_01DDDC {
    COP [0D] ( #16, #0E, #1F, &code_01DE49 ) ; {122332}
    COP [9C] ( &code_01DDE9, &code_01DE1B ) ; {122339}
}

code_01DDE9 {
    COP [9A] ( #$0010, &code_01DDF3, &code_01DE1B, &code_01DE12 ) ; {122345}
}

code_01DDF3 {
    COP [14] ( #$0056, &code_01DE09 ) ; {122355}
    LDA $0000, X          ; {122361}
    CMP #$0120            ; {122364}
    BCS code_01DE09       ; {122367}
    LDA $0002, X          ; {122369}
    CMP #$0170            ; {122372}
    BCC code_01DDD8       ; {122375}
}

code_01DE09 {
    COP [97]              ; {122377}
    COP [80] ( #0B )      ; {122379}
    COP [82]              ; {122382}
    BRA code_01DDDC       ; {122384}
}

code_01DE12 {
    COP [96]              ; {122386}
    COP [80] ( #0B )      ; {122388}
    COP [82]              ; {122391}
    BRA code_01DDDC       ; {122393}
}

code_01DE1B {
    COP [9B] ( #$0010, &code_01DE25, &code_01DDD8, &code_01DE42 ) ; {122395}
}

code_01DE25 {
    COP [14] ( #$0056, &code_01DE3B ) ; {122405}
    LDA $0002, X          ; {122411}
    CMP #$0170            ; {122414}
    BCS code_01DE3B       ; {122417}
    LDA $0000, X          ; {122419}
    CMP #$0120            ; {122422}
    BCC code_01DDD8       ; {122425}
}

code_01DE3B {
    COP [80] ( #0A )      ; {122427}
    COP [82]              ; {122430}
    BRA code_01DDDC       ; {122432}
}

code_01DE42 {
    COP [80] ( #09 )      ; {122434}
    COP [82]              ; {122437}
    BRA code_01DDDC       ; {122439}
}

code_01DE49 {
    COP [17] ( &code_01DE6D ) ; {122441}
    COP [15]              ; {122445}
    COP [80] ( #06 )      ; {122447}
    COP [82]              ; {122450}
    COP [91]              ; {122452}
    RTL                   ; {122454}
}

code_01DE57 {
    COP [16]              ; {122455}
    COP [09] ( #$8307 )   ; {122457}
}

code_01DE5D {
    COP [86]              ; {122461}
    RTL                   ; {122463}
}

code_01DE60 {
    COP [01] ( &asciistring_01DE75 ) ; {122464}
    COP [27] ( &code_01DDD2 ) ; {122468}
}

code_01DE68 {
    COP [01] ( &asciistring_01DF22 ) ; {122472}
    RTL                   ; {122476}
}

code_01DE6D {
    COP [01] ( &asciistring_01DF4C ) ; {122477}
    COP [27] ( &code_01DE57 ) ; {122481}
}

asciistring_01DE75 |[10]My name is Monmo the [N]mole- [FIN]This place is so [N]bright I cannot see- [FIN]Would you please lead [N]me to my house? I will[N]follow you- [FIN]Please take to the [N]hole that leads to my [N]home- [FIN]Allright, talk to me [N]when I am standing in [N]the right place- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DF22 |[10]Please don t walk so [N]fast, I can t keep up [N]with you- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DF4C |[10]I ll give you [N]a present- [N]Could you wait here? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|