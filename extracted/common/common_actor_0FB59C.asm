?BANK 1F

---------------------------------------------

code_0FB59C {
    LDA $001A, X
    ORA #$0200
    STA $001A, X

  loc_0FB5A5:
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2A )
    COP [82]
    COP [04]
    BRA loc_0FB5A5
}