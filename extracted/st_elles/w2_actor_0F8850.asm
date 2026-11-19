?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8850 {
    COP [14] ( #$00AD, &code_0F8857 ) ; {1017936}
    RTL                   ; {1017942}
}

code_0F8857 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1017943}
    COP [17] ( &code_0F886A ) ; {1017948}

  loc_0F8860:
    COP [81] ( #12, #04 ) ; {1017952}
    COP [83]              ; {1017956}
    COP [87]              ; {1017958}
    BRA loc_0F8860        ; {1017960}
}

code_0F886A {
    LDA $0016, X          ; {1017962}
    AND #$FFEF            ; {1017965}
    STA $0016, X          ; {1017968}
    COP [01] ( &asciistring_0F8881 ) ; {1017971}
    LDA $0016, X          ; {1017975}
    ORA #$0010            ; {1017978}
    STA $0016, X          ; {1017981}
    RTL                   ; {1017984}
}

asciistring_0F8881 |[10][0A]If█you█travel[N]the█coral█reef█you[N]will█find█a█passage█to[N]a█small█creek-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|