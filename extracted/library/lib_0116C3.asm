?BANK 02

?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_003005'
?INCLUDE 'lib_system_helpers'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!soul_orb_actor                 03A0
!w12sel_shadow                  03C3
!souls_flags                    1B82
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130

---------------------------------------------

code_0116C3 {
    LDA $souls_flags
    AND #$0002
    BNE loc_0116CC
    RTL 

  loc_0116CC:
    SEP #$20
    STZ $W12SEL
    STZ $W34SEL
    LDA #$30
    STA $WOBJSEL
    LDA #$12
    STA $CGWSEL
    REP #$20
    BRA loc_01175D

  code_0116E2:
    LDA $souls_flags
    AND #$0010
    BNE loc_0116EB
    RTL 

  loc_0116EB:
    SEP #$20
    LDA #$20
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    STZ $WOBJSEL
    LDA #$01
    STA $bg2_offset_x
    STA $bg2_offset_y
    REP #$20
    BRA loc_01175D

  code_011707:
    LDA $souls_flags
    AND #$0008
    BNE loc_011710
    RTL 

  loc_011710:
    SEP #$20
    LDA #$20
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    LDA #$01
    STA $WOBJSEL
    LDA #$01
    STA $bg2_offset_x
    STA $bg2_offset_y
    REP #$20
    BRA loc_01175D

  code_01172E:
    LDA $souls_flags
    AND #$0004
    BNE loc_011737
    RTL 

  loc_011737:
    SEP #$20
    LDA #$33
    STA $W12SEL
    STA $w12sel_shadow
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $TMW
    LDA #$03
    STA $TSW
    LDA #$82
    STA $CGWSEL
    REP #$20
    COP [B0] ( @engine_003005.DestroyHazardsNearOrb, #$2010 )

  loc_01175D:
    COP [91]
    PHX 
    LDY $soul_orb_actor
    LDA $0000, Y
    SEC 
    SBC $scroll_bg1_x
    CLC 
    ADC #$0008
    BMI loc_01177A
    CMP #$0100
    BCC loc_01177D
    LDA #$00FF
    BRA loc_01177D

  loc_01177A:
    LDA #$0000

  loc_01177D:
    STA $16
    LDA $0002, Y
    SEC 
    SBC $scroll_bg1_y
    SEC 
    SBC #$0008
    BMI loc_011796
    CMP #$00E0
    BCC loc_011799
    LDA #$00DF
    BRA loc_011799

  loc_011796:
    LDA #$0000

  loc_011799:
    STA $18
    LDX #$0000
    TXY 
    LDA #$00E0
    STA $0C
    LDA $18
    SEC 
    SBC #$0040
    BEQ loc_0117ED
    BPL loc_0117BA
    EOR #$FFFF
    INC 
    CMP #$0080
    BCS loc_011822
    TAY 
    BRA loc_0117ED

  loc_0117BA:
    TAY 
    SEC 
    SBC $0C
    EOR #$FFFF
    INC 
    STA $0C
    TYA 
    CMP #$0080
    BCC loc_0117DD
    SEC 
    SBC #$007F
    TAY 
    LDA #$FF7F
    STA $7E7000, X
    STA $7E7800, X
    INX 
    INX 
    TYA 

  loc_0117DD:
    ORA #$FF00
    STA $7E7000, X
    STA $7E7800, X
    INX 
    INX 
    LDY #$0002

  loc_0117ED:
    SEP #$20

  loc_0117EF:
    LDA #$02
    STA $7E7000, X
    STA $7E7800, X
    LDA $16
    SEC 
    SBC $&data_engine_tables.CircleHalfWidths, Y
    BCS loc_011803
    LDA #$00

  loc_011803:
    STA $7E7001, X
    LDA $16
    CLC 
    ADC $&data_engine_tables.CircleHalfWidths, Y
    BCC loc_011811
    LDA #$FF

  loc_011811:
    STA $7E7801, X
    INX 
    INX 
    INY 
    INY 
    DEC $0C
    BEQ loc_011822
    CPY #$0080
    BCC loc_0117EF

  loc_011822:
    SEP #$20
    LDA #$01
    STA $7E7000, X
    STA $7E7800, X
    LDA #$FF
    STA $7E7001, X
    STA $7E7801, X
    LDA #$00
    STA $7E7002, X
    STA $7E7802, X
    LDA #$26
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$27
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLX 
    REP #$20
    RTL 
}