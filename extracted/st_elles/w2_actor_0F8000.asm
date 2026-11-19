?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8000 {
    COP [3B] ( #$007C, &code_0F8016 ) ; {1015808}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1015814}
    SEP #$20              ; {1015818}
    LDA #$^engine_003005.code_00305F ; {1015820}
    PHA                   ; {1015822}
    REP #$20              ; {1015823}
    LDA #$&engine_003005.code_00305F-1 ; {1015825}
    PHA                   ; {1015828}
    RTL                   ; {1015829}
}

code_0F8016 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1015830}
    COP [15]              ; {1015835}
    COP [17] ( &code_0F8029 ) ; {1015837}

  loc_0F8021:
    COP [80] ( #11 )      ; {1015841}
    COP [82]              ; {1015844}
    BRL loc_0F8021        ; {1015846}
}

code_0F8029 {
    COP [07] ( #$8704, &code_0F804A ) ; {1015849}
    COP [19] ( #1C, &code_0F8045 ) ; {1015855}
    COP [01] ( &asciistring_0F8059 ) ; {1015860}
    COP [3C] ( #04 )      ; {1015864}
    COP [10] ( #$0209, #01, #$0078, #$0410 ) ; {1015867}
    RTL                   ; {1015876}
}

code_0F8045 {
    COP [01] ( &asciistring_0F804F ) ; {1015877}
    RTL                   ; {1015881}
}

code_0F804A {
    COP [01] ( &asciistring_0F8080 ) ; {1015882}
    RTL                   ; {1015886}
}

asciistring_0F804F |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8059 |[10][02:2] placed [N]the Dream Rod on [N]the dolphin s nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8080 |[10]I always have the same[N]dream- Isn t that [N]strange! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|