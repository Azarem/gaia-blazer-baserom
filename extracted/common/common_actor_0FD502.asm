?BANK 1F

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