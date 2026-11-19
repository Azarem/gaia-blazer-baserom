?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_pressed                    0322

---------------------------------------------

code_022D05 {
    COP [14] ( #$014A, &code_022D0C ) ; {142597}
    RTL                   ; {142603}
}

code_022D0C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {142604}
    COP [17] ( &code_022D63 ) ; {142609}
    COP [15]              ; {142613}
    COP [05] ( #$0000 )   ; {142615}
    COP [16]              ; {142619}
    COP [9A] ( #$0000, &code_022D27, &code_022D27, &code_022D37 ) ; {142621}
}

code_022D27 {
    COP [96]              ; {142631}
    COP [80] ( #0F )      ; {142633}
    COP [82]              ; {142636}
    COP [97]              ; {142638}
    COP [80] ( #0C )      ; {142640}
    COP [82]              ; {142643}
    BRA loc_022D45        ; {142645}
}

code_022D37 {
    COP [97]              ; {142647}
    COP [80] ( #0F )      ; {142649}
    COP [82]              ; {142652}
    COP [96]              ; {142654}
    COP [80] ( #0C )      ; {142656}
    COP [82]              ; {142659}

  loc_022D45:
    COP [15]              ; {142661}
    COP [91]              ; {142663}
    COP [0D] ( #00, #14, #05, &code_022D51 ) ; {142665}
    RTL                   ; {142672}
}

code_022D51 {
    LDA $joy_pressed      ; {142673}
    AND #$0800            ; {142676}
    BNE loc_022D5A        ; {142679}
    RTL                   ; {142681}

  loc_022D5A:
    COP [01] ( &asciistring_022D98 ) ; {142682}
    COP [37]              ; {142686}
    COP [91]              ; {142688}
    RTL                   ; {142690}
}

code_022D63 {
    COP [01] ( &asciistring_022D6C ) ; {142691}
    COP [09] ( #$8000 )   ; {142695}
    RTL                   ; {142699}
}

asciistring_022D6C |[10]I am a devout mouse, [N]stand here and you [N]will be purified- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022D98 |[10][02:2], [N]felt his body and mind[N]become purified- [JMP:&w4_shared_023F33.asciistring_023FA3]|