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
    LDX #$0000
    STX $player_x
    STX $player_y
    STX $0382
    STX $0384
    STX $joy_pressed
    STX $03D4
    STX $03D6
    STX $03D8
    STX $038A
    STX $038C
    STX $joy_block_mask
    STX $0433
    STX $0433
    STX $0458
    STX $0464
    STX $0468
    LDX #$06AA
    STX $039E
    STX $03A0
    STX $039A
    STZ $event_flags
    STZ $042D
    STZ $0439
    STZ $BG12NBA
    STZ $vram_upload_flags
    STZ $W12SEL
    STZ $03C3
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $MOSAIC
    LDA #$E0
    STA $COLDATA
    LDA #$00
    STA $coldata_buffer
    STA $7F0201
    STA $7F0202
    STA $cgram_buffer
    STA $7F0001
    JSL $@lib_0133A6_part3.code_0133A6
    LDA $0454
    BEQ loc_027A41
    STZ $0454
    JSL $@lib_0118FC_part5.code_012463
    JSL $@lib_0118FC_part5.code_01249C

  loc_027A41:
    JSL $@lib_027781_part2.code_027723
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    SEP #$20
    LDA $@lib_017504.unk14_017504+28, X
    STA $map_width_pages
    LDA $@lib_017504.unk14_017504+29, X
    STA $map_height_pages
    JSL $@engine_000000.code_0012AF
    JSL $@engine_000000.code_0012DE
    JSL $@lib_011395.code_011395
    JSL $@lib_0112F5.code_0112F5
    JSL $@lib_0133A6_part1.code_01157E
    JSL $@lib_011395.code_011445
    JSL $@lib_0114D0.code_0114D0
    JSL $@lib_0114E4.code_0114E4
    JSL $@lib_0133A6_part1.code_0115F1
    JSL $@lib_027781_part2.code_0276EE
    JSL $@lib_027781_part2.code_027706
    JSL $@engine_000000.code_0005A6
    JSL $@engine_000000.code_0005A6
    JSL $@lib_027781_part1.code_0273F9
    LDA $location_id
    CMP #$10
    BEQ loc_027A9F
    JSL $@lib_01020E.code_01020E

  loc_027A9F:
    LDA #$01
    TSB $vram_upload_flags
    STZ $031E
    STZ $03B4
    LDX $frame_counter
    STX $rng_state+1
    LDX #$FFFF
    STX $joy_release_latch
    STX $frame_counter
    LDA #$00
    STA $WH0
    DEC 
    STA $WH1
    JSL $@lib_shared_027260.code_027260
    LDA $1A7D
    BIT #$04
    BNE loc_027AD2
    LDA #$1F
    STA $0332

  loc_027AD2:
    RTL 
}