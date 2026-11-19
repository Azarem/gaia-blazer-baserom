?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'
?INCLUDE 'lib_0109D6_part3'

---------------------------------------------

Cop0A_SetInventoryIfEmpty {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0064F8.code_00651E
    BCC loc_005885
    JSL $@lib_0109D6_part3.code_0120F9

  loc_005885:
    BRL cop_handler_006473.loc_0064BF
}