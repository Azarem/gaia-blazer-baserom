?BANK 00

?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_0029EC'
?INCLUDE 'engine_002EC0'
?INCLUDE 'engine_003005'
?INCLUDE 'engine_0065A7'
?INCLUDE 'engine_006B7F'
?INCLUDE 'lib_010000'
?INCLUDE 'lib_010069'
?INCLUDE 'lib_01010B'
?INCLUDE 'lib_01020E_part2'
?INCLUDE 'lib_0109D6'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_010EA9_part1'
?INCLUDE 'lib_010EEA'
?INCLUDE 'lib_011695'
?INCLUDE 'lib_01185E'
?INCLUDE 'lib_0118FC'
?INCLUDE 'lib_0118FC_part6'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_0133A6_part3'
?INCLUDE 'lib_013ADA'
?INCLUDE 'lib_027223'
?INCLUDE 'lib_027572'
?INCLUDE 'lib_027614'
?INCLUDE 'lib_027781_part2'
?INCLUDE 'lib_027912'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_0131B7'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'meta_tables_008000'
?INCLUDE 'table_0099B4'

!frame_counter                  0312
!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!tile_dma_pending               03B6
!vram_upload_flags              03B8
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!oam_buffer                     0486
!actor_list_tail                06A6
!actor_list_head                06A8
!tile_dma_list                  1A06
!player_hp                      1B88
!player_max_hp                  1B8A
!location_id                    1C6A
!vram_write_queue               1C7B
!OAMADDL                        2102
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG3HOFS                        2111
!BG3VOFS                        2112
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!CGADD                          2121
!COLDATA                        2132
!APUIO2                         2142
!MDMAEN                         420B
!HDMAEN                         420C
!HVBJOY                         4212
!JOY1L                          4218
!JOY2H                          421B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305
!DMAP1                          4310
!BBAD1                          4311
!A1T1L                          4312
!A1B1                           4314
!DAS1L                          4315
!DMAP2                          4320
!BBAD2                          4321
!A1T2L                          4322
!A1B2                           4324
!DAS2L                          4325
!coldata_buffer                 7F0200
!tile_type_map                  7F8000

---------------------------------------------

emulation_mode_reset_000000 {
    SEI                   ; {0}
    CLD                   ; {1}
    CLC                   ; {2}
    XCE                   ; {3}
    REP #$30              ; {4}
    LDA #$0000            ; {6}
    TCD                   ; {9}
    LDA #$1FFF            ; {10}
    TCS                   ; {13}
    SEP #$20              ; {14}
    LDA #$01              ; {16}
    PHA                   ; {18}
    PLB                   ; {19}
    JSL $@lib_0133A6_part3.code_0139AC ; {20}
    JSL $@lib_013ADA.code_013ADA ; {24}
    JSL $@lib_027912.code_027912 ; {28}
    JSL $@lib_027781_part2.code_0276EE ; {32}
    LDX #$000C            ; {36}
    STX $scene_next       ; {39}
    JSL $@lib_0118FC_part8.code_0131A2 ; {42}
    JSL $@lib_027781_part2.code_027781 ; {46}

  loc_000032:
    JSL $@lib_shared_0131B7.code_0131B7 ; {50}
    JSL $@lib_027781_part2.code_027781 ; {54}
    LDA $location_id      ; {58}
    SEC                   ; {61}
    SBC #$10              ; {62}
    CMP #$03              ; {64}
    BCC loc_00008F        ; {66}
    LDA $return_active    ; {68}
    BNE loc_0000AA        ; {71}
    JSL $@lib_0118FC.code_0118FC ; {73}
    JSL $@lib_027572.code_027572 ; {77}
    JSL $@lib_0118FC_part8.code_0131AE ; {81}
    JSL $@lib_0109D6.code_0109D6 ; {85}
    JSL $@lib_01185E.code_01185E ; {89}
    JSL $@code_0005A6     ; {93}
    JSL $@code_0005C4     ; {97}
    JSL $@code_000A34     ; {101}
    JSL $@code_000DF4     ; {105}
    JSL $@engine_003005.code_003005 ; {109}
    JSL $@lib_010069.code_010069 ; {113}
    JSL $@lib_01010B.code_01010B ; {117}
    JSL $@code_0006EE     ; {121}
    JSL $@lib_0118FC_part6.code_012659 ; {125}
    JSL $@lib_011695.code_011695 ; {129}
    JSL $@lib_027223.code_027223 ; {133}
    JSL $@lib_0118FC_part8.code_0131A2 ; {137}
    BRA loc_000032        ; {141}

  loc_00008F:
    JSL $@lib_0118FC_part8.code_0131AE ; {143}
    JSL $@lib_01185E.code_01185E ; {147}
    JSL $@code_0005A6     ; {151}
    JSL $@code_0005C4     ; {155}
    JSL $@code_0006EE     ; {159}
    JSL $@lib_0118FC_part8.code_0131A2 ; {163}
    BRL loc_000032        ; {167}

  loc_0000AA:
    JSL $@lib_0118FC_part8.code_0131AE ; {170}
    JSL $@lib_010EA9_part1.code_010EA9 ; {174}
    JSL $@lib_01185E.code_01185E ; {178}
    STZ $0323             ; {182}
    JSL $@code_0005A6     ; {185}
    JSL $@code_0005C4     ; {189}
    JSL $@code_0006EE     ; {193}
    JSL $@lib_0118FC_part6.code_012659 ; {197}
    JSL $@lib_011695.code_011695 ; {201}
    JSL $@lib_027223.code_027223 ; {205}
    JSL $@lib_0118FC_part8.code_0131A2 ; {209}
    JSL $@lib_shared_0131B7.code_0131B7 ; {213}
    JSL $@lib_0118FC_part8.code_0131AE ; {217}

  loc_0000DD:
    JSL $@code_0001BE     ; {221}
    LDX $return_active    ; {225}
    BMI loc_0000DD        ; {228}
    STZ $return_active    ; {230}
    STZ $03FC             ; {233}
    LDA $player_max_hp    ; {236}
    LSR                   ; {239}
    LSR                   ; {240}
    LSR                   ; {241}
    CLC                   ; {242}
    ADC $043B             ; {243}
    STA $043B             ; {246}
    LDA #$78              ; {249}
    JSL $@lib_shared_012769.code_013140 ; {251}
    LDA #$80              ; {255}
    STA $transition_type  ; {257}
    LDA $return_area      ; {260}
    STA $area_next        ; {263}
    LDA $return_scene     ; {266}
    STA $scene_next       ; {269}
    REP #$20              ; {272}
    LDA $return_x         ; {274}
    STA $warp_dest_x      ; {277}
    LDA $return_y         ; {280}
    STA $warp_dest_y      ; {283}
    SEP #$20              ; {286}
    JSL $@lib_0118FC_part8.code_0131A2 ; {288}
    BRL loc_000032        ; {292}
}

code_000127 {
    PHB                   ; {295}
    PHA                   ; {296}
    XBA                   ; {297}
    PHA                   ; {298}
    PHX                   ; {299}
    PHY                   ; {300}
    JSL $@lib_0118FC_part8.code_0131AE ; {301}
    INC $03A6             ; {305}
    JSL $@lib_01185E.code_01185E ; {308}
    JSL $@code_0005A6     ; {312}
    JSL $@code_0005C4     ; {316}
    JSL $@lib_010000.code_010000 ; {320}
    JSL $@lib_010069.code_010069 ; {324}
    JSL $@lib_01010B.code_01010B ; {328}
    JSL $@code_0006EE     ; {332}
    LDA $0462             ; {336}
    BNE loc_00015D        ; {339}
    JSL $@lib_0118FC_part6.code_012659 ; {341}
    JSL $@lib_011695.code_011695 ; {345}

  loc_00015D:
    JSL $@lib_027223.code_027223 ; {349}
    STZ $03A6             ; {353}
    JSL $@lib_0118FC_part8.code_0131A2 ; {356}
    JSL $@lib_shared_0131B7.code_0131B7 ; {360}
    PLY                   ; {364}
    PLX                   ; {365}
    PLA                   ; {366}
    XBA                   ; {367}
    PLA                   ; {368}
    PLB                   ; {369}
    RTL                   ; {370}
}

code_000173 {
    PHB                   ; {371}
    PHA                   ; {372}
    XBA                   ; {373}
    PHA                   ; {374}
    PHX                   ; {375}
    PHY                   ; {376}
    LDA #$01              ; {377}
    PHA                   ; {379}
    PLB                   ; {380}
    INC $03A6             ; {381}
    JSL $@lib_01185E.code_01185E ; {384}
    JSL $@code_0005A6     ; {388}
    JSL $@code_0005C4     ; {392}
    JSL $@lib_010069.code_010069 ; {396}
    JSL $@lib_01010B.code_01010B ; {400}
    JSL $@code_0006EE     ; {404}
    JSL $@lib_0118FC_part6.code_012659 ; {408}
    JSL $@lib_011695.code_011695 ; {412}
    JSL $@lib_027223.code_027223 ; {416}
    JSL $@lib_010EEA.code_010EEA ; {420}
    JSL $@lib_0118FC_part8.code_0131A2 ; {424}
    JSL $@lib_shared_0131B7.code_0131B7 ; {428}
    JSL $@lib_0118FC_part8.code_0131AE ; {432}
    STZ $03A6             ; {436}
    PLY                   ; {439}
    PLX                   ; {440}
    PLA                   ; {441}
    XBA                   ; {442}
    PLA                   ; {443}
    PLB                   ; {444}
    RTL                   ; {445}
}

code_0001BE {
    PHB                   ; {446}
    PHA                   ; {447}
    XBA                   ; {448}
    PHA                   ; {449}
    PHX                   ; {450}
    PHY                   ; {451}
    LDA #$01              ; {452}
    PHA                   ; {454}
    PLB                   ; {455}
    INC $03A6             ; {456}
    JSL $@lib_01185E.code_01185E ; {459}
    JSL $@code_0005A6     ; {463}
    JSL $@code_0005C4     ; {467}
    JSL $@lib_010069.code_010069 ; {471}
    JSL $@lib_01010B.code_01010B ; {475}
    JSL $@code_0006EE     ; {479}
    JSL $@lib_0118FC_part6.code_012659 ; {483}
    JSL $@lib_011695.code_011695 ; {487}
    JSL $@lib_027223.code_027223 ; {491}
    JSL $@lib_0118FC_part8.code_0131A2 ; {495}
    JSL $@lib_shared_0131B7.code_0131B7 ; {499}
    JSL $@lib_0118FC_part8.code_0131AE ; {503}
    STZ $03A6             ; {507}
    PLY                   ; {510}
    PLX                   ; {511}
    PLA                   ; {512}
    XBA                   ; {513}
    PLA                   ; {514}
    PLB                   ; {515}
    RTL                   ; {516}
}
---------------------------------------------

code_000205 {
    LDA $JOY2H            ; {517}
    BIT #$20              ; {520}
    BEQ loc_000210        ; {522}
    JSR $&code_00022B     ; {524}
    RTS                   ; {527}

  loc_000210:
    LDA $JOY2H            ; {528}
    BIT #$80              ; {531}
    BEQ loc_000223        ; {533}
    LDA #$1E              ; {535}

  loc_000219:
    PHA                   ; {537}
    JSL $@lib_shared_0131B7.code_0131B7 ; {538}
    PLA                   ; {542}
    DEC                   ; {543}
    BNE loc_000219        ; {544}
    RTS                   ; {546}

  loc_000223:
    BIT #$40              ; {547}
    BEQ loc_00022A        ; {549}
    JSR $&code_000271     ; {551}

  loc_00022A:
    RTS                   ; {554}
}

code_00022B {
    LDA #$00              ; {555}
    JSR $&code_000240     ; {557}
    LDA #$03              ; {560}
    JSR $&code_000240     ; {562}
    LDA #$04              ; {565}
    JSR $&code_000240     ; {567}
    LDA #$1F              ; {570}
    JSR $&code_000240     ; {572}
    RTS                   ; {575}
}

code_000240 {
    PHB                   ; {576}
    PHA                   ; {577}
    PLB                   ; {578}
    LDX #$8000            ; {579}

  loc_000246:
    LDA $0000, X          ; {582}
    CMP #$02              ; {585}
    BNE loc_00026C        ; {587}
    LDA $0001, X          ; {589}
    CMP #$01              ; {592}
    BNE loc_00026C        ; {594}
    LDA $0002, X          ; {596}
    CMP #$AA              ; {599}
    BNE loc_00026C        ; {601}
    LDY $0003, X          ; {603}
    BPL loc_00026C        ; {606}
    PHX                   ; {608}
    LDX #$040A            ; {609}
    STX $03F3             ; {612}
    JSL $@lib_shared_012769.code_012C27 ; {615}
    PLX                   ; {619}

  loc_00026C:
    INX                   ; {620}
    BNE loc_000246        ; {621}
    PLB                   ; {623}
    RTS                   ; {624}
}

