?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FB348 {
    LDA $0016, X          ; {1028936}
    BIT #$8000            ; {1028939}
    BEQ loc_0FB356        ; {1028942}

  code_0FB350:
    COP [1B] ( &code_0FB348, #$0020 ) ; {1028944}

  loc_0FB356:
    COP [1F]              ; {1028950}
    LDA $rng_state+1      ; {1028952}
    AND #$0003            ; {1028955}
    BEQ loc_0FB369        ; {1028958}
    DEC                   ; {1028960}
    BEQ loc_0FB372        ; {1028961}
    DEC                   ; {1028963}
    BEQ loc_0FB37B        ; {1028964}
    DEC                   ; {1028966}
    BEQ loc_0FB386        ; {1028967}

  loc_0FB369:
    COP [9D] ( #0E )      ; {1028969}
    COP [9E] ( &code_0FB350 ) ; {1028972}

  loc_0FB370:
    BRA loc_0FB391        ; {1028976}

  loc_0FB372:
    COP [9D] ( #0D )      ; {1028978}
    COP [9E] ( &code_0FB350 ) ; {1028981}

  loc_0FB379:
    BRA loc_0FB391        ; {1028985}

  loc_0FB37B:
    COP [96]              ; {1028987}
    COP [9D] ( #0F )      ; {1028989}
    COP [9E] ( &code_0FB350 ) ; {1028992}

  loc_0FB384:
    BRA loc_0FB391        ; {1028996}

  loc_0FB386:
    COP [97]              ; {1028998}
    COP [9D] ( #0F )      ; {1029000}
    COP [9E] ( &code_0FB350 ) ; {1029003}

  loc_0FB38F:
    BRA loc_0FB391        ; {1029007}

  loc_0FB391:
    COP [9A] ( #$0010, &code_0FB3A5, &code_0FB39B, &code_0FB3AF ) ; {1029009}
}

code_0FB39B {
    COP [9B] ( #$0000, &code_0FB3B9, &code_0FB3C2, &code_0FB3C2 ) ; {1029019}
}

code_0FB3A5 {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3CB, &code_0FB348 ) ; {1029029}
}

code_0FB3AF {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3D4, &code_0FB348 ) ; {1029039}
}

code_0FB3B9 {
    COP [97]              ; {1029049}
    COP [85] ( @code_0FB3F6 ) ; {1029051}
    BRA loc_0FB3DB        ; {1029056}
}

code_0FB3C2 {
    COP [97]              ; {1029058}
    COP [85] ( @code_0FB406 ) ; {1029060}
    BRA loc_0FB3DB        ; {1029065}
}

code_0FB3CB {
    COP [97]              ; {1029067}
    COP [85] ( @code_0FB416 ) ; {1029069}
    BRA loc_0FB3DB        ; {1029074}
}

code_0FB3D4 {
    COP [96]              ; {1029076}
    COP [85] ( @code_0FB416 ) ; {1029078}

  loc_0FB3DB:
    LDA $0016, X          ; {1029083}
    ORA #$0200            ; {1029086}
    STA $0016, X          ; {1029089}
    COP [81] ( #0C, #02 ) ; {1029092}
    COP [83]              ; {1029096}
    LDA $0016, X          ; {1029098}
    AND #$FDFF            ; {1029101}
    STA $0016, X          ; {1029104}
    BRL code_0FB350       ; {1029107}
}

code_0FB3F6 {
    LDA #$0200            ; {1029110}
    STA $0016, X          ; {1029113}
    COP [A4]              ; {1029116}
    COP [80] ( #12 )      ; {1029118}
    COP [82]              ; {1029121}
    COP [86]              ; {1029123}
    RTL                   ; {1029125}
}

code_0FB406 {
    LDA #$0200            ; {1029126}
    STA $0016, X          ; {1029129}
    COP [A4]              ; {1029132}
    COP [80] ( #11 )      ; {1029134}
    COP [82]              ; {1029137}
    COP [86]              ; {1029139}
    RTL                   ; {1029141}
}

code_0FB416 {
    LDA #$0200            ; {1029142}
    STA $0016, X          ; {1029145}
    COP [A4]              ; {1029148}
    LDA $001C, X          ; {1029150}
    ASL                   ; {1029153}
    BPL loc_0FB42B        ; {1029154}
    COP [80] ( #27 )      ; {1029156}
    COP [82]              ; {1029159}
    BRA loc_0FB430        ; {1029161}

  loc_0FB42B:
    COP [80] ( #13 )      ; {1029163}
    COP [82]              ; {1029166}

  loc_0FB430:
    COP [86]              ; {1029168}
    RTL                   ; {1029170}
}