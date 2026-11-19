?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FB348 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB356

  code_0FB350:
    COP [1B] ( &code_0FB348, #$0020 )

  loc_0FB356:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB369
    DEC 
    BEQ loc_0FB372
    DEC 
    BEQ loc_0FB37B
    DEC 
    BEQ loc_0FB386

  loc_0FB369:
    COP [9D] ( #0E )
    COP [9E] ( &code_0FB350 )

  loc_0FB370:
    BRA loc_0FB391

  loc_0FB372:
    COP [9D] ( #0D )
    COP [9E] ( &code_0FB350 )

  loc_0FB379:
    BRA loc_0FB391

  loc_0FB37B:
    COP [96]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB384:
    BRA loc_0FB391

  loc_0FB386:
    COP [97]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB38F:
    BRA loc_0FB391

  loc_0FB391:
    COP [9A] ( #$0010, &code_0FB3A5, &code_0FB39B, &code_0FB3AF )
}

code_0FB39B {
    COP [9B] ( #$0000, &code_0FB3B9, &code_0FB3C2, &code_0FB3C2 )
}

code_0FB3A5 {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3CB, &code_0FB348 )
}

code_0FB3AF {
    COP [9B] ( #$0010, &code_0FB348, &code_0FB3D4, &code_0FB348 )
}

code_0FB3B9 {
    COP [97]
    COP [85] ( @code_0FB3F6 )
    BRA loc_0FB3DB
}

code_0FB3C2 {
    COP [97]
    COP [85] ( @code_0FB406 )
    BRA loc_0FB3DB
}

code_0FB3CB {
    COP [97]
    COP [85] ( @code_0FB416 )
    BRA loc_0FB3DB
}

code_0FB3D4 {
    COP [96]
    COP [85] ( @code_0FB416 )

  loc_0FB3DB:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [81] ( #0C, #02 )
    COP [83]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL code_0FB350
}

code_0FB3F6 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #12 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB406 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #11 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB416 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    LDA $001C, X
    ASL 
    BPL loc_0FB42B
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FB430

  loc_0FB42B:
    COP [80] ( #13 )
    COP [82]

  loc_0FB430:
    COP [86]
    RTL 
}