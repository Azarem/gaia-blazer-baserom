?BANK 03

?INCLUDE 'lib_01186E'

---------------------------------------------

code_01B273 {
    PHP                   ; {111219}
    SEP #$20              ; {111220}
    LDA #$32              ; {111222}
    XBA                   ; {111224}
    LDA #$^binary_01B284  ; {111225}
    LDY #$&binary_01B284  ; {111227}
    JSL $@lib_01186E.code_01188A ; {111230}
    PLP                   ; {111234}
    RTL                   ; {111235}
}
---------------------------------------------

binary_01B284 #07F20CF10CF00CEF0CEE0CED0CEC0CEB0CEA0CE90CE80CE70CE60CE50CE40CE30CE20CE10CE000