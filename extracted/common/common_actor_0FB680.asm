?BANK 1F

---------------------------------------------

code_0FB680 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB68E
    COP [1B] ( &code_0FB680, #$0010 )

  loc_0FB68E:
    COP [80] ( #12 )
    COP [82]
    BRA code_0FB680
}