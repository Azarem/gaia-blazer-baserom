?BANK 1F

!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FCFD6 {
    COP [AD] ( #08 )
    COP [80] ( #18 )
    COP [82]
    COP [81] ( #19, #08 )
    COP [83]
    COP [85] ( @code_0FD000 )
    COP [85] ( @code_0FD005 )
    COP [85] ( @code_0FD01D )
    COP [85] ( @code_0FD022 )
    COP [81] ( #18, #0C )
    COP [83]
    BRA code_0FCFD6
}

code_0FD000 {
    LDA #$FFE0
    BRA loc_0FD008
}

code_0FD005 {
    LDA #$0020

  loc_0FD008:
    CLC 
    ADC $player_y
    AND #$FFF0
    STA $0002, X
    LDA $player_x
    AND #$FFF0
    STA $0000, X
    BRA loc_0FD038
}

code_0FD01D {
    LDA #$FFE0
    BRA loc_0FD025
}

code_0FD022 {
    LDA #$0020

  loc_0FD025:
    CLC 
    ADC $player_x
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    AND #$FFF0
    STA $0002, X

  loc_0FD038:
    COP [28] ( &code_0FD055 )
    LDA #$0300
    STA $0016, X
    COP [81] ( #16, #02 )
    COP [83]
    LDA #$0200
    STA $0016, X
    BRK #$5B
    COP [80] ( #17 )
    COP [82]
}

code_0FD055 {
    COP [86]
    RTL 
}