?BANK 00

?INCLUDE 'cop_handler_006473'

!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

Cop37_GetMissingHp {
    TYX 
    LDA $player_max_hp
    SEC 
    SBC $player_hp
    STA $043B
    BRL cop_handler_006473.loc_0064BF
}