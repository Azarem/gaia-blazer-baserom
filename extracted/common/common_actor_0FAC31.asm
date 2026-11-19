?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FAC31 {
    LDA $0016, X          ; {1027121}
    BIT #$8000            ; {1027124}
    BEQ loc_0FAC3F        ; {1027127}

  code_0FAC39:
    COP [1B] ( &code_0FAC31, #$0010 ) ; {1027129}

  loc_0FAC3F:
    COP [1F]              ; {1027135}
    LDA $rng_state+1      ; {1027137}
    AND #$0003            ; {1027140}
    BEQ loc_0FAC52        ; {1027143}
    DEC                   ; {1027145}
    BEQ loc_0FAC5B        ; {1027146}
    DEC                   ; {1027148}
    BEQ loc_0FAC64        ; {1027149}
    DEC                   ; {1027151}
    BEQ loc_0FAC6F        ; {1027152}

  loc_0FAC52:
    COP [9D] ( #14 )      ; {1027154}
    COP [9E] ( &code_0FAC39 ) ; {1027157}

  loc_0FAC59:
    BRA code_0FAC31       ; {1027161}

  loc_0FAC5B:
    COP [9D] ( #12 )      ; {1027163}
    COP [9E] ( &code_0FAC39 ) ; {1027166}

  loc_0FAC62:
    BRA code_0FAC31       ; {1027170}

  loc_0FAC64:
    COP [96]              ; {1027172}
    COP [9D] ( #16 )      ; {1027174}
    COP [9E] ( &code_0FAC39 ) ; {1027177}

  loc_0FAC6D:
    BRA code_0FAC31       ; {1027181}

  loc_0FAC6F:
    COP [97]              ; {1027183}
    COP [9D] ( #16 )      ; {1027185}
    COP [9E] ( &code_0FAC39 ) ; {1027188}

  loc_0FAC78:
    BRA code_0FAC31       ; {1027192}
}