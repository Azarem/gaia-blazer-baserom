?BANK 1F

---------------------------------------------

code_0FCA35 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FCA48, &code_0FCAAD, &code_0FCB12, &code_0FCB77 )
}

code_0FCA48 {
    LDA #$0005
    STA $002C, X

  loc_0FCA4E:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCA5E )

  code_0FCA57:
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FCA4E
}

code_0FCA5E {
    COP [9C] ( &code_0FCA64, &code_0FCA88 )
}

code_0FCA64 {
    COP [9A] ( #$0010, &code_0FCA6E, &code_0FCA79, &code_0FCA79 )
}

code_0FCA6E {
    COP [23] ( &code_0FCA57 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA79 {
    COP [24] ( &code_0FCA57 )
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [97]
    BRA loc_0FCAA8
}

code_0FCA88 {
    COP [9B] ( #$0010, &code_0FCA92, &code_0FCA9D, &code_0FCA9D )
}

code_0FCA92 {
    COP [21] ( &code_0FCA57 )
    COP [80] ( #13 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA9D {
    COP [22] ( &code_0FCA57 )
    COP [80] ( #12 )
    COP [82]
    BRA loc_0FCAA8

  loc_0FCAA8:
    DEC $002C, X
    BNE loc_0FCA4E
}

code_0FCAAD {
    LDA #$0005
    STA $002C, X

  loc_0FCAB3:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCAC3 )

  code_0FCABC:
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FCAB3
}

code_0FCAC3 {
    COP [9C] ( &code_0FCAC9, &code_0FCAED )
}

code_0FCAC9 {
    COP [9A] ( #$0010, &code_0FCAD3, &code_0FCADE, &code_0FCADE )
}

code_0FCAD3 {
    COP [23] ( &code_0FCABC )
    COP [80] ( #17 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCADE {
    COP [24] ( &code_0FCABC )
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    BRA loc_0FCB0D
}

code_0FCAED {
    COP [9B] ( #$0010, &code_0FCAF7, &code_0FCB02, &code_0FCB02 )
}

code_0FCAF7 {
    COP [21] ( &code_0FCABC )
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCB02 {
    COP [22] ( &code_0FCABC )
    COP [80] ( #15 )
    COP [82]
    BRA loc_0FCB0D

  loc_0FCB0D:
    DEC $002C, X
    BNE loc_0FCAB3
}

code_0FCB12 {
    LDA #$0005
    STA $002C, X

  loc_0FCB18:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB28 )

  code_0FCB21:
    COP [80] ( #31 )
    COP [82]
    BRA loc_0FCB18
}

code_0FCB28 {
    COP [9C] ( &code_0FCB2E, &code_0FCB52 )
}

code_0FCB2E {
    COP [9A] ( #$0010, &code_0FCB38, &code_0FCB43, &code_0FCB43 )
}

code_0FCB38 {
    COP [23] ( &code_0FCB21 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB43 {
    COP [24] ( &code_0FCB21 )
    COP [96]
    COP [80] ( #1A )
    COP [82]
    COP [97]
    BRA loc_0FCB72
}

code_0FCB52 {
    COP [9B] ( #$0010, &code_0FCB5C, &code_0FCB67, &code_0FCB67 )
}

code_0FCB5C {
    COP [21] ( &code_0FCB21 )
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB67 {
    COP [22] ( &code_0FCB21 )
    COP [80] ( #18 )
    COP [82]
    BRA loc_0FCB72

  loc_0FCB72:
    DEC $002C, X
    BNE loc_0FCB18
}

code_0FCB77 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB87 )
    COP [80] ( #32 )
    COP [82]
    BRA code_0FCB77
}

code_0FCB87 {
    COP [9C] ( &code_0FCB8D, &code_0FCBB1 )
}

code_0FCB8D {
    COP [9A] ( #$0010, &code_0FCB97, &code_0FCBA2, &code_0FCBA2 )
}

code_0FCB97 {
    COP [23] ( &code_0FCBD7 )
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBA2 {
    COP [24] ( &code_0FCBD7 )
    COP [96]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FCBD1
}

code_0FCBB1 {
    COP [9B] ( #$0010, &code_0FCBBB, &code_0FCBC6, &code_0FCBC6 )
}

code_0FCBBB {
    COP [21] ( &code_0FCBD7 )
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBC6 {
    COP [22] ( &code_0FCBD7 )
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FCBD1

  loc_0FCBD1:
    COP [1B] ( &code_0FCB77, #$0001 )
}

code_0FCBD7 {
    COP [80] ( #1E )
    COP [82]
    COP [86]
    RTL 
}