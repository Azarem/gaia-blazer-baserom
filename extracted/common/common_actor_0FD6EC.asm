?BANK 1F

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