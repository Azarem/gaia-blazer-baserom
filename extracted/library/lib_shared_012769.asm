?BANK 02

?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_014789'
?INCLUDE 'string_lookup_080000'

!frame_counter                  0312
!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012769 {
    PHP 
    PHB 
    SEP #$20
    LDA #$02
    PHA 
    PLB 
    LDA $03F9
    PHA 
    LDA $03E9
    PHA 
    LDA #$20
    STA $03E9
    STZ $03F9
    PHX 

  loc_012782:
    JSR $&code_0129DA
    CMP #$14
    BNE loc_01278C
    BRL loc_012814

  loc_01278C:
    CMP #$13
    BEQ loc_012809
    CMP #$0D
    BNE loc_012797
    BRL loc_0129BB

  loc_012797:
    BCS loc_0127E4
    CMP #$00
    BNE loc_0127A0
    BRL loc_0129C9

  loc_0127A0:
    DEC 
    BNE loc_0127A6
    BRL loc_0129AA

  loc_0127A6:
    DEC 
    BNE loc_0127AC
    BRL loc_01298D

  loc_0127AC:
    DEC 
    BNE loc_0127B2
    BRL loc_01297E

  loc_0127B2:
    DEC 
    BNE loc_0127B8
    BRL loc_01295A

  loc_0127B8:
    DEC 
    BNE loc_0127BE
    BRL loc_012931

  loc_0127BE:
    DEC 
    BNE loc_0127C4
    BRL loc_0128A2

  loc_0127C4:
    DEC 
    BNE loc_0127CA
    BRL loc_012882

  loc_0127CA:
    DEC 
    BNE loc_0127D0
    BRL loc_012870

  loc_0127D0:
    DEC 
    BNE loc_0127D6
    BRL loc_012865

  loc_0127D6:
    DEC 
    BNE loc_0127DC
    BRL loc_01285A

  loc_0127DC:
    DEC 
    BNE loc_0127E2
    BRL loc_012829

  loc_0127E2:
    BRA loc_012782

  loc_0127E4:
    ORA $03F9
    STA $bg3_tilemap_buffer, X
    XBA 
    LDA $03E9
    STA $7F7001, X
    INX 
    INX 
    BIT #$02
    BEQ loc_0127FC
    BRL loc_012782

  loc_0127FC:
    INC 
    STA $7F6FBF, X
    XBA 
    STA $7F6FBE, X
    BRL loc_012782

  loc_012809:
    LDA $0001, Y
    XBA 
    LDA $0000, Y
    TAY 
    BRL loc_012782

  loc_012814:
    LDA #$20
    XBA 
    LDA $0000, Y
    INY 

  loc_01281B:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_01281B
    BRL loc_012782

  loc_012829:
    LDA $0000, Y
    INY 
    STA $00
    REP #$20
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    AND #$00FF
    SEP #$20
    TAY 
    BEQ loc_012856
    LDA $03E9
    XBA 
    LDA $00
    REP #$20

  loc_01284B:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEY 
    BNE loc_01284B
    SEP #$20

  loc_012856:
    PLY 
    BRL loc_012782

  loc_01285A:
    LDA $03F9
    EOR #$80
    STA $03F9
    BRL loc_012782

  loc_012865:
    LDA $03E9
    EOR #$02
    STA $03E9
    BRL loc_012782

  loc_012870:
    PHX 
    REP #$20
    LDX $0000, Y
    INY 
    INY 
    SEP #$20
    JSL $@code_012BDA
    PLX 
    BRL loc_012782

  loc_012882:
    LDA $0000, Y
    INY 
    STA $00
    LDA $0000, Y
    INY 
    STA $02
    STX $03F7
    JSR $&code_012B5D
    REP #$20
    PLA 
    CLC 
    ADC #$0082
    TAX 
    PHX 
    SEP #$20
    BRL loc_012782

  loc_0128A2:
    LDA $0000, Y
    INY 
    STA $00
    STA $02
    REP #$20
    DEC 
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    TAX 
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    SEP #$20
    LDA $03E9
    XBA 

  loc_0128C5:
    LDA $0000, Y
    AND #$0F
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BEQ loc_0128F4
    LDA $0000, Y
    INY 
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BNE loc_0128C5

  loc_0128F4:
    INX 
    INX 
    DEC $02
    BEQ loc_01290A
    LDA $bg3_tilemap_buffer, X
    CMP #$30
    BNE loc_01290A
    LDA #$20
    STA $bg3_tilemap_buffer, X
    BRA loc_0128F4

  loc_01290A:
    XBA 
    BIT #$02
    BNE loc_01292A
    XBA 
    INC $02

  loc_012912:
    LDA $bg3_tilemap_buffer, X
    REP #$20
    ORA #$0100
    STA $7F6FC0, X
    AND #$FEFF
    SEP #$20
    INX 
    INX 
    DEC $02
    BNE loc_012912

  loc_01292A:
    PLY 
    PLX 
    INX 
    INX 
    BRL loc_012782

  loc_012931:
    REP #$20
    LDA $0000, Y
    INY 
    INY 
    STA $00
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    ASL 
    CLC 
    ADC $00
    TAY 
    LDA $0000, Y
    TAY 
    SEP #$20
    LDA $03E9
    XBA 
    JSR $&code_012A48
    PLY 
    BRL loc_012782

  loc_01295A:
    REP #$20
    PHY 
    LDA $0000, Y
    TAY 
    LDA $0000, Y
    STA $00
    PLY 
    PHY 
    LDA $0002, Y
    TAY 
    LDA $0000, Y
    STA $02
    SEP #$20
    JSR $&code_012ABF
    PLY 
    INY 
    INY 
    INY 
    INY 
    BRL loc_012782

  loc_01297E:
    LDA $03E9
    AND #$E3
    ORA $0000, Y
    INY 
    STA $03E9
    BRL loc_012782

  loc_01298D:
    LDA $0000, Y
    INY 
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAY 
    LDA $&lib_shared_014789.binary_list_014789, Y
    TAY 
    SEP #$20
    LDA $03E9
    XBA 
    JSR $&code_012A92
    PLY 
    BRL loc_012782

  loc_0129AA:
    LDA $0001, Y
    STA $02, S
    XBA 
    LDA $0000, Y
    STA $01, S
    INY 
    INY 
    TAX 
    BRL loc_012782

  loc_0129BB:
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    PHA 
    SEP #$20
    BRL loc_012782

  loc_0129C9:
    PLX 
    PLA 
    STA $03E9
    PLA 
    STA $03F9
    LDA #$01
    TSB $vram_upload_flags
    PLB 
    PLP 
    RTL 
}

