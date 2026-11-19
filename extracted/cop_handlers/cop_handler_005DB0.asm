?BANK 00

?INCLUDE 'cop_handler_006473'

!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

Cop37_GetMissingHp {
    TYX                   ; {23984}
    LDA $player_max_hp    ; {23985}
    SEC                   ; {23988}
    SBC $player_hp        ; {23989}
    STA $043B             ; {23992}
    BRL cop_handler_006473.loc_0064BF ; {23995}
}