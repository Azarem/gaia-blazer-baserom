?BANK 04

?INCLUDE 'lib_0118FC_part10'
?INCLUDE 'lib_014536'
?INCLUDE 'lib_014547'
?INCLUDE 'lib_01456A'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'

!frame_counter                  0312
!vram_upload_flags              03B8
!APUIO0                         2140
!JOY1L                          4218

---------------------------------------------

code_027572 {
    LDA $03A2
    BMI loc_0275DB
    BNE loc_0275D1
    LDA $0323
    BIT #$10
    BEQ loc_0275DB
    INC $03A2
    LDA #$F2
    STA $APUIO0
    LDA $JOY1L
    BIT #$80
    BNE loc_0275B1
    LDY #$&lib_014536.asciistring_014536
    JSL $@lib_shared_012769.code_012769
    LDA $0439
    BNE loc_0275AC
    LDA $0456
    LDX #$1B80
    JSL $@lib_0118FC_part10.code_013215
    LDY #$&lib_014547.asciistring_014547
    JSL $@lib_shared_012769.code_012769

  loc_0275AC:
    LDA #$01
    STA $vram_upload_flags

  loc_0275B1:
    JSR $&code_0275DC
    BNE loc_0275B1

  loc_0275B6:
    JSR $&code_0275DC
    BEQ loc_0275B6
    LDY #$&lib_01456A.asciistring_01456A
    JSL $@lib_shared_012769.code_012769
    LDA #$01
    STA $vram_upload_flags
    LDA #$01
    STA $APUIO0
    JSL $@lib_shared_0131B7.code_0131B7
    RTL 

  loc_0275D1:
    LDA $0323
    BIT #$10
    BNE loc_0275DB
    STZ $03A2

  loc_0275DB:
    RTL 
}

code_0275DC {
    LDX $frame_counter
    DEX 
    STX $frame_counter
    JSL $@lib_shared_0131B7.code_0131B7
    LDA $0323
    BIT #$10
    RTS 
}