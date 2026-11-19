?BANK 00

?INCLUDE 'cop_handler_006473'

!rng_state                      0301
!random_mod_result              0437

---------------------------------------------

Cop35_RandomMod {
    TYX                   ; {23926}
    LDA [$38]             ; {23927}
    INC $38               ; {23929}
    AND #$00FF            ; {23931}
    STA $00               ; {23934}
    LDA $rng_state+1      ; {23936}
    AND #$00FF            ; {23939}

  loc_005D86:
    SEC                   ; {23942}
    SBC $00               ; {23943}
    BPL loc_005D86        ; {23945}
    CLC                   ; {23947}
    ADC $00               ; {23948}
    STA $random_mod_result ; {23950}
    BRL cop_handler_006473.loc_0064BF ; {23953}
}