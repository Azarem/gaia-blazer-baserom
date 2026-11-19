?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_0F8F45 {
    COP [14] ( #$00C1, &code_0F8F4C ) ; {1019717}
    RTL                   ; {1019723}
}

code_0F8F4C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1019724}

  loc_0F8F51:
    COP [17] ( &code_0F9041 ) ; {1019729}
    COP [15]              ; {1019733}

  code_0F8F57:
    COP [80] ( #10 )      ; {1019735}
    COP [82]              ; {1019738}
    COP [07] ( #$0000, &code_0F8F57 ) ; {1019740}

  loc_0F8F62:
    COP [0D] ( #00, #03, #31, &code_0F8F71 ) ; {1019746}
    COP [80] ( #10 )      ; {1019753}
    COP [82]              ; {1019756}
    BRL loc_0F8F62        ; {1019758}
}

code_0F8F71 {
    COP [16]              ; {1019761}
    COP [17] ( #$0000 )   ; {1019763}
    COP [85] ( @code_0F8FAB ) ; {1019767}
    COP [81] ( #0D, #1B ) ; {1019772}
    COP [83]              ; {1019776}
    COP [17] ( &code_0F9041 ) ; {1019778}
    COP [15]              ; {1019782}

  loc_0F8F88:
    COP [0D] ( #00, #03, #19, &code_0F8F97 ) ; {1019784}
    COP [80] ( #0F )      ; {1019791}
    COP [82]              ; {1019794}
    BRL loc_0F8F88        ; {1019796}
}

code_0F8F97 {
    COP [16]              ; {1019799}
    COP [17] ( #$0000 )   ; {1019801}
    COP [85] ( @code_0F8FF6 ) ; {1019805}
    COP [81] ( #0C, #1B ) ; {1019810}
    COP [83]              ; {1019814}
    BRL loc_0F8F51        ; {1019816}
}

code_0F8FAB {
    LDA #$2F80            ; {1019819}
    TSB $joy_block_mask   ; {1019822}
    LDA #$01B0            ; {1019825}
    STA $0025, X          ; {1019828}
    LDY $player_actor     ; {1019831}
    LDA $0016, Y          ; {1019834}
    AND #$EFFF            ; {1019837}
    STA $0016, Y          ; {1019840}
    COP [91]              ; {1019843}
    LDY $003C, X          ; {1019845}
    LDA $0002, Y          ; {1019848}
    SEC                   ; {1019851}
    SBC #$0020            ; {1019852}
    LDY $player_actor     ; {1019855}
    STA $0002, Y          ; {1019858}
    LDA #$FFFF            ; {1019861}
    STA $0006, Y          ; {1019864}
    DEC $0025, X          ; {1019867}
    BEQ loc_0F8FE1        ; {1019870}
    RTL                   ; {1019872}

  loc_0F8FE1:
    LDY $player_actor     ; {1019873}
    LDA $0016, Y          ; {1019876}
    ORA #$1000            ; {1019879}
    STA $0016, Y          ; {1019882}
    LDA #$2F80            ; {1019885}
    TRB $joy_block_mask   ; {1019888}
    COP [86]              ; {1019891}
    RTL                   ; {1019893}
}

code_0F8FF6 {
    LDA #$2F80            ; {1019894}
    TSB $joy_block_mask   ; {1019897}
    LDA #$01B0            ; {1019900}
    STA $0025, X          ; {1019903}
    LDY $player_actor     ; {1019906}
    LDA $0016, Y          ; {1019909}
    AND #$EFFF            ; {1019912}
    STA $0016, Y          ; {1019915}
    COP [91]              ; {1019918}
    LDY $003C, X          ; {1019920}
    LDA $0002, Y          ; {1019923}
    CLC                   ; {1019926}
    ADC #$0010            ; {1019927}
    LDY $player_actor     ; {1019930}
    STA $0002, Y          ; {1019933}
    LDA #$0001            ; {1019936}
    STA $0006, Y          ; {1019939}
    DEC $0025, X          ; {1019942}
    BEQ loc_0F902C        ; {1019945}
    RTL                   ; {1019947}

  loc_0F902C:
    LDY $player_actor     ; {1019948}
    LDA $0016, Y          ; {1019951}
    ORA #$1000            ; {1019954}
    STA $0016, Y          ; {1019957}
    LDA #$2F80            ; {1019960}
    TRB $joy_block_mask   ; {1019963}
    COP [86]              ; {1019966}
    RTL                   ; {1019968}
}

code_0F9041 {
    COP [01] ( &asciistring_0F904A ) ; {1019969}
    COP [09] ( #$8000 )   ; {1019973}
    RTL                   ; {1019977}
}

asciistring_0F904A |[10]Stand on my nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|