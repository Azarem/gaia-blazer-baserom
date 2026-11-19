?BANK 04

?INCLUDE 'data_00F9F7'

!player_actor                   039C

---------------------------------------------

code_0273D4 {
    PHP                   ; {160724}
    SEP #$20              ; {160725}
    LDY $player_actor     ; {160727}
    LDX $001E, Y          ; {160730}
    CPX #$002C            ; {160733}
    BCS loc_0273E8        ; {160736}
    LDA $&data_00F9F7.binary_00FA7F, X ; {160738}
    PLP                   ; {160741}
    CLC                   ; {160742}
    RTL                   ; {160743}

  loc_0273E8:
    PLP                   ; {160744}
    SEC                   ; {160745}
    RTL                   ; {160746}
}