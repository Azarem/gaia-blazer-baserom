?BANK 00

?INCLUDE 'cop_handler_005EEE'
?INCLUDE 'cop_handler_006473'

!return_active                  03FB

---------------------------------------------

Cop30_ConditionalSpawn {
    TYX                   ; {23766}
    LDA $return_active    ; {23767}
    BNE loc_005CDF        ; {23770}
    BRL cop_handler_006473.loc_0064B5 ; {23772}

  loc_005CDF:
    LDA [$38]             ; {23775}
    INC $38               ; {23777}
    INC $38               ; {23779}
    CMP $0405             ; {23781}
    BEQ loc_005CED        ; {23784}
    BRL cop_handler_006473.loc_0064B9 ; {23786}

  loc_005CED:
    BRL cop_handler_005EEE.Cop85_SpawnActorBefore ; {23789}
}