code_000271 {
    LDA $area_current     ; {625}
    JSR $&code_0002FC     ; {628}
    STA $1F06             ; {631}
    LDA $area_current     ; {634}
    JSR $&code_000300     ; {637}
    STA $1F07             ; {640}
    LDA $scene_current    ; {643}
    JSR $&code_0002FC     ; {646}
    STA $1F09             ; {649}
    LDA $scene_current    ; {652}
    JSR $&code_000300     ; {655}
    STA $1F0A             ; {658}
    LDA $location_id      ; {661}
    JSR $&code_0002FC     ; {664}
    STA $1F0C             ; {667}
    LDA $location_id      ; {670}
    JSR $&code_000300     ; {673}
    STA $1F0D             ; {676}
    LDA $player_tile_x    ; {679}
    JSR $&code_0002FC     ; {682}
    STA $1F0F             ; {685}
    LDA $player_tile_x    ; {688}
    JSR $&code_000300     ; {691}
    STA $1F10             ; {694}
    LDA $player_x         ; {697}
    JSR $&code_000300     ; {700}
    STA $1F12             ; {703}
    LDA $player_tile_y    ; {706}
    JSR $&code_0002FC     ; {709}
    STA $1F14             ; {712}
    LDA $player_tile_y    ; {715}
    JSR $&code_000300     ; {718}
    STA $1F15             ; {721}
    LDA $player_y         ; {724}
    JSR $&code_000300     ; {727}
    STA $1F17             ; {730}
    LDA $1F00             ; {733}
    JSR $&code_0002FC     ; {736}
    STA $1F19             ; {739}
    LDA $1F00             ; {742}
    JSR $&code_000300     ; {745}
    STA $1F1A             ; {748}
    LDY #$1F02            ; {751}
    JSL $@lib_shared_012769.code_012769 ; {754}
    LDA #$01              ; {758}
    STA $vram_upload_flags ; {760}
    RTS                   ; {763}
}

code_0002FC {
    LSR                   ; {764}
    LSR                   ; {765}
    LSR                   ; {766}
    LSR                   ; {767}
}

code_000300 {
    REP #$20              ; {768}
    AND #$000F            ; {770}
    TAX                   ; {773}
    LDA $@binary_00030D, X ; {774}
    SEP #$20              ; {778}
    RTS                   ; {780}
}
---------------------------------------------

binary_00030D #30313233343536373839414243444546
---------------------------------------------

code_00031D {
    LDA $0484             ; {797}
    BNE loc_000323        ; {800}
    RTS                   ; {802}

  loc_000323:
    AND #$F0              ; {803}
    LSR                   ; {805}
    LSR                   ; {806}
    LSR                   ; {807}
    LSR                   ; {808}
    XBA                   ; {809}
    LDA #$0A              ; {810}
    JSL $@lib_shared_0131D1.code_0131D1 ; {812}
    PHA                   ; {816}
    LDA $0484             ; {817}
    AND #$0F              ; {820}
    CLC                   ; {822}
    ADC $01, S            ; {823}
    JSL $@lib_0109D6_part3.code_0120F9 ; {825}
    PLA                   ; {829}
    STZ $0484             ; {830}
    RTS                   ; {833}
}
---------------------------------------------

native_mode_nmi_000342 {
    PHP                   ; {834}
    PHB                   ; {835}
    REP #$30              ; {836}
    PHA                   ; {838}
    PHX                   ; {839}
    PHY                   ; {840}
    SEP #$20              ; {841}
    REP #$10              ; {843}
    CLD                   ; {845}
    LDA #$01              ; {846}
    PHA                   ; {848}
    PLB                   ; {849}
    STZ $HDMAEN           ; {850}
    JSR $&code_0003C5     ; {853}
    JSR $&code_0003EA     ; {856}
    JSR $&code_000421     ; {859}
    JSR $&code_00046E     ; {862}
    JSR $&code_0004C8     ; {865}
    JSR $&code_0004E5     ; {868}
    JSR $&code_000543     ; {871}
    JSR $&code_00058B     ; {874}
    JSL $@engine_006B7F.code_006B7F ; {877}

  loc_000371:
    LDA $HVBJOY           ; {881}
    ROR                   ; {884}
    BCS loc_000371        ; {885}
    LDA $42               ; {887}
    STA $HDMAEN           ; {889}
    REP #$30              ; {892}
    INC $frame_counter    ; {894}
    LDA $0468             ; {897}
    BNE loc_0003AA        ; {900}
    LDA $JOY1L            ; {902}
    XBA                   ; {905}
    LSR                   ; {906}
    AND #$2000            ; {907}
    ORA $JOY1L            ; {910}
    PHA                   ; {913}
    LDA $joy_block_mask   ; {914}
    EOR #$FFFF            ; {917}
    AND $01, S            ; {920}
    STA $joy_pressed      ; {922}
    PLA                   ; {925}
    EOR #$FFFF            ; {926}
    ORA $joy_release_latch ; {929}
    STA $joy_release_latch ; {932}
    AND $joy_pressed      ; {935}

  loc_0003AA:
    STA $joy_pressed      ; {938}
    LDA $frame_counter    ; {941}
    LSR                   ; {944}
    LDA #$0000            ; {945}
    BCS loc_0003BC        ; {948}
    LDA $0398             ; {950}
    STZ $0398             ; {953}

  loc_0003BC:
    STA $APUIO2           ; {956}
    PLY                   ; {959}
    PLX                   ; {960}
    PLA                   ; {961}
    PLB                   ; {962}
    PLP                   ; {963}
    RTI                   ; {964}
}

code_0003C5 {
    LDX #$0000            ; {965}
    STX $OAMADDL          ; {968}
    STZ $DMAP0            ; {971}
    LDA #$04              ; {974}
    STA $BBAD0            ; {976}
    LDX #$0486            ; {979}
    STX $A1T0L            ; {982}
    LDA #$00              ; {985}
    STA $A1B0             ; {987}
    LDX #$0220            ; {990}
    STX $DAS0L            ; {993}
    LDA #$01              ; {996}
    STA $MDMAEN           ; {998}
    RTS                   ; {1001}
}

code_0003EA {
    STZ $CGADD            ; {1002}
    STZ $DMAP1            ; {1005}
    LDA #$22              ; {1008}
    STA $BBAD1            ; {1010}
    LDX #$0000            ; {1013}
    STX $A1T1L            ; {1016}
    LDA #$7F              ; {1019}
    STA $A1B1             ; {1021}
    LDX #$0200            ; {1024}
    STX $DAS1L            ; {1027}
    LDA #$02              ; {1030}
    STA $MDMAEN           ; {1032}
    LDA $coldata_buffer   ; {1035}
    STA $COLDATA          ; {1039}
    LDA $7F0201           ; {1042}
    STA $COLDATA          ; {1046}
    LDA $7F0202           ; {1049}
    STA $COLDATA          ; {1053}
    RTS                   ; {1056}
}

code_000421 {
    LDA $1C7C             ; {1057}
    BEQ loc_000427        ; {1060}
    RTS                   ; {1062}

  loc_000427:
    LDA $vram_upload_flags ; {1063}
    BNE loc_00042D        ; {1066}
    RTS                   ; {1068}

  loc_00042D:
    BIT #$02              ; {1069}
    BNE loc_000442        ; {1071}
    LDX #$5800            ; {1073}
    STX $VMADDL           ; {1076}
    LDX #$7000            ; {1079}
    STX $A1T2L            ; {1082}
    STZ $vram_upload_flags ; {1085}
    BRA loc_000453        ; {1088}

  loc_000442:
    LDX #$5C00            ; {1090}
    STX $VMADDL           ; {1093}
    LDX #$7800            ; {1096}
    STX $A1T2L            ; {1099}
    LDA #$02              ; {1102}
    TRB $vram_upload_flags ; {1104}

  loc_000453:
    LDA #$01              ; {1107}
    STA $DMAP2            ; {1109}
    LDA #$18              ; {1112}
    STA $BBAD2            ; {1114}
    LDA #$7F              ; {1117}
    STA $A1B2             ; {1119}
    LDX #$0800            ; {1122}
    STX $DAS2L            ; {1125}
    LDA #$04              ; {1128}
    STA $MDMAEN           ; {1130}
    RTS                   ; {1133}
}

code_00046E {
    LDA $scroll_bg3_x     ; {1134}
    STA $BG3HOFS          ; {1137}
    STZ $BG3HOFS          ; {1140}
    LDA $scroll_bg3_y     ; {1143}
    STA $BG3VOFS          ; {1146}
    STZ $BG3VOFS          ; {1149}
    LDA $03DB             ; {1152}
    BNE loc_000498        ; {1155}
    LDX #$0000            ; {1157}
    LDY #$0000            ; {1160}
    JSR $&code_0004AB     ; {1163}
    LDX #$0004            ; {1166}
    LDY #$0002            ; {1169}
    JSR $&code_0004AB     ; {1172}
    RTS                   ; {1175}

  loc_000498:
    LDX #$0004            ; {1176}
    LDY #$0000            ; {1179}
    JSR $&code_0004AB     ; {1182}
    LDX #$0000            ; {1185}
    LDY #$0002            ; {1188}
    JSR $&code_0004AB     ; {1191}
    RTS                   ; {1194}
}

code_0004AB {
    LDA $scroll_bg1_x, X  ; {1195}
    STA $BG1HOFS, Y       ; {1198}
    LDA $033B, X          ; {1201}
    AND #$03              ; {1204}
    STA $BG1HOFS, Y       ; {1206}
    LDA $scroll_bg1_y, X  ; {1209}
    STA $BG1VOFS, Y       ; {1212}
    LDA $033D, X          ; {1215}
    AND #$03              ; {1218}
    STA $BG1VOFS, Y       ; {1220}
    RTS                   ; {1223}
}

code_0004C8 {
    LDX #$3000            ; {1224}
    STX $32               ; {1227}
    LDX #$3102            ; {1229}
    STX $35               ; {1232}
    JSL $@lib_01020E_part2.code_01057D ; {1234}
    LDX #$3204            ; {1238}
    STX $32               ; {1241}
    LDX #$3306            ; {1243}
    STX $35               ; {1246}
    JSL $@lib_01020E_part2.code_01057D ; {1248}
    RTS                   ; {1252}
}

code_0004E5 {
    LDA $tile_dma_pending ; {1253}
    BNE loc_0004EB        ; {1256}
    RTS                   ; {1258}

  loc_0004EB:
    LDA #$18              ; {1259}
    STA $BBAD2            ; {1261}
    LDA #$01              ; {1264}
    STA $DMAP2            ; {1266}
    LDY #$0000            ; {1269}
    LDX #$2000            ; {1272}
    STX $VMADDL           ; {1275}
    JSR $&code_000524     ; {1278}
    LDX #$0000            ; {1281}

  loc_000504:
    LDY $tile_dma_list, X ; {1284}
    BEQ loc_000514        ; {1287}
    INC $1A07, X          ; {1289}
    INC $1A07, X          ; {1292}
    INX                   ; {1295}
    INX                   ; {1296}
    INX                   ; {1297}
    BRA loc_000504        ; {1298}

  loc_000514:
    LDY #$0000            ; {1300}
    LDX #$2100            ; {1303}
    STX $VMADDL           ; {1306}
    JSR $&code_000524     ; {1309}
    STZ $tile_dma_pending ; {1312}
    RTS                   ; {1315}
}

code_000524 {
    LDX $tile_dma_list, Y ; {1316}
    BEQ loc_000542        ; {1319}
    STX $A1T2L            ; {1321}
    LDA $1A08, Y          ; {1324}
    STA $A1B2             ; {1327}
    LDX #$0040            ; {1330}
    STX $DAS2L            ; {1333}
    LDA #$04              ; {1336}
    STA $MDMAEN           ; {1338}
    INY                   ; {1341}
    INY                   ; {1342}
    INY                   ; {1343}
    BRA code_000524       ; {1344}

  loc_000542:
    RTS                   ; {1346}
}

code_000543 {
    LDA $vram_strip_pending ; {1347}
    BNE loc_000549        ; {1350}
    RTS                   ; {1352}

  loc_000549:
    LDA #$01              ; {1353}
    STA $DMAP2            ; {1355}
    LDA #$18              ; {1358}
    STA $BBAD2            ; {1360}
    LDX $vram_strip_src   ; {1363}
    STX $A1T2L            ; {1366}
    LDA #$7F              ; {1369}
    STA $A1B2             ; {1371}
    LDX #$0040            ; {1374}
    STX $DAS2L            ; {1377}
    LDX $vram_strip_dest  ; {1380}
    STX $VMADDL           ; {1383}
    LDA #$04              ; {1386}
    STA $MDMAEN           ; {1388}
    LDX #$0040            ; {1391}
    STX $DAS2L            ; {1394}
    LDA $vram_strip_dest  ; {1397}
    STA $VMADDL           ; {1400}
    LDA $03E0             ; {1403}
    INC                   ; {1406}
    STA $VMADDH           ; {1407}
    LDA #$04              ; {1410}
    STA $MDMAEN           ; {1412}
    STZ $vram_strip_pending ; {1415}
    RTS                   ; {1418}
}

