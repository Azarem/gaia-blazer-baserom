?BANK 1F

---------------------------------------------

code_0FEA1D {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FEA2A, &code_0FEA48, &code_0FEA48 )
}

code_0FEA2A {
    COP [97]
    COP [9B] ( #$0018, &code_0FEA36, &code_0FEAE9, &code_0FEA36 )
}

code_0FEA36 {
    COP [21] ( &code_0FEA41 )
    COP [80] ( #04 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA41 {
    COP [80] ( #01 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA48 {
    COP [97]
    COP [9B] ( #$0018, &code_0FEA54, &code_0FEB23, &code_0FEA54 )
}

code_0FEA54 {
    COP [22] ( &code_0FEA5F )
    COP [80] ( #03 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA5F {
    COP [80] ( #00 )
    COP [82]
    BRA code_0FEA1D

  loc_0FEA66:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FEA73, &code_0FEA91, &code_0FEA91 )
}

code_0FEA73 {
    COP [9A] ( #$0018, &code_0FEA7D, &code_0FEAAF, &code_0FEA7D )
}

code_0FEA7D {
    COP [97]
    COP [23] ( &code_0FEA8A )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEA8A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEA91 {
    COP [9A] ( #$0018, &code_0FEA9B, &code_0FEAAF, &code_0FEA9B )
}

code_0FEA9B {
    COP [96]
    COP [24] ( &code_0FEAA8 )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEAA8 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEAAF {
    COP [9B] ( #$0000, &code_0FEAB9, &code_0FEAD1, &code_0FEAD1 )
}

code_0FEAB9 {
    COP [80] ( #0E )
    COP [82]
    COP [B2] ( @code_0FEB7B, #$FFF8, #$FFE8, #$0200 )
    COP [80] ( #0F )
    COP [82]
    BRL code_0FEA1D
}

code_0FEAD1 {
    COP [80] ( #10 )
    COP [82]
    COP [B2] ( @code_0FEB88, #$FFF8, #$0008, #$0200 )
    COP [80] ( #11 )
    COP [82]
    BRL code_0FEA1D
}

code_0FEAE9 {
    COP [9A] ( #$0000, &code_0FEAF3, &code_0FEB0B, &code_0FEB0B )
}

code_0FEAF3 {
    COP [80] ( #0C )
    COP [82]
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #0D )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB0B {
    COP [80] ( #0A )
    COP [82]
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #0B )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB23 {
    COP [9A] ( #$0000, &code_0FEB2D, &code_0FEB45, &code_0FEB45 )
}

code_0FEB2D {
    COP [80] ( #06 )
    COP [82]
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #07 )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB45 {
    COP [80] ( #08 )
    COP [82]
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #09 )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB5D {
    COP [A3]
    COP [97]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB6C {
    COP [A3]
    COP [96]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB7B {
    COP [A3]
    BRK #$52
    COP [81] ( #13, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB88 {
    COP [A3]
    BRK #$52
    COP [81] ( #12, #08 )
    COP [83]
    COP [86]
    RTL 
}