code_0129DA {
    LDA $0000, Y
    BMI loc_0129E1
    INY 
    RTS 

  loc_0129E1:
    INY 
    PHB 
    PHY 
    REP #$20
    AND #$007F
    PHA 
    ASL 
    CLC 
    ADC $01, S
    ASL 
    ASL 
    TAY 
    PLA 
    SEP #$20
    LDA #$^string_lookup_080000.lookup_080000
    PHA 
    PLB 
    LDA #$0C
    STA $0C
    LDA $03E9
    XBA 

  loc_012A00:
    LDA $&string_lookup_080000.lookup_080000, Y
    BEQ loc_012A26
    INY 
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012A20
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A20:
    SEP #$20
    DEC $0C
    BNE loc_012A00

  loc_012A26:
    LDA #$20
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012A42
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A42:
    SEP #$20
    PLY 
    PLB 
    BRA code_0129DA
}

code_012A48 {
    LDA $0000, Y
    BMI loc_012A73
    BNE loc_012A50
    RTS 

  loc_012A50:
    CMP #$14
    BEQ loc_012A79
    INY 
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012A6F
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A6F:
    SEP #$20
    BRA code_012A48

  loc_012A73:
    JSR $&code_0129DA
    DEY 
    BRA code_012A48

  loc_012A79:
    LDA #$20
    ORA $03F9
    XBA 
    INY 
    LDA $0000, Y
    INY 

  loc_012A84:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012A84
    BRL code_012A48
}