code_00058B {
    REP #$20              ; {1419}
    TSX                   ; {1421}
    LDA #$1C7A            ; {1422}
    TCS                   ; {1425}

  loc_000592:
    PLA                   ; {1426}
    BEQ loc_00059E        ; {1427}
    STA $VMADDL           ; {1429}
    PLA                   ; {1432}
    STA $VMDATAL          ; {1433}
    BRA loc_000592        ; {1436}

  loc_00059E:
    TXS                   ; {1438}
    STZ $vram_write_queue ; {1439}
    SEP #$20              ; {1442}
    RTS                   ; {1444}
}
---------------------------------------------

native_mode_irq_0005A5 {
    RTI                   ; {1445}
}

code_0005A6 {
    PHP                   ; {1446}
    PHB                   ; {1447}
    PEI ($38)             ; {1448}
    PEI ($39)             ; {1450}
    REP #$20              ; {1452}
    STZ $1F00             ; {1454}
    LDA $actor_list_tail  ; {1457}
    PEA $&code_0005BB-1   ; {1460}
    PEA $&code_0009BF-1   ; {1463}
    RTS                   ; {1466}
}

code_0005BB {
    PLX                   ; {1467}
    STX $39               ; {1468}
    PLX                   ; {1470}
    STX $38               ; {1471}
    PLB                   ; {1473}
    PLP                   ; {1474}
    RTL                   ; {1475}
}

code_0005C4 {
    PHP                   ; {1476}
    REP #$20              ; {1477}
    LDA $actor_list_head  ; {1479}
    LDY #$0000            ; {1482}

  loc_0005CD:
    TAX                   ; {1485}
    BNE loc_0005D3        ; {1486}
    BRL loc_00067A        ; {1488}

  loc_0005D3:
    LDA $0000, X          ; {1491}
    SEC                   ; {1494}
    SBC $0008, X          ; {1495}
    SEC                   ; {1498}
    SBC $scroll_bg1_x     ; {1499}
    CMP #$0100            ; {1502}
    BCC loc_0005F8        ; {1505}
    BMI loc_0005E8        ; {1507}
    BRL loc_00066B        ; {1509}

  loc_0005E8:
    LDA $0000, X          ; {1512}
    CLC                   ; {1515}
    ADC $000C, X          ; {1516}
    SEC                   ; {1519}
    SBC $scroll_bg1_x     ; {1520}
    CMP #$0100            ; {1523}
    BCS loc_00066B        ; {1526}

  loc_0005F8:
    LDA $0002, X          ; {1528}
    SEC                   ; {1531}
    SBC $000A, X          ; {1532}
    SEC                   ; {1535}
    SBC $scroll_bg1_y     ; {1536}
    CMP #$00E0            ; {1539}
    BCC loc_00061A        ; {1542}
    BPL loc_00066B        ; {1544}
    LDA $0002, X          ; {1546}
    CLC                   ; {1549}
    ADC $000E, X          ; {1550}
    SEC                   ; {1553}
    SBC $scroll_bg1_y     ; {1554}
    CMP #$00E0            ; {1557}
    BCS loc_00066B        ; {1560}

  loc_00061A:
    LDA $0016, X          ; {1562}
    BIT #$2000            ; {1565}
    BNE loc_00065C        ; {1568}
    LDA $001A, X          ; {1570}
    BIT #$0080            ; {1573}
    BNE loc_00065C        ; {1576}
    BIT #$6000            ; {1578}
    BEQ loc_000639        ; {1581}
    BIT #$4000            ; {1583}
    BNE loc_000645        ; {1586}
    LDA #$01FE            ; {1588}
    BRA loc_00064C        ; {1591}

  loc_000639:
    LDA $0002, X          ; {1593}
    SEC                   ; {1596}
    SBC $scroll_bg1_y     ; {1597}
    CMP #$0100            ; {1600}
    BCC loc_000648        ; {1603}

  loc_000645:
    LDA #$00FF            ; {1605}

  loc_000648:
    EOR #$00FF            ; {1608}
    ASL                   ; {1611}

  loc_00064C:
    CMP #$0200            ; {1612}
    BCS loc_00064C        ; {1615}
    STA $1900, Y          ; {1617}
    TXA                   ; {1620}
    STA $1902, Y          ; {1621}
    INY                   ; {1624}
    INY                   ; {1625}
    INY                   ; {1626}
    INY                   ; {1627}

  loc_00065C:
    LDA $0016, X          ; {1628}
    AND #$7FFF            ; {1631}
    STA $0016, X          ; {1634}
    LDA $003C, X          ; {1637}
    BRL loc_0005CD        ; {1640}

  loc_00066B:
    LDA $0016, X          ; {1643}
    ORA #$8000            ; {1646}
    STA $0016, X          ; {1649}
    LDA $003C, X          ; {1652}
    BRL loc_0005CD        ; {1655}

  loc_00067A:
    LDA #$FFFF            ; {1658}
    STA $1900, Y          ; {1661}
    LDA #$0486            ; {1664}
    STA $02               ; {1667}
    TSC                   ; {1669}
    STA $00               ; {1670}
    LDA #$18FF            ; {1672}
    TCS                   ; {1675}

  loc_00068C:
    PLX                   ; {1676}
    BMI loc_0006C6        ; {1677}
    LDY $0100, X          ; {1679}
    BNE loc_0006AE        ; {1682}
    LDA $02               ; {1684}
    STA $0100, X          ; {1686}
    TAY                   ; {1689}
    PLA                   ; {1690}
    STA $0000, Y          ; {1691}
    LDA #$0000            ; {1694}
    STA $0002, Y          ; {1697}
    LDA $02               ; {1700}
    CLC                   ; {1702}
    ADC #$0004            ; {1703}
    STA $02               ; {1706}
    BRA loc_00068C        ; {1708}

  loc_0006AE:
    LDA $02               ; {1710}
    STA $0100, X          ; {1712}
    TAX                   ; {1715}
    PLA                   ; {1716}
    STA $0000, X          ; {1717}
    TYA                   ; {1720}
    STA $0002, X          ; {1721}
    LDA $02               ; {1724}
    CLC                   ; {1726}
    ADC #$0004            ; {1727}
    STA $02               ; {1730}
    BRA loc_00068C        ; {1732}

  loc_0006C6:
    LDA #$00FF            ; {1734}
    TCS                   ; {1737}
    LDX #$0000            ; {1738}
    BRA loc_0006D1        ; {1741}

  loc_0006CF:
    PHA                   ; {1743}
    PLA                   ; {1744}

  loc_0006D1:
    PLY                   ; {1745}
    BEQ loc_0006D1        ; {1746}
    BMI loc_0006E6        ; {1748}

  loc_0006D6:
    LDA $0000, Y          ; {1750}
    STA $1900, X          ; {1753}
    INX                   ; {1756}
    INX                   ; {1757}
    LDA $0002, Y          ; {1758}
    BEQ loc_0006CF        ; {1761}
    TAY                   ; {1763}
    BRA loc_0006D6        ; {1764}

  loc_0006E6:
    STZ $1900, X          ; {1766}
    LDA $00               ; {1769}
    TCS                   ; {1771}
    PLP                   ; {1772}
    RTL                   ; {1773}
}

code_0006EE {
    PHB                   ; {1774}
    PHP                   ; {1775}
    SEP #$20              ; {1776}
    REP #$30              ; {1778}
    LDA #$1A06            ; {1780}
    STA $04               ; {1783}
    STZ $tile_dma_list    ; {1785}
    STZ $02               ; {1788}
    LDA $scroll_bg1_x     ; {1790}
    SEC                   ; {1793}
    SBC #$0010            ; {1794}
    STA $52               ; {1797}
    LDA $scroll_bg1_y     ; {1799}
    SEC                   ; {1802}
    SBC #$0010            ; {1803}
    STA $54               ; {1806}
    LDA #$0686            ; {1808}
    STA $4C               ; {1811}
    LDA #$0004            ; {1813}
    STA $4E               ; {1816}
    TSC                   ; {1818}
    STA $00               ; {1819}
    LDA #$0685            ; {1821}
    TCS                   ; {1824}
    LDX #$0010            ; {1825}
    LDA #$E080            ; {1828}

  loc_000727:
    PHA                   ; {1831}
    PHA                   ; {1832}
    PHA                   ; {1833}
    PHA                   ; {1834}
    PHA                   ; {1835}
    PHA                   ; {1836}
    PHA                   ; {1837}
    PHA                   ; {1838}
    PHA                   ; {1839}
    PHA                   ; {1840}
    PHA                   ; {1841}
    PHA                   ; {1842}
    PHA                   ; {1843}
    PHA                   ; {1844}
    PHA                   ; {1845}
    PHA                   ; {1846}
    DEX                   ; {1847}
    BNE loc_000727        ; {1848}
    LDA $00               ; {1850}
    TCS                   ; {1852}
    LDX #$0000            ; {1853}
    TXY                   ; {1856}

  loc_000741:
    LDA $1900, X          ; {1857}
    BEQ loc_000752        ; {1860}
    INX                   ; {1862}
    INX                   ; {1863}
    PHX                   ; {1864}
    TAX                   ; {1865}
    JSR $&code_000761     ; {1866}
    PLX                   ; {1869}
    BCS loc_00075E        ; {1870}
    BRA loc_000741        ; {1872}

  loc_000752:
    SEP #$20              ; {1874}
    LDA $00               ; {1876}

  loc_000756:
    LSR                   ; {1878}
    LSR                   ; {1879}
    DEC $4E               ; {1880}
    BNE loc_000756        ; {1882}
    STA ($4C)             ; {1884}

  loc_00075E:
    PLP                   ; {1886}
    PLB                   ; {1887}
    RTL                   ; {1888}
}

