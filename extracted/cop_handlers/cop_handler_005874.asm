?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'
?INCLUDE 'lib_0109D6_part3'

---------------------------------------------

Cop0A_SetInventoryIfEmpty {
    TYX                   ; {22644}
    LDA [$38]             ; {22645}
    INC $38               ; {22647}
    AND #$00FF            ; {22649}
    JSR $&engine_0064F8.code_00651E ; {22652}
    BCC loc_005885        ; {22655}
    JSL $@lib_0109D6_part3.code_0120F9 ; {22657}

  loc_005885:
    BRL cop_handler_006473.loc_0064BF ; {22661}
}