?BANK 04

---------------------------------------------

code_0276C9 {
    SED 
    STA $04
    LDA $1B66
    SEC 
    SBC $04
    STA $00
    LDA $1B68
    SBC #$0000
    STA $02
    BCS loc_0276E1
    CLD 
    SEC 
    RTL 

  loc_0276E1:
    LDA $00
    STA $1B66
    LDA $02
    STA $1B68
    CLD 
    CLC 
    RTL 
}