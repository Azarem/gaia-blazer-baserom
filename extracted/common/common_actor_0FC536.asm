?BANK 1F

---------------------------------------------

code_0FC536 {
    COP [A3]
    COP [A2] ( #30 )

  code_0FC53B:
    COP [0C] ( #00, #10, &code_0FC547 )
    COP [1B] ( &code_0FC53B, #$0010 )
}

code_0FC547 {
    COP [9A] ( #$0018, &code_0FC551, &code_0FC619, &code_0FC55B )
}

code_0FC551 {
    COP [9B] ( #$0018, &code_0FC5BF, &code_0FC6AA, &code_0FC5EC )
}

code_0FC55B {
    COP [9B] ( #$0018, &code_0FC565, &code_0FC67D, &code_0FC592 )
}

code_0FC565 {
    COP [96]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC575 )
    BRA loc_0FC589
}

code_0FC575 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC589:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC592 {
    COP [96]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5A2 )
    BRA loc_0FC5B6
}

code_0FC5A2 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5B6:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5BF {
    COP [97]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5CF )
    BRA loc_0FC5E3
}

code_0FC5CF {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5E3:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5EC {
    COP [97]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5FC )
    BRA loc_0FC610
}

code_0FC5FC {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC610:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC619 {
    COP [9B] ( #$0000, &code_0FC650, &code_0FC650, &code_0FC623 )
}

code_0FC623 {
    COP [97]
    COP [81] ( #21, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC633 )
    BRA loc_0FC647
}

code_0FC633 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC647:
    COP [81] ( #21, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC650 {
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC660 )
    BRA loc_0FC674
}

code_0FC660 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC674:
    COP [81] ( #22, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC67D {
    COP [96]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC68D )
    BRA loc_0FC6A1
}

code_0FC68D {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6A1:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC6AA {
    COP [97]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC6BA )
    BRA loc_0FC6CE
}

code_0FC6BA {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @code_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6CE:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC6D7 {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$001C )
    BRK #$56
    COP [80] ( #29 )
    COP [82]
    COP [9A] ( #$0000, &code_0FC6F2, &code_0FC6FC, &code_0FC6FC )
}

code_0FC6F2 {
    COP [9B] ( #$0000, &code_0FC706, &code_0FC710, &code_0FC710 )
}

code_0FC6FC {
    COP [9B] ( #$0000, &code_0FC71A, &code_0FC724, &code_0FC724 )
}

code_0FC706 {
    COP [97]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC710 {
    COP [97]
    COP [81] ( #2A, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC71A {
    COP [96]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC724 {
    COP [96]
    COP [81] ( #2A, #08 )
    COP [83]

  loc_0FC72C:
    COP [86]
    RTL 
}