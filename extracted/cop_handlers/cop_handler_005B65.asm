?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_0276A5'

---------------------------------------------

Cop25_CallLib0276A5 {
    TYX                   ; {23397}
    LDA [$38]             ; {23398}
    INC $38               ; {23400}
    INC $38               ; {23402}
    JSL $@lib_0276A5.code_0276A5 ; {23404}
    LDA #$0010            ; {23408}
    TSB $0332             ; {23411}
    BRL cop_handler_006473.loc_0064BF ; {23414}
}