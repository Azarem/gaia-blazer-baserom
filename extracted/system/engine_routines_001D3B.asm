?BANK 00

?INCLUDE 'common_actor_001A28_part1'
?INCLUDE 'engine_routines_002678'

!scene_next                     0318
!joy_release_latch              032A

---------------------------------------------

code_001D3B {
    BCS loc_001D4B        ; {7483}
    LDA #$0001            ; {7485}
    JSR $&code_001F9D     ; {7488}
    COP [80] ( #01 )      ; {7491}
    COP [82]              ; {7494}
    BRL common_actor_001A28_part1.loc_001A65 ; {7496}

  loc_001D4B:
    LDA #$002B            ; {7499}
    JSR $&code_001F9D     ; {7502}
    COP [80] ( #2B )      ; {7505}
    COP [82]              ; {7508}
    BRL common_actor_001A28_part1.loc_001A65 ; {7510}
}

code_001D59 {
    BCS loc_001D69        ; {7513}
    LDA #$0000            ; {7515}
    JSR $&code_001F9D     ; {7518}
    COP [80] ( #00 )      ; {7521}
    COP [82]              ; {7524}
    BRL common_actor_001A28_part1.loc_001A65 ; {7526}

  loc_001D69:
    LDA #$0029            ; {7529}
    JSR $&code_001F9D     ; {7532}
    COP [80] ( #29 )      ; {7535}
    COP [82]              ; {7538}
    BRL common_actor_001A28_part1.loc_001A65 ; {7540}
}

code_001D77 {
    BCS loc_001D87        ; {7543}
    LDA #$0002            ; {7545}
    JSR $&code_001F9D     ; {7548}
    COP [80] ( #02 )      ; {7551}
    COP [82]              ; {7554}
    BRL common_actor_001A28_part1.loc_001A65 ; {7556}

  loc_001D87:
    LDA #$0027            ; {7559}
    JSR $&code_001F9D     ; {7562}
    COP [80] ( #27 )      ; {7565}
    COP [82]              ; {7568}
    BRL common_actor_001A28_part1.loc_001A65 ; {7570}
}

code_001D95 {
    BCS loc_001DA5        ; {7573}
    LDA #$0003            ; {7575}
    JSR $&code_001F9D     ; {7578}
    COP [80] ( #03 )      ; {7581}
    COP [82]              ; {7584}
    BRL common_actor_001A28_part1.loc_001A65 ; {7586}

  loc_001DA5:
    LDA #$0024            ; {7589}
    JSR $&code_001F9D     ; {7592}
    COP [80] ( #24 )      ; {7595}
    COP [82]              ; {7598}
    BRL common_actor_001A28_part1.loc_001A65 ; {7600}
}

code_001DB3 {
    BCS loc_001DC3        ; {7603}
    LDA #$0006            ; {7605}
    JSR $&code_001F9D     ; {7608}
    COP [80] ( #06 )      ; {7611}
    COP [82]              ; {7614}
    BRL common_actor_001A28_part1.loc_001A65 ; {7616}

  loc_001DC3:
    LDA #$002A            ; {7619}
    JSR $&code_001F9D     ; {7622}
    COP [80] ( #2A )      ; {7625}
    COP [82]              ; {7628}
    BRL common_actor_001A28_part1.loc_001A65 ; {7630}
}

code_001DD1 {
    BCS loc_001DE1        ; {7633}
    LDA #$0004            ; {7635}
    JSR $&code_001F9D     ; {7638}
    COP [80] ( #04 )      ; {7641}
    COP [82]              ; {7644}
    BRL common_actor_001A28_part1.loc_001A65 ; {7646}

  loc_001DE1:
    LDA #$0028            ; {7649}
    JSR $&code_001F9D     ; {7652}
    COP [80] ( #28 )      ; {7655}
    COP [82]              ; {7658}
    BRL common_actor_001A28_part1.loc_001A65 ; {7660}
}

code_001DEF {
    BCS loc_001DFF        ; {7663}
    LDA #$0008            ; {7665}
    JSR $&code_001F9D     ; {7668}
    COP [80] ( #08 )      ; {7671}
    COP [82]              ; {7674}
    BRL common_actor_001A28_part1.loc_001A65 ; {7676}

  loc_001DFF:
    LDA #$0026            ; {7679}
    JSR $&code_001F9D     ; {7682}
    COP [80] ( #26 )      ; {7685}
    COP [82]              ; {7688}
    BRL common_actor_001A28_part1.loc_001A65 ; {7690}
}

code_001E0D {
    BCS loc_001E1D        ; {7693}
    LDA #$000A            ; {7695}
    JSR $&code_001F9D     ; {7698}
    COP [80] ( #0A )      ; {7701}
    COP [82]              ; {7704}
    BRL common_actor_001A28_part1.loc_001A65 ; {7706}

  loc_001E1D:
    LDA #$0025            ; {7709}
    JSR $&code_001F9D     ; {7712}
    COP [80] ( #25 )      ; {7715}
    COP [82]              ; {7718}
    BRL common_actor_001A28_part1.loc_001A65 ; {7720}
}

code_001E2B {
    LDA #$0005            ; {7723}
    JSR $&code_001F9D     ; {7726}
    COP [80] ( #05 )      ; {7729}
    COP [82]              ; {7732}
    BRL common_actor_001A28_part1.loc_001A65 ; {7734}
}

code_001E39 {
    LDA #$0011            ; {7737}
    JSR $&code_001F9D     ; {7740}
    COP [80] ( #11 )      ; {7743}
    COP [82]              ; {7746}
    BRL common_actor_001A28_part1.loc_001A65 ; {7748}
}

code_001E47 {
    LDA #$0012            ; {7751}
    JSR $&code_001F9D     ; {7754}
    COP [80] ( #12 )      ; {7757}
    COP [82]              ; {7760}
    BRL common_actor_001A28_part1.loc_001A65 ; {7762}
}

code_001E55 {
    LDA #$0007            ; {7765}
    JSR $&code_001F9D     ; {7768}
    COP [80] ( #07 )      ; {7771}
    COP [82]              ; {7774}
    BRL common_actor_001A28_part1.loc_001A65 ; {7776}
}

code_001E63 {
    LDA #$0010            ; {7779}
    JSR $&code_001F9D     ; {7782}
    COP [80] ( #10 )      ; {7785}
    COP [82]              ; {7788}
    BRL common_actor_001A28_part1.loc_001A65 ; {7790}
}

code_001E71 {
    LDA #$0013            ; {7793}
    JSR $&code_001F9D     ; {7796}
    COP [80] ( #13 )      ; {7799}
    COP [82]              ; {7802}
    BRL common_actor_001A28_part1.loc_001A65 ; {7804}
}

code_001E7F {
    LDA #$000E            ; {7807}
    JSR $&code_001F9D     ; {7810}
    COP [80] ( #0E )      ; {7813}
    COP [82]              ; {7816}
    BRL common_actor_001A28_part1.loc_001A65 ; {7818}
}

code_001E8D {
    LDA #$000D            ; {7821}
    JSR $&code_001F9D     ; {7824}
    COP [80] ( #0D )      ; {7827}
    COP [82]              ; {7830}
    BRL common_actor_001A28_part1.loc_001A65 ; {7832}
}

code_001E9B {
    LDA #$000B            ; {7835}
    JSR $&code_001F9D     ; {7838}
    COP [80] ( #0B )      ; {7841}
    COP [82]              ; {7844}
    BRL common_actor_001A28_part1.loc_001A65 ; {7846}
}

code_001EA9 {
    LDA #$000F            ; {7849}
    JSR $&code_001F9D     ; {7852}
    COP [80] ( #0F )      ; {7855}
    COP [82]              ; {7858}
    BRL common_actor_001A28_part1.loc_001A65 ; {7860}
}

code_001EB7 {
    LDA #$000C            ; {7863}
    JSR $&code_001F9D     ; {7866}
    COP [80] ( #0C )      ; {7869}
    COP [82]              ; {7872}
    BRL common_actor_001A28_part1.loc_001A65 ; {7874}
}

code_001EC5 {
    LDA #$0009            ; {7877}
    JSR $&code_001F9D     ; {7880}
    COP [80] ( #09 )      ; {7883}
    COP [82]              ; {7886}
    BRL common_actor_001A28_part1.loc_001A65 ; {7888}

  loc_001ED3:
    SEP #$20              ; {7891}
    LDA #$0B              ; {7893}
    STA $0024, X          ; {7895}
    LDY $039E             ; {7898}
    LDA #$0C              ; {7901}
    STA $0024, Y          ; {7903}
    REP #$20              ; {7906}
    BRK #$84              ; {7908}
    LDA #$001C            ; {7910}
    JSR $&code_001F9D     ; {7913}
    COP [80] ( #1C )      ; {7916}
    COP [82]              ; {7919}
    LDA $03BA             ; {7921}
    INC                   ; {7924}
    STA $scene_next       ; {7925}
    COP [91]              ; {7928}
    RTL                   ; {7930}
}

code_001EFB {
    BRK #$01              ; {7931}
    JSR $&code_001F7B     ; {7933}
    BCS loc_001F07        ; {7936}
    COP [84] ( @engine_routines_002678.code_002678 ) ; {7938}

  loc_001F07:
    LDA #$8000            ; {7943}
    TRB $joy_release_latch ; {7946}
    LDA #$0021            ; {7949}
    JSR $&code_001F9D     ; {7952}
    COP [80] ( #21 )      ; {7955}
    COP [82]              ; {7958}
    BRL common_actor_001A28_part1.loc_001A65 ; {7960}
}

code_001F1B {
    BRK #$01              ; {7963}
    JSR $&code_001F7B     ; {7965}
    BCS loc_001F27        ; {7968}
    COP [84] ( @engine_routines_002678.code_00268D ) ; {7970}

  loc_001F27:
    LDA #$8000            ; {7975}
    TRB $joy_release_latch ; {7978}
    LDA #$0020            ; {7981}
    JSR $&code_001F9D     ; {7984}
    COP [80] ( #20 )      ; {7987}
    COP [82]              ; {7990}
    BRL common_actor_001A28_part1.loc_001A65 ; {7992}
}

code_001F3B {
    BRK #$01              ; {7995}
    JSR $&code_001F7B     ; {7997}
    BCS loc_001F47        ; {8000}
    COP [84] ( @engine_routines_002678.code_0026A4 ) ; {8002}

  loc_001F47:
    LDA #$8000            ; {8007}
    TRB $joy_release_latch ; {8010}
    LDA #$0022            ; {8013}
    JSR $&code_001F9D     ; {8016}
    COP [80] ( #22 )      ; {8019}
    COP [82]              ; {8022}
    BRL common_actor_001A28_part1.loc_001A65 ; {8024}
}

code_001F5B {
    BRK #$01              ; {8027}
    JSR $&code_001F7B     ; {8029}
    BCS loc_001F67        ; {8032}
    COP [84] ( @engine_routines_002678.code_0026B9 ) ; {8034}

  loc_001F67:
    LDA #$8000            ; {8039}
    TRB $joy_release_latch ; {8042}
    LDA #$0023            ; {8045}
    JSR $&code_001F9D     ; {8048}
    COP [80] ( #23 )      ; {8051}
    COP [82]              ; {8054}
    BRL common_actor_001A28_part1.loc_001A65 ; {8056}
}

code_001F7B {
    LDA $1B5E             ; {8059}
    CMP #$0008            ; {8062}
    BNE code_001F9B       ; {8065}
    LDA $1B60             ; {8067}
    CMP #$0010            ; {8070}
    BNE code_001F9B       ; {8073}
    LDA $1B62             ; {8075}
    CMP #$0018            ; {8078}
    BNE code_001F9B       ; {8081}
    COP [26] ( #$0002, &code_001F9B ) ; {8083}
    CLC                   ; {8089}
    RTS                   ; {8090}
}

code_001F9B {
    SEC                   ; {8091}
    RTS                   ; {8092}
}

code_001F9D {
    LDY $003E, X          ; {8093}
    STA $001E, Y          ; {8096}
    SEC                   ; {8099}
    SBC #$0020            ; {8100}
    CMP #$0004            ; {8103}
    BCS loc_001FB5        ; {8106}
    LDA $1B70             ; {8108}
    CLC                   ; {8111}
    ADC $1B72             ; {8112}
    BRA loc_001FB8        ; {8115}

  loc_001FB5:
    LDA $1B70             ; {8117}

  loc_001FB8:
    STA $1B8C             ; {8120}
    LDA $1B74             ; {8123}
    CLC                   ; {8126}
    ADC $1B76             ; {8127}
    STA $1B8E             ; {8130}
    LDA #$0000            ; {8133}
    STA $0020, Y          ; {8136}
    STA $0014, Y          ; {8139}
    RTS                   ; {8142}
}