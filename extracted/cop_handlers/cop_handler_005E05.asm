?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_0124EE'

---------------------------------------------

Cop3A_CallLib0124EE {
    TYX                   ; {24069}
    JSL $@lib_0124EE.code_0124EE ; {24070}
    BRL cop_handler_006473.loc_0064BF ; {24074}
}