code_012A92 {
    LDA $0000, Y
    BMI loc_012AB9
    BNE loc_012A9A
    RTS 

  loc_012A9A:
    INY 
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012AB5
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012AB5:
    SEP #$20
    BRA code_012A92

  loc_012AB9:
    JSR $&code_0129DA
    DEY 
    BRA code_012A92
}

code_012ABF {
    PHX 
    LDX #$0000
    LDA $00

  loc_012AC5:
    SEC 
    SBC #$0A
    BMI loc_012ACE
    INX 
    INX 
    BRA loc_012AC5

  loc_012ACE:
    LDA $01, S
    CMP #$CC
    BNE loc_012AE6
    LDA $@data_00F9F7.word_00FB2F, X
    STA $7F0014
    LDA $@data_00F9F7.word_00FB2F+1, X
    STA $7F0015
    BRA loc_012AF6

  loc_012AE6:
    LDA $@data_00F9F7.word_00FB2F, X
    STA $7F001C
    LDA $@data_00F9F7.word_00FB2F+1, X
    STA $7F001D

  loc_012AF6:
    LDA $00
    CMP #$33
    BCC loc_012AFE
    LDA #$32

  loc_012AFE:
    STA $00
    LDA $02
    CMP #$33
    BCC loc_012B08
    LDA #$32

  loc_012B08:
    STA $02
    PLX 
    LDA $00
    LSR 
    BEQ loc_012B1F
    PHP 

  loc_012B11:
    XBA 
    LDA #$1B
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012B11
    PLP 

  loc_012B1F:
    BCS loc_012B28
    LDA $02
    SEC 
    SBC $00
    BRA loc_012B42

  loc_012B28:
    LDA #$1C
    STA $bg3_tilemap_buffer, X
    LDA $02
    SEC 
    SBC $00
    BEQ loc_012B5C
    XBA 
    LDA #$1D
    STA $bg3_tilemap_buffer, X
    XBA 
    INX 
    INX 
    DEC 
    BEQ loc_012B5C

  loc_012B42:
    LSR 
    BEQ loc_012B54
    PHP 

  loc_012B46:
    XBA 
    LDA #$1E
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012B46
    PLP 

  loc_012B54:
    BCC loc_012B5C
    LDA #$1F
    STA $bg3_tilemap_buffer, X

  loc_012B5C:
    RTS 
}

code_012B5D {
    PHX 
    LDA #$01
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0C
    LDA #$03

  loc_012B6A:
    STA $7F7002, X
    INX 
    INX 
    DEC $0C
    BNE loc_012B6A
    LDA #$02
    STA $7F7002, X
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    LDA $02
    STA $0C

  loc_012B88:
    PHX 
    LDA #$07
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0E
    STZ $0F
    LDA $03E9
    XBA 
    LDA #$20
    REP #$20

  loc_012B9D:
    STA $7F7002, X
    INX 
    INX 
    DEC $0E
    BNE loc_012B9D
    SEP #$20
    LDA #$08
    STA $7F7002, X
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    DEC $0C
    BNE loc_012B88
    LDA #$05
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0C
    LDA #$04

  loc_012BC9:
    STA $7F7002, X
    INX 
    INX 
    DEC $0C
    BNE loc_012BC9
    LDA #$06
    STA $7F7002, X
    RTS 
}

