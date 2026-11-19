?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1C_JumpIfActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    AND $0016, X
    BNE loc_005AAD
    BRL cop_handler_006473.loc_0064BB

  loc_005AAD:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}