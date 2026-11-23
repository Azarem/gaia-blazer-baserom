?BANK 1F

---------------------------------------------

code_0FD275 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FD316, &code_0FD2EA, &code_0FD288, &code_0FD2BC )
}

code_0FD288 {
    COP [21] ( &code_0FD29C )
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FD2D2
}

code_0FD29C {
    COP [24] ( &code_0FD2AC )

  loc_0FD2A0:
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [97]
    BRA code_0FD288
}

code_0FD2AC {
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #00 )
    COP [82]
    BRA code_0FD316
}

code_0FD2BC {
    COP [23] ( &code_0FD2CE )
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FD300
}

code_0FD2CE {
    COP [21] ( &code_0FD2DA )

  loc_0FD2D2:
    COP [81] ( #04, #02 )
    COP [83]
    BRA code_0FD2BC
}

code_0FD2DA {
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD288
}

code_0FD2EA {
    COP [22] ( &code_0FD2FC )
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FD32F
}

code_0FD2FC {
    COP [23] ( &code_0FD308 )

  loc_0FD300:
    COP [81] ( #05, #02 )
    COP [83]
    BRA code_0FD2EA
}

code_0FD308 {
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRA code_0FD2BC
}

code_0FD316 {
    COP [24] ( &code_0FD32B )
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRL loc_0FD2A0
}

code_0FD32B {
    COP [22] ( &code_0FD337 )

  loc_0FD32F:
    COP [81] ( #03, #02 )
    COP [83]
    BRA code_0FD316
}

code_0FD337 {
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD2EA
}
---------------------------------------------

code_0FD345 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  code_0FD34E:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD35C

  code_0FD356:
    COP [1B] ( &code_0FD34E, #$0004 )

  loc_0FD35C:
    COP [9A] ( #$0010, &code_0FD366, &code_0FD370, &code_0FD366 )
}

code_0FD366 {
    COP [9B] ( #$0010, &code_0FD356, &code_0FD37A, &code_0FD356 )
}

code_0FD370 {
    COP [9B] ( #$0000, &code_0FD3C2, &code_0FD3E2, &code_0FD3E2 )
}

code_0FD37A {
    COP [9A] ( #$0000, &code_0FD384, &code_0FD3A3, &code_0FD3A3 )
}

code_0FD384 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3A3 {
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3C2 {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0B, #04 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0C, #10 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    BRL code_0FD34E
}

code_0FD3E2 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    BRL code_0FD34E
}
---------------------------------------------

code_0FD402 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  loc_0FD40B:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD414, &code_0FD41E )
}

code_0FD414 {
    COP [9A] ( #$0000, &code_0FD428, &code_0FD440, &code_0FD440 )
}

code_0FD41E {
    COP [9B] ( #$0000, &code_0FD458, &code_0FD470, &code_0FD470 )
}

code_0FD428 {
    COP [97]

  code_0FD42A:
    COP [81] ( #18, #02 )
    COP [83]
    COP [28] ( &code_0FD436 )
    BRA loc_0FD488
}

code_0FD436 {
    COP [9A] ( #$0008, &code_0FD42A, &code_0FD41E, &code_0FD440 )
}

code_0FD440 {
    COP [97]

  code_0FD442:
    COP [81] ( #19, #02 )
    COP [83]
    COP [28] ( &code_0FD44E )
    BRA loc_0FD488
}

code_0FD44E {
    COP [9A] ( #$0008, &code_0FD428, &code_0FD41E, &code_0FD442 )
}

code_0FD458 {
    COP [97]

  code_0FD45A:
    COP [81] ( #17, #02 )
    COP [83]
    COP [28] ( &code_0FD466 )
    BRA loc_0FD488
}

code_0FD466 {
    COP [9B] ( #$0008, &code_0FD45A, &code_0FD414, &code_0FD470 )
}

code_0FD470 {
    COP [97]

  code_0FD472:
    COP [81] ( #16, #02 )
    COP [83]
    COP [28] ( &code_0FD47E )
    BRA loc_0FD488
}

code_0FD47E {
    COP [9B] ( #$0008, &code_0FD458, &code_0FD414, &code_0FD472 )

  loc_0FD488:
    COP [80] ( #15 )
    COP [82]

  loc_0FD48D:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD496, &code_0FD4A0 )
}

code_0FD496 {
    COP [9A] ( #$0000, &code_0FD4AA, &code_0FD4C0, &code_0FD4C0 )
}

code_0FD4A0 {
    COP [9B] ( #$0000, &code_0FD4D6, &code_0FD4EC, &code_0FD4EC )
}

code_0FD4AA {
    COP [97]
    COP [23] ( &code_0FD4B8 )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4B8 {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4C0 {
    COP [96]
    COP [24] ( &code_0FD4CE )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4CE {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4D6 {
    COP [97]
    COP [21] ( &code_0FD4E4 )
    COP [81] ( #13, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4E4 {
    COP [80] ( #10 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4EC {
    COP [97]
    COP [22] ( &code_0FD4FA )
    COP [81] ( #12, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4FA {
    COP [80] ( #0F )
    COP [82]
    BRL loc_0FD40B
}
---------------------------------------------

code_0FD502 {
    COP [A5] ( &code_0FD673, &code_0FD583, &code_0FD50C, &code_0FD5FA )
}

code_0FD50C {
    COP [97]
    COP [80] ( #1B )
    COP [82]

  loc_0FD513:
    COP [AD] ( #08 )
    COP [9A] ( #$0020, &code_0FD520, &code_0FD52B, &code_0FD520 )
}

code_0FD520 {
    COP [23] ( &code_0FD583 )
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FD513
}

code_0FD52B {
    COP [9B] ( #$0000, &code_0FD535, &code_0FD558, &code_0FD558 )
}

code_0FD535 {
    COP [AE] ( #$0000, #$FFD0, &code_0FD520 )
    COP [AE] ( #$0000, #$FFF0, &code_0FD547 )
    BRA code_0FD520
}

code_0FD547 {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FD579
}

code_0FD558 {
    COP [AE] ( #$0000, #$0030, &code_0FD520 )
    COP [AE] ( #$0000, #$0010, &code_0FD56A )
    BRA code_0FD520
}

code_0FD56A {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    COP [80] ( #21 )
    COP [82]

  loc_0FD579:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 )
}

code_0FD583 {
    COP [96]
    COP [80] ( #1B )
    COP [82]

  loc_0FD58A:
    COP [AD] ( #08 )
    COP [9A] ( #$0020, &code_0FD597, &code_0FD5A2, &code_0FD597 )
}

code_0FD597 {
    COP [24] ( &code_0FD50C )
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FD58A
}

code_0FD5A2 {
    COP [9B] ( #$0000, &code_0FD5AC, &code_0FD5CF, &code_0FD5CF )
}

code_0FD5AC {
    COP [AE] ( #$0000, #$FFD0, &code_0FD597 )
    COP [AE] ( #$0000, #$FFF0, &code_0FD5BE )
    BRA code_0FD597
}

code_0FD5BE {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FD5F0
}

code_0FD5CF {
    COP [AE] ( #$0000, #$0030, &code_0FD597 )
    COP [AE] ( #$0000, #$0010, &code_0FD5E1 )
    BRA code_0FD597
}

code_0FD5E1 {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    COP [80] ( #21 )
    COP [82]

  loc_0FD5F0:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 )
}

code_0FD5FA {
    COP [97]
    COP [80] ( #1A )
    COP [82]

  loc_0FD601:
    COP [AD] ( #08 )
    COP [9B] ( #$0020, &code_0FD60E, &code_0FD619, &code_0FD60E )
}

code_0FD60E {
    COP [21] ( &code_0FD673 )
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FD601
}

code_0FD619 {
    COP [9A] ( #$0000, &code_0FD623, &code_0FD646, &code_0FD646 )
}

code_0FD623 {
    COP [AE] ( #$FFD0, #$0000, &code_0FD60E )
    COP [AE] ( #$FFF0, #$0000, &code_0FD635 )
    BRA code_0FD60E
}

code_0FD635 {
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FD669
}

code_0FD646 {
    COP [AE] ( #$0030, #$0000, &code_0FD60E )
    COP [AE] ( #$0010, #$0000, &code_0FD658 )
    BRA code_0FD60E
}

code_0FD658 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FD669:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 )
}

code_0FD673 {
    COP [97]
    COP [80] ( #1A )
    COP [82]

  loc_0FD67A:
    COP [AD] ( #08 )
    COP [9B] ( #$0020, &code_0FD687, &code_0FD692, &code_0FD687 )
}

code_0FD687 {
    COP [22] ( &code_0FD5FA )
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FD67A
}

code_0FD692 {
    COP [9A] ( #$0000, &code_0FD69C, &code_0FD6BF, &code_0FD6BF )
}

code_0FD69C {
    COP [AE] ( #$FFD0, #$0000, &code_0FD687 )
    COP [AE] ( #$FFF0, #$0000, &code_0FD6AE )
    BRA code_0FD687
}

code_0FD6AE {
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FD6E2
}

code_0FD6BF {
    COP [AE] ( #$0030, #$0000, &code_0FD687 )
    COP [AE] ( #$0010, #$0000, &code_0FD6D1 )
    BRA code_0FD687
}

code_0FD6D1 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FD6E2:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 )
}
---------------------------------------------

code_0FD6EC {
    COP [A5] ( &code_0FD6F6, &code_0FD6FC, &code_0FD724, &code_0FD72A )
}

code_0FD6F6 {
    COP [9F] ( #$FFF0 )
    BRA loc_0FD711
}

code_0FD6FC {
    COP [9F] ( #$0010 )

  loc_0FD700:
    LDA $0016, X
    ORA #$0100
    STA $0016, X
    COP [A2] ( #20 )
    COP [80] ( #25 )
    COP [82]

  loc_0FD711:
    LDA $0016, X
    AND #$FEFF
    STA $0016, X
    COP [A2] ( #30 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD700
}

code_0FD724 {
    COP [A0] ( #$FFF8 )
    BRA loc_0FD73F
}

code_0FD72A {
    COP [A0] ( #$0018 )

  loc_0FD72E:
    LDA $0016, X
    ORA #$0100
    STA $0016, X
    COP [A2] ( #20 )
    COP [80] ( #27 )
    COP [82]

  loc_0FD73F:
    LDA $0016, X
    AND #$FEFF
    STA $0016, X
    COP [A2] ( #30 )
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD72E
}
---------------------------------------------

code_0FD752 {
    COP [A5] ( &code_0FD75C, &code_0FD81C, &code_0FD7DC, &code_0FD79C )
}

code_0FD75C {
    JSR $&code_0FD85C
    COP [24] ( &code_0FD76B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD76B {
    COP [1B] ( &code_0FD771, #$0000 )
}

code_0FD771 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7CD )
    COP [81] ( #2C, #04 )
    COP [83]

  loc_0FD77E:
    JSR $&code_0FD85C
    COP [23] ( &code_0FD78D )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA loc_0FD77E
}

code_0FD78D {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7AB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD79C {
    JSR $&code_0FD85C
    COP [23] ( &code_0FD7AB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7AB {
    COP [1B] ( &code_0FD7B1, #$0000 )
}

code_0FD7B1 {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD78D )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FD7BE:
    JSR $&code_0FD85C
    COP [24] ( &code_0FD7CD )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA loc_0FD7BE
}

code_0FD7CD {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD76B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7DC {
    JSR $&code_0FD85C
    COP [22] ( &code_0FD7EB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD7EB {
    COP [1B] ( &code_0FD7F1, #$0000 )
}

code_0FD7F1 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD84D )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FD7FE:
    JSR $&code_0FD85C
    COP [21] ( &code_0FD80D )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA loc_0FD7FE
}

code_0FD80D {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD82B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD81C {
    JSR $&code_0FD85C
    COP [21] ( &code_0FD82B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD81C
}

code_0FD82B {
    COP [1B] ( &code_0FD831, #$0000 )
}

code_0FD831 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD80D )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FD83E:
    JSR $&code_0FD85C
    COP [22] ( &code_0FD84D )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA loc_0FD83E
}

code_0FD84D {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD7EB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD81C
}

code_0FD85C {
    COP [0C] ( #00, #02, &code_0FD863 )
    RTS 
}

code_0FD863 {
    PLA 
    STA $0030, X
    COP [80] ( #30 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$56
    COP [B2] ( @code_0FD8E8, #$0000, #$0008, #$0200 )
    COP [B2] ( @code_0FD8FE, #$0010, #$FFF8, #$0200 )
    COP [B2] ( @code_0FD916, #$0000, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD92A, #$FFF0, #$FFF8, #$0200 )
    COP [1B] ( &code_0FD8A9, #$0001 )
}

code_0FD8A9 {
    COP [B2] ( @code_0FD8F2, #$0010, #$0008, #$0200 )
    COP [B2] ( @code_0FD90A, #$0010, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD920, #$FFF0, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD934, #$FFF0, #$0008, #$0200 )
    COP [80] ( #31 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    LDA $0030, X
    PHA 
    RTS 
}

code_0FD8E8 {
    COP [A3]
    COP [81] ( #32, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD8F2 {
    COP [A3]
    COP [96]
    COP [81] ( #35, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD8FE {
    COP [A3]
    COP [96]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD90A {
    COP [A3]
    COP [96]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD916 {
    COP [A3]
    COP [81] ( #33, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD920 {
    COP [A3]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD92A {
    COP [A3]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD934 {
    COP [A3]
    COP [81] ( #35, #03 )
    COP [83]

  loc_0FD93C:
    COP [80] ( #37 )
    COP [82]
    COP [86]
    RTL 
}