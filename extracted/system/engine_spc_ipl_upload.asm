; SPC700 upload code, the SPC engine block and a sine-moving actor (file offsets 1044134-1047708, SNES $1F:EEA6-$FC9C, bank 1F).
; 
; === SPC UPLOAD ===
; UploadSpcDriver runs once at start-up (the boot actor of gv_front_end): it sends SpcEngineBlock with SendSpcIplBlocks (the IPL ROM boot protocol: after reset the SPC700 waits for $BBAA in APUIO0/1, then takes records of a length word, a destination word and the bytes, acknowledged by a counter in APUIO0; a record of length 0 ends the transfer and the IPL ROM jumps to its destination), waits two vblanks, writes $FF to APUIO0, sends data_spc_driver.SpcDriverBlock with UploadSpcStream and stores the SPC address after that block in $0320. UploadSpcStream is also the upload of every song (MusicLoadUpload in engine_spawn_lairs_death_drops, UploadSceneMusic in lib_scene_asset_loader): the pointer to the block list is in dp$29-$2B. The formats are decoded in docs/code/spc-interface.md: a block list is IPL records closed by a record of length 0 whose destination word is the sample count (low byte) and the first sample index (high byte), then one index byte per further sample; the samples are records of the 33-entry table at $07:8000 (OQ-I042-6).
; 
; === SINE WAVE MOVER ===
; RunSineWaveMover and the labels up to StepSineSwayXMirrored (file offsets 1044134-1044411) are not upload code but an actor script that sits in front of it. CopA5_JumpByFlipState picks one of four variants by the sprite's flip bits (none, flip X, flip Y, both). Each variant waits until the actor is on screen (COP AD, operand $10), waits $78 frames, then runs seven passes of a loop (COP 03/04, one frame per pass): a trail actor (RunSineWaveMoverTrail, COP B0, flags $0200) is spawned, y moves by $30,X (plus for NoFlip and FlipY, minus for FlipX and FlipXY) and x by half of a sine sample minus 12 (StepSineSwayX; the mirrored step for FlipY and FlipXY), and $30,X grows by $10 each pass, so the actor accelerates; then the cycle starts again. The actor has no reference in the extraction (OQ-I042-5); the names describe the code only.
; 
; === NOTES ===
; - SpcEngineBlock is the data part at the end: an IPL stream of one record (length $0B47 = 2887 bytes, destination $0400), the data and a closing record of length 0.
---------------------------------------------

?BANK 1F

?INCLUDE 'data_engine_tables'
?INCLUDE 'data_spc_driver'
?INCLUDE 'lib_system_helpers'

!APUIO0                         2140
!APUIO1                         2141
!APUIO2                         2142

---------------------------------------------

; Four-way actor script: waits until on screen, then moves with growing speed and a sine sway while spawning a trail.
; 
; When: no reference in the extraction; it is not a meta entry script or a spawn target of any file (OQ-I042-5).
; Sees: not located at run time.
; Why: CopA5_JumpByFlipState picks the variant from the sprite's flip bits ($1C bits 14-15, cleared by the command): none, flip X, flip Y, both.
; In: actor entry, X = actor slot.
; Out: a jump to SineWaveMoverNoFlip, SineWaveMoverFlipX, SineWaveMoverFlipY or SineWaveMoverFlipXY.
; Clobbers: A, Y.

RunSineWaveMover {
    COP [A5] ( &SineWaveMoverNoFlip, &SineWaveMoverFlipX, &SineWaveMoverFlipY, &SineWaveMoverFlipXY )
}

---------------------------------------------
; Start of the no-flip variant: wait until on screen, then $78 frames.
; 
; When: RunSineWaveMover (no flip), and again at the end of every cycle (SineWaveMoverNoFlipNext).
; Sees: n/a (see RunSineWaveMover).
; Why: the object only moves once it can be seen.
; In: actor entry, X = actor slot.
; Out: COP AD (operand $10), then COP 1B to SineWaveMoverNoFlipStep after $78 frames.
; Clobbers: A, Y.