code_012BDA {
    PHY 
    LDA $bg3_tilemap_buffer, X
    CMP #$01
    BNE loc_012C25
    STZ $00
    STZ $01
    PHX 

  loc_012BE8:
    LDA $bg3_tilemap_buffer, X
    CMP #$02
    BEQ loc_012BF6
    INX 
    INX 
    INC $00
    BRA loc_012BE8

  loc_012BF6:
    PLX 

  loc_012BF7:
    REP #$20
    LDA $00
    STA $0C
    PHX 
    LDA #$2000

  loc_012C01:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_012C01
    LDA $bg3_tilemap_buffer, X
    TAY 
    LDA #$2000
    STA $bg3_tilemap_buffer, X
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    TYA 
    CMP #$06
    BNE loc_012BF7

  loc_012C25:
    PLY 
    RTL 
}

code_012C27 {
    PHP 
    PHB 
    SEP #$20
    LDA $01, S
    CMP #$01
    BNE loc_012C35
    LDA #$02
    PHA 
    PLB 

  loc_012C35:
    LDA #$20
    STA $03E9
    LDA #$01
    STA $03F5
    STZ $03F9
    LDA $0000, Y
    CMP #$01
    BEQ loc_012C6C
    CMP #$10
    BEQ loc_012C5C
    LDX $03F3
    PHX 
    LDA $1B84
    BEQ loc_012C59
    BRL loc_012F3B

  loc_012C59:
    BRL loc_012D6E

  loc_012C5C:
    INY 
    LDX #$0408
    PHX 
    LDA #$16
    STA $00
    LDA #$09
    STA $02
    BRL loc_012DDA

  loc_012C6C:
    PHX 

  loc_012C6D:
    JSR $&code_012F6E
    CMP #$0D
    BNE loc_012C77
    BRL loc_012F3B

  loc_012C77:
    CMP #$14
    BNE loc_012C7E
    BRL loc_012D53

  loc_012C7E:
    BCS loc_012CF7
    CMP #$00
    BNE loc_012C87
    BRL loc_012F5F

  loc_012C87:
    DEC 
    BNE loc_012C8D
    BRL loc_012F07

  loc_012C8D:
    DEC 
    BNE loc_012C93
    BRL loc_012EE0

  loc_012C93:
    DEC 
    BNE loc_012C99
    BRL loc_012ED1

  loc_012C99:
    DEC 
    BNE loc_012C9F
    BRL loc_012EAD

  loc_012C9F:
    DEC 
    BNE loc_012CA5
    BRL loc_012E7A

  loc_012CA5:
    DEC 
    BNE loc_012CAB
    BRL loc_012DEB

  loc_012CAB:
    DEC 
    BNE loc_012CB1
    BRL loc_012DCE

  loc_012CB1:
    DEC 
    BNE loc_012CB7
    BRL loc_012DBC

  loc_012CB7:
    DEC 
    BNE loc_012CBD
    BRL loc_012DB1

  loc_012CBD:
    DEC 
    BNE loc_012CC3
    BRL loc_012DA6

  loc_012CC3:
    DEC 
    BNE loc_012CC9
    BRL loc_012DA0

  loc_012CC9:
    DEC 
    BNE loc_012CCF
    BRL loc_012F62

  loc_012CCF:
    DEC 
    DEC 
    BNE loc_012CD6
    BRL loc_012D90

  loc_012CD6:
    DEC 
    BNE loc_012CDC
    BRL loc_012D85

  loc_012CDC:
    DEC 
    BNE loc_012CE2
    BRL loc_012D6E

  loc_012CE2:
    DEC 
    BNE loc_012CE8
    BRL loc_012F18

  loc_012CE8:
    DEC 
    BNE loc_012CEE
    BRL loc_012D68

  loc_012CEE:
    DEC 
    BNE loc_012CF4
    BRL loc_012D48

  loc_012CF4:
    BRL loc_012C6D

  loc_012CF7:
    ORA $03F9
    STA $bg3_tilemap_buffer, X
    XBA 
    LDA $03E9
    STA $7F7001, X
    INX 
    INX 
    BIT #$02
    BNE loc_012D18
    INC 
    STA $7F6FBF, X
    XBA 
    STA $7F6FBE, X
    BRA loc_012D42

  loc_012D18:
    LDA $7F6FBE, X
    CMP #$FE
    BCC loc_012D26
    LDA #$20
    STA $7F6FBE, X

  loc_012D26:
    XBA 
    CMP #$F4
    BCS loc_012D33
    CMP #$CC
    BCC loc_012D42
    LDA #$FE
    BRA loc_012D35

  loc_012D33:
    LDA #$FF

  loc_012D35:
    STA $7F6FBE, X
    XBA 
    LDA $03E9
    STA $7F6FBF, X
    XBA 

  loc_012D42:
    JSR $&code_013124
    BRL loc_012C6D

  loc_012D48:
    LDA $0001, Y
    XBA 
    LDA $0000, Y
    TAY 
    BRL loc_012C6D

  loc_012D53:
    LDA #$20
    XBA 
    LDA $0000, Y
    INY 

  loc_012D5A:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012D5A
    BRL loc_012C6D

  loc_012D68:
    JSR $&code_01314A
    BRL loc_012C6D

  loc_012D6E:
    PLX 
    JSR $&code_0130CA
    JSR $&code_01300F
    REP #$20
    LDA $03EB
    CLC 
    ADC #$0040
    TAX 
    PHX 
    SEP #$20
    BRL loc_012C6D

  loc_012D85:
    LDA $03F5
    EOR #$01
    STA $03F5
    BRL loc_012C6D

  loc_012D90:
    LDA $1B84
    BEQ loc_012D9C
    LDA $0000, Y
    JSL $@code_013140

  loc_012D9C:
    INY 
    BRL loc_012C6D

  loc_012DA0:
    INY 
    INY 
    INY 
    BRL loc_012C6D

  loc_012DA6:
    LDA $03F9
    EOR #$80
    STA $03F9
    BRL loc_012C6D

  loc_012DB1:
    LDA $03E9
    EOR #$02
    STA $03E9
    BRL loc_012C6D

  loc_012DBC:
    PHX 
    REP #$20
    LDX $0000, Y
    INY 
    INY 
    SEP #$20
    JSL $@code_012BDA
    PLX 
    BRL loc_012C6D

  loc_012DCE:
    LDA $0000, Y
    INY 
    STA $00
    LDA $0000, Y
    INY 
    STA $02

  loc_012DDA:
    JSR $&code_012B5D
    REP #$20
    PLA 
    CLC 
    ADC #$0082
    TAX 
    PHX 
    SEP #$20
    BRL loc_012C6D

  loc_012DEB:
    LDA $0000, Y
    INY 
    STA $00
    STA $02
    REP #$20
    DEC 
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    TAX 
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    SEP #$20
    LDA $03E9
    XBA 

  loc_012E0E:
    LDA $0000, Y
    AND #$0F
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BEQ loc_012E3D
    LDA $0000, Y
    INY 
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BNE loc_012E0E

  loc_012E3D:
    INX 
    INX 
    DEC $02
    BEQ loc_012E53
    LDA $bg3_tilemap_buffer, X
    CMP #$30
    BNE loc_012E53
    LDA #$20
    STA $bg3_tilemap_buffer, X
    BRA loc_012E3D

  loc_012E53:
    XBA 
    BIT #$02
    BNE loc_012E73
    XBA 
    INC $02

  loc_012E5B:
    LDA $bg3_tilemap_buffer, X
    REP #$20
    ORA #$0100
    STA $7F6FC0, X
    AND #$FEFF
    SEP #$20
    INX 
    INX 
    DEC $02
    BNE loc_012E5B

  loc_012E73:
    PLY 
    PLX 
    INX 
    INX 
    BRL loc_012C6D

  loc_012E7A:
    REP #$20
    LDA $0000, Y
    INY 
    INY 
    STA $00
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    ASL 
    CLC 
    ADC $00
    TAY 
    SEP #$20
    PHB 
    LDA #$02
    PHA 
    PLB 
    REP #$20
    LDA $0000, Y
    TAY 
    SEP #$20
    LDA $03E9
    XBA 
    JSR $&code_012FDF
    PLB 
    PLY 
    BRL loc_012C6D

  loc_012EAD:
    REP #$20
    PHY 
    LDA $0000, Y
    TAY 
    LDA $0000, Y
    STA $00
    PLY 
    PHY 
    LDA $0002, Y
    TAY 
    LDA $0000, Y
    STA $02
    SEP #$20
    JSR $&code_012ABF
    PLY 
    INY 
    INY 
    INY 
    INY 
    BRL loc_012C6D

  loc_012ED1:
    LDA $03E9
    AND #$E3
    ORA $0000, Y
    INY 
    STA $03E9
    BRL loc_012C6D

  loc_012EE0:
    LDA $0000, Y
    INY 
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAY 
    SEP #$20
    PHB 
    LDA #$^lib_shared_014789.binary_list_014789
    PHA 
    PLB 
    REP #$20
    LDA $&lib_shared_014789.binary_list_014789, Y
    TAY 
    SEP #$20
    LDA $03E9
    XBA 
    JSR $&code_012FDF
    PLB 
    PLY 
    BRL loc_012C6D

  loc_012F07:
    LDA $0001, Y
    STA $02, S
    XBA 
    LDA $0000, Y
    STA $01, S
    INY 
    INY 
    TAX 
    BRL loc_012C6D

  loc_012F18:
    PLX 

  loc_012F19:
    PHX 
    JSR $&code_0130CA
    REP #$20
    LDA $03ED
    DEC 
    AND #$FFFE
    CLC 
    ADC $01, S
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    JSR $&code_01303A
    LDA $1B84
    BNE loc_012F3B
    BRL loc_012D6E

  loc_012F3B:
    PLX 
    LDA $7F7080, X
    CMP #$04
    BNE loc_012F51
    LDA $1B84
    BEQ loc_012F19
    JSR $&code_0130CA
    JSR $&code_013080
    BRA loc_012F5B

  loc_012F51:
    REP #$20
    TXA 
    CLC 
    ADC #$0080
    TAX 
    SEP #$20

  loc_012F5B:
    PHX 
    BRL loc_012C6D

  loc_012F5F:
    JSR $&code_01314A

  loc_012F62:
    PLX 
    STX $03F3
    LDA #$01
    TSB $vram_upload_flags
    PLB 
    PLP 
    RTL 
}

