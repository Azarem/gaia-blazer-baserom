?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019365 {
    COP [14] ( #$0018, &code_01936C ) ; {103269}
    RTL                   ; {103275}
}

code_01936C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {103276}
    COP [17] ( &code_01937E ) ; {103281}
    COP [15]              ; {103285}

  loc_019377:
    COP [80] ( #1E )      ; {103287}
    COP [82]              ; {103290}
    BRA loc_019377        ; {103292}
}

code_01937E {
    COP [07] ( #$8104, &code_019389 ) ; {103294}
    COP [01] ( &asciistring_01938E ) ; {103300}
    RTL                   ; {103304}
}

code_019389 {
    COP [01] ( &asciistring_0193FB ) ; {103305}
    RTL                   ; {103309}
}

asciistring_01938E |[10]I wonder who placed [N]the boundary between [N]dreams and reality? [FIN]Sometimes things that [N]happen in dreams come [N]true in reality- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0193FB |[10]You remember Lisa s, [N]dream right? Have you [N]returned to the place [N]you saw in her dream? [FIN]Things may be [N]different from when [N]you saw her before- [JMP:&w0_shared_01B988.asciistring_01B988]|