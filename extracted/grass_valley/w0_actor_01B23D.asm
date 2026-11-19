?BANK 03

?INCLUDE 'lib_01186E'

---------------------------------------------

code_01B23D {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_01B24E
    LDY #$&binary_01B24E
    JSL $@lib_01186E.code_01188A
    PLP 
    RTL 
}
---------------------------------------------

binary_01B24E #7FE020E004E104E204E304E404E504E604E704E804E904EA04EB04EC04ED04EE04EF04F000