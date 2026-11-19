?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_pressed                    0322

---------------------------------------------

code_022D05 {
    COP [14] ( #$014A, &code_022D0C )
    RTL 
}

code_022D0C {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022D63 )
    COP [15]
    COP [05] ( #$0000 )
    COP [16]
    COP [9A] ( #$0000, &code_022D27, &code_022D27, &code_022D37 )
}

code_022D27 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA loc_022D45
}

code_022D37 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [96]
    COP [80] ( #0C )
    COP [82]

  loc_022D45:
    COP [15]
    COP [91]
    COP [0D] ( #00, #14, #05, &code_022D51 )
    RTL 
}

code_022D51 {
    LDA $joy_pressed
    AND #$0800
    BNE loc_022D5A
    RTL 

  loc_022D5A:
    COP [01] ( &asciistring_022D98 )
    COP [37]
    COP [91]
    RTL 
}

code_022D63 {
    COP [01] ( &asciistring_022D6C )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_022D6C |[10]I am a devout mouse, [N]stand here and you [N]will be purified- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022D98 |[10][02:2], [N]felt his body and mind[N]become purified- [JMP:&w4_shared_023F33.asciistring_023FA3]|