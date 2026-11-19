?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop05_WaitFlag {
    TYX                   ; {22557}
    LDA [$38]             ; {22558}
    BMI loc_005829        ; {22560}
    JSR $&engine_0064F8.code_0064F8 ; {22562}
    BCC loc_00582E        ; {22565}
    BRA loc_005835        ; {22567}

  loc_005829:
    JSR $&engine_0064F8.code_0064F8 ; {22569}
    BCC loc_005835        ; {22572}

  loc_00582E:
    DEC $38               ; {22574}
    DEC $38               ; {22576}
    BRL cop_handler_006473.loc_0064C4 ; {22578}

  loc_005835:
    BRL cop_handler_006473.loc_0064BB ; {22581}
}