code_000761 {
    PHB                   ; {1889}
    PHX                   ; {1890}
    SEP #$20              ; {1891}
    LDA $0024, X          ; {1893}
    PHA                   ; {1896}
    PLB                   ; {1897}
    REP #$20              ; {1898}
    LDA $0000, X          ; {1900}
    SEC                   ; {1903}
    SBC $0008, X          ; {1904}
    SEC                   ; {1907}
    SBC $52               ; {1908}
    STA $16               ; {1910}
    LDA $0002, X          ; {1912}
    SEC                   ; {1915}
    SBC $000A, X          ; {1916}
    SEC                   ; {1919}
    SBC $54               ; {1920}
    STA $18               ; {1922}
    LDA $001C, X          ; {1924}
    STA $50               ; {1927}
    STZ $06               ; {1929}
    LDA $0016, X          ; {1931}
    BIT #$0800            ; {1934}
    BEQ loc_0007A6        ; {1937}
    LDA $0026, X          ; {1939}
    BMI loc_00079E        ; {1942}
    LSR                   ; {1944}
    BCS loc_0007A6        ; {1945}
    BRL loc_000827        ; {1947}

  loc_00079E:
    LSR                   ; {1950}
    BCS loc_0007A6        ; {1951}
    LDA #$0E00            ; {1953}
    STA $06               ; {1956}

  loc_0007A6:
    LDA $001A, X          ; {1958}
    BPL loc_0007AE        ; {1961}
    BRL loc_000832        ; {1963}

  loc_0007AE:
    LDA $0028, X          ; {1966}
    TAX                   ; {1969}
    LDA $0000, X          ; {1970}
    INX                   ; {1973}
    INX                   ; {1974}
    STA $0C               ; {1975}

  loc_0007B9:
    LDA $50               ; {1977}
    ASL                   ; {1979}
    LDA $0003, X          ; {1980}
    BCC loc_0007C2        ; {1983}
    XBA                   ; {1985}

  loc_0007C2:
    AND #$00FF            ; {1986}
    CLC                   ; {1989}
    ADC $18               ; {1990}
    CMP #$00F0            ; {1992}
    BCS loc_00082A        ; {1995}
    SBC #$0010            ; {1997}
    STA $0487, Y          ; {2000}
    LDA $0005, X          ; {2003}
    EOR $50               ; {2006}
    ORA $06               ; {2008}
    STA $0488, Y          ; {2010}
    LDA $50               ; {2013}
    ASL                   ; {2015}
    ASL                   ; {2016}
    LDA $0001, X          ; {2017}
    BCC loc_0007E7        ; {2020}
    XBA                   ; {2022}

  loc_0007E7:
    AND #$00FF            ; {2023}
    CLC                   ; {2026}
    ADC $16               ; {2027}
    CMP #$0110            ; {2029}
    BCS loc_00082A        ; {2032}
    SBC #$000F            ; {2034}
    SEP #$20              ; {2037}
    STA $oam_buffer, Y    ; {2039}
    XBA                   ; {2042}
    LSR                   ; {2043}
    ROR $00               ; {2044}
    LDA $0000, X          ; {2046}
    LSR                   ; {2049}
    ROR $00               ; {2050}
    DEC $4E               ; {2052}
    BNE loc_000812        ; {2054}
    LDA $00               ; {2056}
    STA ($4C)             ; {2058}
    INC $4C               ; {2060}
    LDA #$04              ; {2062}
    STA $4E               ; {2064}

  loc_000812:
    REP #$20              ; {2066}
    INY                   ; {2068}
    INY                   ; {2069}
    INY                   ; {2070}
    INY                   ; {2071}
    CPY #$0200            ; {2072}
    BEQ loc_000827        ; {2075}

  loc_00081D:
    TXA                   ; {2077}
    CLC                   ; {2078}
    ADC #$0007            ; {2079}
    TAX                   ; {2082}
    DEC $0C               ; {2083}
    BNE loc_0007B9        ; {2085}

  loc_000827:
    PLX                   ; {2087}
    PLB                   ; {2088}
    RTS                   ; {2089}

  loc_00082A:
    LDA #$E080            ; {2090}
    STA $oam_buffer, Y    ; {2093}
    BRA loc_00081D        ; {2096}

  loc_000832:
    LDA $0034, X          ; {2098}
    STA $1A02             ; {2101}
    LDA $002C, X          ; {2104}
    STA $1A04             ; {2107}
    LDA $0028, X          ; {2110}
    TAX                   ; {2113}
    LDA $0000, X          ; {2114}
    INX                   ; {2117}
    INX                   ; {2118}
    STA $0C               ; {2119}
    INC $tile_dma_pending ; {2121}

  loc_00084C:
    LDA $50               ; {2124}
    ASL                   ; {2126}
    LDA $0003, X          ; {2127}
    BCC loc_000855        ; {2130}
    XBA                   ; {2132}

  loc_000855:
    AND #$00FF            ; {2133}
    CLC                   ; {2136}
    ADC $18               ; {2137}
    CMP #$00F0            ; {2139}
    BCC loc_000863        ; {2142}
    BRL loc_0008EB        ; {2144}

  loc_000863:
    SBC #$0010            ; {2147}
    STA $0487, Y          ; {2150}
    LDA $0005, X          ; {2153}
    EOR $50               ; {2156}
    ORA $06               ; {2158}
    PHA                   ; {2160}
    AND #$01FF            ; {2161}
    ASL                   ; {2164}
    ASL                   ; {2165}
    ASL                   ; {2166}
    ASL                   ; {2167}
    ASL                   ; {2168}
    ADC $1A02             ; {2169}
    STA ($04)             ; {2172}
    INC $04               ; {2174}
    INC $04               ; {2176}
    LDA $1A04             ; {2178}
    STA ($04)             ; {2181}
    INC $04               ; {2183}
    PLA                   ; {2185}
    AND #$FE00            ; {2186}
    ORA $02               ; {2189}
    INC $02               ; {2191}
    INC $02               ; {2193}
    STA $0488, Y          ; {2195}
    LDA $50               ; {2198}
    ASL                   ; {2200}
    ASL                   ; {2201}
    LDA $0001, X          ; {2202}
    BCC loc_0008A0        ; {2205}
    XBA                   ; {2207}

  loc_0008A0:
    AND #$00FF            ; {2208}
    CLC                   ; {2211}
    ADC $16               ; {2212}
    CMP #$0110            ; {2214}
    BCS loc_0008EB        ; {2217}
    SBC #$000F            ; {2219}
    SEP #$20              ; {2222}
    STA $oam_buffer, Y    ; {2224}
    XBA                   ; {2227}
    LSR                   ; {2228}
    ROR $00               ; {2229}
    LDA $0000, X          ; {2231}
    LSR                   ; {2234}
    ROR $00               ; {2235}
    DEC $4E               ; {2237}
    BNE loc_0008CB        ; {2239}
    LDA $00               ; {2241}
    STA ($4C)             ; {2243}
    INC $4C               ; {2245}
    LDA #$04              ; {2247}
    STA $4E               ; {2249}

  loc_0008CB:
    REP #$20              ; {2251}
    INY                   ; {2253}
    INY                   ; {2254}
    INY                   ; {2255}
    INY                   ; {2256}
    CPY #$0200            ; {2257}
    BEQ loc_0008E3        ; {2260}

  loc_0008D6:
    TXA                   ; {2262}
    CLC                   ; {2263}
    ADC #$0007            ; {2264}
    TAX                   ; {2267}
    DEC $0C               ; {2268}
    BEQ loc_0008E3        ; {2270}
    BRL loc_00084C        ; {2272}

  loc_0008E3:
    LDA #$0000            ; {2275}
    STA ($04)             ; {2278}
    PLX                   ; {2280}
    PLB                   ; {2281}
    RTS                   ; {2282}

  loc_0008EB:
    LDA #$E080            ; {2283}
    STA $oam_buffer, Y    ; {2286}
    BRA loc_0008D6        ; {2289}
}

code_0008F3 {
    PHB                   ; {2291}
    SEP #$20              ; {2292}
    LDA $0024, X          ; {2294}
    PHA                   ; {2297}
    PLB                   ; {2298}
    REP #$20              ; {2299}
    LDA $001E, X          ; {2301}
    ASL                   ; {2304}
    CLC                   ; {2305}
    ADC $0022, X          ; {2306}
    TAY                   ; {2309}
    LDA $0020, X          ; {2310}
    ASL                   ; {2313}
    ASL                   ; {2314}
    ASL                   ; {2315}
    CLC                   ; {2316}
    ADC $0000, Y          ; {2317}
    TAY                   ; {2320}
    LDA $0000, Y          ; {2321}
    BPL loc_000919        ; {2324}
    BRL loc_0009B0        ; {2326}

  loc_000919:
    STA $0014, X          ; {2329}
    LDA $001C, X          ; {2332}
    ROL                   ; {2335}
    BPL loc_00092B        ; {2336}
    LDA #$0000            ; {2338}
    SEC                   ; {2341}
    SBC $0002, Y          ; {2342}
    BRA loc_00092E        ; {2345}

  loc_00092B:
    LDA $0002, Y          ; {2347}

  loc_00092E:
    STA $0004, X          ; {2350}
    LDA $001C, X          ; {2353}
    BPL loc_00093F        ; {2356}
    LDA #$0000            ; {2358}
    SEC                   ; {2361}
    SBC $0004, Y          ; {2362}
    BRA loc_000942        ; {2365}

  loc_00093F:
    LDA $0004, Y          ; {2367}

  loc_000942:
    STA $0006, X          ; {2370}
    LDA $0006, Y          ; {2373}
    TAY                   ; {2376}
    CLC                   ; {2377}
    ADC #$000C            ; {2378}
    STA $0028, X          ; {2381}
    LDA $001C, X          ; {2384}
    ROL                   ; {2387}
    PHP                   ; {2388}
    BPL loc_00096D        ; {2389}
    LDA $0002, Y          ; {2391}
    SEC                   ; {2394}
    SBC $0008, Y          ; {2395}
    STA $0008, X          ; {2398}
    LDA $0000, Y          ; {2401}
    CLC                   ; {2404}
    ADC $0008, Y          ; {2405}
    STA $000C, X          ; {2408}
    BRA loc_000979        ; {2411}

  loc_00096D:
    LDA $0000, Y          ; {2413}
    STA $0008, X          ; {2416}
    LDA $0002, Y          ; {2419}
    STA $000C, X          ; {2422}

  loc_000979:
    PLP                   ; {2425}
    BCC loc_000992        ; {2426}
    LDA $0006, Y          ; {2428}
    CLC                   ; {2431}
    ADC $000A, Y          ; {2432}
    STA $000A, X          ; {2435}
    LDA $0004, Y          ; {2438}
    SEC                   ; {2441}
    SBC $000A, Y          ; {2442}
    STA $000E, X          ; {2445}
    BRA loc_00099E        ; {2448}

  loc_000992:
    LDA $0004, Y          ; {2450}
    STA $000A, X          ; {2453}
    LDA $0006, Y          ; {2456}
    STA $000E, X          ; {2459}

  loc_00099E:
    LDA $0008, Y          ; {2462}
    STA $0010, X          ; {2465}
    LDA $000A, Y          ; {2468}
    STA $0012, X          ; {2471}
    INC $0020, X          ; {2474}
    CLC                   ; {2477}
    PLB                   ; {2478}
    RTL                   ; {2479}

  loc_0009B0:
    STZ $0020, X          ; {2480}
    STZ $0004, X          ; {2483}
    STZ $0006, X          ; {2486}
    SEC                   ; {2489}
    PLB                   ; {2490}
    RTL                   ; {2491}
}

code_0009BC {
    LDA $003E, X          ; {2492}
}

code_0009BF {
    TAX                   ; {2495}
    BEQ loc_000A33        ; {2496}
    INC $1F00             ; {2498}
    LDA $0016, X          ; {2501}
    BIT #$0800            ; {2504}
    BEQ loc_0009F9        ; {2507}
    LDA $0026, X          ; {2509}
    BPL loc_0009E1        ; {2512}
    INC $0026, X          ; {2514}
    BPL loc_0009F0        ; {2517}
    LDA $001A, X          ; {2519}
    BIT #$0040            ; {2522}
    BEQ loc_0009F9        ; {2525}
    BRA code_0009BC       ; {2527}

  loc_0009E1:
    DEC $0026, X          ; {2529}
    BEQ loc_0009F0        ; {2532}
    LDA $001A, X          ; {2534}
    BIT #$0040            ; {2537}
    BEQ loc_0009F9        ; {2540}
    BRA code_0009BC       ; {2542}

  loc_0009F0:
    LDA $0016, X          ; {2544}
    AND #$F7FF            ; {2547}
    STA $0016, X          ; {2550}

  loc_0009F9:
    LDA $03A6             ; {2553}
    BEQ loc_000A06        ; {2556}
    LDA $0016, X          ; {2558}
    BIT #$0010            ; {2561}
    BEQ code_0009BC       ; {2564}

  loc_000A06:
    DEC $0014, X          ; {2566}
    BPL code_000A22       ; {2569}
    STZ $0014, X          ; {2571}
    SEP #$20              ; {2574}
    LDA #$00              ; {2576}
    PHA                   ; {2578}
    PEA $&code_000A22-1   ; {2579}
    LDA $0036, X          ; {2582}
    PHA                   ; {2585}
    REP #$20              ; {2586}
    LDA $0018, X          ; {2588}
    DEC                   ; {2591}
    PHA                   ; {2592}
    RTL                   ; {2593}
}

code_000A22 {
    LDA $0016, X          ; {2594}
    BIT #$1000            ; {2597}
    BEQ loc_000A2E        ; {2600}
    JSL $@code_000F28     ; {2602}

  loc_000A2E:
    JSR $&code_00129A     ; {2606}
    BRA code_0009BC       ; {2609}

  loc_000A33:
    RTS                   ; {2611}
}

