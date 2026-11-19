?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01DDB7 {
    COP [14] ( #$0072, &code_01DDBE )
    RTL 
}

code_01DDBE {
    COP [07] ( #$8307, &code_01DE5D )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01DE60 )
    COP [15]
    COP [91]
    RTL 
}

code_01DDD2 {
    COP [17] ( &code_01DE68 )
    COP [16]

  code_01DDD8:
    COP [27] ( &code_01DDDC )
}

code_01DDDC {
    COP [0D] ( #16, #0E, #1F, &code_01DE49 )
    COP [9C] ( &code_01DDE9, &code_01DE1B )
}

code_01DDE9 {
    COP [9A] ( #$0010, &code_01DDF3, &code_01DE1B, &code_01DE12 )
}

code_01DDF3 {
    COP [14] ( #$0056, &code_01DE09 )
    LDA $0000, X
    CMP #$0120
    BCS code_01DE09
    LDA $0002, X
    CMP #$0170
    BCC code_01DDD8
}

code_01DE09 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE12 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE1B {
    COP [9B] ( #$0010, &code_01DE25, &code_01DDD8, &code_01DE42 )
}

code_01DE25 {
    COP [14] ( #$0056, &code_01DE3B )
    LDA $0002, X
    CMP #$0170
    BCS code_01DE3B
    LDA $0000, X
    CMP #$0120
    BCC code_01DDD8
}

code_01DE3B {
    COP [80] ( #0A )
    COP [82]
    BRA code_01DDDC
}

code_01DE42 {
    COP [80] ( #09 )
    COP [82]
    BRA code_01DDDC
}

code_01DE49 {
    COP [17] ( &code_01DE6D )
    COP [15]
    COP [80] ( #06 )
    COP [82]
    COP [91]
    RTL 
}

code_01DE57 {
    COP [16]
    COP [09] ( #$8307 )
}

code_01DE5D {
    COP [86]
    RTL 
}

code_01DE60 {
    COP [01] ( &asciistring_01DE75 )
    COP [27] ( &code_01DDD2 )
}

code_01DE68 {
    COP [01] ( &asciistring_01DF22 )
    RTL 
}

code_01DE6D {
    COP [01] ( &asciistring_01DF4C )
    COP [27] ( &code_01DE57 )
}

asciistring_01DE75 |[10]My name is Monmo the [N]mole- [FIN]This place is so [N]bright I cannot see- [FIN]Would you please lead [N]me to my house? I will[N]follow you- [FIN]Please take to the [N]hole that leads to my [N]home- [FIN]Allright, talk to me [N]when I am standing in [N]the right place- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DF22 |[10]Please don t walk so [N]fast, I can t keep up [N]with you- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DF4C |[10]I ll give you [N]a present- [N]Could you wait here? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|