?BANK 1F

!player_actor                   039C
!subframe_active                03A6

---------------------------------------------

code_0FA6F5 {
    COP [85] ( @code_0FA78C )
    COP [85] ( @code_0FA777 )
    COP [91]
    LDA $subframe_active
    BNE loc_0FA717
    LDY $player_actor
    LDA $0004, Y
    BMI loc_0FA726
    BNE loc_0FA72B
    LDA $0006, Y
    BMI loc_0FA721
    BNE loc_0FA71C

  loc_0FA717:
    LDA #$0020
    BRA loc_0FA72E

  loc_0FA71C:
    LDA #$0022
    BRA loc_0FA72E

  loc_0FA721:
    LDA #$0024
    BRA loc_0FA72E

  loc_0FA726:
    LDA #$0026
    BRA loc_0FA72E

  loc_0FA72B:
    LDA #$0028

  loc_0FA72E:
    STA $00
    LDY $003E, X
    PHX 
    LDX $player_actor
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    INC 
    STA $0002, Y
    LDA $00
    CMP $001E, Y
    BEQ loc_0FA754
    STA $001E, Y
    LDA #$0000
    STA $0014, Y

  loc_0FA754:
    LDA $003E, Y
    TAY 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    PLX 
    LDA $00
    INC 
    CMP $001E, Y
    BEQ loc_0FA776
    STA $001E, Y
    LDA #$0000
    STA $0014, Y

  loc_0FA776:
    RTL 
}

code_0FA777 {
    LDA #$0310
    STA $0016, X
    LDA #$0020
    STA $001E, X
    STZ $0020, X
    COP [91]

  loc_0FA788:
    COP [82]
    BRA loc_0FA788
}

code_0FA78C {
    LDA #$0310
    STA $0016, X
    LDA #$0021
    STA $001E, X
    STZ $0020, X
    COP [91]

  loc_0FA79D:
    COP [82]
    BRA loc_0FA79D
}