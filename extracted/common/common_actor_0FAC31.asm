?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FAC31 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAC3F

  code_0FAC39:
    COP [1B] ( &code_0FAC31, #$0010 )

  loc_0FAC3F:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FAC52
    DEC 
    BEQ loc_0FAC5B
    DEC 
    BEQ loc_0FAC64
    DEC 
    BEQ loc_0FAC6F

  loc_0FAC52:
    COP [9D] ( #14 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC59:
    BRA code_0FAC31

  loc_0FAC5B:
    COP [9D] ( #12 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC62:
    BRA code_0FAC31

  loc_0FAC64:
    COP [96]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC6D:
    BRA code_0FAC31

  loc_0FAC6F:
    COP [97]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC78:
    BRA code_0FAC31
}