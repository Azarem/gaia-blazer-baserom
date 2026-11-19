?BANK 02

?INCLUDE 'lib_0118FC'
?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_shared_012769'

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_012138 {
    STA $03C4
    XBA 
    PHA 
    STZ $03C6

  loc_012140:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  loc_01214F:
    JSR $&lib_shared_012769.code_013169
    BEQ loc_012159
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_01214F

  loc_012159:
    JSR $&lib_shared_012769.code_013169
    BIT #$08
    BNE loc_012185
    BIT #$04
    BNE loc_01219A
    BIT #$40
    BNE loc_012176
    BIT #$80
    BNE loc_012171
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_012159

  loc_012171:
    BRK #$07
    CLC 
    BRA loc_012179

  loc_012176:
    BRK #$07
    SEC 

  loc_012179:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    PLA 
    RTS 

  loc_012185:
    LDA $01, S
    BEQ loc_01214F
    DEC 
    STA $01, S
    TXY 
    REP #$20
    TYA 
    SEC 
    SEC 
    SBC #$0080
    TAY 
    SEP #$20
    BRA loc_0121AF

  loc_01219A:
    LDA $01, S
    INC 
    CMP $03C4
    BCS loc_01214F
    STA $01, S
    TXY 
    REP #$20
    TYA 
    CLC 
    ADC #$0080
    TAY 
    SEP #$20

  loc_0121AF:
    BRK #$07
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    STZ $03C6
    TYX 
    LDA $042F
    BEQ loc_0121D6
    LDA $01, S
    CMP #$03
    BNE loc_0121CD
    BRL loc_012140

  loc_0121CD:
    JSR $&lib_0118FC.code_011D46
    STZ $042F
    BRL loc_012140

  loc_0121D6:
    LDA $01, S
    CMP #$03
    BEQ loc_0121DF
    BRL loc_012140

  loc_0121DF:
    JSR $&lib_0118FC.code_011D76
    INC $042F
    BRL loc_012140

  code_0121E8:
    PHX 
    SEP #$20
    STA $03C4
    XBA 
    PHA 

  loc_0121F0:
    LDA $01, S
    REP #$20
    AND #$00FF
    ASL 
    TAX 
    LDA $@word_012277, X
    TAX 
    SEP #$20
    STZ $03C6
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  loc_012212:
    JSR $&lib_shared_012769.code_013169
    BEQ loc_01221C
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_012212

  loc_01221C:
    JSR $&lib_shared_012769.code_013169
    BIT #$08
    BNE loc_012255
    BIT #$04
    BNE loc_01225E
    BIT #$40
    BNE loc_012243
    BIT #$80
    BNE loc_012234
    JSR $&lib_shared_01230B.code_01230B
    BRA loc_01221C

  loc_012234:
    BRK #$18
    CLC 
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    BRA loc_012250

  loc_012243:
    BRK #$07
    SEC 
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X

  loc_012250:
    PLA 
    PLX 
    REP #$20
    RTL 

  loc_012255:
    LDA $01, S
    BEQ loc_012212
    DEC 
    STA $01, S
    BRA loc_012268

  loc_01225E:
    LDA $01, S
    INC 
    CMP $03C4
    BCS loc_012212
    STA $01, S

  loc_012268:
    BRK #$07
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    BRL loc_0121F0
}
---------------------------------------------

word_012277 [
  #$02CA   ;00
  #$038A   ;01
  #$044A   ;02
  #$050A   ;03
  #$05CA   ;04
]