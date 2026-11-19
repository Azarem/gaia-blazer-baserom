?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FDFC3 {
    COP [AD] ( #08 )      ; {1040323}
    COP [0C] ( #00, #04, &code_0FDFD3 ) ; {1040326}
    COP [80] ( #0A )      ; {1040332}
    COP [82]              ; {1040335}
    BRA code_0FDFC3       ; {1040337}
}

code_0FDFD3 {
    COP [9A] ( #$0000, &code_0FDFE1, &code_0FDFDD, &code_0FDFDD ) ; {1040339}
}

code_0FDFDD {
    COP [96]              ; {1040349}
    BRA loc_0FDFE3        ; {1040351}
}

code_0FDFE1 {
    COP [97]              ; {1040353}

  loc_0FDFE3:
    COP [9B] ( #$0028, &code_0FDFF7, &code_0FDFED, &code_0FE00C ) ; {1040355}
}

code_0FDFED {
    COP [9B] ( #$0000, &code_0FDFFE, &code_0FE005, &code_0FE005 ) ; {1040365}
}

code_0FDFF7 {
    COP [80] ( #0E )      ; {1040375}
    COP [82]              ; {1040378}
    BRA loc_0FE011        ; {1040380}
}

code_0FDFFE {
    COP [80] ( #0D )      ; {1040382}
    COP [82]              ; {1040385}
    BRA loc_0FE011        ; {1040387}
}

code_0FE005 {
    COP [80] ( #0C )      ; {1040389}
    COP [82]              ; {1040392}
    BRA loc_0FE011        ; {1040394}
}

code_0FE00C {
    COP [80] ( #0B )      ; {1040396}
    COP [82]              ; {1040399}

  loc_0FE011:
    COP [81] ( #0A, #02 ) ; {1040401}
    COP [83]              ; {1040405}
    COP [0C] ( #00, #02, &code_0FDFC3 ) ; {1040407}
    COP [81] ( #0F, #04 ) ; {1040413}
    COP [83]              ; {1040417}
    COP [B0] ( @code_0FE032, #$0200 ) ; {1040419}
    COP [81] ( #0A, #02 ) ; {1040426}
    COP [83]              ; {1040430}
    BRA code_0FDFC3       ; {1040432}
}

code_0FE032 {
    COP [A3]              ; {1040434}
    BRK #$64              ; {1040436}
    LDY #$0010            ; {1040438}
    SEP #$20              ; {1040441}
    LDA #$^common_actor_004659_part1.code_002D67 ; {1040443}
    PHA                   ; {1040445}
    REP #$20              ; {1040446}
    LDA #$&common_actor_004659_part1.code_002D67-1 ; {1040448}
    PHA                   ; {1040451}
    RTL                   ; {1040452}
}