code_000A34 {
    PHP                   ; {2612}
    PHB                   ; {2613}
    REP #$20              ; {2614}
    LDX $player_actor     ; {2616}
    LDA $0016, X          ; {2619}
    BIT #$0400            ; {2622}
    BEQ loc_000A46        ; {2625}
    BRL loc_000AEF        ; {2627}

  loc_000A46:
    LDX #$0000            ; {2630}

  loc_000A49:
    LDY $1900, X          ; {2633}
    BNE loc_000A51        ; {2636}
    BRL loc_000AEF        ; {2638}

  loc_000A51:
    INX                   ; {2641}
    INX                   ; {2642}
    LDA $0016, Y          ; {2643}
    BIT #$0080            ; {2646}
    BEQ loc_000A49        ; {2649}
    BIT #$0D00            ; {2651}
    BNE loc_000A49        ; {2654}
    PHX                   ; {2656}
    SEP #$20              ; {2657}
    LDA $0024, Y          ; {2659}
    PHA                   ; {2662}
    PLB                   ; {2663}
    REP #$20              ; {2664}
    LDX #$0000            ; {2666}
    STY $3E               ; {2669}

  loc_000A6F:
    LDY $3E               ; {2671}
    LDA $0002, Y          ; {2673}
    SEC                   ; {2676}
    SBC $000A, Y          ; {2677}
    STA $00               ; {2680}
    LDA $0002, Y          ; {2682}
    CLC                   ; {2685}
    ADC $000E, Y          ; {2686}
    STA $02               ; {2689}
    LDA $0000, Y          ; {2691}
    SEC                   ; {2694}
    SBC $0008, Y          ; {2695}
    STA $04               ; {2698}
    LDA $0000, Y          ; {2700}
    CLC                   ; {2703}
    ADC $000C, Y          ; {2704}
    STA $06               ; {2707}

  loc_000A95:
    LDY $1900, X          ; {2709}
    BEQ loc_000AEB        ; {2712}
    INX                   ; {2714}
    INX                   ; {2715}
    LDA $0016, Y          ; {2716}
    BIT #$EEC0            ; {2719}
    BNE loc_000A95        ; {2722}
    LDA $0000, Y          ; {2724}
    SEC                   ; {2727}
    SBC $0008, Y          ; {2728}
    CMP $06               ; {2731}
    BCS loc_000A95        ; {2733}
    LDA $0000, Y          ; {2735}
    CLC                   ; {2738}
    ADC $000C, Y          ; {2739}
    CMP $04               ; {2742}
    BCC loc_000A95        ; {2744}
    LDA $0002, Y          ; {2746}
    SEC                   ; {2749}
    SBC $000A, Y          ; {2750}
    CMP $02               ; {2753}
    BCS loc_000A95        ; {2755}
    LDA $0002, Y          ; {2757}
    CLC                   ; {2760}
    ADC $000E, Y          ; {2761}
    CMP $00               ; {2764}
    BCC loc_000A95        ; {2766}
    JSR $&code_000D55     ; {2768}
    BCC loc_000A6F        ; {2771}
    PHX                   ; {2773}
    LDX $3E               ; {2774}
    LDA $0016, X          ; {2776}
    BIT #$0020            ; {2779}
    BNE loc_000AE5        ; {2782}
    JSR $&code_000AF2     ; {2784}
    BRA loc_000AE8        ; {2787}

  loc_000AE5:
    JSR $&code_000C67     ; {2789}

  loc_000AE8:
    PLX                   ; {2792}
    BRA loc_000A6F        ; {2793}

  loc_000AEB:
    PLX                   ; {2795}
    BRL loc_000A49        ; {2796}

  loc_000AEF:
    PLB                   ; {2799}
    PLP                   ; {2800}
    RTL                   ; {2801}
}

code_000AF2 {
    LDX $player_actor     ; {2802}
    LDA $001E, X          ; {2805}
    CMP #$0024            ; {2808}
    BCC loc_000AFE        ; {2811}
    RTS                   ; {2813}

  loc_000AFE:
    LDA $0016, Y          ; {2814}
    BIT #$0002            ; {2817}
    BEQ loc_000B09        ; {2820}

  loc_000B06:
    BRK #$4C              ; {2822}
    RTS                   ; {2824}

  loc_000B09:
    LDA $1B5E             ; {2825}
    CMP #$0008            ; {2828}
    BEQ loc_000B62        ; {2831}
    LDA $1B5E             ; {2833}
    CMP #$0002            ; {2836}
    BNE loc_000B3E        ; {2839}
    CPY $039A             ; {2841}
    BEQ loc_000B3E        ; {2844}
    LDA $001A, Y          ; {2846}
    BIT #$0E00            ; {2849}
    BEQ loc_000B62        ; {2852}
    LDA $001A, Y          ; {2854}
    ORA #$0040            ; {2857}
    STA $001A, Y          ; {2860}
    LDA $0016, Y          ; {2863}
    ORA #$0800            ; {2866}
    STA $0016, Y          ; {2869}
    LDA #$00B4            ; {2872}
    STA $0026, Y          ; {2875}

  loc_000B3E:
    LDA $001A, Y          ; {2878}
    BIT #$0800            ; {2881}
    BNE loc_000B51        ; {2884}
    BIT #$0400            ; {2886}
    BNE loc_000B5A        ; {2889}
    BIT #$0200            ; {2891}
    BEQ loc_000B62        ; {2894}
    RTS                   ; {2896}

  loc_000B51:
    LDA $1B5E             ; {2897}
    CMP #$0006            ; {2900}
    BEQ loc_000B62        ; {2903}
    RTS                   ; {2905}

  loc_000B5A:
    LDA $1B5E             ; {2906}
    CMP #$0005            ; {2909}
    BNE loc_000B06        ; {2912}

  loc_000B62:
    LDA $1B5E             ; {2914}
    CMP #$0003            ; {2917}
    BNE loc_000B77        ; {2920}
    CPY $039A             ; {2922}
    BEQ loc_000B77        ; {2925}
    LDA $frame_counter    ; {2927}
    AND #$000F            ; {2930}
    BEQ loc_000BE7        ; {2933}

  loc_000B77:
    SEP #$20              ; {2935}
    LDX $0038, Y          ; {2937}
    LDA $@meta_tables_008000+1, X ; {2940}
    STA $00               ; {2944}
    LDA $1B8C             ; {2946}
    SEC                   ; {2949}
    SBC $00               ; {2950}
    BEQ loc_000B8C        ; {2952}
    BCS loc_000B8E        ; {2954}

  loc_000B8C:
    LDA #$01              ; {2956}

  loc_000B8E:
    STA $00               ; {2958}
    LDA $1B64             ; {2960}
    CMP #$37              ; {2963}
    BEQ loc_000B9B        ; {2965}
    CMP #$35              ; {2967}
    BNE loc_000B9D        ; {2969}

  loc_000B9B:
    ASL $00               ; {2971}

  loc_000B9D:
    LDA $0025, Y          ; {2973}
    SEC                   ; {2976}
    SBC $00               ; {2977}
    BCC loc_000BE7        ; {2979}
    BEQ loc_000BE7        ; {2981}

  loc_000BA7:
    STA $0025, Y          ; {2983}
    REP #$20              ; {2986}
    CPY $039A             ; {2988}
    BEQ loc_000BC0        ; {2991}
    LDX $player_actor     ; {2993}
    LDA $001E, X          ; {2996}
    SEC                   ; {2999}
    SBC #$0020            ; {3000}
    CMP #$0004            ; {3003}
    BCC loc_000BCB        ; {3006}

  loc_000BC0:
    LDA $001A, Y          ; {3008}
    AND #$FFBF            ; {3011}
    STA $001A, Y          ; {3014}
    BRA loc_000BD4        ; {3017}

  loc_000BCB:
    LDA $001A, Y          ; {3019}
    ORA #$0040            ; {3022}
    STA $001A, Y          ; {3025}

  loc_000BD4:
    LDA #$FFF8            ; {3028}
    STA $0026, Y          ; {3031}
    LDA $0016, Y          ; {3034}
    ORA #$0800            ; {3037}
    STA $0016, Y          ; {3040}
    BRK #$42              ; {3043}
    BRA loc_000C44        ; {3045}

  loc_000BE7:
    REP #$20              ; {3047}
    LDA $001A, Y          ; {3049}
    BIT #$0100            ; {3052}
    SEP #$20              ; {3055}
    BEQ loc_000BF7        ; {3057}
    LDA #$01              ; {3059}
    BRA loc_000BA7        ; {3061}

  loc_000BF7:
    LDA #$^engine_0029EC.code_002A10 ; {3063}
    STA $0036, Y          ; {3065}
    LDA #$00              ; {3068}
    STA $0025, Y          ; {3070}
    REP #$20              ; {3073}
    LDA #$&engine_0029EC.code_002A10 ; {3075}
    STA $0018, Y          ; {3078}
    LDA #$0000            ; {3081}
    STA $0014, Y          ; {3084}
    LDA $0016, Y          ; {3087}
    ORA #$0400            ; {3090}
    STA $0016, Y          ; {3093}
    LDX $0038, Y          ; {3096}
    LDA $@meta_tables_008000+3, X ; {3099}
    JSL $@lib_027614.code_027687 ; {3103}
    LDA #$0002            ; {3107}
    TSB $0332             ; {3110}
    LDA $1B5E             ; {3113}
    CMP #$0007            ; {3116}
    BNE loc_000C42        ; {3119}
    LDA $player_hp        ; {3121}
    CMP $player_max_hp    ; {3124}
    BEQ loc_000C42        ; {3127}
    INC $player_hp        ; {3129}
    LDA #$0004            ; {3132}
    TSB $0332             ; {3135}

  loc_000C42:
    BRK #$43              ; {3138}

  loc_000C44:
    LDA $0016, Y          ; {3140}
    BIT #$0001            ; {3143}
    BEQ loc_000C4D        ; {3146}
    RTS                   ; {3148}

  loc_000C4D:
    SEP #$20              ; {3149}
    LDA $0025, Y          ; {3151}
    STA $0336             ; {3154}
    LDX $0038, Y          ; {3157}
    LDA $@meta_tables_008000+2, X ; {3160}
    STA $0338             ; {3164}
    LDA #$80              ; {3167}
    STA $0330             ; {3169}
    REP #$20              ; {3172}
    RTS                   ; {3174}
}

code_000C67 {
    LDA $0016, Y          ; {3175}
    BIT #$0002            ; {3178}
    BEQ loc_000C72        ; {3181}

  loc_000C6F:
    BRK #$4C              ; {3183}
    RTS                   ; {3185}

  loc_000C72:
    LDA $0030, X          ; {3186}
    CMP #$00FF            ; {3189}
    BEQ loc_000C95        ; {3192}
    LDA $1B62             ; {3194}
    CMP #$0018            ; {3197}
    BEQ loc_000CA4        ; {3200}
    CPY $039A             ; {3202}
    BEQ loc_000C6F        ; {3205}
    LDA $001A, Y          ; {3207}
    BIT #$0A00            ; {3210}
    BEQ loc_000C90        ; {3213}
    RTS                   ; {3215}

  loc_000C90:
    BIT #$0400            ; {3216}
    BNE loc_000C6F        ; {3219}

  loc_000C95:
    SEP #$20              ; {3221}
    LDA $0025, Y          ; {3223}
    SEC                   ; {3226}
    SBC $0030, X          ; {3227}
    BCC loc_000CEC        ; {3230}
    BEQ loc_000CEC        ; {3232}
    BRA loc_000CCB        ; {3234}

  loc_000CA4:
    SEP #$20              ; {3236}
    LDX $0038, Y          ; {3238}
    LDA $@meta_tables_008000+1, X ; {3241}
    STA $00               ; {3245}
    LDA $1B70             ; {3247}
    CLC                   ; {3250}
    ADC $1B72             ; {3251}
    SEC                   ; {3254}
    SBC $00               ; {3255}
    BEQ loc_000CBD        ; {3257}
    BCS loc_000CBF        ; {3259}

  loc_000CBD:
    LDA #$01              ; {3261}

  loc_000CBF:
    STA $00               ; {3263}
    LDA $0025, Y          ; {3265}
    SEC                   ; {3268}
    SBC $00               ; {3269}
    BCC loc_000CEC        ; {3271}
    BEQ loc_000CEC        ; {3273}

  loc_000CCB:
    STA $0025, Y          ; {3275}
    REP #$20              ; {3278}
    LDA #$FFF8            ; {3280}
    STA $0026, Y          ; {3283}
    LDA $0016, Y          ; {3286}
    ORA #$0800            ; {3289}
    STA $0016, Y          ; {3292}
    LDA $001A, Y          ; {3295}
    AND #$FFBF            ; {3298}
    STA $001A, Y          ; {3301}
    BRK #$42              ; {3304}
    BRA loc_000D32        ; {3306}

  loc_000CEC:
    REP #$20              ; {3308}
    LDA $001A, Y          ; {3310}
    BIT #$0100            ; {3313}
    SEP #$20              ; {3316}
    BEQ loc_000CFC        ; {3318}
    LDA #$01              ; {3320}
    BRA loc_000CCB        ; {3322}

  loc_000CFC:
    SEP #$20              ; {3324}
    LDA #$^engine_0029EC.code_002A10 ; {3326}
    STA $0036, Y          ; {3328}
    LDA #$00              ; {3331}
    STA $0025, Y          ; {3333}
    REP #$20              ; {3336}
    LDA #$&engine_0029EC.code_002A10 ; {3338}
    STA $0018, Y          ; {3341}
    LDA #$0000            ; {3344}
    STA $0014, Y          ; {3347}
    LDA $0016, Y          ; {3350}
    ORA #$0400            ; {3353}
    STA $0016, Y          ; {3356}
    LDX $0038, Y          ; {3359}
    LDA $@meta_tables_008000+3, X ; {3362}
    JSL $@lib_027614.code_027687 ; {3366}
    LDA #$0002            ; {3370}
    TSB $0332             ; {3373}
    BRK #$43              ; {3376}

  loc_000D32:
    LDA $0016, Y          ; {3378}
    BIT #$0001            ; {3381}
    BEQ loc_000D3B        ; {3384}
    RTS                   ; {3386}

  loc_000D3B:
    SEP #$20              ; {3387}
    LDA $0025, Y          ; {3389}
    STA $0336             ; {3392}
    LDX $0038, Y          ; {3395}
    LDA $@meta_tables_008000+2, X ; {3398}
    STA $0338             ; {3402}
    LDA #$80              ; {3405}
    STA $0330             ; {3407}
    REP #$20              ; {3410}
    RTS                   ; {3412}
}

