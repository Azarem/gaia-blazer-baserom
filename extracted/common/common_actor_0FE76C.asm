?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FE76C {
    LDA $0016, X
    ORA #$2000
    STA $0016, X

  code_0FE775:
    COP [28] ( &code_0FE77B )
    BRA loc_0FE781
}

code_0FE77B {
    COP [1B] ( &code_0FE775, #$0008 )

  loc_0FE781:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X

  code_0FE78A:
    COP [AD] ( #08 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [15]
    COP [97]
    COP [03] ( #32 )
    COP [0C] ( #00, #01, &code_0FE7E1 )
    COP [80] ( #25 )
    COP [82]
    COP [04]
    COP [80] ( #29 )
    COP [82]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FE7CC
    DEC 
    BEQ loc_0FE7D3
    DEC 
    BEQ loc_0FE7DA
    COP [96]

  loc_0FE7CC:
    COP [80] ( #28 )
    COP [82]
    BRA code_0FE78A

  loc_0FE7D3:
    COP [80] ( #27 )
    COP [82]
    BRA code_0FE78A

  loc_0FE7DA:
    COP [80] ( #26 )
    COP [82]
    BRA code_0FE78A
}

code_0FE7E1 {
    COP [81] ( #25, #0A )
    COP [83]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  code_0FE7F2:
    COP [1B] ( &code_0FE7F8, #$0008 )
}

code_0FE7F8 {
    COP [9C] ( &code_0FE7FE, &code_0FE808 )
}

code_0FE7FE {
    COP [9A] ( #$0008, &code_0FE828, &code_0FE808, &code_0FE833 )
}

code_0FE808 {
    COP [9B] ( #$0008, &code_0FE812, &code_0FE7F2, &code_0FE81D )
}

code_0FE812 {
    COP [97]
    COP [9D] ( #2B )
    COP [9E] ( &code_0FE78A )

  loc_0FE81B:
    BRA code_0FE7F2
}

code_0FE81D {
    COP [97]
    COP [9D] ( #2A )
    COP [9E] ( &code_0FE78A )

  loc_0FE826:
    BRA code_0FE7F2
}

code_0FE828 {
    COP [97]
    COP [9D] ( #2C )
    COP [9E] ( &code_0FE78A )

  loc_0FE831:
    BRA code_0FE7F2
}

code_0FE833 {
    COP [96]
    COP [9D] ( #2C )
    COP [9E] ( &code_0FE78A )

  loc_0FE83C:
    BRA code_0FE7F2
}