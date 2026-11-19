?BANK 1F

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FB433 {
    COP [15]

  code_0FB435:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FB443
    COP [0C] ( #00, #01, &code_0FB449 )

  loc_0FB443:
    COP [1B] ( &code_0FB435, #$0010 )
}

code_0FB449 {
    COP [16]
    BRL loc_0FB4CE

  code_0FB44E:
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB462
    EOR #$FFFF
    INC 

  loc_0FB462:
    CLC 
    ADC $player_x
    AND #$FFF0
    CMP $map_width_px
    BCS code_0FB4DE
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB485
    EOR #$FFFF
    INC 

  loc_0FB485:
    CLC 
    ADC $player_y
    AND #$FFF0
    CMP $map_height_px
    BCS code_0FB4DE
    STA $0002, X
    COP [28] ( &code_0FB4DE )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [85] ( @code_0FB4E4 )
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X

  loc_0FB4CE:
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FB4DE {
    COP [1B] ( &code_0FB44E, #$0020 )
}

code_0FB4E4 {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A0] ( #$FFF4 )
    BRK #$5B
    COP [9A] ( #$0018, &code_0FB506, &code_0FB4FC, &code_0FB510 )
}

code_0FB4FC {
    COP [9B] ( #$0000, &code_0FB558, &code_0FB55E, &code_0FB532 )
}

code_0FB506 {
    COP [9B] ( #$0018, &code_0FB51A, &code_0FB522, &code_0FB52A )
}

code_0FB510 {
    COP [9B] ( #$0018, &code_0FB54E, &code_0FB544, &code_0FB53A )
}

code_0FB51A {
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB522 {
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB52A {
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB532 {
    COP [81] ( #1E, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB53A {
    COP [96]
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB544 {
    COP [96]
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB54E {
    COP [96]
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB558 {
    COP [81] ( #1F, #10 )
    COP [83]
}

code_0FB55E {
    COP [86]
    RTL 
}