code_000D55 {
    PHX                   ; {3413}
    PHY                   ; {3414}
    TYX                   ; {3415}
    LDY $3E               ; {3416}
    LDA $0002, X          ; {3418}
    SEC                   ; {3421}
    SBC $000A, X          ; {3422}
    STA $00               ; {3425}
    LDA $0002, X          ; {3427}
    CLC                   ; {3430}
    ADC $000E, X          ; {3431}
    STA $02               ; {3434}
    LDA $0000, X          ; {3436}
    SEC                   ; {3439}
    SBC $0008, X          ; {3440}
    STA $04               ; {3443}
    LDA $0000, X          ; {3445}
    CLC                   ; {3448}
    ADC $000C, X          ; {3449}
    STA $06               ; {3452}
    LDA $0000, Y          ; {3454}
    SEC                   ; {3457}
    SBC $0008, Y          ; {3458}
    STA $08               ; {3461}
    LDA $0002, Y          ; {3463}
    SEC                   ; {3466}
    SBC $000A, Y          ; {3467}
    STA $0A               ; {3470}
    LDX $0028, Y          ; {3472}
    LDA $0000, X          ; {3475}
    STA $0C               ; {3478}
    INX                   ; {3480}
    INX                   ; {3481}

  loc_000D9A:
    LDA $0000, X          ; {3482}
    LSR                   ; {3485}
    BCC loc_000DA5        ; {3486}
    LDA #$000F            ; {3488}
    BRA loc_000DA8        ; {3491}

  loc_000DA5:
    LDA #$0007            ; {3493}

  loc_000DA8:
    PHA                   ; {3496}
    LDA $001C, Y          ; {3497}
    ASL                   ; {3500}
    ASL                   ; {3501}
    LDA $0001, X          ; {3502}
    BCC loc_000DB4        ; {3505}
    XBA                   ; {3507}

  loc_000DB4:
    AND #$00FF            ; {3508}
    CLC                   ; {3511}
    ADC $08               ; {3512}
    CMP $06               ; {3514}
    BCS loc_000DE5        ; {3516}
    CLC                   ; {3518}
    ADC $01, S            ; {3519}
    CMP $04               ; {3521}
    BCC loc_000DE5        ; {3523}
    LDA $001C, Y          ; {3525}
    ASL                   ; {3528}
    LDA $0003, X          ; {3529}
    BCC loc_000DCF        ; {3532}
    XBA                   ; {3534}

  loc_000DCF:
    AND #$00FF            ; {3535}
    CLC                   ; {3538}
    ADC $0A               ; {3539}
    CMP $02               ; {3541}
    BCS loc_000DE5        ; {3543}
    CLC                   ; {3545}
    ADC $01, S            ; {3546}
    CMP $00               ; {3548}
    BCC loc_000DE5        ; {3550}
    PLA                   ; {3552}
    PLY                   ; {3553}
    PLX                   ; {3554}
    SEC                   ; {3555}
    RTS                   ; {3556}

  loc_000DE5:
    PLA                   ; {3557}
    TXA                   ; {3558}
    CLC                   ; {3559}
    ADC #$0007            ; {3560}
    TAX                   ; {3563}
    DEC $0C               ; {3564}
    BNE loc_000D9A        ; {3566}
    PLY                   ; {3568}
    PLX                   ; {3569}
    CLC                   ; {3570}
    RTS                   ; {3571}
}

code_000DF4 {
    PHP                   ; {3572}
    REP #$30              ; {3573}
    LDA $042D             ; {3575}
    BNE loc_000E5F        ; {3578}
    LDY $player_actor     ; {3580}
    LDA $0000, Y          ; {3583}
    CLC                   ; {3586}
    ADC #$0005            ; {3587}
    STA $16               ; {3590}
    CLC                   ; {3592}
    ADC #$0007            ; {3593}
    STA $1A               ; {3596}
    LDA $0002, Y          ; {3598}
    SEC                   ; {3601}
    SBC #$0004            ; {3602}
    STA $1C               ; {3605}
    SEC                   ; {3607}
    SBC #$0008            ; {3608}
    STA $18               ; {3611}
    LDA $0016, Y          ; {3613}
    BIT #$0400            ; {3616}
    BNE loc_000E5F        ; {3619}
    BIT #$0800            ; {3621}
    BNE loc_000E61        ; {3624}
    LDY #$0000            ; {3626}

  loc_000E2D:
    LDX $1900, Y          ; {3629}
    BEQ loc_000E5F        ; {3632}
    INY                   ; {3634}
    INY                   ; {3635}
    LDA $0016, X          ; {3636}
    BIT #$25C0            ; {3639}
    BNE loc_000E2D        ; {3642}
    LDA $0000, X          ; {3644}
    CMP $1A               ; {3647}
    BCS loc_000E2D        ; {3649}
    CLC                   ; {3651}
    ADC $0010, X          ; {3652}
    CMP $16               ; {3655}
    BCC loc_000E2D        ; {3657}
    LDA $0002, X          ; {3659}
    CMP $18               ; {3662}
    BCC loc_000E2D        ; {3664}
    SEC                   ; {3666}
    SBC $0012, X          ; {3667}
    CMP $1C               ; {3670}
    BCS loc_000E2D        ; {3672}
    JSR $&code_000E9D     ; {3674}
    BCS loc_000E2D        ; {3677}

  loc_000E5F:
    PLP                   ; {3679}
    RTL                   ; {3680}

  loc_000E61:
    LDY #$0000            ; {3681}

  loc_000E64:
    LDX $1900, Y          ; {3684}
    BEQ loc_000E9B        ; {3687}
    INY                   ; {3689}
    INY                   ; {3690}
    LDA $0016, X          ; {3691}
    BIT #$25C0            ; {3694}
    BNE loc_000E64        ; {3697}
    BIT #$4000            ; {3699}
    BEQ loc_000E64        ; {3702}
    LDA $0000, X          ; {3704}
    CMP $1A               ; {3707}
    BCS loc_000E64        ; {3709}
    CLC                   ; {3711}
    ADC $0010, X          ; {3712}
    CMP $16               ; {3715}
    BCC loc_000E64        ; {3717}
    LDA $0002, X          ; {3719}
    CMP $18               ; {3722}
    BCC loc_000E64        ; {3724}
    SEC                   ; {3726}
    SBC $0012, X          ; {3727}
    CMP $1C               ; {3730}
    BCS loc_000E64        ; {3732}
    JSR $&code_000E9D     ; {3734}
    BCS loc_000E64        ; {3737}

  loc_000E9B:
    PLP                   ; {3739}
    RTL                   ; {3740}
}

code_000E9D {
    LDA $0016, X          ; {3741}
    BIT #$4000            ; {3744}
    BNE loc_000F22        ; {3747}
    LDA $1B60             ; {3749}
    CMP #$000E            ; {3752}
    BNE loc_000EC3        ; {3755}
    SEP #$20              ; {3757}
    LDY $0038, X          ; {3759}
    LDA $&meta_tables_008000, Y ; {3762}
    LSR                   ; {3765}
    CLC                   ; {3766}
    ADC $&meta_tables_008000, Y ; {3767}
    CMP $1B8E             ; {3770}
    BCS loc_000EC3        ; {3773}
    BRK #$0C              ; {3775}
    BRA loc_000F20        ; {3777}

  loc_000EC3:
    SEP #$20              ; {3779}
    LDY $0038, X          ; {3781}
    LDA $&meta_tables_008000, Y ; {3784}
    DEC                   ; {3787}
    SEC                   ; {3788}
    SBC $1B8E             ; {3789}
    BCS loc_000ED4        ; {3792}
    LDA #$00              ; {3794}

  loc_000ED4:
    STA $00               ; {3796}
    LDA $1B64             ; {3798}
    CMP #$37              ; {3801}
    BEQ loc_000EE1        ; {3803}
    CMP #$36              ; {3805}
    BNE loc_000EE3        ; {3807}

  loc_000EE1:
    LSR $00               ; {3809}

  loc_000EE3:
    LDA $00               ; {3811}
    BNE loc_000EE8        ; {3813}
    INC                   ; {3815}

  loc_000EE8:
    PHA                   ; {3816}
    LDA $player_hp        ; {3817}
    SEC                   ; {3820}
    SBC $01, S            ; {3821}
    BPL loc_000EF3        ; {3823}
    LDA #$00              ; {3825}

  loc_000EF3:
    STA $player_hp        ; {3827}
    PLA                   ; {3830}
    REP #$20              ; {3831}
    LDA #$0004            ; {3833}
    TSB $0332             ; {3836}
    LDX $player_actor     ; {3839}
    LDA $1B60             ; {3842}
    CMP #$000D            ; {3845}
    BNE loc_000F0F        ; {3848}
    LDA #$FFC0            ; {3850}
    BRA loc_000F12        ; {3853}

  loc_000F0F:
    LDA #$FFE0            ; {3855}

  loc_000F12:
    STA $0026, X          ; {3858}
    BRK #$04              ; {3861}
    LDA $0016, X          ; {3863}
    ORA #$0800            ; {3866}
    STA $0016, X          ; {3869}

  loc_000F20:
    CLC                   ; {3872}
    RTS                   ; {3873}

  loc_000F22:
    JSL $@engine_002EC0.code_002F0A ; {3874}
    SEC                   ; {3878}
    RTS                   ; {3879}
}

code_000F28 {
    LDA $0010, X          ; {3880}
    ORA $0012, X          ; {3883}
    AND #$0008            ; {3886}
    BNE loc_000F52        ; {3889}
    LDA $0004, X          ; {3891}
    BEQ loc_000F42        ; {3894}
    BMI loc_000F3F        ; {3896}
    JSR $&code_000F56     ; {3898}
    BRA loc_000F42        ; {3901}

  loc_000F3F:
    JSR $&code_000FFF     ; {3903}

  loc_000F42:
    LDA $0006, X          ; {3906}
    BEQ loc_000F51        ; {3909}
    BMI loc_000F4E        ; {3911}
    JSR $&code_0010AF     ; {3913}
    BRA loc_000F51        ; {3916}

  loc_000F4E:
    JSR $&code_001154     ; {3918}

  loc_000F51:
    RTL                   ; {3921}

  loc_000F52:
    JSR $&code_001208     ; {3922}
    RTL                   ; {3925}
}

code_000F56 {
    PHP                   ; {3926}
    LDA $0000, X          ; {3927}
    CLC                   ; {3930}
    ADC $0010, X          ; {3931}
    SEC                   ; {3934}
    SBC #$0010            ; {3935}
    LSR                   ; {3938}
    LSR                   ; {3939}
    LSR                   ; {3940}
    LSR                   ; {3941}
    STA $16               ; {3942}
    LDA $0002, X          ; {3944}
    SEC                   ; {3947}
    SBC $0012, X          ; {3948}
    LSR                   ; {3951}
    LSR                   ; {3952}
    LSR                   ; {3953}
    LSR                   ; {3954}
    STA $18               ; {3955}
    STA $1C               ; {3957}
    LDA $0002, X          ; {3959}
    DEC                   ; {3962}
    LSR                   ; {3963}
    LSR                   ; {3964}
    LSR                   ; {3965}
    LSR                   ; {3966}
    STA $00               ; {3967}
    LDA $0012, X          ; {3969}
    LSR                   ; {3972}
    LSR                   ; {3973}
    LSR                   ; {3974}
    LSR                   ; {3975}
    STA $0C               ; {3976}
    STA $0E               ; {3978}
    SEP #$20              ; {3980}

  loc_000F8E:
    JSR $&code_001256     ; {3982}
    CMP #$0A              ; {3985}
    BEQ loc_000FE4        ; {3987}
    INC $18               ; {3989}
    DEC $0C               ; {3991}
    BNE loc_000F8E        ; {3993}
    LDA $00               ; {3995}
    STA $18               ; {3997}
    JSR $&code_001256     ; {3999}
    CMP #$0A              ; {4002}
    BEQ loc_000FE4        ; {4004}
    LDA $1C               ; {4006}
    STA $18               ; {4008}
    INC $16               ; {4010}

  loc_000FAC:
    JSR $&code_001256     ; {4012}
    BCS loc_000FFC        ; {4015}
    CMP #$0F              ; {4017}
    BEQ loc_000FE4        ; {4019}
    CMP #$05              ; {4021}
    BEQ loc_000FE4        ; {4023}
    CMP #$06              ; {4025}
    BEQ loc_000FE4        ; {4027}
    INC $18               ; {4029}
    DEC $0E               ; {4031}
    BNE loc_000FAC        ; {4033}
    LDA $00               ; {4035}
    STA $18               ; {4037}
    JSR $&code_001256     ; {4039}
    BCS loc_000FFC        ; {4042}
    CMP #$0F              ; {4044}
    BEQ loc_000FE4        ; {4046}
    CMP #$05              ; {4048}
    BEQ loc_000FE4        ; {4050}
    CMP #$06              ; {4052}
    BEQ loc_000FE4        ; {4054}
    PLP                   ; {4056}
    LDA $0016, X          ; {4057}
    AND #$FFFB            ; {4060}
    STA $0016, X          ; {4063}
    CLC                   ; {4066}
    RTS                   ; {4067}

  loc_000FE4:
    PLP                   ; {4068}
    LDA $0016, X          ; {4069}
    ORA #$0004            ; {4072}
    STA $0016, X          ; {4075}

  loc_000FEE:
    LDA $0000, X          ; {4078}
    AND #$FFF0            ; {4081}
    STA $0000, X          ; {4084}
    STZ $0004, X          ; {4087}
    SEC                   ; {4090}
    RTS                   ; {4091}

  loc_000FFC:
    PLP                   ; {4092}
    BRA loc_000FEE        ; {4093}
}

