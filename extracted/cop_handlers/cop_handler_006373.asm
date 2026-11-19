?BANK 00

?INCLUDE 'cop_handler_006473'

!map_width_px                   0342
!map_height_px                  0344

---------------------------------------------

CopAD_YieldWhileInView {
    TYX                   ; {25459}
    LDA $0016, X          ; {25460}
    BIT #$8000            ; {25463}
    BNE loc_00637F        ; {25466}
    BRL cop_handler_006473.loc_0064BD ; {25468}

  loc_00637F:
    LDA $0000, X          ; {25471}
    CMP $map_width_px     ; {25474}
    BCC loc_00638A        ; {25477}
    BRL cop_handler_006473.loc_0064BD ; {25479}

  loc_00638A:
    LDA $0002, X          ; {25482}
    CMP $map_height_px    ; {25485}
    BCC loc_006395        ; {25488}
    BRL cop_handler_006473.loc_0064BD ; {25490}

  loc_006395:
    LDA $38               ; {25493}
    DEC                   ; {25495}
    DEC                   ; {25496}
    STA $0018, X          ; {25497}
    LDA [$38]             ; {25500}
    INC $38               ; {25502}
    AND #$00FF            ; {25504}
    STA $0014, X          ; {25507}
    BRL cop_handler_006473.loc_0064C9 ; {25510}
}