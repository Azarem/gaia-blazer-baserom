?BANK 00

?INCLUDE 'engine_004281'

---------------------------------------------

code_004102 {
    COP [14] ( #$00B6, &code_00419D )

  loc_004108:
    COP [AD] ( #08 )
    COP [0C] ( #00, #03, &code_004118 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_004108
}

code_004118 {
    BRK #$A1
    COP [B0] ( @engine_004281.code_004281, #$0200 )
    COP [B0] ( @engine_004281.code_004289, #$0200 )
    COP [B0] ( @engine_004281.code_004291, #$0200 )
    STZ $0016, X
    COP [80] ( #0B )
    COP [82]

  loc_004137:
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_004147 )

  code_004140:
    COP [80] ( #2A )
    COP [82]
    BRA loc_004137
}

code_004147 {
    COP [9C] ( &code_00414D, &code_004175 )
}

code_00414D {
    COP [9A] ( #$0010, &code_004157, &code_004166, &code_004166 )
}

code_004157 {
    COP [23] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004166 {
    COP [24] ( &code_004140 )
    COP [96]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004175 {
    COP [9B] ( #$0010, &code_00417F, &code_00418E, &code_00418E )
}

code_00417F {
    COP [21] ( &code_004140 )
    COP [97]
    COP [98]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00418E {
    COP [22] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00419D {
    COP [86]
    RTL 
}