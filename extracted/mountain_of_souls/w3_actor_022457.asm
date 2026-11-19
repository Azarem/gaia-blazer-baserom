?BANK 04

?INCLUDE 'lib_01186E'

!cgram_buffer                   7F0000

---------------------------------------------

code_022457 {
    LDA #$1C81
    STA $cgram_buffer
    COP [91]
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_022471
    LDY #$&binary_022471
    JSL $@lib_01186E.code_01188A
    PLP 
    RTL 
}
---------------------------------------------

binary_022471 #09F30AF20AF10AF00AEF0AEE0AED0AEC0AEB0AEA0AE90AE80AE70AE60AE50AE40AE30AE20AE122E000