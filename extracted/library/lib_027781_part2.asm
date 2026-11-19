?BANK 04

?INCLUDE 'data_048000'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_01318C'
?INCLUDE 'lib_027781_part3'
?INCLUDE 'lib_shared_0131D1'

!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!scene_active                   032E
!map_width_pages                0343
!map_height_pages               0345
!vram_upload_flags              03B8
!transition_type                03E3
!return_active                  03FB
!S_switch_owner_table           0483
!INIDISP                        2100
!MOSAIC                         2106
!VMADDL                         2116
!VMDATAL                        2118
!cgram_buffer                   7F0000
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_0276EE {
    PHX 
    PHP 
    REP #$20
    LDA #$2000
    LDX #$0000

  loc_0276F8:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    CPX #$1000
    BNE loc_0276F8
    PLP 
    PLX 
    RTL 
}

code_027706 {
    LDA $return_active
    BEQ loc_027722
    PHB 
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDX #$0000

  loc_027715:
    STZ $S_switch_owner_table, X
    INX 
    INX 
    CPX #$0400
    BNE loc_027715
    SEP #$20
    PLB 

  loc_027722:
    RTL 
}

code_027723 {
    LDA #$02
    STA $2A
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_shared_0131D1.code_0131D1
    XBA 
    TAY 
    BEQ loc_02773C
    LDX #$8000
    JSR $&code_02773D

  loc_02773C:
    RTL 
}

code_02773D {
    PHX 
    PHY 
    LDX #$0000
    TXY 
    LDA #$00
    STA $0C

  loc_027747:
    LDA #$04
    STA $0E

  loc_02774B:
    LDA $7E2001, X
    INX 
    INX 
    AND #$02
    PHA 
    DEC $0E
    BNE loc_02774B
    PLA 
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR 
    STA $0200, Y
    INY 
    PLA 
    PLA 
    PLA 
    DEC $0C
    BNE loc_027747
    PLY 
    PLX 

  loc_027770:
    LDA $7E0000, X
    STA $29
    LDA ($29)
    STA $cgram_buffer, X
    INX 
    DEY 
    BNE loc_027770
    RTS 
}

code_027781 {
    LDA $scene_next
    BEQ loc_0277D4
    LDA $scene_active
    BEQ loc_027798
    LDA #$1E
    STA $03E5
    LDA #$FF
    STA $03E7
    JSR $&code_0277D5

  loc_027798:
    STZ $scene_active
    STZ $42
    JSL $@lib_01318C.code_01318C
    LDA $scene_next
    STA $scene_current
    LDA $area_next
    STA $area_current
    STZ $scene_next
    JSL $@lib_027781_part3.code_0279B5
    JSL $@engine_000000.code_000127
    JSL $@lib_0118FC_part8.code_0131A2
    STZ $03E5
    LDA #$01
    STA $03E7
    JSR $&code_027827
    INC $scene_active
    STZ $transition_type
    STZ $0462
    JSL $@engine_000000.code_000127

  loc_0277D4:
    RTL 
}

code_0277D5 {
    LDA $transition_type
    BPL loc_0277DD
    BRL loc_02787C

  loc_0277DD:
    BEQ loc_0277F4
    DEC 
    BEQ loc_0277F4
    DEC 
    BEQ loc_027801
    DEC 
    BEQ loc_027801
    DEC 
    BEQ loc_027809
    DEC 
    BEQ loc_027809
    DEC 
    BEQ loc_027801
    DEC 
    BEQ loc_027801

  loc_0277F4:
    LDA #$0F

  loc_0277F6:
    JSL $@engine_000000.code_000127
    STA $INIDISP
    DEC 
    BPL loc_0277F6
    RTS 

  loc_027801:
    JSL $@engine_000000.code_000127
    STZ $INIDISP
    RTS 

  loc_027809:
    LDA #$0F

  loc_02780B:
    JSL $@engine_000000.code_000127
    JSL $@engine_000000.code_000127
    STA $INIDISP
    PHA 
    EOR #$0F
    ASL 
    ASL 
    ASL 
    ASL 
    ORA #$03
    STA $MOSAIC
    PLA 
    DEC 
    BPL loc_02780B
    RTS 
}

code_027827 {
    LDA $transition_type
    BMI loc_02787C
    BEQ loc_027843
    DEC 
    BEQ loc_027852
    DEC 
    BEQ loc_027843
    DEC 
    BEQ loc_027852
    DEC 
    BEQ loc_02785C
    DEC 
    BEQ loc_027852
    DEC 
    BEQ loc_02785C
    DEC 
    BEQ loc_027852

  loc_027843:
    LDA #$00

  loc_027845:
    JSL $@engine_000000.code_000127
    STA $INIDISP
    INC 
    CMP #$10
    BCC loc_027845
    RTS 

  loc_027852:
    JSL $@engine_000000.code_000127
    LDA #$0F
    STA $INIDISP
    RTS 

  loc_02785C:
    LDA #$00

  loc_02785E:
    JSL $@engine_000000.code_000127
    JSL $@engine_000000.code_000127
    STA $INIDISP
    PHA 
    EOR #$0F
    ASL 
    ASL 
    ASL 
    ASL 
    ORA #$03
    STA $MOSAIC
    PLA 
    INC 
    CMP #$10
    BCC loc_02785E
    RTS 

  loc_02787C:
    LDA $03E7
    BPL loc_02788F
    INC $0462
    JSL $@code_0276EE
    LDA #$01
    TSB $vram_upload_flags
    BRA loc_027894

  loc_02788F:
    LDA #$0F
    STA $INIDISP

  loc_027894:
    JSL $@engine_000000.code_000127
    JSL $@engine_000000.code_000127
    LDA $03E5
    ASL 
    ASL 
    ASL 
    ASL 
    XBA 
    LDA $transition_type
    ADC $transition_type
    XBA 
    TAX 
    REP #$20
    LDA #$4000
    STA $VMADDL
    LDA $@data_048000.binary_048000, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+2, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+4, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+6, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+8, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+A, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+C, X
    STA $VMDATAL
    LDA $@data_048000.binary_048000+E, X
    STA $VMDATAL
    SEP #$20
    LDA $03E7
    BPL loc_027900
    LDA $03E5
    CLC 
    ADC $03E7
    STA $03E5
    BPL loc_027894
    RTS 

  loc_027900:
    LDA $03E5
    CLC 
    ADC $03E7
    STA $03E5
    CMP #$20
    BEQ loc_027911
    BRL loc_027894

  loc_027911:
    RTS 
}