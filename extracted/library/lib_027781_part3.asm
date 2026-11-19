?BANK 04

?INCLUDE 'engine_000000'
?INCLUDE 'lib_01020E'
?INCLUDE 'lib_0112F5'
?INCLUDE 'lib_011395'
?INCLUDE 'lib_0114D0'
?INCLUDE 'lib_0114E4'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_0133A6_part1'
?INCLUDE 'lib_0133A6_part3'
?INCLUDE 'lib_017504'
?INCLUDE 'lib_027781_part1'
?INCLUDE 'lib_027781_part2'
?INCLUDE 'lib_shared_027260'

!rng_state                      0301
!frame_counter                  0312
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!map_width_pages                0343
!map_height_pages               0345
!player_x                       0374
!player_y                       0376
!vram_upload_flags              03B8
!event_flags                    1A5E
!location_id                    1C6A
!MOSAIC                         2106
!BG12NBA                        210B
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!COLDATA                        2132
!cgram_buffer                   7F0000
!coldata_buffer                 7F0200

---------------------------------------------

code_0279B5 {
    LDX #$0000            ; {162229}
    STX $player_x         ; {162232}
    STX $player_y         ; {162235}
    STX $0382             ; {162238}
    STX $0384             ; {162241}
    STX $joy_pressed      ; {162244}
    STX $03D4             ; {162247}
    STX $03D6             ; {162250}
    STX $03D8             ; {162253}
    STX $038A             ; {162256}
    STX $038C             ; {162259}
    STX $joy_block_mask   ; {162262}
    STX $0433             ; {162265}
    STX $0433             ; {162268}
    STX $0458             ; {162271}
    STX $0464             ; {162274}
    STX $0468             ; {162277}
    LDX #$06AA            ; {162280}
    STX $039E             ; {162283}
    STX $03A0             ; {162286}
    STX $039A             ; {162289}
    STZ $event_flags      ; {162292}
    STZ $042D             ; {162295}
    STZ $0439             ; {162298}
    STZ $BG12NBA          ; {162301}
    STZ $vram_upload_flags ; {162304}
    STZ $W12SEL           ; {162307}
    STZ $03C3             ; {162310}
    STZ $W34SEL           ; {162313}
    STZ $WOBJSEL          ; {162316}
    STZ $MOSAIC           ; {162319}
    LDA #$E0              ; {162322}
    STA $COLDATA          ; {162324}
    LDA #$00              ; {162327}
    STA $coldata_buffer   ; {162329}
    STA $7F0201           ; {162333}
    STA $7F0202           ; {162337}
    STA $cgram_buffer     ; {162341}
    STA $7F0001           ; {162345}
    JSL $@lib_0133A6_part3.code_0133A6 ; {162349}
    LDA $0454             ; {162353}
    BEQ loc_027A41        ; {162356}
    STZ $0454             ; {162358}
    JSL $@lib_0118FC_part5.code_012463 ; {162361}
    JSL $@lib_0118FC_part5.code_01249C ; {162365}

  loc_027A41:
    JSL $@lib_027781_part2.code_027723 ; {162369}
    REP #$20              ; {162373}
    LDA $location_id      ; {162375}
    ASL                   ; {162378}
    TAX                   ; {162379}
    SEP #$20              ; {162380}
    LDA $@lib_017504.unk14_017504+28, X ; {162382}
    STA $map_width_pages  ; {162386}
    LDA $@lib_017504.unk14_017504+29, X ; {162389}
    STA $map_height_pages ; {162393}
    JSL $@engine_000000.code_0012AF ; {162396}
    JSL $@engine_000000.code_0012DE ; {162400}
    JSL $@lib_011395.code_011395 ; {162404}
    JSL $@lib_0112F5.code_0112F5 ; {162408}
    JSL $@lib_0133A6_part1.code_01157E ; {162412}
    JSL $@lib_011395.code_011445 ; {162416}
    JSL $@lib_0114D0.code_0114D0 ; {162420}
    JSL $@lib_0114E4.code_0114E4 ; {162424}
    JSL $@lib_0133A6_part1.code_0115F1 ; {162428}
    JSL $@lib_027781_part2.code_0276EE ; {162432}
    JSL $@lib_027781_part2.code_027706 ; {162436}
    JSL $@engine_000000.code_0005A6 ; {162440}
    JSL $@engine_000000.code_0005A6 ; {162444}
    JSL $@lib_027781_part1.code_0273F9 ; {162448}
    LDA $location_id      ; {162452}
    CMP #$10              ; {162455}
    BEQ loc_027A9F        ; {162457}
    JSL $@lib_01020E.code_01020E ; {162459}

  loc_027A9F:
    LDA #$01              ; {162463}
    TSB $vram_upload_flags ; {162465}
    STZ $031E             ; {162468}
    STZ $03B4             ; {162471}
    LDX $frame_counter    ; {162474}
    STX $rng_state+1      ; {162477}
    LDX #$FFFF            ; {162480}
    STX $joy_release_latch ; {162483}
    STX $frame_counter    ; {162486}
    LDA #$00              ; {162489}
    STA $WH0              ; {162491}
    DEC                   ; {162494}
    STA $WH1              ; {162495}
    JSL $@lib_shared_027260.code_027260 ; {162498}
    LDA $1A7D             ; {162502}
    BIT #$04              ; {162505}
    BNE loc_027AD2        ; {162507}
    LDA #$1F              ; {162509}
    STA $0332             ; {162511}

  loc_027AD2:
    RTL                   ; {162514}
}