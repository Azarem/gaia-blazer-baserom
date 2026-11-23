?BANK 00

?INCLUDE 'engine_003005'

!player_y                       0376
!boss_actor                     039A
!exit_list_ofs                  03B2
!boss_fight_active              0458

---------------------------------------------

code_0031AD {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    COP [85] ( @engine_003005.RunBossMapPatch )
    LDA #$0000
    STA $0030, Y

  loc_0031C1:
    COP [80] ( #00 )
    COP [82]

  loc_0031C6:
    LDA $player_y
    CMP #$0070
    BCS loc_0031D1
    BRL loc_0032B2

  loc_0031D1:
    COP [9F] ( #$0010 )
    COP [9A] ( #$0010, &code_003210, &code_0031DF, &code_003210 )
}

code_0031DF {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0E )
    COP [82]
    COP [B2] ( @code_003348, #$0008, #$FFE8, #$0200 )
    COP [B2] ( @code_003359, #$0008, #$FFE8, #$0200 )
    COP [B2] ( @code_003367, #$0008, #$FFE8, #$0200 )
    COP [80] ( #16 )
    COP [82]
    BRA loc_0031C1
}

code_003210 {
    COP [9A] ( #$0050, &code_00321A, &code_003290, &code_00321A )
}

code_00321A {
    COP [9A] ( #$0070, &code_003290, &code_003224, &code_003290 )
}

code_003224 {
    COP [9A] ( #$0000, &code_00322E, &code_00325F, &code_00325F )
}

code_00322E {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_00337F, #$FFFC, #$FFE6, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_00337F, #$FFFC, #$FFE6, #$0200 )
    COP [80] ( #17 )
    COP [82]
    BRL loc_0031C6
}

code_00325F {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0F )
    COP [82]
    COP [B2] ( @code_003394, #$0014, #$FFE6, #$0200 )
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    COP [B2] ( @code_003394, #$0014, #$FFE6, #$0200 )
    COP [80] ( #18 )
    COP [82]
    BRL loc_0031C6
}

code_003290 {
    COP [9A] ( #$0000, &code_00329A, &code_0032A6, &code_0032A6 )
}

code_00329A {
    COP [9F] ( #$FFF0 )
    COP [80] ( #07 )
    COP [82]
    BRL loc_0031C6
}

code_0032A6 {
    COP [9F] ( #$FFF0 )
    COP [80] ( #05 )
    COP [82]
    BRL loc_0031C6

  loc_0032B2:
    COP [9F] ( #$0010 )
    COP [9A] ( #$0040, &code_003330, &code_0032C0, &code_00333C )
}

code_0032C0 {
    COP [9A] ( #$0000, &code_0032CA, &code_0032FD, &code_0032FD )
}

code_0032CA {
    COP [9F] ( #$FFF0 )
    LDA $0016, X
    ORA #$0002
    STA $0016, X
    COP [85] ( @code_0033B9 )
    COP [80] ( #09 )
    COP [82]
    COP [B2] ( @code_0033A9, #$FFD8, #$FFE8, #$0200 )
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FFFD
    STA $0016, X
    BRL loc_0031C6
}

code_0032FD {
    COP [9F] ( #$FFF0 )
    LDA $0016, X
    ORA #$0002
    STA $0016, X
    COP [85] ( @code_0033B9 )
    COP [80] ( #0B )
    COP [82]
    COP [B2] ( @code_0033B1, #$0028, #$FFE8, #$0200 )
    COP [80] ( #0C )
    COP [82]
    LDA $0016, X
    AND #$FFFD
    STA $0016, X
    BRL loc_0031C6
}

code_003330 {
    COP [9F] ( #$FFF0 )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0031C6
}

code_00333C {
    COP [9F] ( #$FFF0 )
    COP [80] ( #06 )
    COP [82]
    BRL loc_0031C6
}

code_003348 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    BRA loc_003376
}

code_003359 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #10 )
    COP [82]
    BRA loc_003376
}

code_003367 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #1C )
    COP [82]

  loc_003376:
    COP [81] ( #13, #0C )
    COP [83]
    COP [86]
    RTL 
}

code_00337F {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #11 )
    COP [82]
    COP [81] ( #14, #0C )
    COP [83]
    COP [86]
    RTL 
}

code_003394 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #12 )
    COP [82]
    COP [81] ( #15, #0C )
    COP [83]
    COP [86]
    RTL 
}

code_0033A9 {
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

code_0033B1 {
    COP [80] ( #1A )
    COP [82]
    COP [86]
    RTL 
}

code_0033B9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4E )
    COP [94]
    COP [86]
    RTL 
}