code_000FFF {
    PHP                   ; {4095}
    LDA $0004, X          ; {4096}
    CLC                   ; {4099}
    ADC $0000, X          ; {4100}
    EOR $0000, X          ; {4103}
    AND #$FFF0            ; {4106}
    BEQ loc_001088        ; {4109}
    LDA $0000, X          ; {4111}
    LSR                   ; {4114}
    LSR                   ; {4115}
    LSR                   ; {4116}
    LSR                   ; {4117}
    STA $16               ; {4118}
    LDA $0002, X          ; {4120}
    SEC                   ; {4123}
    SBC $0012, X          ; {4124}
    LSR                   ; {4127}
    LSR                   ; {4128}
    LSR                   ; {4129}
    LSR                   ; {4130}
    STA $18               ; {4131}
    STA $1C               ; {4133}
    LDA $0002, X          ; {4135}
    DEC                   ; {4138}
    LSR                   ; {4139}
    LSR                   ; {4140}
    LSR                   ; {4141}
    LSR                   ; {4142}
    STA $00               ; {4143}
    LDA $0012, X          ; {4145}
    LSR                   ; {4148}
    LSR                   ; {4149}
    LSR                   ; {4150}
    LSR                   ; {4151}
    STA $0C               ; {4152}
    STA $0E               ; {4154}
    SEP #$20              ; {4156}

  loc_00103E:
    JSR $&code_001256     ; {4158}
    CMP #$05              ; {4161}
    BEQ loc_001094        ; {4163}
    INC $18               ; {4165}
    DEC $0C               ; {4167}
    BNE loc_00103E        ; {4169}
    LDA $00               ; {4171}
    STA $18               ; {4173}
    JSR $&code_001256     ; {4175}
    CMP #$05              ; {4178}
    BEQ loc_001094        ; {4180}
    LDA $1C               ; {4182}
    STA $18               ; {4184}
    DEC $16               ; {4186}

  loc_00105C:
    JSR $&code_001256     ; {4188}
    BCS loc_0010AC        ; {4191}
    CMP #$0F              ; {4193}
    BEQ loc_001094        ; {4195}
    CMP #$0A              ; {4197}
    BEQ loc_001094        ; {4199}
    CMP #$06              ; {4201}
    BEQ loc_001094        ; {4203}
    INC $18               ; {4205}
    DEC $0E               ; {4207}
    BNE loc_00105C        ; {4209}
    LDA $00               ; {4211}
    STA $18               ; {4213}
    JSR $&code_001256     ; {4215}
    BCS loc_0010AC        ; {4218}
    CMP #$0F              ; {4220}
    BEQ loc_001094        ; {4222}
    CMP #$0A              ; {4224}
    BEQ loc_001094        ; {4226}
    CMP #$06              ; {4228}
    BEQ loc_001094        ; {4230}

  loc_001088:
    PLP                   ; {4232}
    LDA $0016, X          ; {4233}
    AND #$FFFB            ; {4236}
    STA $0016, X          ; {4239}
    CLC                   ; {4242}
    RTS                   ; {4243}

  loc_001094:
    PLP                   ; {4244}
    LDA $0016, X          ; {4245}
    ORA #$0004            ; {4248}
    STA $0016, X          ; {4251}

  loc_00109E:
    LDA $0000, X          ; {4254}
    AND #$FFF0            ; {4257}
    STA $0000, X          ; {4260}
    STZ $0004, X          ; {4263}
    SEC                   ; {4266}
    RTS                   ; {4267}

  loc_0010AC:
    PLP                   ; {4268}
    BRA loc_00109E        ; {4269}
}

code_0010AF {
    PHP                   ; {4271}
    LDA $0002, X          ; {4272}
    SEC                   ; {4275}
    SBC #$0010            ; {4276}
    LSR                   ; {4279}
    LSR                   ; {4280}
    LSR                   ; {4281}
    LSR                   ; {4282}
    STA $18               ; {4283}
    LDA $0000, X          ; {4285}
    LSR                   ; {4288}
    LSR                   ; {4289}
    LSR                   ; {4290}
    LSR                   ; {4291}
    STA $16               ; {4292}
    STA $1A               ; {4294}
    LDA $0000, X          ; {4296}
    CLC                   ; {4299}
    ADC $0010, X          ; {4300}
    DEC                   ; {4303}
    LSR                   ; {4304}
    LSR                   ; {4305}
    LSR                   ; {4306}
    LSR                   ; {4307}
    STA $00               ; {4308}
    LDA $0010, X          ; {4310}
    LSR                   ; {4313}
    LSR                   ; {4314}
    LSR                   ; {4315}
    LSR                   ; {4316}
    STA $0C               ; {4317}
    STA $0E               ; {4319}
    SEP #$20              ; {4321}

  loc_0010E3:
    JSR $&code_001256     ; {4323}
    CMP #$0C              ; {4326}
    BEQ loc_001139        ; {4328}
    INC $16               ; {4330}
    DEC $0C               ; {4332}
    BNE loc_0010E3        ; {4334}
    LDA $00               ; {4336}
    STA $16               ; {4338}
    JSR $&code_001256     ; {4340}
    CMP #$0C              ; {4343}
    BEQ loc_001139        ; {4345}
    LDA $1A               ; {4347}
    STA $16               ; {4349}
    INC $18               ; {4351}

  loc_001101:
    JSR $&code_001256     ; {4353}
    BCS loc_001151        ; {4356}
    CMP #$0F              ; {4358}
    BEQ loc_001139        ; {4360}
    CMP #$03              ; {4362}
    BEQ loc_001139        ; {4364}
    CMP #$06              ; {4366}
    BEQ loc_001139        ; {4368}
    INC $16               ; {4370}
    DEC $0E               ; {4372}
    BNE loc_001101        ; {4374}
    LDA $00               ; {4376}
    STA $16               ; {4378}
    JSR $&code_001256     ; {4380}
    BCS loc_001151        ; {4383}
    CMP #$0F              ; {4385}
    BEQ loc_001139        ; {4387}
    CMP #$03              ; {4389}
    BEQ loc_001139        ; {4391}
    CMP #$06              ; {4393}
    BEQ loc_001139        ; {4395}
    PLP                   ; {4397}
    LDA $0016, X          ; {4398}
    AND #$FFFB            ; {4401}
    STA $0016, X          ; {4404}
    CLC                   ; {4407}
    RTS                   ; {4408}

  loc_001139:
    PLP                   ; {4409}
    LDA $0016, X          ; {4410}
    ORA #$0004            ; {4413}
    STA $0016, X          ; {4416}

  loc_001143:
    LDA $0002, X          ; {4419}
    AND #$FFF0            ; {4422}
    STA $0002, X          ; {4425}
    STZ $0006, X          ; {4428}
    SEC                   ; {4431}
    RTS                   ; {4432}

  loc_001151:
    PLP                   ; {4433}
    BRA loc_001143        ; {4434}
}

code_001154 {
    PHP                   ; {4436}
    LDA $0006, X          ; {4437}
    CLC                   ; {4440}
    ADC $0002, X          ; {4441}
    EOR $0002, X          ; {4444}
    AND #$FFF0            ; {4447}
    BEQ loc_0011E1        ; {4450}
    LDA $0002, X          ; {4452}
    SEC                   ; {4455}
    SBC $0012, X          ; {4456}
    LSR                   ; {4459}
    LSR                   ; {4460}
    LSR                   ; {4461}
    LSR                   ; {4462}
    STA $18               ; {4463}
    LDA $0000, X          ; {4465}
    LSR                   ; {4468}
    LSR                   ; {4469}
    LSR                   ; {4470}
    LSR                   ; {4471}
    STA $16               ; {4472}
    STA $1A               ; {4474}
    LDA $0000, X          ; {4476}
    CLC                   ; {4479}
    ADC $0010, X          ; {4480}
    DEC                   ; {4483}
    LSR                   ; {4484}
    LSR                   ; {4485}
    LSR                   ; {4486}
    LSR                   ; {4487}
    STA $00               ; {4488}
    LDA $0010, X          ; {4490}
    LSR                   ; {4493}
    LSR                   ; {4494}
    LSR                   ; {4495}
    LSR                   ; {4496}
    STA $0C               ; {4497}
    STA $0E               ; {4499}
    SEP #$20              ; {4501}

  loc_001197:
    JSR $&code_001256     ; {4503}
    CMP #$03              ; {4506}
    BEQ loc_0011ED        ; {4508}
    INC $16               ; {4510}
    DEC $0C               ; {4512}
    BNE loc_001197        ; {4514}
    LDA $00               ; {4516}
    STA $16               ; {4518}
    JSR $&code_001256     ; {4520}
    CMP #$03              ; {4523}
    BEQ loc_0011ED        ; {4525}
    LDA $1A               ; {4527}
    STA $16               ; {4529}
    DEC $18               ; {4531}

  loc_0011B5:
    JSR $&code_001256     ; {4533}
    BCS loc_001205        ; {4536}
    CMP #$0F              ; {4538}
    BEQ loc_0011ED        ; {4540}
    CMP #$0C              ; {4542}
    BEQ loc_0011ED        ; {4544}
    CMP #$06              ; {4546}
    BEQ loc_0011ED        ; {4548}
    INC $16               ; {4550}
    DEC $0E               ; {4552}
    BNE loc_0011B5        ; {4554}
    LDA $00               ; {4556}
    STA $16               ; {4558}
    JSR $&code_001256     ; {4560}
    BCS loc_001205        ; {4563}
    CMP #$0F              ; {4565}
    BEQ loc_0011ED        ; {4567}
    CMP #$0C              ; {4569}
    BEQ loc_0011ED        ; {4571}
    CMP #$06              ; {4573}
    BEQ loc_0011ED        ; {4575}

  loc_0011E1:
    PLP                   ; {4577}
    LDA $0016, X          ; {4578}
    AND #$FFFB            ; {4581}
    STA $0016, X          ; {4584}
    CLC                   ; {4587}
    RTS                   ; {4588}

  loc_0011ED:
    PLP                   ; {4589}
    LDA $0016, X          ; {4590}
    ORA #$0004            ; {4593}
    STA $0016, X          ; {4596}

  loc_0011F7:
    LDA $0002, X          ; {4599}
    AND #$FFF0            ; {4602}
    STA $0002, X          ; {4605}
    STZ $0006, X          ; {4608}
    SEC                   ; {4611}
    RTS                   ; {4612}

  loc_001205:
    PLP                   ; {4613}
    BRA loc_0011F7        ; {4614}
}

code_001208 {
    LDA $0004, X          ; {4616}
    ORA $0004, X          ; {4619}
    BEQ loc_001243        ; {4622}
    LDA $0000, X          ; {4624}
    CLC                   ; {4627}
    ADC $0004, X          ; {4628}
    SEC                   ; {4631}
    SBC #$0004            ; {4632}
    LSR                   ; {4635}
    LSR                   ; {4636}
    LSR                   ; {4637}
    LSR                   ; {4638}
    STA $16               ; {4639}
    LDA $0002, X          ; {4641}
    CLC                   ; {4644}
    ADC $0006, X          ; {4645}
    SEC                   ; {4648}
    SBC #$0004            ; {4649}
    LSR                   ; {4652}
    LSR                   ; {4653}
    LSR                   ; {4654}
    LSR                   ; {4655}
    STA $18               ; {4656}
    JSR $&code_001256     ; {4658}
    CMP #$000F            ; {4661}
    BEQ loc_001245        ; {4664}
    LDA $0016, X          ; {4666}
    AND #$FFFB            ; {4669}
    STA $0016, X          ; {4672}

  loc_001243:
    CLC                   ; {4675}
    RTS                   ; {4676}

  loc_001245:
    STZ $0004, X          ; {4677}
    STZ $0006, X          ; {4680}
    LDA $0016, X          ; {4683}
    ORA #$0004            ; {4686}
    STA $0016, X          ; {4689}
    SEC                   ; {4692}
    RTS                   ; {4693}
}

