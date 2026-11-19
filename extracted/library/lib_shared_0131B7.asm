?BANK 02

!RDNMI                          4210

---------------------------------------------

code_0131B7 {
    PHP                   ; {78263}
    SEP #$20              ; {78264}
    PHA                   ; {78266}
    LDA $RDNMI            ; {78267}

  loc_0131BE:
    LDA $RDNMI            ; {78270}
    BPL loc_0131BE        ; {78273}
    LDA $RDNMI            ; {78275}
    PLA                   ; {78278}
    PLP                   ; {78279}
    RTL                   ; {78280}
}