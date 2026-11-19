?BANK 04

?INCLUDE 'lib_01186E'

!cgram_buffer                   7F0000

---------------------------------------------

code_022457 {
    LDA #$1C81            ; {140375}
    STA $cgram_buffer     ; {140378}
    COP [91]              ; {140382}
    PHP                   ; {140384}
    SEP #$20              ; {140385}
    LDA #$32              ; {140387}
    XBA                   ; {140389}
    LDA #$^binary_022471  ; {140390}
    LDY #$&binary_022471  ; {140392}
    JSL $@lib_01186E.code_01188A ; {140395}
    PLP                   ; {140399}
    RTL                   ; {140400}
}
---------------------------------------------

binary_022471 #09F30AF20AF10AF00AEF0AEE0AED0AEC0AEB0AEA0AE90AE80AE70AE60AE50AE40AE30AE20AE122E000