code_001256 {
    PHP                   ; {4694}
    PHX                   ; {4695}
    REP #$20              ; {4696}
    LDA $18               ; {4698}
    ASL                   ; {4700}
    ASL                   ; {4701}
    ASL                   ; {4702}
    ASL                   ; {4703}
    PHA                   ; {4704}
    SEP #$20              ; {4705}
    LDA $map_width_pages  ; {4707}
    JSL $@lib_shared_0131D1.code_0131D1 ; {4710}
    STA $02, S            ; {4714}
    LDA $16               ; {4716}
    AND #$0F              ; {4718}
    CLC                   ; {4720}
    ADC $01, S            ; {4721}
    STA $01, S            ; {4723}
    LDA $16               ; {4725}
    LSR                   ; {4727}
    LSR                   ; {4728}
    LSR                   ; {4729}
    LSR                   ; {4730}
    CLC                   ; {4731}
    ADC $02, S            ; {4732}
    STA $02, S            ; {4734}
    PLX                   ; {4736}
    CPX #$4000            ; {4737}
    BCS loc_001294        ; {4740}
    LDA $tile_type_map, X ; {4742}
    BIT #$F0              ; {4746}
    BNE loc_001294        ; {4748}
    AND #$0F              ; {4750}
    PLX                   ; {4752}
    PLP                   ; {4753}
    CLC                   ; {4754}
    RTS                   ; {4755}

  loc_001294:
    LDA #$0F              ; {4756}
    PLX                   ; {4758}
    PLP                   ; {4759}
    SEC                   ; {4760}
    RTS                   ; {4761}
}

code_00129A {
    LDA $0000, X          ; {4762}
    CLC                   ; {4765}
    ADC $0004, X          ; {4766}
    STA $0000, X          ; {4769}
    LDA $0002, X          ; {4772}
    CLC                   ; {4775}
    ADC $0006, X          ; {4776}
    STA $0002, X          ; {4779}
    RTS                   ; {4782}
}
---------------------------------------------

code_0012AF {
    PHP                   ; {4783}
    REP #$20              ; {4784}
    LDX #$1800            ; {4786}
    STX $4A               ; {4789}
    LDA #$0800            ; {4791}

  loc_0012BA:
    STA $0000, X          ; {4794}
    INX                   ; {4797}
    INX                   ; {4798}
    CLC                   ; {4799}
    ADC #$0040            ; {4800}
    CPX #$1880            ; {4803}
    BNE loc_0012BA        ; {4806}
    LDX #$0800            ; {4808}
    STX $actor_list_tail  ; {4811}
    LDA #$0000            ; {4814}
    TAX                   ; {4817}

  loc_0012D2:
    STA $0800, X          ; {4818}
    INX                   ; {4821}
    INX                   ; {4822}
    CPX #$1000            ; {4823}
    BNE loc_0012D2        ; {4826}
    PLP                   ; {4828}
    RTL                   ; {4829}
}

code_0012DE {
    PHP                   ; {4830}
    REP #$20              ; {4831}
    LDA $03BA             ; {4833}
    ASL                   ; {4836}
    TAX                   ; {4837}
    LDA $&meta_tables_008000, X ; {4838}
    SEC                   ; {4841}
    SBC #$&meta_tables_008000 ; {4842}
    STA $03B0             ; {4845}
    SEP #$20              ; {4848}
    LDX #$0000            ; {4850}

  loc_0012F5:
    LDA $&table_0099B4, X ; {4853}
    BMI loc_001312        ; {4856}
    CMP $area_current     ; {4858}
    BNE loc_00130C        ; {4861}
    LDA $&table_0099B4+1, X ; {4863}
    CMP $scene_current    ; {4866}
    BNE loc_00130C        ; {4869}
    JSR $&code_001314     ; {4871}
    BRA loc_001312        ; {4874}

  loc_00130C:
    INX                   ; {4876}
    INX                   ; {4877}
    INX                   ; {4878}
    INX                   ; {4879}
    BRA loc_0012F5        ; {4880}

  loc_001312:
    PLP                   ; {4882}
    RTL                   ; {4883}
}

code_001314 {
    LDA #$01              ; {4884}
    STA $2B               ; {4886}
    REP #$20              ; {4888}
    LDA $&table_0099B4+2, X ; {4890}
    STA $29               ; {4893}
    JSL $@engine_0065A7.code_00668A ; {4895}
    BRA loc_00133C        ; {4899}

  loc_001325:
    LDA [$29]             ; {4901}
    AND #$00FF            ; {4903}
    CMP #$00FF            ; {4906}
    BNE loc_001330        ; {4909}
    RTS                   ; {4911}

  loc_001330:
    JSL $@engine_0065A7.code_00668A ; {4912}
    TYA                   ; {4916}
    STA $003E, X          ; {4917}
    TXA                   ; {4920}
    STA $003C, Y          ; {4921}

  loc_00133C:
    STY $actor_list_head  ; {4924}
    TYX                   ; {4927}
    LDA $29               ; {4928}
    STA $003A, X          ; {4930}
    CLC                   ; {4933}
    ADC #$0004            ; {4934}
    STA $29               ; {4937}
    JSL $@code_0013AB     ; {4939}
    LDA $0016, X          ; {4943}
    BIT #$0080            ; {4946}
    BEQ loc_001325        ; {4949}
    LDA $warp_dest_x      ; {4951}
    ORA $warp_dest_y      ; {4954}
    BEQ loc_001399        ; {4957}
    LDA $warp_dest_x      ; {4959}
    STA $0000, X          ; {4962}
    LDA $warp_dest_y      ; {4965}
    CLC                   ; {4968}
    ADC #$0010            ; {4969}
    STA $0002, X          ; {4972}
    LDA $warp_dest_anim   ; {4975}
    STA $001E, X          ; {4978}
    STZ $0020, X          ; {4981}
    JSL $@code_0008F3     ; {4984}
    STZ $0014, X          ; {4988}
    LDA $warp_dest_x      ; {4991}
    STZ $warp_dest_x      ; {4994}
    LSR                   ; {4997}
    LSR                   ; {4998}
    LSR                   ; {4999}
    LSR                   ; {5000}
    STA $player_tile_x    ; {5001}
    LDA $warp_dest_y      ; {5004}
    STZ $warp_dest_y      ; {5007}
    LSR                   ; {5010}
    LSR                   ; {5011}
    LSR                   ; {5012}
    LSR                   ; {5013}
    STA $player_tile_y    ; {5014}

  loc_001399:
    LDA $0000, X          ; {5017}
    STA $player_x         ; {5020}
    LDA $0002, X          ; {5023}
    STA $player_y         ; {5026}
    STX $player_actor     ; {5029}
    BRL loc_001325        ; {5032}
}

code_0013AB {
    TXY                   ; {5035}
    LDX $003A, Y          ; {5036}
    LDA $010000, X        ; {5039}
    AND #$00FF            ; {5043}
    ASL                   ; {5046}
    ASL                   ; {5047}
    ASL                   ; {5048}
    ASL                   ; {5049}
    STA $0000, Y          ; {5050}
    LDA $010001, X        ; {5053}
    PHA                   ; {5057}
    AND #$00FF            ; {5058}
    ASL                   ; {5061}
    ASL                   ; {5062}
    ASL                   ; {5063}
    ASL                   ; {5064}
    CLC                   ; {5065}
    ADC #$0010            ; {5066}
    STA $0002, Y          ; {5069}
    PLA                   ; {5072}
    AND #$C100            ; {5073}
    ORA $0372             ; {5076}
    STA $001C, Y          ; {5079}
    SEP #$20              ; {5082}
    LDA $010003, X        ; {5084}
    XBA                   ; {5088}
    LDA #$0E              ; {5089}
    JSL $@lib_shared_0131D1.code_0131D1 ; {5091}
    REP #$20              ; {5095}
    CLC                   ; {5097}
    ADC $03B0             ; {5098}
    TAX                   ; {5101}
    STA $0038, Y          ; {5102}
    SEP #$20              ; {5105}
    LDA $&meta_tables_008000+2, X ; {5107}
    STA $0025, Y          ; {5110}
    LDA $&meta_tables_008000+5, X ; {5113}
    STA $001E, Y          ; {5116}
    LDA $&meta_tables_008000+A, X ; {5119}
    STA $0024, Y          ; {5122}
    LDA $&meta_tables_008000+D, X ; {5125}
    STA $0036, Y          ; {5128}
    REP #$20              ; {5131}
    LDA $&meta_tables_008000+6, X ; {5133}
    ORA #$8000            ; {5136}
    STA $0016, Y          ; {5139}
    LDA $&meta_tables_008000+8, X ; {5142}
    STA $0022, Y          ; {5145}
    LDA $&meta_tables_008000+B, X ; {5148}
    STA $0018, Y          ; {5151}
    TYX                   ; {5154}
    LDA $0016, X          ; {5155}
    BIT #$0040            ; {5158}
    BNE loc_001441        ; {5161}
    BIT #$2000            ; {5163}
    BEQ loc_001441        ; {5166}
    LDA #$0010            ; {5168}
    STA $000C, X          ; {5171}
    STA $000A, X          ; {5174}
    STZ $0008, X          ; {5177}
    STZ $000E, X          ; {5180}
    BRA loc_001445        ; {5183}

  loc_001441:
    JSL $@code_0008F3     ; {5185}

  loc_001445:
    STZ $0014, X          ; {5189}
    STZ $0004, X          ; {5192}
    STZ $0006, X          ; {5195}
    RTL                   ; {5198}
}

code_00144F {
    PHP                   ; {5199}
    PHX                   ; {5200}
    PHY                   ; {5201}
    REP #$20              ; {5202}
    PHX                   ; {5204}
    LDA $7F0203, X        ; {5205}
    STA $00               ; {5209}
    LDA $&data_00BA0D+C, Y ; {5211}
    AND #$00FF            ; {5214}
    ASL                   ; {5217}
    ASL                   ; {5218}
    ASL                   ; {5219}
    ASL                   ; {5220}
    STA $16               ; {5221}
    LDA $&data_00BA0D+D, Y ; {5223}
    AND #$00FF            ; {5226}
    INC                   ; {5229}
    ASL                   ; {5230}
    ASL                   ; {5231}
    ASL                   ; {5232}
    ASL                   ; {5233}
    STA $18               ; {5234}
    TYX                   ; {5236}
    PHX                   ; {5237}
    LDX $actor_list_head  ; {5238}
    JSR $&engine_0065A7.code_006662 ; {5241}
    PLX                   ; {5244}
    LDA #$A000            ; {5245}
    STA $0016, Y          ; {5248}
    PLA                   ; {5251}
    STA $0034, Y          ; {5252}
    LDA $16               ; {5255}
    STA $0000, Y          ; {5257}
    LDA $18               ; {5260}
    STA $0002, Y          ; {5262}
    LDA $&data_00BA0D+16, X ; {5265}
    ORA #$0100            ; {5268}
    ORA $0372             ; {5271}
    STA $001C, Y          ; {5274}
    STA $0030, Y          ; {5277}
    LDA $&data_00BA0D+10, X ; {5280}
    STA $0018, Y          ; {5283}
    SEP #$20              ; {5286}
    LDA $&data_00BA0D+12, X ; {5288}
    STA $0036, Y          ; {5291}
    LDA $00               ; {5294}
    STA $002E, Y          ; {5296}
    STA $002F, Y          ; {5299}
    REP #$20              ; {5302}
    LDA $&data_00BA0D+14, X ; {5304}
    AND #$00FF            ; {5307}
    STA $0026, Y          ; {5310}
    SEP #$20              ; {5313}
    LDA $&data_00BA0D+15, X ; {5315}
    XBA                   ; {5318}
    LDA #$0E              ; {5319}
    JSL $@lib_shared_0131D1.code_0131D1 ; {5321}
    REP #$20              ; {5325}
    CLC                   ; {5327}
    ADC $03B0             ; {5328}
    STA $0038, Y          ; {5331}
    TAX                   ; {5334}
    SEP #$20              ; {5335}
    LDA $&meta_tables_008000+2, X ; {5337}
    STA $0025, Y          ; {5340}
    LDA $&meta_tables_008000+5, X ; {5343}
    STA $001E, Y          ; {5346}
    LDA $&meta_tables_008000+A, X ; {5349}
    STA $0024, Y          ; {5352}
    REP #$20              ; {5355}
    LDA $&meta_tables_008000+8, X ; {5357}
    STA $0022, Y          ; {5360}
    LDA #$0010            ; {5363}
    STA $0010, Y          ; {5366}
    STA $0012, Y          ; {5369}
    STA $000C, Y          ; {5372}
    STA $000A, Y          ; {5375}
    LDA #$0000            ; {5378}
    STA $0008, Y          ; {5381}
    STA $000E, Y          ; {5384}
    STA $0032, Y          ; {5387}
    PLY                   ; {5390}
    PLX                   ; {5391}
    PLP                   ; {5392}
    RTL                   ; {5393}
}