code_012F6E {
    LDA $0000, Y
    BMI loc_012F75
    INY 
    RTS 

  loc_012F75:
    INY 
    PHB 
    PHY 
    REP #$20
    AND #$007F
    PHA 
    ASL 
    CLC 
    ADC $01, S
    ASL 
    ASL 
    TAY 
    PLA 
    SEP #$20
    LDA #$^string_lookup_080000.lookup_080000
    PHA 
    PLB 
    LDA #$0C
    STA $14
    LDA $03E9
    XBA 

  loc_012F94:
    LDA $&string_lookup_080000.lookup_080000, Y
    BEQ loc_012FBD
    INY 
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012FB4
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012FB4:
    SEP #$20
    JSR $&code_013124
    DEC $14
    BNE loc_012F94

  loc_012FBD:
    LDA #$20
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012FD9
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012FD9:
    SEP #$20
    PLY 
    PLB 
    BRA code_012F6E
}

code_012FDF {
    LDA $0000, Y
    BMI loc_013009
    BNE loc_012FE7
    RTS 

  loc_012FE7:
    INY 
    ORA $03F9
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_013002
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_013002:
    SEP #$20
    JSR $&code_013124
    BRA code_012FDF

  loc_013009:
    JSR $&code_012F6E
    DEY 
    BRA code_012FDF
}