SineWaveMoverNoFlip {
    COP [AD] ( #10 )
    COP [1B] ( &SineWaveMoverNoFlipStep, #$0078 )
}

---------------------------------------------
; One cycle of the no-flip variant: seven frames of motion, y plus.
; 
; When: $78 frames after SineWaveMoverNoFlip.
; Sees: n/a (see RunSineWaveMover).
; Why: each pass spawns a trail actor and moves the object; $30,X grows by $10 per pass.
; In: actor entry, X = actor slot (Y holds the actor's field base, as the COP dispatch leaves it).
; Out: $30,X = 0, BRK #$5D (a sound request), COP 03 for 7 passes: each pass spawns RunSineWaveMoverTrail (COP B0, flags $0200), y = y + $30,X, StepSineSwayX, then COP 1B to SineWaveMoverNoFlipNext after 1 frame.
; Clobbers: A.

SineWaveMoverNoFlipStep {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @RunSineWaveMoverTrail, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    JSR $&StepSineSwayX
    COP [1B] ( &SineWaveMoverNoFlipNext, #$0001 )
}

---------------------------------------------
; Loop end of the no-flip variant.
; 
; When: after every pass of SineWaveMoverNoFlipStep.
; Sees: n/a.
; Why: COP 04 repeats the pass until seven have run; then the cycle restarts.
; In: actor entry, X = actor slot.
; Out: COP 04 (loop next), then BRA SineWaveMoverNoFlip after the seventh pass.
; Clobbers: A, Y.

SineWaveMoverNoFlipNext {
    COP [04]
    BRA SineWaveMoverNoFlip
}

---------------------------------------------
; Start of the flip-X variant: wait until on screen, then $78 frames.
; 
; When: RunSineWaveMover (flip X only), and again at the end of every cycle.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverNoFlip.
; In: actor entry, X = actor slot.
; Out: COP AD (operand $10), then COP 1B to SineWaveMoverFlipXStep after $78 frames.
; Clobbers: A, Y.

SineWaveMoverFlipX {
    COP [AD] ( #10 )
    COP [1B] ( &SineWaveMoverFlipXStep, #$0078 )
}

---------------------------------------------
; One cycle of the flip-X variant: seven frames of motion, y minus.
; 
; When: $78 frames after SineWaveMoverFlipX.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverNoFlipStep, moving the other way.
; In: actor entry, X = actor slot (Y holds the actor's field base, as the COP dispatch leaves it).
; Out: $30,X = 0, BRK #$5D, COP 03 for 7 passes: trail spawn, y = y - $30,X, StepSineSwayX, COP 1B to SineWaveMoverFlipXNext after 1 frame.
; Clobbers: A.

SineWaveMoverFlipXStep {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @RunSineWaveMoverTrail, #$0200 )
    LDA $0002, Y
    SEC 
    SBC $0030, X
    STA $0002, Y
    JSR $&StepSineSwayX
    COP [1B] ( &SineWaveMoverFlipXNext, #$0001 )
}

---------------------------------------------
; Loop end of the flip-X variant.
; 
; When: after every pass of SineWaveMoverFlipXStep.
; Sees: n/a.
; Why: as SineWaveMoverNoFlipNext.
; In: actor entry, X = actor slot.
; Out: COP 04, then BRA SineWaveMoverFlipX after the seventh pass.
; Clobbers: A, Y.

SineWaveMoverFlipXNext {
    COP [04]
    BRA SineWaveMoverFlipX
}

---------------------------------------------
; Start of the flip-Y variant: wait until on screen, then $78 frames.
; 
; When: RunSineWaveMover (flip Y only), and again at the end of every cycle.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverNoFlip.
; In: actor entry, X = actor slot.
; Out: COP AD (operand $10), then COP 1B to SineWaveMoverFlipYStep after $78 frames.
; Clobbers: A, Y.

SineWaveMoverFlipY {
    COP [AD] ( #10 )
    COP [1B] ( &SineWaveMoverFlipYStep, #$0078 )
}

---------------------------------------------
; One cycle of the flip-Y variant: seven frames of motion, y plus, mirrored sway.
; 
; When: $78 frames after SineWaveMoverFlipY.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverNoFlipStep with the sway mirrored.
; In: actor entry, X = actor slot (Y holds the actor's field base, as the COP dispatch leaves it).
; Out: $30,X = 0, BRK #$5D, COP 03 for 7 passes: trail spawn, y = y + $30,X, StepSineSwayXMirrored, COP 1B to SineWaveMoverFlipYNext after 1 frame.
; Clobbers: A.

SineWaveMoverFlipYStep {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @RunSineWaveMoverTrail, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0002, Y
    STA $0002, Y
    JSR $&StepSineSwayXMirrored
    COP [1B] ( &SineWaveMoverFlipYNext, #$0001 )
}

---------------------------------------------
; Loop end of the flip-Y variant.
; 
; When: after every pass of SineWaveMoverFlipYStep.
; Sees: n/a.
; Why: as SineWaveMoverNoFlipNext.
; In: actor entry, X = actor slot.
; Out: COP 04, then BRA SineWaveMoverFlipY after the seventh pass.
; Clobbers: A, Y.

SineWaveMoverFlipYNext {
    COP [04]
    BRA SineWaveMoverFlipY
}

---------------------------------------------
; Start of the flip-X-and-Y variant: wait until on screen, then $78 frames.
; 
; When: RunSineWaveMover (both flip bits), and again at the end of every cycle.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverNoFlip.
; In: actor entry, X = actor slot.
; Out: COP AD (operand $10), then COP 1B to SineWaveMoverFlipXYStep after $78 frames.
; Clobbers: A, Y.

SineWaveMoverFlipXY {
    COP [AD] ( #10 )
    COP [1B] ( &SineWaveMoverFlipXYStep, #$0078 )
}

---------------------------------------------
; One cycle of the flip-X-and-Y variant: seven frames of motion, y minus, mirrored sway.
; 
; When: $78 frames after SineWaveMoverFlipXY.
; Sees: n/a (see RunSineWaveMover).
; Why: as SineWaveMoverFlipXStep with the sway mirrored.
; In: actor entry, X = actor slot (Y holds the actor's field base, as the COP dispatch leaves it).
; Out: $30,X = 0, BRK #$5D, COP 03 for 7 passes: trail spawn, y = y - $30,X, StepSineSwayXMirrored, COP 1B to SineWaveMoverFlipXYNext after 1 frame.
; Clobbers: A.

SineWaveMoverFlipXYStep {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @RunSineWaveMoverTrail, #$0200 )
    LDA $0002, Y
    SEC 
    SBC $0030, X
    STA $0002, Y
    JSR $&StepSineSwayXMirrored
    COP [1B] ( &SineWaveMoverFlipXYNext, #$0001 )
}

---------------------------------------------
; Loop end of the flip-X-and-Y variant.
; 
; When: after every pass of SineWaveMoverFlipXYStep.
; Sees: n/a.
; Why: as SineWaveMoverNoFlipNext.
; In: actor entry, X = actor slot.
; Out: COP 04, then BRA SineWaveMoverFlipXY after the seventh pass.
; Clobbers: A, Y.

SineWaveMoverFlipXYNext {
    COP [04]
    BRA SineWaveMoverFlipXY
}

---------------------------------------------
; Trail actor of the sine wave mover: plays animation $29 once and removes itself.
; 
; When: spawned by every pass of the Step labels with COP B0 (flags $0200).
; Sees: a short effect at the mover's position.
; Why: leaves an effect behind the moving object.
; In: actor entry, X = actor slot.
; Out: COP 80 (animation $29), COP 82 (wait until it ends), COP 86 (kill self), RTL.
; Clobbers: A, Y.

RunSineWaveMoverTrail {
    COP [80] ( #29 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Moves the actor's x by a sine sample and advances the sway counter.
; 
; When: the Step labels of the no-flip and flip-X variants, once per pass.
; Sees: the object sways sideways while it moves along y.
; Why: the sample is half of a byte of data_engine_tables.SineTable at ($30,X + $10), minus 12, so the sway is centred.
; In: near call (RTS); X = actor slot, Y = the actor's field base, $30,X = the counter.
; Out: x ($0000,Y) += SineTable[$30,X + $10] / 2 - 12; $30,X += $10; Y preserved.
; Clobbers: A.

StepSineSwayX {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR 
    CLC 
    ADC $0000, Y
    SEC 
    SBC #$000C
    STA $0000, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}

---------------------------------------------
; As StepSineSwayX with the sway mirrored.
; 
; When: the Step labels of the flip-Y and flip-X-and-Y variants, once per pass.
; Sees: the object sways the other way.
; Why: the mirrored variants of the mover.
; In: near call (RTS); X = actor slot, Y = the actor's field base, $30,X = the counter.
; Out: x ($0000,Y) += 12 - SineTable[$30,X + $10] / 2; $30,X += $10; Y preserved.
; Clobbers: A.

StepSineSwayXMirrored {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0000, Y
    CLC 
    ADC #$000C
    STA $0000, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}

---------------------------------------------
; Uploads the SPC engine and the driver block to the sound chip.
; 
; When: once at start-up, from the boot actor of gv_front_end (code_0066DE), after the SPC reset.
; Sees: the sound chip starts running its program; music and sound effects work afterwards.
; Why: the SPC700 has no program after reset; the CPU has to send it.
; In: long call; M = 8, X = 16.
; Out: dp$29-$2B = SpcEngineBlock sent with SendSpcIplBlocks; two vblanks; APUIO0 = $FF; dp$29-$2B = data_spc_driver.SpcDriverBlock, $0320 = $3000, sent with UploadSpcStream; $0320 = dp$02 + dp$08 (the SPC address after the last block).
; Clobbers: A, X, dp$02 and the work cells of the two upload routines.

UploadSpcDriver {
    LDX #$&SpcEngineBlock
    STX $29
    LDA #$^SpcEngineBlock
    STA $2B
    JSR $&SendSpcIplBlocks
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$FF
    STA $APUIO0
    LDX #$&data_spc_driver.SpcDriverBlock
    STX $29
    LDA #$^data_spc_driver.SpcDriverBlock
    STA $2B
    LDX #$3000
    STX $0320
    JSL $@UploadSpcStream
    REP #$20
    LDA $02
    CLC 
    ADC $08
    STA $0320
    SEP #$20
    RTL 
}

---------------------------------------------
; Sends the block list that dp$29-$2B points to into the SPC700.
; 
; When: UploadSpcDriver (the driver block), MusicLoadUpload (engine_spawn_lairs_death_drops, a song by track) and UploadSceneMusic (lib_scene_asset_loader, the song of a scene).
; Sees: the sound chip receives new data; the music changes after the upload.
; Why: songs and the driver are sent as data, not as part of the SPC program.
; In: long call; M = 8 (set inside), dp$29-$2B = the list, $0320 = SPC destination base; NMI off (it waits for vblanks).
; Out: SendSpcIplBlocks runs first on the list; then two vblanks, APUIO0 = $FF and the $BBAA handshake; then the destination word of the closing record is read again as the sample count (low byte) and the first sample index (high byte), and one more index byte follows for each further sample, the records are taken from a table that is walked through dp$2C-$2E starting at $07:8000 (record = a length word and its bytes, destination counting up from $0320), each record is sent with the counter protocol in APUIO0, and a record of length 0 is sent last; dp$2E = $7E at the end; P and Y restored. The record shapes of the driver and of the 21 songs are in docs/code/spc-interface.md (OQ-I042-6).
; Clobbers: A, X, dp$00-$0E, $2C-$2E.

UploadSpcStream {
    PHP 
    PHY 
    JSR $&SendSpcIplBlocks
    DEY 
    DEY 
    SEP #$20
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$FF
    STA $APUIO0
    LDA #$CC
    STA $04
    REP #$20
    LDA #$BBAA

  loc_0FF014:
    CMP $APUIO0
    BNE loc_0FF014
    LDA [$29], Y
    INY 
    STY $06
    AND #$00FF
    STA $0C
    LDX $0320
    STX $02
    STZ $00

  loc_0FF02A:
    REP #$20
    LDX #$8000
    STX $2C
    SEP #$20
    LDA #$07
    STA $2E
    REP #$20
    LDY $06
    LDA [$29], Y
    INY 
    STY $06
    AND #$00FF
    STA $0E
    LDA $02
    CLC 
    ADC $00
    STA $02

  loc_0FF04C:
    LDA [$2C]
    STA $00
    STA $08
    INC $2C
    INC $2C
    LDA $0E
    BEQ loc_0FF06E
    DEC $0E
    LDA $2C
    CLC 
    ADC $00
    STA $2C
    BCC loc_0FF04C
    ORA #$8000
    STA $2C
    INC $2E
    BRA loc_0FF04C

  loc_0FF06E:
    LDY $2C
    STZ $2C
    SEP #$20
    LDA $04
    BRA loc_0FF0B9

  loc_0FF078:
    LDA [$2C], Y
    INY 
    BNE loc_0FF082
    LDY #$8000
    INC $2E

  loc_0FF082:
    XBA 
    LDA #$00
    BRA loc_0FF099

  loc_0FF087:
    XBA 
    LDA [$2C], Y
    INY 
    BNE loc_0FF092
    LDY #$8000
    INC $2E

  loc_0FF092:
    XBA 

  loc_0FF093:
    CMP $APUIO0
    BNE loc_0FF093
    INC 

  loc_0FF099:
    REP #$20
    STA $APUIO0
    SEP #$20
    DEX 
    BNE loc_0FF087

  loc_0FF0A3:
    CMP $APUIO0
    BNE loc_0FF0A3

  loc_0FF0A8:
    ADC #$03
    BEQ loc_0FF0A8
    STA $04
    DEC $0C
    BEQ loc_0FF0B5
    BRL loc_0FF02A

  loc_0FF0B5:
    STZ $00
    STZ $01

  loc_0FF0B9:
    PHA 
    REP #$20
    LDA $00
    TAX 
    LDA $02
    STA $APUIO2
    SEP #$20
    CPX #$0001
    LDA #$00
    ROL 
    STA $APUIO1
    ADC #$7F
    PLA 
    STA $APUIO0

  loc_0FF0D5:
    CMP $APUIO0
    BNE loc_0FF0D5
    BVS loc_0FF078
    LDA #$7E
    STA $2E
    STZ $APUIO2
    PLY 
    PLP 
    RTL 
}

---------------------------------------------
; Sends records to the SPC700 IPL ROM with the boot protocol.
; 
; When: UploadSpcDriver (SpcEngineBlock) and the first step of UploadSpcStream.
; Sees: n/a.
; Why: after reset the SPC700 runs only its IPL ROM, which accepts records and jumps to the destination of a record of length 0; every call after the first talks to the engine's own copy of that loop (command $FF), which accepts the same records and returns at the record of length 0.
; In: near call (RTS); dp$29-$2B = the list, Y = 0 at the start of the list; the routine sets 16-bit registers itself.
; Out: waits for $BBAA in APUIO0/1, answers $CC; for every record (length word, destination word, bytes) sends the destination to APUIO2/3, 1 or 0 to APUIO1 (0 = start the program at the destination), the bytes in pairs with the counter in APUIO0; ends after the record of length 0 with APUIO2 = 0; X and P restored.
; Clobbers: A, Y.

SendSpcIplBlocks {
    PHP 
    PHX 
    REP #$30
    LDY #$0000
    LDA #$BBAA

  loc_0FF0F0:
    CMP $APUIO0
    BNE loc_0FF0F0
    SEP #$20
    LDA #$CC
    BRA loc_0FF121

  loc_0FF0FB:
    LDA [$29], Y
    INY 
    XBA 
    LDA #$00
    BRA loc_0FF10E

  loc_0FF103:
    XBA 
    LDA [$29], Y
    INY 
    XBA 

  loc_0FF108:
    CMP $APUIO0
    BNE loc_0FF108
    INC 

  loc_0FF10E:
    REP #$20
    STA $APUIO0
    SEP #$20
    DEX 
    BNE loc_0FF103

  loc_0FF118:
    CMP $APUIO0
    BNE loc_0FF118

  loc_0FF11D:
    ADC #$03
    BEQ loc_0FF11D

  loc_0FF121:
    PHA 
    REP #$20
    LDA [$29], Y
    INY 
    INY 
    TAX 
    LDA [$29], Y
    INY 
    INY 
    STA $APUIO2
    SEP #$20
    CPX #$0001
    LDA #$00
    ROL 
    STA $APUIO1
    ADC #$7F
    PLA 
    STA $APUIO0

  loc_0FF141:
    CMP $APUIO0
    BNE loc_0FF141
    BVS loc_0FF0FB
    STZ $APUIO2
    PLX 
    PLP 
    RTS 
}
---------------------------------------------

; The IPL stream with the SPC700 program that is sent first at start-up.
; 
; When: UploadSpcDriver, once.
; Sees: nothing directly; the music and sound effects run on it.
; Why: the SPC700 needs its program from the CPU.
; In: n/a (data): 2895 bytes: the length word $0B47 (2887 bytes), the destination word $0400, the 2887 data bytes and a closing record (length 0, start address). The program is not disassembled here.
; Out: n/a.
; Clobbers: n/a.

SpcEngineBlock [
  #470B000420CDCFBDE8005DAFC8F0D0FB   ;00
  #C5FF0FBC3FA909A248E8608D0C3FB805   ;01
  #8D1C3FB805E82C8D5D3FB805E830C4F1   ;02
  #E810C4FAC453E801C4F1E43648FF244A   ;03
  #C4388D0AAD05F007B008694D4CD00FE3   ;04
  #4C0CF65D0DC4F2F6670D5DE6C4F3FEE4   ;05
  #CB45CB46EBFDF0FC6DE840CF608443C4   ;06
  #43900A3FA00D694D4CF002AB4CE453EE   ;07
  #CF608451C45190193F8306E430F00A8B   ;08
  #31D0068F00043FE805CD003FB6045F36   ;09
  #04E404F012CD008F0147F4D5F0033F34   ;0A
  #0C3D3D0B47D0F35F3604F404D4F4F4F4   ;0B
  #74F4D0FAD4006FADCA90053FDF078DA4   ;0C
  #ADC8B0F2E41A2447D0ECDD287F608450   ;0D
  #6095F002D57D03F5A503D57C03F5A102   ;0E
  #5CE8007CD58C02E800D4ACD50001D5C8   ;0F
  #02D4C009475E094745F56402D498F01E   ;10
  #F56502D499F57802D00AF57D0380B579   ;11
  #02D57D03F5790260957D033F150A3F2D   ;12
  #0A8D00E41180A834B009E41180A813B0   ;13
  #06DC1C7A10DA104DE4111C8D00CD189E   ;14
  #5DF6730DC415F6720DC414F6750D2DF6   ;15
  #740DEE9A14EB10CFDD8D007A14CB151C   ;16
  #2B15C4142F044B157C3DC806D0F8C414   ;17
  #CEF52802EB15CFDA16F52802EB14CF6D   ;18
  #F52902EB14CF7A16DA16F52902EB15CF   ;19
  #FDAE7A16DA16F58C0D0802FDE4163FB0   ;1A
  #05FCE4172DE447241AAED004CBF2C4F3   ;1B
  #6F8D00F7403A402DF7403A40FDAE6F8F   ;1C
  #FF308F7F31C4046F2DE5FD0FECFE0FDA   ;1D
  #3BE8005DC73B3A3BD0FAAE6F8FFF468F   ;1E
  #0004A248C248E800C4E5C4E7E8013FA9   ;1F
  #096FC2486F3F060FC408C4046F68F0F0   ;20
  #DB68F1F0BA68F2F0E968FFF0E86FC404   ;21
  #1CF0263FD4055DF5FF0FFDF5FE0FDA40   ;22
  #8F020CE800C430C45FC439C435C436C4   ;23
  #E5C4E7D248E8FFC4F7E41A48FF0E4600   ;24
  #6FCD0E8F8047E8FFD50503E80A3F4908   ;25
  #D51502D5A503D5F002D56402D4ADD4C1   ;26
  #1D1D4B47D0E0C45AC468C454C450C442   ;27
  #8FC0598F20536FEB08E40068F090035F   ;28
  #0906C4087E00D086E404F0EAD248E40C   ;29
  #F0526E0CAC3FBD05D019FDD005C4F75F   ;2A
  #1A068B421002C4423FBD05F842F0E6DA   ;2B
  #402FE2DA168D0FF716D6D400DC10F8CD   ;2C
  #008F0147F4D5F00AF51502D005E8003F   ;2D
  #DF07E800D5B803D484D485BCD4703D3D   ;2E
  #0B47D0E0CD00D85E8F0147D844F4D5F0   ;2F
  #6C9B70D0623FD507D01DF5B803F0963F   ;30
  #4109F5B8039CD5B803D0EAF53C02D4D4   ;31
  #F53D02D4D52FDE3020D500023FD50730   ;32
  #182D9F2807FDF6002FD50102AE280FFD   ;33
  #F6082FD514023FD50768E090053FC307   ;34
  #2FB33FC304F50002D470FDF50102CFDD   ;35
  #D001BCD4712F033F5C0B3FF5093D3D0B   ;36
  #47D088E430F0038FFF5EE454F00BBA56   ;37
  #7A526E5402BA54DA52E468F015BA647A   ;38
  #60DA60BA667A626E6806BA68DA60EB6A   ;39
  #DA62E45AF00EBA5C7A586E5A02BA5ADA   ;3A
  #588FFF5ECD008F0147F4D5F0033FA50A   ;3B
  #3D3D0B47D0F36F1CFDF695092DF69409   ;3C
  #2DDD5CFDF62A0AF008E7D4BBD4D002BB   ;3D
  #D5FD6FD51502EB34D00FFD100680A8CA   ;3E
  #60845F6085FF0F2F09FD100680A8CA60   ;3F
  #84398D06CFDA1460980014982E15E41A   ;40
  #2447D0384DF58C0D08045D8D00F71410   ;41
  #0E281F3820480E4800094749DD2F07E4   ;42
  #474E4900F714D8F2C4F33DFCAD04D0F4   ;43
  #CEF714D52902FCF714D528026FD56903   ;44
  #281FD54103E800D540036FD4852D3FD5   ;45
  #07D5680380B54103CE3F380AD55403DD   ;46
  #D555036FD5A0023FD507D58D023FD507   ;47
  #D4ADD5B502E800D5A1026FD5A1022D8D   ;48
  #00F4ADCE9EF844D5B4026FDD80A800FD   ;49
  #E800DA586FC45A3FD507C45B80A459F8   ;4A
  #5A3F380ADA5C6FE434D004E800DA526F   ;4B
  #C4543FD507C45580A453F8543F380ADA   ;4C
  #566FC4506FD5F0026FD5DC023FD507D5   ;4D
  #C9023FD507D4C16FE8012F02E800D578   ;4E
  #02DDD565023FD507D564023FD507D579   ;4F
  #026FD564026FD50503E800D504036FD4   ;50
  #842D3FD507D52C0380B50503CE3F380A   ;51
  #D51803DDD519036FD5A5036FD550023F   ;52
  #D507D551023FD507D5B803F4D4D53C02   ;53
  #F4D5D53D02F55002D4D4F55102D4D56F   ;54
  #C44A3FD507E800DA603FD507E800DA62   ;55
  #B2486FC4683FD507C46980A461F8683F   ;56
  #380ADA643FD507C46A80A463F8683F38   ;57
  #0ADA666FDA60DA62A2486F3FA9093FD5   ;58
  #07C44E3FD5078D08CF5D8D0FF53E0D3F   ;59
  #B8053DDD608810FD10F2F8446FC44D8D   ;5A
  #7DCBF2E4F3644DF029280F48FFF34C03   ;5B
  #60844CC44C8D04F65D0DC4F2E800C4F3   ;5C
  #FEF5E44808208D6C3FB805E44D8D7D3F   ;5D
  #B8051C1C1C48FF8088FF8D6D5FB805EB   ;5E
  #34D003C45F6FC4396FF498D033E7D468   ;5F
  #F9D02D3FD7073FD507D4993FD507D498   ;60
  #3FD50760845095F002287FD5A40380B5   ;61
  #7D03FB986DCE3F380AD59003DDD59103   ;62
  #6FF57D03C411F57C03C4106FED6B1210   ;63
  #0348FFBC8D009E2DE8009EEEF844F312   ;64
  #06DA14BA0E9A146FDF07490857087008   ;65
  #7C089708A108B308BC08CE08D108D508   ;66
  #E10802090B0928098708E408E808FE08   ;67
  #24094C09800987095F09050AEB090101   ;68
  #02030001020102010103000102030103   ;69
  #030001030003030301F484F009E8048D   ;6A
  #039B843F380BFBC1F023F5DC02DEC01B   ;6B
  #09475EF5C8021007FCD004E8802F0460   ;6C
  #95C902D5C8023FC00C2F07BBC0E8FF3F   ;6D
  #CB0CF485F009E8408D039B853F380BE4   ;6E
  #47245EF046F54103FDF54003DA10F58C   ;6F
  #0DC412EB11F6EA0C80B6E90CEB10CFDD   ;70
  #EB116096E90CFDF52D03CFF569031C13   ;71
  #12011CDD900348FFBCEB123FB0058D14   ;72
  #E8009A10DA10AB123312C86F09475EDA   ;73
  #14DA164DEE60D00A982716E800D714FC   ;74
  #2F099814163F550BFCF7149716D7146F   ;75
  #F471F0649B71F005E802DE705BF5B803   ;76
  #C417F4D4FBD5DA148D00F714F01C3005   ;77
  #FCF71410FB68C8F03F68EFF02968E090   ;78
  #306DFDAE96AA09FD2FE0E417F0238B17   ;79
  #D00AF53D022DF53C02EE2FCAF551022D   ;7A
  #F55002EE2FC0FCF7142DFCF714FDAE2F   ;7B
  #B5E4478D5C3FB005F213F498F013F499   ;7C
  #F0049B992F0BE213E87C8D039B983F3B   ;7D
  #0B3F2D0AF4ADF04CF5A002DEAC44F500   ;7E
  #0175A102D005F5B5022F0D40BB0020FD   ;7F
  #F002F4AD6095B402D4ADF58C0260958D   ;80
  #02D58C02C4121C1C900248FFFDF4AD68   ;81
  #F19005280FCF2F04CFDD8D003FAB0C5F   ;82
  #2D05BBACE313F86FF213F4C1F009F5DC   ;83
  #02DEC0033FB30CF54103FDF54003DA10   ;84
  #F485F00AF55503FDF554033F950CF313   ;85
  #033FFA0AF213F57D03FDF57C03DA10F4   ;86
  #98F00EF499D00AF59103FDF590033F95   ;87
  #0CF4ADF0AFF5A002DEACA9EB51F58D02   ;88
  #CFDD60958C025F100CE213CB123F4A0A   ;89
  #6DEB51CFCB148F0015EB51AECF7A143F   ;8A
  #4A0A7A10DA106FE213EB51F5C902CFDD   ;8B
  #6095C8021C900248FFFBC1CFDD48FFEB   ;8C
  #34D003EB59CFF51402CFF50503CFE430   ;8D
  #F004E4311CCFDDCFDDD52D036F000103   ;8E
  #070D151E293442515E676E73777A7C7D   ;8F
  #7E7F0A0B0C0D0E0F1011111212131313   ;90
  #141414141413131312121111100F0E0D   ;91
  #0C0B0A09080706050403030202010101   ;92
  #00000000000101010202030304050607   ;93
  #08097F0000000000000058BFDBF0FE07   ;94
  #0C0C0C212B2B13FEF3F9343300D9E501   ;95
  #FCEB2C3C0D4D6C4C5C3D2D5C61634E38   ;96
  #48450E494B465F08DE086509F4098C0A   ;97
  #2C0BD60B8B0C4A0D140EEA0ECD0FBE10   ;98
  #00001000200030004000500060007000   ;99
  #60007000FA1A37383F1A8FFF348F005E   ;9A
  #8F4047CD10E4F6F0393004EB35D0332D   ;9B
  #0D0947460947370947363F140E8E1021   ;9C
  #3F790E8FFF358F003F8F8047CD12AE09   ;9D
  #47460947370947363F140EE803D4702F   ;9E
  #1DAE3F790E8F8047CD12E435D010E4F7   ;9F
  #F00C0947460947370947363F140E3F79   ;A0
  #0E8F0034FA371A6F1C4D5DF50124FDF5   ;A1
  #0024CED4D4DBD5E8DCD50503E80A3F49   ;A2
  #08E800D51502D5A503D5F002D56402D4   ;A3
  #ADD4C1D5B803D484D485E802D4706FE4   ;A4
  #4748FFFD2437C437DD2436C43609475E   ;A5
  #FA475C8F00344D7D80A8045DF515023F   ;A6
  #DF07CE8FFF34E800D4D5C4356FF4D5D0   ;A7
  #016FE435F02809475EC812D012E43FAB   ;A8
  #3F5C283FFDF6FE0C08C03F49082F0FE4   ;A9
  #3F48FFBC5C283FFDF6FE0C3F4908D844   ;AA
  #9B70D0453FD507F0963020D500023FD5   ;AB
  #0730182D9F2807FDF6002FD50102AE28   ;AC
  #0FFDF6082FD514023FD50768E090053F   ;AD
  #C3072FD03FC304F50002D470FDF50102   ;AE
  #CFDDD001BCD4712F033F5C0B3FF509E4   ;AF
  #30F00309475E3FA50A6F8DBBE8AADAF4   ;B0
  #E4F468CCD0FA2F1EEBF4D0FC7EF4D010   ;B1
  #CBF4E4F5D60000FCD0F2AC220F5F180F   ;B2
  #10EA7EF410E6BAF6C5210FCC220FEBF4   ;B3
  #E4F5CBF4D0D2CD31D8F16F00000004   ;B4
]