?BANK 00

---------------------------------------------

native_mode_brk_0055FC {
    REP #$20
    PHA 
    LDA $04, S
    DEC 
    STA $3B
    SEP #$20
    LDA $06, S
    STA $3D
    LDA [$3B]
    BIT #$40
    BNE loc_005615
    STA $0398
    BRA loc_00561A

  loc_005615:
    AND #$BF
    STA $0399

  loc_00561A:
    REP #$20
    PLA 
    RTI 
}