code_01300F {
    REP #$20
    LDX $03EB
    LDA $03EF
    STA $0E

  loc_013019:
    LDA $03ED
    STA $0C
    PHX 
    LDA #$2020

  loc_013022:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_013022
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    DEC $0E
    BNE loc_013019
    SEP #$20
    RTS 
}

code_01303A {
    LDA #$3D

  loc_01303C:
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    JSR $&code_013161
    BIT #$C0
    BEQ loc_013069
    LDA $frame_counter
    AND #$10
    BNE code_01303A
    LDA #$20
    BRA loc_01303C

  loc_013057:
    LDA #$3D

  loc_013059:
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    JSR $&code_013161
    BIT #$C0
    BNE loc_013074

  loc_013069:
    LDA $frame_counter
    AND #$10
    BNE loc_013057
    LDA #$20
    BRA loc_013059

  loc_013074:
    LDA #$20
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    RTS 
}

code_013080 {
    REP #$20
    PHX 
    LDX $03EB
    LDA $03EF
    SEC 
    SBC #$0003
    BEQ loc_0130B0
    STA $0E

  loc_013091:
    LDA $03ED
    STA $0C
    PHX 

  loc_013097:
    LDA $7F7080, X
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_013097
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    DEC $0E
    BNE loc_013091

  loc_0130B0:
    LDA $03ED
    STA $0C
    LDA #$2020

  loc_0130B8:
    STA $bg3_tilemap_buffer, X
    STA $7F7040, X
    INX 
    INX 
    DEC $0C
    BNE loc_0130B8
    PLX 
    SEP #$20
    RTS 
}

