?BANK 00

?INCLUDE 'cop_handler_005EEE'
?INCLUDE 'cop_handler_006473'

!return_active                  03FB

---------------------------------------------

Cop30_ConditionalSpawn {
    TYX 
    LDA $return_active
    BNE loc_005CDF
    BRL cop_handler_006473.loc_0064B5

  loc_005CDF:
    LDA [$38]
    INC $38
    INC $38
    CMP $0405
    BEQ loc_005CED
    BRL cop_handler_006473.loc_0064B9

  loc_005CED:
    BRL cop_handler_005EEE.Cop85_SpawnActorBefore
}