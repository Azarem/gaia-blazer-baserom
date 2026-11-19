?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01CF41 {
    COP [14] ( #$0059, &code_01CF48 ) ; {118593}
    RTL                   ; {118599}
}

code_01CF48 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {118600}
    COP [17] ( &code_01CFB4 ) ; {118605}
    COP [15]              ; {118609}
    COP [91]              ; {118611}
    COP [14] ( #$0056, &code_01CF5C ) ; {118613}
    RTL                   ; {118619}
}

code_01CF5C {
    COP [17] ( &code_01CFA7 ) ; {118620}
    COP [91]              ; {118624}
    RTL                   ; {118626}
}

code_01CF63 {
    COP [16]              ; {118627}
    COP [17] ( &code_01CFAF ) ; {118629}

  code_01CF69:
    COP [9C] ( &code_01CF6F, &code_01CF8B ) ; {118633}
}

code_01CF6F {
    COP [9A] ( #$0010, &code_01CF79, &code_01CF8B, &code_01CF82 ) ; {118639}
}

code_01CF79 {
    COP [97]              ; {118649}
    COP [80] ( #05 )      ; {118651}
    COP [82]              ; {118654}
    BRA code_01CF69       ; {118656}
}

code_01CF82 {
    COP [96]              ; {118658}
    COP [80] ( #05 )      ; {118660}
    COP [82]              ; {118663}
    BRA code_01CF69       ; {118665}
}

code_01CF8B {
    COP [9B] ( #$0010, &code_01CF95, &code_01CFA3, &code_01CF9C ) ; {118667}
}

code_01CF95 {
    COP [80] ( #04 )      ; {118677}
    COP [82]              ; {118680}
    BRA code_01CF69       ; {118682}
}

code_01CF9C {
    COP [80] ( #03 )      ; {118684}
    COP [82]              ; {118687}
    BRA code_01CF69       ; {118689}
}

code_01CFA3 {
    COP [27] ( &code_01CF69 ) ; {118691}
}

code_01CFA7 {
    COP [01] ( &asciistring_01CFB9 ) ; {118695}
    COP [27] ( &code_01CF63 ) ; {118699}
}

code_01CFAF {
    COP [01] ( &asciistring_01CFE0 ) ; {118703}
    RTL                   ; {118707}
}

code_01CFB4 {
    COP [01] ( &asciistring_01D01B ) ; {118708}
    RTL                   ; {118712}
}

asciistring_01CFB9 |[10]I need to take [N]a walk and work some [N]of this food off- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CFE0 |[10]"Why am I following [N]you?ˮ [N]Well it s purely [N]coincidence- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D01B |[10]I m starving! This [N]place used to be a [N]restaurant- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|