code_0130CA {
    PHX 
    PHY 

  loc_0130CC:
    LDA $7F6FFE, X
    CMP #$07
    BEQ loc_0130D8
    DEX 
    DEX 
    BRA loc_0130CC

  loc_0130D8:
    LDA $7F6FC0, X
    CMP #$03
    BEQ loc_0130EC
    REP #$20
    TXA 
    SEC 
    SBC #$0040
    TAX 
    SEP #$20
    BRA loc_0130D8

  loc_0130EC:
    STX $03EB
    STZ $00

  loc_0130F1:
    LDA $bg3_tilemap_buffer, X
    CMP #$08
    BEQ loc_0130FF
    INX 
    INX 
    INC $00
    BRA loc_0130F1

  loc_0130FF:
    LDA $00
    STA $03ED
    STZ $00

  loc_013106:
    LDA $bg3_tilemap_buffer, X
    CMP #$06
    BEQ loc_01311C
    REP #$20
    TXA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    INC $00
    BRA loc_013106

  loc_01311C:
    LDA $00
    STA $03EF
    PLY 
    PLX 
    RTS 
}

code_013124 {
    AND #$7F
    CMP #$20
    BNE loc_01312B
    RTS 

  loc_01312B:
    LDA #$01
    TSB $vram_upload_flags
    LDA $1B84
    JSL $@code_013140
    LDA $03F5
    BNE loc_01313D
    RTS 

  loc_01313D:
    BRK #$07
    RTS 
}

code_013140 {
    BEQ loc_013149
    JSL $@engine_000000.code_0001BE
    DEC 
    BRA code_013140

  loc_013149:
    RTL 
}

code_01314A {
    JSR $&code_013161
    BIT #$CF
    BNE code_01314A

  loc_013151:
    JSR $&code_013161
    BIT #$CF
    BEQ loc_013151
    LDA #$C0
    TRB $032B
    STZ $0323
    RTS 
}

code_013161 {
    JSL $@engine_000000.code_0001BE
    LDA $0323
    RTS 
}

code_013169 {
    LDA $03D2
    BEQ code_013161
    JSL $@lib_shared_0131B7.code_0131B7
    LDA $0323
    RTS 
}