?BANK 03

?INCLUDE 'lib_01186E'

---------------------------------------------

code_01B273 {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_01B284
    LDY #$&binary_01B284
    JSL $@lib_01186E.code_01188A
    PLP 
    RTL 
}
---------------------------------------------

binary_01B284 #07F20CF10CF00CEF0CEE0CED0CEC0CEB0CEA0CE90CE80CE70CE60CE50CE40CE30CE20CE10CE000