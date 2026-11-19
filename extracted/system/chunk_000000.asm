?BANK 00

?INCLUDE 'chunk_010000'
?INCLUDE 'chunk_0270E4'
?INCLUDE 'chunk_0FAA49'
?INCLUDE 'data_00BA0D'
?INCLUDE 'data_00EE8E'
?INCLUDE 'data_00F9F7'
?INCLUDE 'meta_tables_008000'
?INCLUDE 'table_0099B4'

!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!OAMADDL                        2102
!BGMODE                         2105
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG3HOFS                        2111
!BG3VOFS                        2112
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!CGADD                          2121
!TM                             212C
!CGADSUB                        2131
!COLDATA                        2132
!MPYL                           2134
!MPYM                           2135
!APUIO0                         2140
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
    JSL $@chunk_010000.code_0139AC ; {20}
    JSL $@chunk_010000.code_013ADA ; {24}
    JSL $@chunk_0270E4.code_027912 ; {28}
    JSL $@chunk_0270E4.code_0276EE ; {32}
    LDX #$000C            ; {36}
    STX $scene_next       ; {39}
    JSL $@chunk_010000.code_0131A2 ; {42}
    JSL $@chunk_0270E4.code_027781 ; {46}

  loc_000032:
    JSL $@chunk_010000.code_0131B7 ; {50}
    JSL $@chunk_0270E4.code_027781 ; {54}
    LDA $1C6A             ; {58}
    SEC                   ; {61}
    SBC #$10              ; {62}
    CMP #$03              ; {64}
    BCC loc_00008F        ; {66}
    LDA $03FB             ; {68}
    BNE loc_0000AA        ; {71}
    JSL $@chunk_010000.code_0118FC ; {73}
    JSL $@chunk_0270E4.code_027572 ; {77}
    JSL $@chunk_010000.code_0131AE ; {81}
    JSL $@chunk_010000.code_0109D6 ; {85}
    JSL $@chunk_010000.code_01185E ; {89}
    JSL $@code_0005A6     ; {93}
    JSL $@code_0005C4     ; {97}
    JSL $@code_000A34     ; {101}
    JSL $@code_000DF4     ; {105}
    JSL $@code_003005     ; {109}
    JSL $@chunk_010000.code_010069 ; {113}
    JSL $@chunk_010000.code_01010B ; {117}
    JSL $@code_0006EE     ; {121}
    JSL $@chunk_010000.code_012659 ; {125}
    JSL $@chunk_010000.code_011695 ; {129}
    JSL $@chunk_0270E4.code_027223 ; {133}
    JSL $@chunk_010000.code_0131A2 ; {137}
    BRA loc_000032        ; {141}

  loc_00008F:
    JSL $@chunk_010000.code_0131AE ; {143}
    JSL $@chunk_010000.code_01185E ; {147}
    JSL $@code_0005A6     ; {151}
    JSL $@code_0005C4     ; {155}
    JSL $@code_0006EE     ; {159}
    JSL $@chunk_010000.code_0131A2 ; {163}
    BRL loc_000032        ; {167}

  loc_0000AA:
    JSL $@chunk_010000.code_0131AE ; {170}
    JSL $@chunk_010000.code_010EA9 ; {174}
    JSL $@chunk_010000.code_01185E ; {178}
    STZ $0323             ; {182}
    JSL $@code_0005A6     ; {185}
    JSL $@code_0005C4     ; {189}
    JSL $@code_0006EE     ; {193}
    JSL $@chunk_010000.code_012659 ; {197}
    JSL $@chunk_010000.code_011695 ; {201}
    JSL $@chunk_0270E4.code_027223 ; {205}
    JSL $@chunk_010000.code_0131A2 ; {209}
    JSL $@chunk_010000.code_0131B7 ; {213}
    JSL $@chunk_010000.code_0131AE ; {217}

  loc_0000DD:
    JSL $@code_0001BE     ; {221}
    LDX $03FB             ; {225}
    BMI loc_0000DD        ; {228}
    STZ $03FB             ; {230}
    STZ $03FC             ; {233}
    LDA $1B8A             ; {236}
    LSR                   ; {239}
    LSR                   ; {240}
    LSR                   ; {241}
    CLC                   ; {242}
    ADC $043B             ; {243}
    STA $043B             ; {246}
    LDA #$78              ; {249}
    JSL $@chunk_010000.code_013140 ; {251}
    LDA #$80              ; {255}
    STA $03E3             ; {257}
    LDA $03FD             ; {260}
    STA $area_next        ; {263}
    LDA $03FF             ; {266}
    STA $scene_next       ; {269}
    REP #$20              ; {272}
    LDA $0401             ; {274}
    STA $037C             ; {277}
    LDA $0403             ; {280}
    STA $037E             ; {283}
    SEP #$20              ; {286}
    JSL $@chunk_010000.code_0131A2 ; {288}
    BRL loc_000032        ; {292}
}

code_000127 {
    PHB                   ; {295}
    PHA                   ; {296}
    XBA                   ; {297}
    PHA                   ; {298}
    PHX                   ; {299}
    PHY                   ; {300}
    JSL $@chunk_010000.code_0131AE ; {301}
    INC $03A6             ; {305}
    JSL $@chunk_010000.code_01185E ; {308}
    JSL $@code_0005A6     ; {312}
    JSL $@code_0005C4     ; {316}
    JSL $@chunk_010000.code_010000 ; {320}
    JSL $@chunk_010000.code_010069 ; {324}
    JSL $@chunk_010000.code_01010B ; {328}
    JSL $@code_0006EE     ; {332}
    LDA $0462             ; {336}
    BNE loc_00015D        ; {339}
    JSL $@chunk_010000.code_012659 ; {341}
    JSL $@chunk_010000.code_011695 ; {345}

  loc_00015D:
    JSL $@chunk_0270E4.code_027223 ; {349}
    STZ $03A6             ; {353}
    JSL $@chunk_010000.code_0131A2 ; {356}
    JSL $@chunk_010000.code_0131B7 ; {360}
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
    JSL $@chunk_010000.code_01185E ; {384}
    JSL $@code_0005A6     ; {388}
    JSL $@code_0005C4     ; {392}
    JSL $@chunk_010000.code_010069 ; {396}
    JSL $@chunk_010000.code_01010B ; {400}
    JSL $@code_0006EE     ; {404}
    JSL $@chunk_010000.code_012659 ; {408}
    JSL $@chunk_010000.code_011695 ; {412}
    JSL $@chunk_0270E4.code_027223 ; {416}
    JSL $@chunk_010000.code_010EEA ; {420}
    JSL $@chunk_010000.code_0131A2 ; {424}
    JSL $@chunk_010000.code_0131B7 ; {428}
    JSL $@chunk_010000.code_0131AE ; {432}
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
    JSL $@chunk_010000.code_01185E ; {459}
    JSL $@code_0005A6     ; {463}
    JSL $@code_0005C4     ; {467}
    JSL $@chunk_010000.code_010069 ; {471}
    JSL $@chunk_010000.code_01010B ; {475}
    JSL $@code_0006EE     ; {479}
    JSL $@chunk_010000.code_012659 ; {483}
    JSL $@chunk_010000.code_011695 ; {487}
    JSL $@chunk_0270E4.code_027223 ; {491}
    JSL $@chunk_010000.code_0131A2 ; {495}
    JSL $@chunk_010000.code_0131B7 ; {499}
    JSL $@chunk_010000.code_0131AE ; {503}
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
    JSL $@chunk_010000.code_0131B7 ; {538}
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
    JSL $@chunk_010000.code_012C27 ; {615}
    PLX                   ; {619}

  loc_00026C:
    INX                   ; {620}
    BNE loc_000246        ; {621}
    PLB                   ; {623}
    RTS                   ; {624}
}

code_000271 {
    LDA $0314             ; {625}
    JSR $&code_0002FC     ; {628}
    STA $1F06             ; {631}
    LDA $0314             ; {634}
    JSR $&code_000300     ; {637}
    STA $1F07             ; {640}
    LDA $scene_current    ; {643}
    JSR $&code_0002FC     ; {646}
    STA $1F09             ; {649}
    LDA $scene_current    ; {652}
    JSR $&code_000300     ; {655}
    STA $1F0A             ; {658}
    LDA $1C6A             ; {661}
    JSR $&code_0002FC     ; {664}
    STA $1F0C             ; {667}
    LDA $1C6A             ; {670}
    JSR $&code_000300     ; {673}
    STA $1F0D             ; {676}
    LDA $0378             ; {679}
    JSR $&code_0002FC     ; {682}
    STA $1F0F             ; {685}
    LDA $0378             ; {688}
    JSR $&code_000300     ; {691}
    STA $1F10             ; {694}
    LDA $0374             ; {697}
    JSR $&code_000300     ; {700}
    STA $1F12             ; {703}
    LDA $037A             ; {706}
    JSR $&code_0002FC     ; {709}
    STA $1F14             ; {712}
    LDA $037A             ; {715}
    JSR $&code_000300     ; {718}
    STA $1F15             ; {721}
    LDA $0376             ; {724}
    JSR $&code_000300     ; {727}
    STA $1F17             ; {730}
    LDA $1F00             ; {733}
    JSR $&code_0002FC     ; {736}
    STA $1F19             ; {739}
    LDA $1F00             ; {742}
    JSR $&code_000300     ; {745}
    STA $1F1A             ; {748}
    LDY #$1F02            ; {751}
    JSL $@chunk_010000.code_012769 ; {754}
    LDA #$01              ; {758}
    STA $03B8             ; {760}
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
    JSL $@chunk_010000.code_0131D1 ; {812}
    PHA                   ; {816}
    LDA $0484             ; {817}
    AND #$0F              ; {820}
    CLC                   ; {822}
    ADC $01, S            ; {823}
    JSL $@chunk_010000.code_0120F9 ; {825}
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
    JSL $@code_006B7F     ; {877}

  loc_000371:
    LDA $HVBJOY           ; {881}
    ROR                   ; {884}
    BCS loc_000371        ; {885}
    LDA $42               ; {887}
    STA $HDMAEN           ; {889}
    REP #$30              ; {892}
    INC $0312             ; {894}
    LDA $0468             ; {897}
    BNE loc_0003AA        ; {900}
    LDA $JOY1L            ; {902}
    XBA                   ; {905}
    LSR                   ; {906}
    AND #$2000            ; {907}
    ORA $JOY1L            ; {910}
    PHA                   ; {913}
    LDA $0326             ; {914}
    EOR #$FFFF            ; {917}
    AND $01, S            ; {920}
    STA $0322             ; {922}
    PLA                   ; {925}
    EOR #$FFFF            ; {926}
    ORA $032A             ; {929}
    STA $032A             ; {932}
    AND $0322             ; {935}

  loc_0003AA:
    STA $0322             ; {938}
    LDA $0312             ; {941}
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
    LDA $7F0200           ; {1035}
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
    LDA $03B8             ; {1063}
    BNE loc_00042D        ; {1066}
    RTS                   ; {1068}

  loc_00042D:
    BIT #$02              ; {1069}
    BNE loc_000442        ; {1071}
    LDX #$5800            ; {1073}
    STX $VMADDL           ; {1076}
    LDX #$7000            ; {1079}
    STX $A1T2L            ; {1082}
    STZ $03B8             ; {1085}
    BRA loc_000453        ; {1088}

  loc_000442:
    LDX #$5C00            ; {1090}
    STX $VMADDL           ; {1093}
    LDX #$7800            ; {1096}
    STX $A1T2L            ; {1099}
    LDA #$02              ; {1102}
    TRB $03B8             ; {1104}

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
    LDA $0386             ; {1134}
    STA $BG3HOFS          ; {1137}
    STZ $BG3HOFS          ; {1140}
    LDA $0388             ; {1143}
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
    LDA $033A, X          ; {1195}
    STA $BG1HOFS, Y       ; {1198}
    LDA $033B, X          ; {1201}
    AND #$03              ; {1204}
    STA $BG1HOFS, Y       ; {1206}
    LDA $033C, X          ; {1209}
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
    JSL $@chunk_010000.code_01057D ; {1234}
    LDX #$3204            ; {1238}
    STX $32               ; {1241}
    LDX #$3306            ; {1243}
    STX $35               ; {1246}
    JSL $@chunk_010000.code_01057D ; {1248}
    RTS                   ; {1252}
}

code_0004E5 {
    LDA $03B6             ; {1253}
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
    LDY $1A06, X          ; {1284}
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
    STZ $03B6             ; {1312}
    RTS                   ; {1315}
}

code_000524 {
    LDX $1A06, Y          ; {1316}
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
    LDA $03E1             ; {1347}
    BNE loc_000549        ; {1350}
    RTS                   ; {1352}

  loc_000549:
    LDA #$01              ; {1353}
    STA $DMAP2            ; {1355}
    LDA #$18              ; {1358}
    STA $BBAD2            ; {1360}
    LDX $03DD             ; {1363}
    STX $A1T2L            ; {1366}
    LDA #$7F              ; {1369}
    STA $A1B2             ; {1371}
    LDX #$0040            ; {1374}
    STX $DAS2L            ; {1377}
    LDX $03DF             ; {1380}
    STX $VMADDL           ; {1383}
    LDA #$04              ; {1386}
    STA $MDMAEN           ; {1388}
    LDX #$0040            ; {1391}
    STX $DAS2L            ; {1394}
    LDA $03DF             ; {1397}
    STA $VMADDL           ; {1400}
    LDA $03E0             ; {1403}
    INC                   ; {1406}
    STA $VMADDH           ; {1407}
    LDA #$04              ; {1410}
    STA $MDMAEN           ; {1412}
    STZ $03E1             ; {1415}
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
    STZ $1C7B             ; {1439}
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
    LDA $06A6             ; {1457}
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
    LDA $06A8             ; {1479}
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
    SBC $033A             ; {1499}
    CMP #$0100            ; {1502}
    BCC loc_0005F8        ; {1505}
    BMI loc_0005E8        ; {1507}
    BRL loc_00066B        ; {1509}

  loc_0005E8:
    LDA $0000, X          ; {1512}
    CLC                   ; {1515}
    ADC $000C, X          ; {1516}
    SEC                   ; {1519}
    SBC $033A             ; {1520}
    CMP #$0100            ; {1523}
    BCS loc_00066B        ; {1526}

  loc_0005F8:
    LDA $0002, X          ; {1528}
    SEC                   ; {1531}
    SBC $000A, X          ; {1532}
    SEC                   ; {1535}
    SBC $033C             ; {1536}
    CMP #$00E0            ; {1539}
    BCC loc_00061A        ; {1542}
    BPL loc_00066B        ; {1544}
    LDA $0002, X          ; {1546}
    CLC                   ; {1549}
    ADC $000E, X          ; {1550}
    SEC                   ; {1553}
    SBC $033C             ; {1554}
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
    SBC $033C             ; {1597}
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
    STZ $1A06             ; {1785}
    STZ $02               ; {1788}
    LDA $033A             ; {1790}
    SEC                   ; {1793}
    SBC #$0010            ; {1794}
    STA $52               ; {1797}
    LDA $033C             ; {1799}
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
    STA $0486, Y          ; {2039}
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
    STA $0486, Y          ; {2093}
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
    INC $03B6             ; {2121}

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
    STA $0486, Y          ; {2224}
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
    STA $0486, Y          ; {2286}
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
    LDX $039C             ; {2616}
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
    LDX $039C             ; {2802}
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
    LDA $0312             ; {2927}
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
    LDX $039C             ; {2993}
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
    LDA #$^code_002A10    ; {3063}
    STA $0036, Y          ; {3065}
    LDA #$00              ; {3068}
    STA $0025, Y          ; {3070}
    REP #$20              ; {3073}
    LDA #$&code_002A10    ; {3075}
    STA $0018, Y          ; {3078}
    LDA #$0000            ; {3081}
    STA $0014, Y          ; {3084}
    LDA $0016, Y          ; {3087}
    ORA #$0400            ; {3090}
    STA $0016, Y          ; {3093}
    LDX $0038, Y          ; {3096}
    LDA $@meta_tables_008000+3, X ; {3099}
    JSL $@chunk_0270E4.code_027687 ; {3103}
    LDA #$0002            ; {3107}
    TSB $0332             ; {3110}
    LDA $1B5E             ; {3113}
    CMP #$0007            ; {3116}
    BNE loc_000C42        ; {3119}
    LDA $1B88             ; {3121}
    CMP $1B8A             ; {3124}
    BEQ loc_000C42        ; {3127}
    INC $1B88             ; {3129}
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
    LDA #$^code_002A10    ; {3326}
    STA $0036, Y          ; {3328}
    LDA #$00              ; {3331}
    STA $0025, Y          ; {3333}
    REP #$20              ; {3336}
    LDA #$&code_002A10    ; {3338}
    STA $0018, Y          ; {3341}
    LDA #$0000            ; {3344}
    STA $0014, Y          ; {3347}
    LDA $0016, Y          ; {3350}
    ORA #$0400            ; {3353}
    STA $0016, Y          ; {3356}
    LDX $0038, Y          ; {3359}
    LDA $@meta_tables_008000+3, X ; {3362}
    JSL $@chunk_0270E4.code_027687 ; {3366}
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
    LDY $039C             ; {3580}
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
    LDA $1B88             ; {3817}
    SEC                   ; {3820}
    SBC $01, S            ; {3821}
    BPL loc_000EF3        ; {3823}
    LDA #$00              ; {3825}

  loc_000EF3:
    STA $1B88             ; {3827}
    PLA                   ; {3830}
    REP #$20              ; {3831}
    LDA #$0004            ; {3833}
    TSB $0332             ; {3836}
    LDX $039C             ; {3839}
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
    JSL $@code_002F0A     ; {3874}
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
    LDA $0343             ; {4707}
    JSL $@chunk_010000.code_0131D1 ; {4710}
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
    LDA $7F8000, X        ; {4742}
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
    STX $06A6             ; {4811}
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
    CMP $0314             ; {4858}
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
    JSL $@code_00668A     ; {4895}
    BRA loc_00133C        ; {4899}

  loc_001325:
    LDA [$29]             ; {4901}
    AND #$00FF            ; {4903}
    CMP #$00FF            ; {4906}
    BNE loc_001330        ; {4909}
    RTS                   ; {4911}

  loc_001330:
    JSL $@code_00668A     ; {4912}
    TYA                   ; {4916}
    STA $003E, X          ; {4917}
    TXA                   ; {4920}
    STA $003C, Y          ; {4921}

  loc_00133C:
    STY $06A8             ; {4924}
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
    LDA $037C             ; {4951}
    ORA $037E             ; {4954}
    BEQ loc_001399        ; {4957}
    LDA $037C             ; {4959}
    STA $0000, X          ; {4962}
    LDA $037E             ; {4965}
    CLC                   ; {4968}
    ADC #$0010            ; {4969}
    STA $0002, X          ; {4972}
    LDA $0380             ; {4975}
    STA $001E, X          ; {4978}
    STZ $0020, X          ; {4981}
    JSL $@code_0008F3     ; {4984}
    STZ $0014, X          ; {4988}
    LDA $037C             ; {4991}
    STZ $037C             ; {4994}
    LSR                   ; {4997}
    LSR                   ; {4998}
    LSR                   ; {4999}
    LSR                   ; {5000}
    STA $0378             ; {5001}
    LDA $037E             ; {5004}
    STZ $037E             ; {5007}
    LSR                   ; {5010}
    LSR                   ; {5011}
    LSR                   ; {5012}
    LSR                   ; {5013}
    STA $037A             ; {5014}

  loc_001399:
    LDA $0000, X          ; {5017}
    STA $0374             ; {5020}
    LDA $0002, X          ; {5023}
    STA $0376             ; {5026}
    STX $039C             ; {5029}
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
    JSL $@chunk_010000.code_0131D1 ; {5091}
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
    LDX $06A8             ; {5238}
    JSR $&code_006662     ; {5241}
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
    JSL $@chunk_010000.code_0131D1 ; {5321}
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
---------------------------------------------

code_001512 {
    LDA $0464             ; {5394}
    BEQ loc_00151A        ; {5397}
    STZ $0322             ; {5399}

  loc_00151A:
    LDA $0439             ; {5402}
    BNE loc_001524        ; {5405}
    LDA $1B5E             ; {5407}
    BNE loc_00152F        ; {5410}

  loc_001524:
    LDY $039C             ; {5412}
    LDA #$C000            ; {5415}
    TRB $0322             ; {5418}
    BRA loc_00155F        ; {5421}

  loc_00152F:
    JSR $&code_0018A1     ; {5423}
    PHX                   ; {5426}
    DEC                   ; {5427}
    ASL                   ; {5428}
    TAX                   ; {5429}
    LDA $@chunk_010000.word_0161CE, X ; {5430}
    CMP $1B6A             ; {5434}
    BEQ loc_001547        ; {5437}
    BCC loc_001547        ; {5439}
    LDA #$8000            ; {5441}
    TRB $0322             ; {5444}

  loc_001547:
    PLX                   ; {5447}
    LDY $039C             ; {5448}
    LDA $001E, Y          ; {5451}
    SEC                   ; {5454}
    SBC #$0014            ; {5455}
    CMP #$0010            ; {5458}
    BCC loc_001577        ; {5461}
    LDA $0322             ; {5463}
    AND #$8000            ; {5466}
    BNE loc_001578        ; {5469}

  loc_00155F:
    LDA $0016, Y          ; {5471}
    BIT #$0400            ; {5474}
    BNE loc_00157F        ; {5477}
    PHX                   ; {5479}
    LDA $001E, Y          ; {5480}
    ASL                   ; {5483}
    TAX                   ; {5484}
    LDA $@word_001588, X  ; {5485}
    PLX                   ; {5489}
    AND $0322             ; {5490}
    BEQ loc_001578        ; {5493}

  loc_001577:
    RTL                   ; {5495}

  loc_001578:
    LDA #$&loc_001A65     ; {5496}
    STA $0018, Y          ; {5499}
    RTL                   ; {5502}

  loc_00157F:
    LDA #$&loc_001A65     ; {5503}
    STA $0018, Y          ; {5506}
    COP [91]              ; {5509}
    RTL                   ; {5511}
}
---------------------------------------------

word_001588 [
  #$0400   ;00
  #$0800   ;01
  #$0200   ;02
  #$0100   ;03
  #$0400   ;04
  #$0800   ;05
  #$0800   ;06
  #$0400   ;07
  #$0200   ;08
  #$0100   ;09
  #$0100   ;0A
  #$0200   ;0B
  #$0100   ;0C
  #$0200   ;0D
  #$0200   ;0E
  #$0100   ;0F
  #$0400   ;10
  #$0800   ;11
  #$0800   ;12
  #$0400   ;13
  #$0000   ;14
  #$0000   ;15
  #$0000   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0100   ;24
  #$0100   ;25
  #$0200   ;26
  #$0200   ;27
  #$0400   ;28
  #$0400   ;29
  #$0800   ;2A
  #$0800   ;2B
]
---------------------------------------------

code_0015E0 {
    LDA $0016, X          ; {5600}
    ORA #$0010            ; {5603}
    STA $0016, X          ; {5606}
    COP [91]              ; {5609}
    PHX                   ; {5611}
    LDX $039C             ; {5612}
    JSR $&code_00169C     ; {5615}
    BCC loc_001630        ; {5618}
    LDA $0004, X          ; {5620}
    PHA                   ; {5623}
    LDA $0006, X          ; {5624}
    PHA                   ; {5627}
    LDA $03D4             ; {5628}
    STA $0004, X          ; {5631}
    LDA $03D6             ; {5634}
    STA $0006, X          ; {5637}
    JSL $@code_000F28     ; {5640}
    LDA $0004, X          ; {5644}
    STA $03D4             ; {5647}
    CLC                   ; {5650}
    ADC $0000, X          ; {5651}
    STA $0000, X          ; {5654}
    LDA $0006, X          ; {5657}
    STA $03D6             ; {5660}
    CLC                   ; {5663}
    ADC $0002, X          ; {5664}
    STA $0002, X          ; {5667}
    PLA                   ; {5670}
    STA $0006, X          ; {5671}
    PLA                   ; {5674}
    STA $0004, X          ; {5675}
    BRA loc_001633        ; {5678}

  loc_001630:
    JSR $&code_001733     ; {5680}

  loc_001633:
    LDA $0326             ; {5683}
    BIT #$0F00            ; {5686}
    BNE loc_001657        ; {5689}
    LDA $03D4             ; {5691}
    BNE loc_001649        ; {5694}
    LDA $0000, X          ; {5696}
    AND #$FFFE            ; {5699}
    STA $0000, X          ; {5702}

  loc_001649:
    LDA $03D6             ; {5705}
    BNE loc_001657        ; {5708}
    LDA $0002, X          ; {5710}
    AND #$FFFE            ; {5713}
    STA $0002, X          ; {5716}

  loc_001657:
    STZ $03D4             ; {5719}
    STZ $03D6             ; {5722}
    LDA $0000, X          ; {5725}
    STA $0374             ; {5728}
    LSR                   ; {5731}
    LSR                   ; {5732}
    LSR                   ; {5733}
    LSR                   ; {5734}
    STA $0378             ; {5735}
    LDA $0002, X          ; {5738}
    STA $0376             ; {5741}
    LSR                   ; {5744}
    LSR                   ; {5745}
    LSR                   ; {5746}
    LSR                   ; {5747}
    DEC                   ; {5748}
    STA $037A             ; {5749}
    LDY $039E             ; {5752}
    LDA $0000, X          ; {5755}
    STA $0000, Y          ; {5758}
    LDA $0002, X          ; {5761}
    STA $0002, Y          ; {5764}
    LDA $001E, X          ; {5767}
    ASL                   ; {5770}
    TAX                   ; {5771}
    LDA $&data_00F9F7.word_00FAD7, X ; {5772}
    CLC                   ; {5775}
    ADC $0002, Y          ; {5776}
    STA $0002, Y          ; {5779}
    JSL $@chunk_010000.code_010000 ; {5782}
    PLX                   ; {5786}
    RTL                   ; {5787}
}

code_00169C {
    LDA $0000, X          ; {5788}
    STA $0374             ; {5791}
    LSR                   ; {5794}
    LSR                   ; {5795}
    LSR                   ; {5796}
    LSR                   ; {5797}
    STA $0378             ; {5798}
    LDA $0002, X          ; {5801}
    STA $0376             ; {5804}
    LSR                   ; {5807}
    LSR                   ; {5808}
    LSR                   ; {5809}
    LSR                   ; {5810}
    DEC                   ; {5811}
    STA $037A             ; {5812}
    CLC                   ; {5815}
    LDY $03D8             ; {5816}
    BNE loc_0016BE        ; {5819}
    RTS                   ; {5821}

  loc_0016BE:
    LDA $03A6             ; {5822}
    BEQ loc_0016C4        ; {5825}
    RTS                   ; {5827}

  loc_0016C4:
    LDA $0000, X          ; {5828}
    CLC                   ; {5831}
    ADC #$000F            ; {5832}
    LSR                   ; {5835}
    LSR                   ; {5836}
    LSR                   ; {5837}
    LSR                   ; {5838}
    STA $16               ; {5839}
    LDA $0002, X          ; {5841}
    DEC                   ; {5844}
    LSR                   ; {5845}
    LSR                   ; {5846}
    LSR                   ; {5847}
    LSR                   ; {5848}
    STA $18               ; {5849}
    SEP #$20              ; {5851}
    PHB                   ; {5853}
    LDA $03DA             ; {5854}
    PHA                   ; {5857}
    PLB                   ; {5858}

  loc_0016E3:
    LDA $0000, Y          ; {5859}
    INC                   ; {5862}
    BEQ loc_001725        ; {5863}
    LDA $16               ; {5865}
    CMP $0000, Y          ; {5867}
    BCC loc_001719        ; {5870}
    LDA $0378             ; {5872}
    CMP $0001, Y          ; {5875}
    BCS loc_001719        ; {5878}
    LDA $18               ; {5880}
    CMP $0002, Y          ; {5882}
    BCC loc_001719        ; {5885}
    LDA $037A             ; {5887}
    CMP $0003, Y          ; {5890}
    BCS loc_001719        ; {5893}
    REP #$20              ; {5895}
    LDA $0004, Y          ; {5897}
    BEQ loc_001711        ; {5900}
    STA $03D4             ; {5902}

  loc_001711:
    LDA $0006, Y          ; {5905}
    BEQ loc_001719        ; {5908}
    STA $03D6             ; {5910}

  loc_001719:
    REP #$20              ; {5913}
    TYA                   ; {5915}
    CLC                   ; {5916}
    ADC #$0008            ; {5917}
    TAY                   ; {5920}
    SEP #$20              ; {5921}
    BRA loc_0016E3        ; {5923}

  loc_001725:
    REP #$20              ; {5925}
    PLB                   ; {5927}
    SEC                   ; {5928}
    LDA $03D4             ; {5929}
    ORA $03D6             ; {5932}
    BNE loc_001732        ; {5935}
    CLC                   ; {5937}

  loc_001732:
    RTS                   ; {5938}
}

code_001733 {
    LDA $0016, X          ; {5939}
    BIT #$0004            ; {5942}
    BNE loc_00173C        ; {5945}
    RTS                   ; {5947}

  loc_00173C:
    JSR $&code_001892     ; {5948}
    BCC loc_001742        ; {5951}
    RTS                   ; {5953}

  loc_001742:
    AND #$00FF            ; {5954}
    BEQ loc_001754        ; {5957}
    DEC                   ; {5959}
    BEQ loc_0017A1        ; {5960}
    DEC                   ; {5962}
    BNE loc_001750        ; {5963}
    BRL loc_0017EA        ; {5965}

  loc_001750:
    BRL loc_00183E        ; {5968}

  loc_001753:
    RTS                   ; {5971}

  loc_001754:
    LDA $0322             ; {5972}
    BIT #$0800            ; {5975}
    BNE loc_00175D        ; {5978}
    RTS                   ; {5980}

  loc_00175D:
    TXY                   ; {5981}
    LDA $0000, X          ; {5982}
    AND #$000F            ; {5985}
    BEQ loc_00178E        ; {5988}
    LDA $0000, X          ; {5990}
    STA $16               ; {5993}
    LDA $0002, X          ; {5995}
    SEC                   ; {5998}
    SBC #$0020            ; {5999}
    STA $18               ; {6002}
    JSL $@chunk_0270E4.code_0272B8 ; {6004}
    LDA $7F8000, X        ; {6008}
    AND #$00FC            ; {6012}
    BEQ loc_001790        ; {6015}
    JSL $@chunk_0270E4.code_02731A ; {6017}
    LDA $7F8000, X        ; {6021}
    AND #$00FC            ; {6025}
    BEQ loc_001795        ; {6028}

  loc_00178E:
    TYX                   ; {6030}
    RTS                   ; {6031}

  loc_001790:
    LDA #$FFFE            ; {6032}
    BRA loc_001798        ; {6035}

  loc_001795:
    LDA #$0002            ; {6037}

  loc_001798:
    TYX                   ; {6040}
    CLC                   ; {6041}
    ADC $0000, X          ; {6042}
    STA $0000, X          ; {6045}
    RTS                   ; {6048}

  loc_0017A1:
    LDA $0322             ; {6049}
    BIT #$0400            ; {6052}
    BNE loc_0017AA        ; {6055}
    RTS                   ; {6057}

  loc_0017AA:
    TXY                   ; {6058}
    LDA $0000, X          ; {6059}
    AND #$000F            ; {6062}
    BEQ loc_0017D7        ; {6065}
    LDA $0000, X          ; {6067}
    STA $16               ; {6070}
    LDA $0002, X          ; {6072}
    STA $18               ; {6075}
    JSL $@chunk_0270E4.code_0272B8 ; {6077}
    LDA $7F8000, X        ; {6081}
    AND #$00F3            ; {6085}
    BEQ loc_0017D9        ; {6088}
    JSL $@chunk_0270E4.code_02731A ; {6090}
    LDA $7F8000, X        ; {6094}
    AND #$00F3            ; {6098}
    BEQ loc_0017DE        ; {6101}

  loc_0017D7:
    TYX                   ; {6103}
    RTS                   ; {6104}

  loc_0017D9:
    LDA #$FFFE            ; {6105}
    BRA loc_0017E1        ; {6108}

  loc_0017DE:
    LDA #$0002            ; {6110}

  loc_0017E1:
    TYX                   ; {6113}
    CLC                   ; {6114}
    ADC $0000, X          ; {6115}
    STA $0000, X          ; {6118}
    RTS                   ; {6121}

  loc_0017EA:
    LDA $0322             ; {6122}
    BIT #$0100            ; {6125}
    BNE loc_0017F3        ; {6128}
    RTS                   ; {6130}

  loc_0017F3:
    TXY                   ; {6131}
    LDA $0002, X          ; {6132}
    AND #$000F            ; {6135}
    BEQ loc_00182B        ; {6138}
    LDA $0000, X          ; {6140}
    CLC                   ; {6143}
    ADC #$0010            ; {6144}
    STA $16               ; {6147}
    LDA $0002, X          ; {6149}
    AND #$FFF0            ; {6152}
    SEC                   ; {6155}
    SBC #$0010            ; {6156}
    STA $18               ; {6159}
    JSL $@chunk_0270E4.code_0272B8 ; {6161}
    LDA $7F8000, X        ; {6165}
    AND #$00F5            ; {6169}
    BEQ loc_00182D        ; {6172}
    JSL $@chunk_0270E4.code_027331 ; {6174}
    LDA $7F8000, X        ; {6178}
    AND #$00F5            ; {6182}
    BEQ loc_001832        ; {6185}

  loc_00182B:
    TYX                   ; {6187}
    RTS                   ; {6188}

  loc_00182D:
    LDA #$FFFE            ; {6189}
    BRA loc_001835        ; {6192}

  loc_001832:
    LDA #$0002            ; {6194}

  loc_001835:
    TYX                   ; {6197}
    CLC                   ; {6198}
    ADC $0002, X          ; {6199}
    STA $0002, X          ; {6202}
    RTS                   ; {6205}

  loc_00183E:
    LDA $0322             ; {6206}
    BIT #$0200            ; {6209}
    BNE loc_001847        ; {6212}
    RTS                   ; {6214}

  loc_001847:
    TXY                   ; {6215}
    LDA $0002, X          ; {6216}
    AND #$000F            ; {6219}
    BEQ loc_00187F        ; {6222}
    LDA $0000, X          ; {6224}
    SEC                   ; {6227}
    SBC #$0010            ; {6228}
    STA $16               ; {6231}
    LDA $0002, X          ; {6233}
    AND #$FFF0            ; {6236}
    SEC                   ; {6239}
    SBC #$0010            ; {6240}
    STA $18               ; {6243}
    JSL $@chunk_0270E4.code_0272B8 ; {6245}
    LDA $7F8000, X        ; {6249}
    AND #$00FA            ; {6253}
    BEQ loc_001881        ; {6256}
    JSL $@chunk_0270E4.code_027331 ; {6258}
    LDA $7F8000, X        ; {6262}
    AND #$00FA            ; {6266}
    BEQ loc_001886        ; {6269}

  loc_00187F:
    TYX                   ; {6271}
    RTS                   ; {6272}

  loc_001881:
    LDA #$FFFE            ; {6273}
    BRA loc_001889        ; {6276}

  loc_001886:
    LDA #$0002            ; {6278}

  loc_001889:
    TYX                   ; {6281}
    CLC                   ; {6282}
    ADC $0002, X          ; {6283}
    STA $0002, X          ; {6286}
    RTS                   ; {6289}
}

code_001892 {
    LDY $001E, X          ; {6290}
    CPY #$002C            ; {6293}
    BCS loc_00189F        ; {6296}
    LDA $&data_00F9F7.binary_00FAAB, Y ; {6298}
    CLC                   ; {6301}
    RTS                   ; {6302}

  loc_00189F:
    SEC                   ; {6303}
    RTS                   ; {6304}
}

code_0018A1 {
    PHX                   ; {6305}
    PHA                   ; {6306}
    LDY $039C             ; {6307}
    LDA $001E, Y          ; {6310}
    CMP #$0004            ; {6313}
    BCS loc_0018E8        ; {6316}
    STA $00               ; {6318}
    LDA $0000, Y          ; {6320}
    CLC                   ; {6323}
    ADC #$0008            ; {6324}
    STA $16               ; {6327}
    LDA $0002, Y          ; {6329}
    CLC                   ; {6332}
    ADC #$0008            ; {6333}
    STA $18               ; {6336}
    LDA $06A6             ; {6338}
    BRA loc_0018CA        ; {6341}

  loc_0018C7:
    LDA $003E, X          ; {6343}

  loc_0018CA:
    TAX                   ; {6346}
    BEQ loc_0018E8        ; {6347}
    LDA $0016, X          ; {6349}
    BMI loc_0018C7        ; {6352}
    BIT #$4000            ; {6354}
    BEQ loc_0018C7        ; {6357}
    LDA $001E, X          ; {6359}
    SEC                   ; {6362}
    SBC #$0004            ; {6363}
    CMP #$0003            ; {6366}
    BCS loc_0018C7        ; {6369}
    JSR $&code_0018EB     ; {6371}
    BRA loc_0018C7        ; {6374}

  loc_0018E8:
    PLA                   ; {6376}
    PLX                   ; {6377}
    RTS                   ; {6378}
}

code_0018EB {
    LDA $00               ; {6379}
    BEQ loc_001923        ; {6381}
    DEC                   ; {6383}
    BEQ loc_0018F8        ; {6384}
    DEC                   ; {6386}
    BEQ loc_00194E        ; {6387}
    BRL loc_001979        ; {6389}

  loc_0018F8:
    LDA $0002, X          ; {6392}
    CMP $18               ; {6395}
    BCC loc_001900        ; {6397}
    RTS                   ; {6399}

  loc_001900:
    LDA $16               ; {6400}
    SEC                   ; {6402}
    SBC $0000, X          ; {6403}
    CMP #$0011            ; {6406}
    BCC loc_00190C        ; {6409}
    RTS                   ; {6411}

  loc_00190C:
    LDA $001E, X          ; {6412}
    CMP #$0006            ; {6415}
    BEQ loc_00191F        ; {6418}
    CMP #$0005            ; {6420}
    BEQ loc_00191C        ; {6423}
    INC $0002, X          ; {6425}

  loc_00191C:
    INC $0002, X          ; {6428}

  loc_00191F:
    INC $0002, X          ; {6431}
    RTS                   ; {6434}

  loc_001923:
    LDA $0002, X          ; {6435}
    CMP $18               ; {6438}
    BCS loc_00192B        ; {6440}
    RTS                   ; {6442}

  loc_00192B:
    LDA $16               ; {6443}
    SEC                   ; {6445}
    SBC $0000, X          ; {6446}
    CMP #$0011            ; {6449}
    BCC loc_001937        ; {6452}
    RTS                   ; {6454}

  loc_001937:
    LDA $001E, X          ; {6455}
    CMP #$0006            ; {6458}
    BEQ loc_00194A        ; {6461}
    CMP #$0005            ; {6463}
    BEQ loc_001947        ; {6466}
    DEC $0002, X          ; {6468}

  loc_001947:
    DEC $0002, X          ; {6471}

  loc_00194A:
    DEC $0002, X          ; {6474}
    RTS                   ; {6477}

  loc_00194E:
    LDA $0000, X          ; {6478}
    CMP $16               ; {6481}
    BCC loc_001956        ; {6483}
    RTS                   ; {6485}

  loc_001956:
    LDA $18               ; {6486}
    SEC                   ; {6488}
    SBC $0002, X          ; {6489}
    CMP #$0011            ; {6492}
    BCC loc_001962        ; {6495}
    RTS                   ; {6497}

  loc_001962:
    LDA $001E, X          ; {6498}
    CMP #$0006            ; {6501}
    BEQ loc_001975        ; {6504}
    CMP #$0005            ; {6506}
    BEQ loc_001972        ; {6509}
    INC $0000, X          ; {6511}

  loc_001972:
    INC $0000, X          ; {6514}

  loc_001975:
    INC $0000, X          ; {6517}
    RTS                   ; {6520}

  loc_001979:
    LDA $0000, X          ; {6521}
    CMP $16               ; {6524}
    BCS loc_001981        ; {6526}
    RTS                   ; {6528}

  loc_001981:
    LDA $18               ; {6529}
    SEC                   ; {6531}
    SBC $0002, X          ; {6532}
    CMP #$0011            ; {6535}
    BCC loc_00198D        ; {6538}
    RTS                   ; {6540}

  loc_00198D:
    LDA $001E, X          ; {6541}
    CMP #$0006            ; {6544}
    BEQ loc_0019A0        ; {6547}
    CMP #$0005            ; {6549}
    BEQ loc_00199D        ; {6552}
    DEC $0000, X          ; {6554}

  loc_00199D:
    DEC $0000, X          ; {6557}

  loc_0019A0:
    DEC $0000, X          ; {6560}
    RTS                   ; {6563}
}

code_0019A4 {
    COP [91]              ; {6564}
    LDA $0380             ; {6566}
    BEQ loc_0019AC        ; {6569}
    RTL                   ; {6571}

  loc_0019AC:
    PHX                   ; {6572}
    LDA $0405             ; {6573}
    ASL                   ; {6576}
    TAX                   ; {6577}
    LDA $7F0483, X        ; {6578}
    PLX                   ; {6582}
    TAY                   ; {6583}
    BNE loc_0019BB        ; {6584}
    RTL                   ; {6586}

  loc_0019BB:
    LDA $0000, X          ; {6587}
    SEC                   ; {6590}
    SBC $0000, Y          ; {6591}
    BMI loc_0019E3        ; {6594}
    STA $16               ; {6596}
    LDA $0002, X          ; {6598}
    SEC                   ; {6601}
    SBC $0002, Y          ; {6602}
    BMI loc_0019D7        ; {6605}
    STA $18               ; {6607}
    CMP $16               ; {6609}
    BCS loc_001A10        ; {6611}
    BRA loc_001A0B        ; {6613}

  loc_0019D7:
    EOR #$FFFF            ; {6615}
    INC                   ; {6618}
    STA $18               ; {6619}
    CMP $16               ; {6621}
    BCS loc_001A06        ; {6623}
    BRA loc_001A0B        ; {6625}

  loc_0019E3:
    EOR #$FFFF            ; {6627}
    INC                   ; {6630}
    STA $16               ; {6631}
    LDA $0002, X          ; {6633}
    SEC                   ; {6636}
    SBC $0002, Y          ; {6637}
    BMI loc_0019FA        ; {6640}
    STA $18               ; {6642}
    CMP $16               ; {6644}
    BCS loc_001A10        ; {6646}
    BRA loc_001A15        ; {6648}

  loc_0019FA:
    EOR #$FFFF            ; {6650}
    INC                   ; {6653}
    STA $18               ; {6654}
    CMP $16               ; {6656}
    BCS loc_001A06        ; {6658}
    BRA loc_001A15        ; {6660}

  loc_001A06:
    LDA #$0000            ; {6662}
    BRA loc_001A18        ; {6665}

  loc_001A0B:
    LDA #$0002            ; {6667}
    BRA loc_001A18        ; {6670}

  loc_001A10:
    LDA #$0001            ; {6672}
    BRA loc_001A18        ; {6675}

  loc_001A15:
    LDA #$0003            ; {6677}

  loc_001A18:
    STA $001E, X          ; {6680}
    STZ $0020, X          ; {6683}
    JSL $@code_0008F3     ; {6686}
    STZ $0014, X          ; {6690}
    COP [91]              ; {6693}
    RTL                   ; {6695}
}

code_001A28 {
    STX $039C             ; {6696}
    COP [A9] ( #$3000, #7F ) ; {6699}
    COP [84] ( @code_002F56 ) ; {6704}
    LDA $03FB             ; {6709}
    BEQ loc_001A3D        ; {6712}
    BRL code_0019A4       ; {6714}

  loc_001A3D:
    COP [84] ( @code_001FE0 ) ; {6717}
    LDA $0016, Y          ; {6722}
    AND #$CF7F            ; {6725}
    ORA #$0310            ; {6728}
    STA $0016, Y          ; {6731}
    STY $03A0             ; {6734}
    COP [84] ( @code_001512 ) ; {6737}
    COP [85] ( @code_0015E0 ) ; {6742}
    COP [85] ( @code_001FCF ) ; {6747}
    STY $039E             ; {6752}
    COP [91]              ; {6755}

  loc_001A65:
    LDA $0016, X          ; {6757}
    BIT #$0400            ; {6760}
    BEQ loc_001A70        ; {6763}
    BRL loc_001ED3        ; {6765}

  loc_001A70:
    LDA $0439             ; {6768}
    BNE loc_001A7A        ; {6771}
    LDA $1B5E             ; {6773}
    BNE loc_001ACD        ; {6776}

  loc_001A7A:
    LDA $0322             ; {6778}
    BIT #$0030            ; {6781}
    BNE loc_001A9E        ; {6784}
    EOR #$FFFF            ; {6786}
    XBA                   ; {6789}
    LSR                   ; {6790}
    BCS loc_001A8C        ; {6791}
    BRL code_001E0D       ; {6793}

  loc_001A8C:
    LSR                   ; {6796}
    BCS loc_001A92        ; {6797}
    BRL code_001DEF       ; {6799}

  loc_001A92:
    LSR                   ; {6802}
    BCS loc_001A98        ; {6803}
    BRL code_001DD1       ; {6805}

  loc_001A98:
    LSR                   ; {6808}
    BCS loc_001A9E        ; {6809}
    BRL code_001DB3       ; {6811}

  loc_001A9E:
    PHX                   ; {6814}
    LDA $001E, X          ; {6815}
    ASL                   ; {6818}
    CLC                   ; {6819}
    ADC $001E, X          ; {6820}
    ASL                   ; {6823}
    ASL                   ; {6824}
    TAX                   ; {6825}
    LDA $0322             ; {6826}
    INX                   ; {6829}
    INX                   ; {6830}
    XBA                   ; {6831}
    LSR                   ; {6832}
    BCS loc_001AC4        ; {6833}
    INX                   ; {6835}
    INX                   ; {6836}
    LSR                   ; {6837}
    BCS loc_001AC4        ; {6838}
    INX                   ; {6840}
    INX                   ; {6841}
    LSR                   ; {6842}
    BCS loc_001AC4        ; {6843}
    INX                   ; {6845}
    INX                   ; {6846}
    LSR                   ; {6847}
    BCS loc_001AC4        ; {6848}
    INX                   ; {6850}
    INX                   ; {6851}

  loc_001AC4:
    LDA $@code_list_001B2B, X ; {6852}
    PLX                   ; {6856}
    DEC                   ; {6857}
    PHA                   ; {6858}
    CLC                   ; {6859}
    RTS                   ; {6860}

  loc_001ACD:
    LDA $0322             ; {6861}
    BIT #$8030            ; {6864}
    BNE loc_001AEE        ; {6867}
    XBA                   ; {6869}
    LSR                   ; {6870}
    BCC loc_001ADC        ; {6871}
    BRL code_001E0D       ; {6873}

  loc_001ADC:
    LSR                   ; {6876}
    BCC loc_001AE2        ; {6877}
    BRL code_001DEF       ; {6879}

  loc_001AE2:
    LSR                   ; {6882}
    BCC loc_001AE8        ; {6883}
    BRL code_001DD1       ; {6885}

  loc_001AE8:
    LSR                   ; {6888}
    BCC loc_001AEE        ; {6889}
    BRL code_001DB3       ; {6891}

  loc_001AEE:
    PHX                   ; {6894}
    LDA $001E, X          ; {6895}
    ASL                   ; {6898}
    CLC                   ; {6899}
    ADC $001E, X          ; {6900}
    ASL                   ; {6903}
    ASL                   ; {6904}
    TAX                   ; {6905}
    LDA $0322             ; {6906}
    BIT #$8000            ; {6909}
    BNE loc_001B19        ; {6912}
    INX                   ; {6914}
    INX                   ; {6915}
    XBA                   ; {6916}
    LSR                   ; {6917}
    BCS loc_001B19        ; {6918}
    INX                   ; {6920}
    INX                   ; {6921}
    LSR                   ; {6922}
    BCS loc_001B19        ; {6923}
    INX                   ; {6925}
    INX                   ; {6926}
    LSR                   ; {6927}
    BCS loc_001B19        ; {6928}
    INX                   ; {6930}
    INX                   ; {6931}
    LSR                   ; {6932}
    BCS loc_001B19        ; {6933}
    INX                   ; {6935}
    INX                   ; {6936}

  loc_001B19:
    CLC                   ; {6937}
    LDA $0322             ; {6938}
    BIT #$0030            ; {6941}
    BNE loc_001B23        ; {6944}
    SEC                   ; {6946}

  loc_001B23:
    LDA $@code_list_001B2B, X ; {6947}
    PLX                   ; {6951}
    DEC                   ; {6952}
    PHA                   ; {6953}
    RTS                   ; {6954}
}
---------------------------------------------

code_list_001B2B [
  &code_001F1B   ;00
  &code_001EB7   ;01
  &code_001E8D   ;02
  &code_001DD1   ;03
  &code_001E2B   ;04
  &code_001D59   ;05
  &code_001EFB   ;06
  &code_001EA9   ;07
  &code_001E7F   ;08
  &code_001E55   ;09
  &code_001DB3   ;0A
  &code_001D3B   ;0B
  &code_001F3B   ;0C
  &code_001EC5   ;0D
  &code_001DEF   ;0E
  &code_001E63   ;0F
  &code_001E39   ;10
  &code_001D77   ;11
  &code_001F5B   ;12
  &code_001E0D   ;13
  &code_001E9B   ;14
  &code_001E71   ;15
  &code_001E47   ;16
  &code_001D95   ;17
  &code_001F1B   ;18
  &code_001EB7   ;19
  &code_001E8D   ;1A
  &code_001DD1   ;1B
  &code_001E2B   ;1C
  &code_001D59   ;1D
  &code_001F1B   ;1E
  &code_001EB7   ;1F
  &code_001E8D   ;20
  &code_001DD1   ;21
  &code_001E2B   ;22
  &code_001D59   ;23
  &code_001EFB   ;24
  &code_001EA9   ;25
  &code_001E7F   ;26
  &code_001E55   ;27
  &code_001DB3   ;28
  &code_001D3B   ;29
  &code_001EFB   ;2A
  &code_001EA9   ;2B
  &code_001E7F   ;2C
  &code_001E55   ;2D
  &code_001DB3   ;2E
  &code_001D3B   ;2F
  &code_001F3B   ;30
  &code_001EC5   ;31
  &code_001DEF   ;32
  &code_001E63   ;33
  &code_001E39   ;34
  &code_001D77   ;35
  &code_001F3B   ;36
  &code_001EC5   ;37
  &code_001DEF   ;38
  &code_001E63   ;39
  &code_001E39   ;3A
  &code_001D77   ;3B
  &code_001F5B   ;3C
  &code_001E0D   ;3D
  &code_001E9B   ;3E
  &code_001E71   ;3F
  &code_001E47   ;40
  &code_001D95   ;41
  &code_001F5B   ;42
  &code_001E0D   ;43
  &code_001E9B   ;44
  &code_001E71   ;45
  &code_001E47   ;46
  &code_001D95   ;47
  &code_001F1B   ;48
  &code_001EB7   ;49
  &code_001E8D   ;4A
  &code_001DD1   ;4B
  &code_001E2B   ;4C
  &code_001D59   ;4D
  &code_001F1B   ;4E
  &code_001EB7   ;4F
  &code_001E8D   ;50
  &code_001DD1   ;51
  &code_001E2B   ;52
  &code_001D59   ;53
  &code_001EFB   ;54
  &code_001EA9   ;55
  &code_001E7F   ;56
  &code_001E55   ;57
  &code_001DB3   ;58
  &code_001D3B   ;59
  &code_001EFB   ;5A
  &code_001EA9   ;5B
  &code_001E7F   ;5C
  &code_001E55   ;5D
  &code_001DB3   ;5E
  &code_001D3B   ;5F
  &code_001F3B   ;60
  &code_001EC5   ;61
  &code_001DEF   ;62
  &code_001E63   ;63
  &code_001E39   ;64
  &code_001D77   ;65
  &code_001F3B   ;66
  &code_001EC5   ;67
  &code_001DEF   ;68
  &code_001E63   ;69
  &code_001E39   ;6A
  &code_001D77   ;6B
  &code_001F5B   ;6C
  &code_001E0D   ;6D
  &code_001E9B   ;6E
  &code_001E71   ;6F
  &code_001E47   ;70
  &code_001D95   ;71
  &code_001F5B   ;72
  &code_001E0D   ;73
  &code_001E9B   ;74
  &code_001E71   ;75
  &code_001E47   ;76
  &code_001D95   ;77
  &code_001D3B   ;78
  &code_001D3B   ;79
  &code_001D3B   ;7A
  &code_001D3B   ;7B
  &code_001D3B   ;7C
  &code_001D3B   ;7D
  &code_001D3B   ;7E
  &code_001D3B   ;7F
  &code_001D3B   ;80
  &code_001D3B   ;81
  &code_001D3B   ;82
  &code_001D3B   ;83
  &code_001D3B   ;84
  &code_001D3B   ;85
  &code_001D3B   ;86
  &code_001D3B   ;87
  &code_001D3B   ;88
  &code_001D3B   ;89
  &code_001D3B   ;8A
  &code_001D3B   ;8B
  &code_001D3B   ;8C
  &code_001D3B   ;8D
  &code_001D3B   ;8E
  &code_001D3B   ;8F
  &code_001D3B   ;90
  &code_001D3B   ;91
  &code_001D3B   ;92
  &code_001D3B   ;93
  &code_001D3B   ;94
  &code_001D3B   ;95
  &code_001D3B   ;96
  &code_001D3B   ;97
  &code_001D3B   ;98
  &code_001D3B   ;99
  &code_001D3B   ;9A
  &code_001D3B   ;9B
  &code_001D3B   ;9C
  &code_001D3B   ;9D
  &code_001D3B   ;9E
  &code_001D3B   ;9F
  &code_001D3B   ;A0
  &code_001D3B   ;A1
  &code_001D3B   ;A2
  &code_001D3B   ;A3
  &code_001D3B   ;A4
  &code_001D3B   ;A5
  &code_001D3B   ;A6
  &code_001D3B   ;A7
  &code_001D3B   ;A8
  &code_001D3B   ;A9
  &code_001D3B   ;AA
  &code_001D3B   ;AB
  &code_001D3B   ;AC
  &code_001D3B   ;AD
  &code_001D3B   ;AE
  &code_001D3B   ;AF
  &code_001D3B   ;B0
  &code_001D3B   ;B1
  &code_001D3B   ;B2
  &code_001D3B   ;B3
  &code_001D3B   ;B4
  &code_001D3B   ;B5
  &code_001D3B   ;B6
  &code_001D3B   ;B7
  &code_001D3B   ;B8
  &code_001D3B   ;B9
  &code_001D3B   ;BA
  &code_001D3B   ;BB
  &code_001D3B   ;BC
  &code_001D3B   ;BD
  &code_001D3B   ;BE
  &code_001D3B   ;BF
  &code_001F1B   ;C0
  &code_001EB7   ;C1
  &code_001E8D   ;C2
  &code_001DD1   ;C3
  &code_001E2B   ;C4
  &code_001D59   ;C5
  &code_001EFB   ;C6
  &code_001EA9   ;C7
  &code_001E7F   ;C8
  &code_001E55   ;C9
  &code_001DB3   ;CA
  &code_001D3B   ;CB
  &code_001F3B   ;CC
  &code_001EC5   ;CD
  &code_001DEF   ;CE
  &code_001E63   ;CF
  &code_001E39   ;D0
  &code_001D77   ;D1
  &code_001F5B   ;D2
  &code_001E0D   ;D3
  &code_001E9B   ;D4
  &code_001E71   ;D5
  &code_001E47   ;D6
  &code_001D95   ;D7
  &code_001F5B   ;D8
  &code_001E0D   ;D9
  &code_001E9B   ;DA
  &code_001E71   ;DB
  &code_001E47   ;DC
  &code_001D95   ;DD
  &code_001F5B   ;DE
  &code_001E0D   ;DF
  &code_001E9B   ;E0
  &code_001E71   ;E1
  &code_001E47   ;E2
  &code_001D95   ;E3
  &code_001F3B   ;E4
  &code_001EC5   ;E5
  &code_001DEF   ;E6
  &code_001E63   ;E7
  &code_001E39   ;E8
  &code_001D77   ;E9
  &code_001F3B   ;EA
  &code_001EC5   ;EB
  &code_001DEF   ;EC
  &code_001E63   ;ED
  &code_001E39   ;EE
  &code_001D77   ;EF
  &code_001F1B   ;F0
  &code_001EB7   ;F1
  &code_001E8D   ;F2
  &code_001DD1   ;F3
  &code_001E2B   ;F4
  &code_001D59   ;F5
  &code_001F1B   ;F6
  &code_001EB7   ;F7
  &code_001E8D   ;F8
  &code_001DD1   ;F9
  &code_001E2B   ;FA
  &code_001D59   ;FB
  &code_001EFB   ;FC
  &code_001EA9   ;FD
  &code_001E7F   ;FE
  &code_001E55   ;FF
  &code_001DB3   ;100
  &code_001D3B   ;101
  &code_001EFB   ;102
  &code_001EA9   ;103
  &code_001E7F   ;104
  &code_001E55   ;105
  &code_001DB3   ;106
  &code_001D3B   ;107
]

code_001D3B {
    BCS loc_001D4B        ; {7483}
    LDA #$0001            ; {7485}
    JSR $&code_001F9D     ; {7488}
    COP [80] ( #01 )      ; {7491}
    COP [82]              ; {7494}
    BRL loc_001A65        ; {7496}

  loc_001D4B:
    LDA #$002B            ; {7499}
    JSR $&code_001F9D     ; {7502}
    COP [80] ( #2B )      ; {7505}
    COP [82]              ; {7508}
    BRL loc_001A65        ; {7510}
}

code_001D59 {
    BCS loc_001D69        ; {7513}
    LDA #$0000            ; {7515}
    JSR $&code_001F9D     ; {7518}
    COP [80] ( #00 )      ; {7521}
    COP [82]              ; {7524}
    BRL loc_001A65        ; {7526}

  loc_001D69:
    LDA #$0029            ; {7529}
    JSR $&code_001F9D     ; {7532}
    COP [80] ( #29 )      ; {7535}
    COP [82]              ; {7538}
    BRL loc_001A65        ; {7540}
}

code_001D77 {
    BCS loc_001D87        ; {7543}
    LDA #$0002            ; {7545}
    JSR $&code_001F9D     ; {7548}
    COP [80] ( #02 )      ; {7551}
    COP [82]              ; {7554}
    BRL loc_001A65        ; {7556}

  loc_001D87:
    LDA #$0027            ; {7559}
    JSR $&code_001F9D     ; {7562}
    COP [80] ( #27 )      ; {7565}
    COP [82]              ; {7568}
    BRL loc_001A65        ; {7570}
}

code_001D95 {
    BCS loc_001DA5        ; {7573}
    LDA #$0003            ; {7575}
    JSR $&code_001F9D     ; {7578}
    COP [80] ( #03 )      ; {7581}
    COP [82]              ; {7584}
    BRL loc_001A65        ; {7586}

  loc_001DA5:
    LDA #$0024            ; {7589}
    JSR $&code_001F9D     ; {7592}
    COP [80] ( #24 )      ; {7595}
    COP [82]              ; {7598}
    BRL loc_001A65        ; {7600}
}

code_001DB3 {
    BCS loc_001DC3        ; {7603}
    LDA #$0006            ; {7605}
    JSR $&code_001F9D     ; {7608}
    COP [80] ( #06 )      ; {7611}
    COP [82]              ; {7614}
    BRL loc_001A65        ; {7616}

  loc_001DC3:
    LDA #$002A            ; {7619}
    JSR $&code_001F9D     ; {7622}
    COP [80] ( #2A )      ; {7625}
    COP [82]              ; {7628}
    BRL loc_001A65        ; {7630}
}

code_001DD1 {
    BCS loc_001DE1        ; {7633}
    LDA #$0004            ; {7635}
    JSR $&code_001F9D     ; {7638}
    COP [80] ( #04 )      ; {7641}
    COP [82]              ; {7644}
    BRL loc_001A65        ; {7646}

  loc_001DE1:
    LDA #$0028            ; {7649}
    JSR $&code_001F9D     ; {7652}
    COP [80] ( #28 )      ; {7655}
    COP [82]              ; {7658}
    BRL loc_001A65        ; {7660}
}

code_001DEF {
    BCS loc_001DFF        ; {7663}
    LDA #$0008            ; {7665}
    JSR $&code_001F9D     ; {7668}
    COP [80] ( #08 )      ; {7671}
    COP [82]              ; {7674}
    BRL loc_001A65        ; {7676}

  loc_001DFF:
    LDA #$0026            ; {7679}
    JSR $&code_001F9D     ; {7682}
    COP [80] ( #26 )      ; {7685}
    COP [82]              ; {7688}
    BRL loc_001A65        ; {7690}
}

code_001E0D {
    BCS loc_001E1D        ; {7693}
    LDA #$000A            ; {7695}
    JSR $&code_001F9D     ; {7698}
    COP [80] ( #0A )      ; {7701}
    COP [82]              ; {7704}
    BRL loc_001A65        ; {7706}

  loc_001E1D:
    LDA #$0025            ; {7709}
    JSR $&code_001F9D     ; {7712}
    COP [80] ( #25 )      ; {7715}
    COP [82]              ; {7718}
    BRL loc_001A65        ; {7720}
}

code_001E2B {
    LDA #$0005            ; {7723}
    JSR $&code_001F9D     ; {7726}
    COP [80] ( #05 )      ; {7729}
    COP [82]              ; {7732}
    BRL loc_001A65        ; {7734}
}

code_001E39 {
    LDA #$0011            ; {7737}
    JSR $&code_001F9D     ; {7740}
    COP [80] ( #11 )      ; {7743}
    COP [82]              ; {7746}
    BRL loc_001A65        ; {7748}
}

code_001E47 {
    LDA #$0012            ; {7751}
    JSR $&code_001F9D     ; {7754}
    COP [80] ( #12 )      ; {7757}
    COP [82]              ; {7760}
    BRL loc_001A65        ; {7762}
}

code_001E55 {
    LDA #$0007            ; {7765}
    JSR $&code_001F9D     ; {7768}
    COP [80] ( #07 )      ; {7771}
    COP [82]              ; {7774}
    BRL loc_001A65        ; {7776}
}

code_001E63 {
    LDA #$0010            ; {7779}
    JSR $&code_001F9D     ; {7782}
    COP [80] ( #10 )      ; {7785}
    COP [82]              ; {7788}
    BRL loc_001A65        ; {7790}
}

code_001E71 {
    LDA #$0013            ; {7793}
    JSR $&code_001F9D     ; {7796}
    COP [80] ( #13 )      ; {7799}
    COP [82]              ; {7802}
    BRL loc_001A65        ; {7804}
}

code_001E7F {
    LDA #$000E            ; {7807}
    JSR $&code_001F9D     ; {7810}
    COP [80] ( #0E )      ; {7813}
    COP [82]              ; {7816}
    BRL loc_001A65        ; {7818}
}

code_001E8D {
    LDA #$000D            ; {7821}
    JSR $&code_001F9D     ; {7824}
    COP [80] ( #0D )      ; {7827}
    COP [82]              ; {7830}
    BRL loc_001A65        ; {7832}
}

code_001E9B {
    LDA #$000B            ; {7835}
    JSR $&code_001F9D     ; {7838}
    COP [80] ( #0B )      ; {7841}
    COP [82]              ; {7844}
    BRL loc_001A65        ; {7846}
}

code_001EA9 {
    LDA #$000F            ; {7849}
    JSR $&code_001F9D     ; {7852}
    COP [80] ( #0F )      ; {7855}
    COP [82]              ; {7858}
    BRL loc_001A65        ; {7860}
}

code_001EB7 {
    LDA #$000C            ; {7863}
    JSR $&code_001F9D     ; {7866}
    COP [80] ( #0C )      ; {7869}
    COP [82]              ; {7872}
    BRL loc_001A65        ; {7874}
}

code_001EC5 {
    LDA #$0009            ; {7877}
    JSR $&code_001F9D     ; {7880}
    COP [80] ( #09 )      ; {7883}
    COP [82]              ; {7886}
    BRL loc_001A65        ; {7888}

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
    COP [84] ( @code_002678 ) ; {7938}

  loc_001F07:
    LDA #$8000            ; {7943}
    TRB $032A             ; {7946}
    LDA #$0021            ; {7949}
    JSR $&code_001F9D     ; {7952}
    COP [80] ( #21 )      ; {7955}
    COP [82]              ; {7958}
    BRL loc_001A65        ; {7960}
}

code_001F1B {
    BRK #$01              ; {7963}
    JSR $&code_001F7B     ; {7965}
    BCS loc_001F27        ; {7968}
    COP [84] ( @code_00268D ) ; {7970}

  loc_001F27:
    LDA #$8000            ; {7975}
    TRB $032A             ; {7978}
    LDA #$0020            ; {7981}
    JSR $&code_001F9D     ; {7984}
    COP [80] ( #20 )      ; {7987}
    COP [82]              ; {7990}
    BRL loc_001A65        ; {7992}
}

code_001F3B {
    BRK #$01              ; {7995}
    JSR $&code_001F7B     ; {7997}
    BCS loc_001F47        ; {8000}
    COP [84] ( @code_0026A4 ) ; {8002}

  loc_001F47:
    LDA #$8000            ; {8007}
    TRB $032A             ; {8010}
    LDA #$0022            ; {8013}
    JSR $&code_001F9D     ; {8016}
    COP [80] ( #22 )      ; {8019}
    COP [82]              ; {8022}
    BRL loc_001A65        ; {8024}
}

code_001F5B {
    BRK #$01              ; {8027}
    JSR $&code_001F7B     ; {8029}
    BCS loc_001F67        ; {8032}
    COP [84] ( @code_0026B9 ) ; {8034}

  loc_001F67:
    LDA #$8000            ; {8039}
    TRB $032A             ; {8042}
    LDA #$0023            ; {8045}
    JSR $&code_001F9D     ; {8048}
    COP [80] ( #23 )      ; {8051}
    COP [82]              ; {8054}
    BRL loc_001A65        ; {8056}
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

code_001FCF {
    LDA $0016, X          ; {8143}
    AND #$CEFF            ; {8146}
    STA $0016, X          ; {8149}
    INC $0024, X          ; {8152}
    COP [91]              ; {8155}
    COP [82]              ; {8157}
    RTL                   ; {8159}
}

code_001FE0 {
    LDA $0016, X          ; {8160}
    ORA #$2000            ; {8163}
    STA $0016, X          ; {8166}
    LDA $03FB             ; {8169}
    BNE loc_002013        ; {8172}
    LDA $1B82             ; {8174}
    BEQ loc_002016        ; {8177}

  loc_001FF3:
    LDA $0016, X          ; {8179}
    AND #$DFFF            ; {8182}
    STA $0016, X          ; {8185}
    COP [85] ( @code_002026 ) ; {8188}
    COP [A8] ( #$8000, #0E ) ; {8193}
    COP [A3]              ; {8198}
    COP [A2] ( #30 )      ; {8200}

  loc_00200B:
    COP [81] ( #08, #10 ) ; {8203}
    COP [83]              ; {8207}
    BRA loc_00200B        ; {8209}

  loc_002013:
    COP [91]              ; {8211}
    RTL                   ; {8213}

  loc_002016:
    COP [91]              ; {8214}
    LDA $1B82             ; {8216}
    BNE loc_00201E        ; {8219}
    RTL                   ; {8221}

  loc_00201E:
    STZ $0000, X          ; {8222}
    STZ $0002, X          ; {8225}
    BRA loc_001FF3        ; {8228}
}

code_002026 {
    LDA $0016, X          ; {8230}
    ORA #$0010            ; {8233}
    STA $0016, X          ; {8236}
    COP [91]              ; {8239}
    PHX                   ; {8241}
    JSR $&code_00210A     ; {8242}
    BCC loc_00203A        ; {8245}
    BRL loc_002108        ; {8247}

  loc_00203A:
    LDA $0322             ; {8250}
    LDY #$0002            ; {8253}
    BIT #$0100            ; {8256}
    BNE loc_002050        ; {8259}
    LDY #$FFFE            ; {8261}
    BIT #$0200            ; {8264}
    BNE loc_002050        ; {8267}
    LDY #$0000            ; {8269}

  loc_002050:
    STY $16               ; {8272}
    LDY #$0002            ; {8274}
    BIT #$0400            ; {8277}
    BNE loc_002065        ; {8280}
    LDY #$FFFE            ; {8282}
    BIT #$0800            ; {8285}
    BNE loc_002065        ; {8288}
    LDY #$0000            ; {8290}

  loc_002065:
    STY $18               ; {8293}
    LDA $0374             ; {8295}
    SEC                   ; {8298}
    SBC $0000, X          ; {8299}
    BEQ loc_00208A        ; {8302}
    BPL loc_002081        ; {8304}
    EOR #$FFFF            ; {8306}
    INC                   ; {8309}
    DEC $16               ; {8310}
    CMP #$0060            ; {8312}
    BCC loc_00208A        ; {8315}
    DEC $16               ; {8317}
    BRA loc_00208A        ; {8319}

  loc_002081:
    INC $16               ; {8321}
    CMP #$0050            ; {8323}
    BCC loc_00208A        ; {8326}
    INC $16               ; {8328}

  loc_00208A:
    LDA $0000, X          ; {8330}
    CLC                   ; {8333}
    ADC $16               ; {8334}
    STA $0000, X          ; {8336}
    STA $16               ; {8339}
    LDA $0376             ; {8341}
    SEC                   ; {8344}
    SBC $0002, X          ; {8345}
    BEQ loc_0020B8        ; {8348}
    BPL loc_0020AF        ; {8350}
    EOR #$FFFF            ; {8352}
    INC                   ; {8355}
    DEC $18               ; {8356}
    CMP #$0040            ; {8358}
    BCC loc_0020B8        ; {8361}
    DEC $18               ; {8363}
    BRA loc_0020B8        ; {8365}

  loc_0020AF:
    INC $18               ; {8367}
    CMP #$0050            ; {8369}
    BCC loc_0020B8        ; {8372}
    INC $18               ; {8374}

  loc_0020B8:
    LDA $0002, X          ; {8376}
    CLC                   ; {8379}
    ADC $18               ; {8380}
    STA $0002, X          ; {8382}
    STA $18               ; {8385}
    LDY $003C, X          ; {8387}
    LDA $0431             ; {8390}
    ASL                   ; {8393}
    AND #$00FF            ; {8394}
    TAX                   ; {8397}
    SEP #$20              ; {8398}
    LDA #$00              ; {8400}
    XBA                   ; {8402}
    LDA $&data_00F9F7.binary_00FC84, X ; {8403}
    BPL loc_0020E1        ; {8406}
    XBA                   ; {8408}
    DEC                   ; {8409}
    XBA                   ; {8410}
    SEC                   ; {8411}
    ROR                   ; {8412}
    SEC                   ; {8413}
    ROR                   ; {8414}
    BRA loc_0020E3        ; {8415}

  loc_0020E1:
    LSR                   ; {8417}
    LSR                   ; {8418}

  loc_0020E3:
    REP #$20              ; {8419}
    CLC                   ; {8421}
    ADC $16               ; {8422}
    STA $0000, Y          ; {8424}
    SEP #$20              ; {8427}
    LDA #$00              ; {8429}
    XBA                   ; {8431}
    LDA $&data_00F9F7.binary_00FCC4, X ; {8432}
    BPL loc_0020FE        ; {8435}
    XBA                   ; {8437}
    DEC                   ; {8438}
    XBA                   ; {8439}
    SEC                   ; {8440}
    ROR                   ; {8441}
    SEC                   ; {8442}
    ROR                   ; {8443}
    BRA loc_002100        ; {8444}

  loc_0020FE:
    LSR                   ; {8446}
    LSR                   ; {8447}

  loc_002100:
    REP #$20              ; {8448}
    CLC                   ; {8450}
    ADC $18               ; {8451}
    STA $0002, Y          ; {8453}

  loc_002108:
    PLX                   ; {8456}
    RTL                   ; {8457}
}

code_00210A {
    LDA $0439             ; {8458}
    BNE code_002163       ; {8461}
    LDA $03A6             ; {8463}
    BNE code_002163       ; {8466}
    LDA $1B62             ; {8468}
    BEQ code_002163       ; {8471}
    LDA ($4A)             ; {8473}
    BEQ code_002163       ; {8475}
    LDA $0433             ; {8477}
    BEQ loc_002140        ; {8480}
    LDA $1B62             ; {8482}
    SEC                   ; {8485}
    SBC #$0011            ; {8486}
    BEQ loc_002176        ; {8489}
    DEC                   ; {8491}
    BEQ loc_002186        ; {8492}
    DEC                   ; {8494}
    BEQ code_002163       ; {8495}
    DEC                   ; {8497}
    BEQ loc_0021A0        ; {8498}
    DEC                   ; {8500}
    BEQ code_002163       ; {8501}
    DEC                   ; {8503}
    BEQ code_002163       ; {8504}
    DEC                   ; {8506}
    BEQ code_002163       ; {8507}
    BRL code_002163       ; {8509}

  loc_002140:
    LDA $0322             ; {8512}
    BIT #$4000            ; {8515}
    BEQ code_002163       ; {8518}
    LDA $1B62             ; {8520}
    SEC                   ; {8523}
    SBC #$0011            ; {8524}
    BEQ loc_002168        ; {8527}
    DEC                   ; {8529}
    BEQ loc_002178        ; {8530}
    DEC                   ; {8532}
    BEQ loc_002188        ; {8533}
    DEC                   ; {8535}
    BEQ loc_002198        ; {8536}
    DEC                   ; {8538}
    BEQ loc_0021A5        ; {8539}
    DEC                   ; {8541}
    BEQ loc_0021B5        ; {8542}
    DEC                   ; {8544}
    BEQ loc_0021C5        ; {8545}

  code_002163:
    INC $0431             ; {8547}
    CLC                   ; {8550}
    RTS                   ; {8551}

  loc_002168:
    COP [26] ( #$0004, &code_002163 ) ; {8552}
    INC $0433             ; {8558}
    COP [85] ( @code_0021D5 ) ; {8561}

  loc_002176:
    SEC                   ; {8566}
    RTS                   ; {8567}

  loc_002178:
    COP [26] ( #$0008, &code_002163 ) ; {8568}
    INC $0433             ; {8574}
    COP [85] ( @code_002246 ) ; {8577}

  loc_002186:
    SEC                   ; {8582}
    RTS                   ; {8583}

  loc_002188:
    COP [26] ( #$0008, &code_002163 ) ; {8584}
    INC $0433             ; {8590}
    COP [85] ( @code_0022F1 ) ; {8593}
    BRA code_002163       ; {8598}

  loc_002198:
    INC $0433             ; {8600}
    COP [85] ( @code_0023DD ) ; {8603}

  loc_0021A0:
    INC $0431             ; {8608}
    BRA code_002163       ; {8611}

  loc_0021A5:
    COP [26] ( #$0008, &code_002163 ) ; {8613}
    INC $0433             ; {8619}
    COP [85] ( @code_002439 ) ; {8622}
    BRA code_002163       ; {8627}

  loc_0021B5:
    COP [26] ( #$0020, &code_002163 ) ; {8629}
    INC $0433             ; {8635}
    COP [85] ( @code_00249D ) ; {8638}
    BRA code_002163       ; {8643}

  loc_0021C5:
    COP [26] ( #$0008, &code_002163 ) ; {8645}
    INC $0433             ; {8651}
    COP [85] ( @code_0024F8 ) ; {8654}
    BRA code_002163       ; {8659}
}

code_0021D5 {
    LDA #$03A0            ; {8661}
    STA $0016, X          ; {8664}
    LDA #$0005            ; {8667}
    STA $0030, X          ; {8670}
    LDY $03A0             ; {8673}
    LDA $0000, Y          ; {8676}
    STA $0000, X          ; {8679}
    LDA $0002, Y          ; {8682}
    STA $0002, X          ; {8685}
    COP [A3]              ; {8688}
    COP [A2] ( #30 )      ; {8690}
    COP [A8] ( #$8000, #0F ) ; {8693}
    COP [80] ( #00 )      ; {8698}
    COP [82]              ; {8701}
    BRK #$1B              ; {8703}
    LDA #$02A0            ; {8705}
    STA $0016, X          ; {8708}
    LDY $039C             ; {8711}
    LDA $001E, Y          ; {8714}
    TAY                   ; {8717}
    LDA $&data_00F9F7.binary_00FA7F, Y ; {8718}
    AND #$00FF            ; {8721}
    BEQ loc_00221E        ; {8724}
    DEC                   ; {8726}
    BEQ loc_002220        ; {8727}
    DEC                   ; {8729}
    BEQ loc_002225        ; {8730}
    BRA loc_002227        ; {8732}

  loc_00221E:
    COP [98]              ; {8734}

  loc_002220:
    LDA #$0002            ; {8736}
    BRA loc_00222A        ; {8739}

  loc_002225:
    COP [96]              ; {8741}

  loc_002227:
    LDA #$0001            ; {8743}

  loc_00222A:
    STA $001E, X          ; {8746}
    STZ $0020, X          ; {8749}
    LDA #$0008            ; {8752}
    STA $002A, X          ; {8755}
    LDA #$4000            ; {8758}
    TRB $032A             ; {8761}
    STZ $0433             ; {8764}
    COP [91]              ; {8767}
    COP [83]              ; {8769}
    COP [86]              ; {8771}
    RTL                   ; {8773}
}

code_002246 {
    LDA #$03A0            ; {8774}
    STA $0016, X          ; {8777}
    LDY $03A0             ; {8780}
    LDA $0000, Y          ; {8783}
    STA $0000, X          ; {8786}
    LDA $0002, Y          ; {8789}
    STA $0002, X          ; {8792}
    COP [A3]              ; {8795}
    COP [A2] ( #30 )      ; {8797}
    COP [A8] ( #$8000, #0F ) ; {8800}
    COP [80] ( #03 )      ; {8805}
    COP [82]              ; {8808}
    BRK #$12              ; {8810}
    COP [B2] ( &code_0022A0, #00, #$0000, #$FFF8, #$02A0 ) ; {8812}
    COP [B2] ( &code_0022B5, #00, #$0000, #$0008, #$02A0 ) ; {8823}
    COP [B2] ( &code_0022C8, #00, #$FFF8, #$0000, #$02A0 ) ; {8834}
    COP [B2] ( &code_0022DB, #00, #$0008, #$0000, #$02A0 ) ; {8845}
    COP [80] ( #04 )      ; {8856}
    COP [82]              ; {8859}
    BRL code_0026E7       ; {8861}
}

code_0022A0 {
    LDA #$000A            ; {8864}
    STA $0030, X          ; {8867}
    COP [98]              ; {8870}
    COP [80] ( #07 )      ; {8872}
    COP [82]              ; {8875}
    COP [81] ( #08, #08 ) ; {8877}
    COP [83]              ; {8881}
    BRA loc_0022EE        ; {8883}
}

code_0022B5 {
    LDA #$000A            ; {8885}
    STA $0030, X          ; {8888}
    COP [80] ( #07 )      ; {8891}
    COP [82]              ; {8894}
    COP [81] ( #08, #08 ) ; {8896}
    COP [83]              ; {8900}
    BRA loc_0022EE        ; {8902}
}

code_0022C8 {
    LDA #$000A            ; {8904}
    STA $0030, X          ; {8907}
    COP [80] ( #05 )      ; {8910}
    COP [82]              ; {8913}
    COP [81] ( #06, #08 ) ; {8915}
    COP [83]              ; {8919}
    BRA loc_0022EE        ; {8921}
}

code_0022DB {
    LDA #$000A            ; {8923}
    STA $0030, X          ; {8926}
    COP [96]              ; {8929}
    COP [80] ( #05 )      ; {8931}
    COP [82]              ; {8934}
    COP [81] ( #06, #08 ) ; {8936}
    COP [83]              ; {8940}

  loc_0022EE:
    COP [86]              ; {8942}
    RTL                   ; {8944}
}

code_0022F1 {
    LDA #$03A0            ; {8945}
    STA $0016, X          ; {8948}
    LDA #$0014            ; {8951}
    STA $0030, X          ; {8954}
    COP [85] ( @code_0023B1 ) ; {8957}
    COP [A3]              ; {8962}
    COP [A2] ( #30 )      ; {8964}
    COP [A8] ( #$8000, #0F ) ; {8967}
    COP [03] ( #05 )      ; {8972}
    COP [80] ( #09 )      ; {8975}
    COP [82]              ; {8978}
    LDA $0322             ; {8980}
    BIT #$4000            ; {8983}
    BEQ loc_002351        ; {8986}
    COP [04]              ; {8988}
    COP [03] ( #05 )      ; {8990}
    COP [80] ( #0A )      ; {8993}
    COP [82]              ; {8996}
    LDA $0322             ; {8998}
    BIT #$4000            ; {9001}
    BEQ loc_002369        ; {9004}
    COP [04]              ; {9006}
    COP [03] ( #05 )      ; {9008}
    COP [80] ( #0B )      ; {9011}
    COP [82]              ; {9014}
    LDA $0322             ; {9016}
    BIT #$4000            ; {9019}
    BEQ loc_002381        ; {9022}
    COP [04]              ; {9024}

  loc_002342:
    COP [80] ( #0C )      ; {9026}
    COP [82]              ; {9029}
    LDA $0322             ; {9031}
    BIT #$4000            ; {9034}
    BEQ loc_002399        ; {9037}
    BRA loc_002342        ; {9039}

  loc_002351:
    LDA #$02A0            ; {9041}
    STA $0016, X          ; {9044}
    COP [A3]              ; {9047}
    COP [81] ( #0D, #03 ) ; {9049}
    COP [83]              ; {9053}
    BRK #$21              ; {9055}
    COP [80] ( #10 )      ; {9057}
    COP [82]              ; {9060}
    BRL code_0026E7       ; {9062}

  loc_002369:
    LDA #$02A0            ; {9065}
    STA $0016, X          ; {9068}
    COP [A3]              ; {9071}
    COP [81] ( #0E, #03 ) ; {9073}
    COP [83]              ; {9077}
    BRK #$21              ; {9079}
    COP [80] ( #11 )      ; {9081}
    COP [82]              ; {9084}
    BRL code_0026E7       ; {9086}

  loc_002381:
    LDA #$02A0            ; {9089}
    STA $0016, X          ; {9092}
    COP [A3]              ; {9095}
    COP [81] ( #0E, #03 ) ; {9097}
    COP [83]              ; {9101}
    BRK #$21              ; {9103}
    COP [80] ( #12 )      ; {9105}
    COP [82]              ; {9108}
    BRL code_0026E7       ; {9110}

  loc_002399:
    LDA #$02A0            ; {9113}
    STA $0016, X          ; {9116}
    COP [A3]              ; {9119}
    COP [81] ( #0E, #03 ) ; {9121}
    COP [83]              ; {9125}
    BRK #$21              ; {9127}
    COP [80] ( #13 )      ; {9129}
    COP [82]              ; {9132}
    BRL code_0026E7       ; {9134}
}

code_0023B1 {
    LDA $0016, X          ; {9137}
    ORA #$0010            ; {9140}
    STA $0016, X          ; {9143}
    COP [91]              ; {9146}
    LDA $0322             ; {9148}
    BIT #$4000            ; {9151}
    BEQ loc_0023DA        ; {9154}
    PHX                   ; {9156}
    LDY $03A0             ; {9157}
    LDA $003C, X          ; {9160}
    TAX                   ; {9163}
    LDA $0000, Y          ; {9164}
    STA $0000, X          ; {9167}
    LDA $0002, Y          ; {9170}
    STA $0002, X          ; {9173}
    PLX                   ; {9176}
    RTL                   ; {9177}

  loc_0023DA:
    COP [86]              ; {9178}
    RTL                   ; {9180}
}

code_0023DD {
    LDA #$2020            ; {9181}
    STA $0016, X          ; {9184}

  code_0023E3:
    LDA $0322             ; {9187}
    BIT #$4000            ; {9190}
    BNE loc_0023EE        ; {9193}
    BRL code_0026E7       ; {9195}

  loc_0023EE:
    COP [26] ( #$0001, &code_0026E7 ) ; {9198}
    COP [B0] ( @code_002401, #$02B0 ) ; {9204}
    COP [1B] ( &code_0023E3, #$0004 ) ; {9211}
}

code_002401 {
    LDY $03A0             ; {9217}
    LDA $0000, Y          ; {9220}
    STA $0000, X          ; {9223}
    LDA $0002, Y          ; {9226}
    STA $0002, X          ; {9229}
    LDA #$0005            ; {9232}
    STA $0030, X          ; {9235}
    COP [A3]              ; {9238}
    COP [A2] ( #30 )      ; {9240}
    COP [A8] ( #$8000, #0F ) ; {9243}
    BRK #$24              ; {9248}
    COP [80] ( #14 )      ; {9250}
    COP [82]              ; {9253}
    COP [80] ( #15 )      ; {9255}
    COP [82]              ; {9258}
    COP [80] ( #16 )      ; {9260}
    COP [82]              ; {9263}
    COP [80] ( #17 )      ; {9265}
    COP [82]              ; {9268}
    COP [86]              ; {9270}
    RTL                   ; {9272}
}

code_002439 {
    LDA #$2020            ; {9273}
    STA $0016, X          ; {9276}
    STZ $0433             ; {9279}
    COP [03] ( #04 )      ; {9282}
    COP [B0] ( @code_002457, #$03A0 ) ; {9285}
    COP [1B] ( &code_002452, #$0010 ) ; {9292}
}

code_002452 {
    COP [04]              ; {9298}
    COP [86]              ; {9300}
    RTL                   ; {9302}
}

code_002457 {
    INC $0433             ; {9303}
    LDA #$001E            ; {9306}
    STA $0030, X          ; {9309}
    LDY $03A0             ; {9312}
    LDA $0000, Y          ; {9315}
    STA $0000, X          ; {9318}
    LDA $0002, Y          ; {9321}
    STA $0002, X          ; {9324}
    COP [A4]              ; {9327}
    COP [A8] ( #$8000, #0F ) ; {9329}
    COP [81] ( #18, #04 ) ; {9334}
    COP [83]              ; {9338}
    COP [81] ( #19, #04 ) ; {9340}
    COP [83]              ; {9344}
    LDA #$02A0            ; {9346}
    STA $0016, X          ; {9349}
    BRK #$21              ; {9352}
    COP [80] ( #1A )      ; {9354}
    COP [82]              ; {9357}
    DEC $0433             ; {9359}
    BNE loc_00249A        ; {9362}
    LDA #$4000            ; {9364}
    TRB $032A             ; {9367}

  loc_00249A:
    COP [86]              ; {9370}
    RTL                   ; {9372}
}

code_00249D {
    LDA #$2020            ; {9373}
    STA $0016, X          ; {9376}
    STZ $0433             ; {9379}
    COP [03] ( #04 )      ; {9382}
    COP [B0] ( @code_0024BB, #$02A0 ) ; {9385}
    COP [1B] ( &code_0024B6, #$0010 ) ; {9392}
}

code_0024B6 {
    COP [04]              ; {9398}
    COP [86]              ; {9400}
    RTL                   ; {9402}
}

code_0024BB {
    INC $0433             ; {9403}
    LDA #$0006            ; {9406}
    STA $0030, X          ; {9409}
    LDY $03A0             ; {9412}
    LDA $0000, Y          ; {9415}
    STA $0000, X          ; {9418}
    LDA $0002, Y          ; {9421}
    STA $0002, X          ; {9424}
    COP [A8] ( #$8000, #0F ) ; {9427}
    BRK #$0B              ; {9432}
    COP [80] ( #1C )      ; {9434}
    COP [82]              ; {9437}
    COP [81] ( #1B, #14 ) ; {9439}
    COP [83]              ; {9443}
    COP [80] ( #1D )      ; {9445}
    COP [82]              ; {9448}
    DEC $0433             ; {9450}
    BNE loc_0024F5        ; {9453}
    LDA #$4000            ; {9455}
    TRB $032A             ; {9458}

  loc_0024F5:
    COP [86]              ; {9461}
    RTL                   ; {9463}
}

code_0024F8 {
    LDA #$02A0            ; {9464}
    STA $0016, X          ; {9467}
    COP [85] ( @code_002666 ) ; {9470}
    LDY $03A0             ; {9475}
    LDA $0000, Y          ; {9478}
    STA $0000, X          ; {9481}
    LDA $0002, Y          ; {9484}
    SEC                   ; {9487}
    SBC #$0010            ; {9488}
    STA $0002, X          ; {9491}
    COP [A8] ( #$8000, #0F ) ; {9494}
    COP [A2] ( #30 )      ; {9499}
    COP [81] ( #24, #04 ) ; {9502}
    COP [83]              ; {9506}
    BRK #$16              ; {9508}
    COP [80] ( #25 )      ; {9510}
    COP [82]              ; {9513}
    LDA #$000F            ; {9515}
    STA $0030, X          ; {9518}
    COP [03] ( #3C )      ; {9521}

  loc_002534:
    COP [80] ( #27 )      ; {9524}
    COP [82]              ; {9527}
    COP [1F]              ; {9529}
    LDA #$0302            ; {9531}
    AND #$0003            ; {9534}
    BNE loc_002546        ; {9537}
    BRL loc_0025AD        ; {9539}

  loc_002546:
    DEC                   ; {9542}
    BNE loc_00254C        ; {9543}
    BRL loc_0025D9        ; {9545}

  loc_00254C:
    DEC                   ; {9548}
    BNE loc_002552        ; {9549}
    BRL loc_002602        ; {9551}

  loc_002552:
    BRL loc_00262B        ; {9554}

  loc_002555:
    COP [80] ( #28 )      ; {9557}
    COP [82]              ; {9560}
    BRA loc_0025AD        ; {9562}

  loc_00255C:
    COP [80] ( #1F )      ; {9564}
    COP [82]              ; {9567}
    BRL loc_00262B        ; {9569}

  loc_002564:
    COP [80] ( #1E )      ; {9572}
    COP [82]              ; {9575}
    BRL loc_002602        ; {9577}

  loc_00256C:
    COP [80] ( #29 )      ; {9580}
    COP [82]              ; {9583}
    BRA loc_0025D9        ; {9585}

  loc_002573:
    COP [80] ( #2B )      ; {9587}
    COP [82]              ; {9590}
    BRA loc_0025AD        ; {9592}

  loc_00257A:
    COP [80] ( #2D )      ; {9594}
    COP [82]              ; {9597}
    BRL loc_00262B        ; {9599}

  loc_002582:
    COP [80] ( #20 )      ; {9602}
    COP [82]              ; {9605}
    BRA loc_002602        ; {9607}

  loc_002589:
    COP [80] ( #22 )      ; {9609}
    COP [82]              ; {9612}
    BRA loc_0025D9        ; {9614}

  loc_002590:
    COP [80] ( #21 )      ; {9616}
    COP [82]              ; {9619}
    BRL loc_00262B        ; {9621}

  loc_002598:
    COP [80] ( #23 )      ; {9624}
    COP [82]              ; {9627}
    BRA loc_0025AD        ; {9629}

  loc_00259F:
    COP [80] ( #2A )      ; {9631}
    COP [82]              ; {9634}
    BRA loc_0025D9        ; {9636}

  loc_0025A6:
    COP [80] ( #2C )      ; {9638}
    COP [82]              ; {9641}
    BRA loc_002602        ; {9643}

  loc_0025AD:
    DEC $002E, X          ; {9645}
    BNE loc_0025B5        ; {9648}
    BRL loc_002654        ; {9650}

  loc_0025B5:
    LDA $0016, X          ; {9653}
    BIT #$8000            ; {9656}
    BEQ loc_0025C0        ; {9659}
    BRL loc_002654        ; {9661}

  loc_0025C0:
    COP [1F]              ; {9664}
    LDA $0302             ; {9666}
    AND #$0003            ; {9669}
    BEQ loc_002555        ; {9672}
    DEC                   ; {9674}
    BNE loc_0025D0        ; {9675}
    BRL loc_00257A        ; {9677}

  loc_0025D0:
    DEC                   ; {9680}
    BNE loc_0025D6        ; {9681}
    BRL loc_00259F        ; {9683}

  loc_0025D6:
    BRL loc_002534        ; {9686}

  loc_0025D9:
    DEC $002E, X          ; {9689}
    BEQ loc_002654        ; {9692}
    LDA $0016, X          ; {9694}
    BIT #$8000            ; {9697}
    BNE loc_002654        ; {9700}
    COP [1F]              ; {9702}
    LDA $0302             ; {9704}
    AND #$0003            ; {9707}
    BNE loc_0025F3        ; {9710}
    BRL loc_00256C        ; {9712}

  loc_0025F3:
    DEC                   ; {9715}
    BNE loc_0025F9        ; {9716}
    BRL loc_002573        ; {9718}

  loc_0025F9:
    DEC                   ; {9721}
    BNE loc_0025FF        ; {9722}
    BRL loc_0025A6        ; {9724}

  loc_0025FF:
    BRL loc_002534        ; {9727}

  loc_002602:
    DEC $002E, X          ; {9730}
    BEQ loc_002654        ; {9733}
    LDA $0016, X          ; {9735}
    BIT #$8000            ; {9738}
    BNE loc_002654        ; {9741}
    COP [1F]              ; {9743}
    LDA $0302             ; {9745}
    AND #$0003            ; {9748}
    BNE loc_00261C        ; {9751}
    BRL loc_002564        ; {9753}

  loc_00261C:
    DEC                   ; {9756}
    BNE loc_002622        ; {9757}
    BRL loc_002589        ; {9759}

  loc_002622:
    DEC                   ; {9762}
    BNE loc_002628        ; {9763}
    BRL loc_002590        ; {9765}

  loc_002628:
    BRL loc_002534        ; {9768}

  loc_00262B:
    DEC $002E, X          ; {9771}
    BEQ loc_002654        ; {9774}
    LDA $0016, X          ; {9776}
    BIT #$8000            ; {9779}
    BNE loc_002654        ; {9782}
    COP [1F]              ; {9784}
    LDA $0302             ; {9786}
    AND #$0003            ; {9789}
    BNE loc_002645        ; {9792}
    BRL loc_00255C        ; {9794}

  loc_002645:
    DEC                   ; {9797}
    BNE loc_00264B        ; {9798}
    BRL loc_002582        ; {9800}

  loc_00264B:
    DEC                   ; {9803}
    BNE loc_002651        ; {9804}
    BRL loc_002598        ; {9806}

  loc_002651:
    BRL loc_002534        ; {9809}

  loc_002654:
    COP [81] ( #26, #02 ) ; {9812}
    COP [83]              ; {9816}
    LDA #$4000            ; {9818}
    TRB $032A             ; {9821}
    STZ $0433             ; {9824}
    COP [86]              ; {9827}
    RTL                   ; {9829}
}

code_002666 {
    COP [A8] ( #$8000, #0D ) ; {9830}

  loc_00266B:
    COP [92] ( #42 )      ; {9835}
    COP [94]              ; {9838}
    LDA $0433             ; {9840}
    BNE loc_00266B        ; {9843}
    COP [86]              ; {9845}
    RTL                   ; {9847}
}

code_002678 {
    JSR $&code_0026D0     ; {9848}
    COP [A0] ( #$FFF0 )   ; {9851}
    COP [80] ( #30 )      ; {9855}
    COP [82]              ; {9858}
    COP [81] ( #31, #08 ) ; {9860}
    COP [83]              ; {9864}
    COP [86]              ; {9866}
    RTL                   ; {9868}
}

code_00268D {
    JSR $&code_0026D0     ; {9869}
    COP [A0] ( #$0010 )   ; {9872}
    COP [98]              ; {9876}
    COP [80] ( #30 )      ; {9878}
    COP [82]              ; {9881}
    COP [81] ( #31, #08 ) ; {9883}
    COP [83]              ; {9887}
    COP [86]              ; {9889}
    RTL                   ; {9891}
}

code_0026A4 {
    JSR $&code_0026D0     ; {9892}
    COP [A0] ( #$FFF0 )   ; {9895}
    COP [80] ( #2E )      ; {9899}
    COP [82]              ; {9902}
    COP [81] ( #2F, #08 ) ; {9904}
    COP [83]              ; {9908}
    COP [86]              ; {9910}
    RTL                   ; {9912}
}

code_0026B9 {
    JSR $&code_0026D0     ; {9913}
    COP [96]              ; {9916}
    COP [A0] ( #$FFF0 )   ; {9918}
    COP [80] ( #2E )      ; {9922}
    COP [82]              ; {9925}
    COP [81] ( #2F, #08 ) ; {9927}
    COP [83]              ; {9931}
    COP [86]              ; {9933}
    RTL                   ; {9935}
}

code_0026D0 {
    LDA #$02A0            ; {9936}
    STA $0016, X          ; {9939}
    LDA #$0014            ; {9942}
    STA $0030, X          ; {9945}
    COP [A3]              ; {9948}
    COP [A2] ( #30 )      ; {9950}
    COP [A8] ( #$8000, #0F ) ; {9953}
    RTS                   ; {9958}
}

code_0026E7 {
    LDA #$4000            ; {9959}
    TRB $032A             ; {9962}
    STZ $0433             ; {9965}
    COP [86]              ; {9968}
    RTL                   ; {9970}
}
---------------------------------------------

code_0026F3 {
    JSR $&code_002842     ; {9971}

  loc_0026F6:
    COP [91]              ; {9974}

  code_0026F8:
    LDA $0016, X          ; {9976}
    BIT #$8000            ; {9979}
    BEQ loc_002701        ; {9982}
    RTL                   ; {9984}

  loc_002701:
    LDA ($4A)             ; {9985}
    BNE loc_002709        ; {9987}
    COP [27] ( &code_0026F8 ) ; {9989}

  loc_002709:
    BRK #$53              ; {9993}
    JSR $&code_0028ED     ; {9995}
    JSR $&code_002913     ; {9998}
    COP [91]              ; {10001}
    JSR $&code_0028C6     ; {10003}
    BCC loc_0026F6        ; {10006}
    JMP $&code_002871     ; {10008}
}
---------------------------------------------

code_00271B {
    JSR $&code_002842     ; {10011}
    LDA $002E, X          ; {10014}
    AND #$00FF            ; {10017}
    STA $002C, X          ; {10020}

  loc_002727:
    COP [91]              ; {10023}

  code_002729:
    LDA $0016, X          ; {10025}
    BIT #$8000            ; {10028}
    BEQ loc_002732        ; {10031}
    RTL                   ; {10033}

  loc_002732:
    LDA ($4A)             ; {10034}
    BNE loc_00273A        ; {10036}
    COP [27] ( &code_002729 ) ; {10038}

  loc_00273A:
    BRK #$53              ; {10042}
    JSR $&code_0028ED     ; {10044}
    JSR $&code_002913     ; {10047}
    DEC $002C, X          ; {10050}
    BNE loc_002727        ; {10053}
    COP [91]              ; {10055}
    JSR $&code_0028C6     ; {10057}
    BCS loc_00274F        ; {10060}
    RTL                   ; {10062}

  loc_00274F:
    JMP $&code_002871     ; {10063}
}
---------------------------------------------

code_002752 {
    JSR $&code_002842     ; {10066}
    LDA $002E, X          ; {10069}
    AND #$00FF            ; {10072}
    STA $0C               ; {10075}
    LDA $0026, X          ; {10077}
    ASL                   ; {10080}
    TAY                   ; {10081}
    LDA $&data_00EE8E, Y  ; {10082}
    STA $00               ; {10085}

  loc_002767:
    JSR $&code_0028ED     ; {10087}
    LDA #$&code_00295E    ; {10090}
    STA $0018, Y          ; {10093}
    LDA ($00)             ; {10096}
    INC $00               ; {10098}
    INC $00               ; {10100}
    STA $0000, Y          ; {10102}
    LDA ($00)             ; {10105}
    INC $00               ; {10107}
    INC $00               ; {10109}
    STA $0002, Y          ; {10111}
    LDA $001C, Y          ; {10114}
    AND #$3FFF            ; {10117}
    ORA ($00)             ; {10120}
    INC $00               ; {10122}
    INC $00               ; {10124}
    STA $001C, Y          ; {10126}
    DEC $0C               ; {10129}
    BNE loc_002767        ; {10131}
    COP [91]              ; {10133}
    JSR $&code_0028C6     ; {10135}
    BCS loc_00279D        ; {10138}
    RTL                   ; {10140}

  loc_00279D:
    JMP $&code_002871     ; {10141}
}

code_0027A0 {
    JSR $&code_002842     ; {10144}

  loc_0027A3:
    COP [91]              ; {10147}

  code_0027A5:
    LDA $0016, X          ; {10149}
    BIT #$8000            ; {10152}
    BEQ loc_0027AE        ; {10155}
    RTL                   ; {10157}

  loc_0027AE:
    LDA ($4A)             ; {10158}
    BNE loc_0027B6        ; {10160}
    COP [27] ( &code_0027A5 ) ; {10162}

  loc_0027B6:
    BRK #$53              ; {10166}
    JSR $&code_0028ED     ; {10168}
    LDA $001C, X          ; {10171}
    CLC                   ; {10174}
    ADC #$4000            ; {10175}
    STA $001C, X          ; {10178}
    JSR $&code_002913     ; {10181}
    COP [91]              ; {10184}
    JSR $&code_0028C6     ; {10186}
    BCC loc_0027A3        ; {10189}
    JMP $&code_002871     ; {10191}
}
---------------------------------------------

code_0027D2 {
    JSR $&code_002842     ; {10194}
    LDA $002E, X          ; {10197}
    AND #$00FF            ; {10200}
    STA $002C, X          ; {10203}

  loc_0027DE:
    COP [91]              ; {10206}

  code_0027E0:
    LDA $0016, X          ; {10208}
    BIT #$8000            ; {10211}
    BEQ loc_0027E9        ; {10214}
    RTL                   ; {10216}

  loc_0027E9:
    LDA ($4A)             ; {10217}
    BNE loc_0027F1        ; {10219}
    COP [27] ( &code_0027E0 ) ; {10221}

  loc_0027F1:
    BRK #$53              ; {10225}
    JSR $&code_0028ED     ; {10227}
    LDA $001C, X          ; {10230}
    CLC                   ; {10233}
    ADC #$4000            ; {10234}
    STA $001C, X          ; {10237}
    JSR $&code_002913     ; {10240}
    DEC $002C, X          ; {10243}
    BNE loc_0027DE        ; {10246}
    COP [91]              ; {10248}
    JSR $&code_0028C6     ; {10250}
    BCS loc_002810        ; {10253}
    RTL                   ; {10255}

  loc_002810:
    JMP $&code_002871     ; {10256}
}
---------------------------------------------

code_002813 {
    JSR $&code_002842     ; {10259}

  loc_002816:
    COP [91]              ; {10262}

  code_002818:
    LDA $0016, X          ; {10264}
    BIT #$8000            ; {10267}
    BEQ loc_002821        ; {10270}
    RTL                   ; {10272}

  loc_002821:
    COP [0C] ( #00, #02, &code_002828 ) ; {10273}
    RTL                   ; {10279}
}

code_002828 {
    LDA ($4A)             ; {10280}
    BNE loc_002830        ; {10282}
    COP [27] ( &code_002818 ) ; {10284}

  loc_002830:
    BRK #$53              ; {10288}
    JSR $&code_0028ED     ; {10290}
    JSR $&code_002913     ; {10293}
    COP [91]              ; {10296}
    JSR $&code_0028C6     ; {10298}
    BCC loc_002816        ; {10301}
    JMP $&code_002871     ; {10303}
}

code_002842 {
    TXY                   ; {10306}
    LDA $002C, X          ; {10307}
    BNE loc_00285E        ; {10310}
    LDA $0000, X          ; {10312}
    STA $16               ; {10315}
    LDA $0002, X          ; {10317}
    SEC                   ; {10320}
    SBC #$0010            ; {10321}
    STA $18               ; {10324}
    JSL $@chunk_0270E4.code_0272B8 ; {10326}
    TXA                   ; {10330}
    STA $002C, Y          ; {10331}

  loc_00285E:
    LDX $002C, Y          ; {10334}
    LDA $7E8000, X        ; {10337}
    TYX                   ; {10341}
    AND #$00FF            ; {10342}
    CMP #$00FD            ; {10345}
    BEQ loc_002870        ; {10348}
    PLA                   ; {10350}
    RTL                   ; {10351}

  loc_002870:
    RTS                   ; {10352}
}

code_002871 {
    COP [91]              ; {10353}
    LDA $1C7B             ; {10355}
    BEQ loc_002879        ; {10358}
    RTL                   ; {10360}

  loc_002879:
    PHX                   ; {10361}
    LDA $0000, X          ; {10362}
    STA $16               ; {10365}
    LDA $0002, X          ; {10367}
    SEC                   ; {10370}
    SBC #$0010            ; {10371}
    STA $18               ; {10374}
    LDA $0034, X          ; {10376}
    ASL                   ; {10379}
    ASL                   ; {10380}
    ASL                   ; {10381}
    ASL                   ; {10382}
    ASL                   ; {10383}
    TAX                   ; {10384}
    SEP #$20              ; {10385}
    LDA $&data_00BA0D+8, X ; {10387}
    BEQ loc_0028A0        ; {10390}
    LDA #$FE              ; {10392}
    JSL $@chunk_010000.code_0107AC ; {10394}
    BRA loc_0028A6        ; {10398}

  loc_0028A0:
    LDA #$FE              ; {10400}
    JSL $@chunk_010000.code_0106F1 ; {10402}

  loc_0028A6:
    PLX                   ; {10406}
    REP #$20              ; {10407}
    COP [A8] ( #$8000, #0E ) ; {10409}
    LDA #$0310            ; {10414}
    STA $0016, X          ; {10417}
    STZ $001C, X          ; {10420}
    COP [A3]              ; {10423}
    COP [A2] ( #30 )      ; {10425}
    BRK #$83              ; {10428}
    COP [80] ( #01 )      ; {10430}
    COP [82]              ; {10433}
    COP [86]              ; {10435}
    RTL                   ; {10437}
}

code_0028C6 {
    SEP #$20              ; {10438}
    LDA $002E, X          ; {10440}
    CMP $002F, X          ; {10443}
    REP #$20              ; {10446}
    BNE loc_0028D4        ; {10448}
    PLA                   ; {10450}
    RTL                   ; {10451}

  loc_0028D4:
    TXY                   ; {10452}
    LDA $0034, X          ; {10453}
    TAX                   ; {10456}
    SEP #$20              ; {10457}
    LDA $002E, Y          ; {10459}
    STA $002F, Y          ; {10462}
    CLC                   ; {10465}
    BNE loc_0028E9        ; {10466}
    SEC                   ; {10468}
    STA $7F0203, X        ; {10469}

  loc_0028E9:
    REP #$20              ; {10473}
    TYX                   ; {10475}
    RTS                   ; {10476}
}

code_0028ED {
    PHX                   ; {10477}
    JSR $&code_006662     ; {10478}
    LDA $0038, X          ; {10481}
    TAX                   ; {10484}
    LDA $&meta_tables_008000+6, X ; {10485}
    ORA #$8000            ; {10488}
    STA $0016, Y          ; {10491}
    LDA #$&code_002928    ; {10494}
    STA $0018, Y          ; {10497}
    SEP #$20              ; {10500}
    LDA #$^code_002928    ; {10502}
    STA $0036, Y          ; {10504}
    REP #$20              ; {10507}
    PLX                   ; {10509}
    TXA                   ; {10510}
    STA $0032, Y          ; {10511}
    RTS                   ; {10514}
}

code_002913 {
    LDA $0026, X          ; {10515}
    BEQ loc_002927        ; {10518}
    ASL                   ; {10520}
    CLC                   ; {10521}
    ADC $0026, X          ; {10522}
    DEC                   ; {10525}
    STA $0014, X          ; {10526}
    PLA                   ; {10529}
    INC                   ; {10530}
    STA $0018, X          ; {10531}
    RTL                   ; {10534}

  loc_002927:
    RTS                   ; {10535}
}
---------------------------------------------

code_002928 {
    COP [A8] ( #$8000, #0E ) ; {10536}
    LDA #$0300            ; {10541}
    STA $0016, X          ; {10544}
    LDA $001C, X          ; {10547}
    STA $0030, X          ; {10550}
    LDA $0372             ; {10553}
    STA $001C, X          ; {10556}
    COP [80] ( #00 )      ; {10559}
    COP [82]              ; {10562}
    LDA $0030, X          ; {10564}
    STA $001C, X          ; {10567}
    LDA #$003C            ; {10570}
    STA $0026, X          ; {10573}
    LDY $0038, X          ; {10576}
    LDA $&meta_tables_008000+6, Y ; {10579}
    ORA #$8800            ; {10582}
    STA $0016, X          ; {10585}
    BRA loc_00296A        ; {10588}
}
---------------------------------------------

code_00295E {
    LDY $0038, X          ; {10590}
    LDA $&meta_tables_008000+6, Y ; {10593}
    ORA #$8000            ; {10596}
    STA $0016, X          ; {10599}

  loc_00296A:
    SEP #$20              ; {10602}
    LDA $&meta_tables_008000+A, Y ; {10604}
    STA $0024, X          ; {10607}
    LDA $&meta_tables_008000+D, Y ; {10610}
    STA $0036, X          ; {10613}
    PHA                   ; {10616}
    REP #$20              ; {10617}
    LDA $&meta_tables_008000+5, Y ; {10619}
    STA $001E, X          ; {10622}
    STZ $0020, X          ; {10625}
    LDA $&meta_tables_008000+8, Y ; {10628}
    STA $0022, X          ; {10631}
    LDA $&meta_tables_008000+B, Y ; {10634}
    STA $0018, X          ; {10637}
    DEC                   ; {10640}
    PHA                   ; {10641}
    JSL $@code_0008F3     ; {10642}
    STZ $0004, X          ; {10646}
    STZ $0006, X          ; {10649}
    RTL                   ; {10652}
}

code_00299D {
    LDA $032E             ; {10653}
    BEQ loc_0029E5        ; {10656}
    COP [A8] ( #$8000, #0E ) ; {10658}
    LDA $0016, X          ; {10663}
    AND #$DFFF            ; {10666}
    ORA #$0010            ; {10669}
    STA $0016, X          ; {10672}
    LDA $0372             ; {10675}
    STA $001C, X          ; {10678}
    COP [A3]              ; {10681}
    COP [A2] ( #30 )      ; {10683}
    LDA $0010, X          ; {10686}
    SEC                   ; {10689}
    SBC #$0010            ; {10690}
    LSR                   ; {10693}
    CLC                   ; {10694}
    ADC $0000, X          ; {10695}
    STA $0000, X          ; {10698}
    LDA $0012, X          ; {10701}
    SEC                   ; {10704}
    SBC #$0010            ; {10705}
    LSR                   ; {10708}
    EOR #$FFFF            ; {10709}
    INC                   ; {10712}
    CLC                   ; {10713}
    ADC $0002, X          ; {10714}
    STA $0002, X          ; {10717}
    COP [80] ( #02 )      ; {10720}
    COP [82]              ; {10723}

  loc_0029E5:
    COP [86]              ; {10725}
    RTL                   ; {10727}
}

code_0029E8 {
    COP [94]              ; {10728}
    BRA code_0029E8       ; {10730}
}
---------------------------------------------

code_0029EC {
    SEP #$20              ; {10732}
    LDA #$00              ; {10734}
    STA $0036, X          ; {10736}
    REP #$20              ; {10739}
    LDA #$0300            ; {10741}
    STA $0016, X          ; {10744}
    COP [A3]              ; {10747}
    LDA $0372             ; {10749}
    STA $001C, X          ; {10752}
    COP [A8] ( #$8000, #0E ) ; {10755}
    COP [80] ( #10 )      ; {10760}
    COP [82]              ; {10763}
    COP [86]              ; {10765}
    RTL                   ; {10767}
}
---------------------------------------------

code_002A10 {
    CPX $039A             ; {10768}
    BNE loc_002A18        ; {10771}
    BRL loc_002B96        ; {10773}

  loc_002A18:
    COP [A8] ( #$8000, #0E ) ; {10776}
    LDA #$0300            ; {10781}
    STA $0016, X          ; {10784}
    STZ $001A, X          ; {10787}
    LDA $0372             ; {10790}
    STA $001C, X          ; {10793}
    LDA $0010, X          ; {10796}
    SEC                   ; {10799}
    SBC #$0010            ; {10800}
    LSR                   ; {10803}
    CLC                   ; {10804}
    ADC $0000, X          ; {10805}
    STA $0000, X          ; {10808}
    LDA $0012, X          ; {10811}
    SEC                   ; {10814}
    SBC #$0010            ; {10815}
    LSR                   ; {10818}
    EOR #$FFFF            ; {10819}
    INC                   ; {10822}
    CLC                   ; {10823}
    ADC $0002, X          ; {10824}
    STA $0002, X          ; {10827}
    LDA $03BA             ; {10830}
    CMP #$0006            ; {10833}
    BNE loc_002A59        ; {10836}
    LDA #$0019            ; {10838}

  loc_002A59:
    ASL                   ; {10841}
    PHA                   ; {10842}
    INC                   ; {10843}
    STA $16               ; {10844}
    PLA                   ; {10846}
    ASL                   ; {10847}
    CLC                   ; {10848}
    ADC #$0004            ; {10849}
    STA $18               ; {10852}
    LDA $1B5E             ; {10854}
    CMP #$0004            ; {10857}
    BNE loc_002A72        ; {10860}
    ASL $16               ; {10862}
    ASL $18               ; {10864}

  loc_002A72:
    COP [1F]              ; {10866}
    COP [35] ( #64 )      ; {10868}
    LDA $0437             ; {10871}
    CMP $18               ; {10874}
    BCS loc_002A94        ; {10876}
    CMP $16               ; {10878}
    BCS loc_002A8B        ; {10880}
    COP [B0] ( @code_002EFA, #$4000 ) ; {10882}
    BRA loc_002A9B        ; {10889}

  loc_002A8B:
    COP [B0] ( @code_002EEA, #$4000 ) ; {10891}
    BRA loc_002A9B        ; {10898}

  loc_002A94:
    COP [B0] ( @code_002EDA, #$4000 ) ; {10900}

  loc_002A9B:
    COP [80] ( #03 )      ; {10907}
    COP [82]              ; {10910}
    COP [A3]              ; {10912}
    COP [A2] ( #30 )      ; {10914}
    COP [A8] ( #$F000, #7E ) ; {10917}
    COP [A0] ( #$FFF0 )   ; {10922}
    PHX                   ; {10926}
    LDY $0038, X          ; {10927}
    LDA $&meta_tables_008000+3, Y ; {10930}
    STA $00               ; {10933}
    TXY                   ; {10935}
    TXA                   ; {10936}
    SEC                   ; {10937}
    SBC #$0800            ; {10938}
    LSR                   ; {10941}
    LSR                   ; {10942}
    LSR                   ; {10943}
    LSR                   ; {10944}
    LSR                   ; {10945}
    LSR                   ; {10946}
    STA $001E, X          ; {10947}
    STZ $0020, X          ; {10950}
    ASL                   ; {10953}
    TAX                   ; {10954}
    LDA $7EF000, X        ; {10955}
    TAX                   ; {10959}
    LDA $7E0006, X        ; {10960}
    CLC                   ; {10964}
    ADC #$000E            ; {10965}
    SEC                   ; {10968}
    SBC #$F000            ; {10969}
    TAX                   ; {10972}
    LDA $00               ; {10973}
    CMP #$1000            ; {10975}
    BCS loc_002B27        ; {10978}
    CMP #$0100            ; {10980}
    BCS loc_002B14        ; {10983}
    CMP #$0010            ; {10985}
    BCS loc_002B01        ; {10988}
    LDA #$0001            ; {10990}
    STA $7EEFFE, X        ; {10993}
    LDA $0000, Y          ; {10997}
    CLC                   ; {11000}
    ADC #$0005            ; {11001}
    STA $0000, Y          ; {11004}
    BRA loc_002B47        ; {11007}

  loc_002B01:
    LDA #$0002            ; {11009}
    STA $7EEFFE, X        ; {11012}
    LDA $0000, Y          ; {11016}
    CLC                   ; {11019}
    ADC #$0003            ; {11020}
    STA $0000, Y          ; {11023}
    BRA loc_002B42        ; {11026}

  loc_002B14:
    LDA #$0003            ; {11028}
    STA $7EEFFE, X        ; {11031}
    LDA $0000, Y          ; {11035}
    CLC                   ; {11038}
    ADC #$0001            ; {11039}
    STA $0000, Y          ; {11042}
    BRA loc_002B3D        ; {11045}

  loc_002B27:
    LDA #$0004            ; {11047}
    STA $7EEFFE, X        ; {11050}
    LDA $0000, Y          ; {11054}
    CLC                   ; {11057}
    ADC #$FFFF            ; {11058}
    STA $0000, Y          ; {11061}
    LDA $01               ; {11064}
    JSR $&code_002B57     ; {11066}

  loc_002B3D:
    LDA $01               ; {11069}
    JSR $&code_002B5B     ; {11071}

  loc_002B42:
    LDA $00               ; {11074}
    JSR $&code_002B57     ; {11076}

  loc_002B47:
    LDA $00               ; {11079}
    JSR $&code_002B5B     ; {11081}
    PLX                   ; {11084}
    COP [91]              ; {11085}
    COP [82]              ; {11087}
    COP [1B] ( &code_002B7E, #$0010 ) ; {11089}
}

code_002B57 {
    LSR                   ; {11095}
    LSR                   ; {11096}
    LSR                   ; {11097}
    LSR                   ; {11098}
}

code_002B5B {
    AND #$000F            ; {11099}
    PHX                   ; {11102}
    TAX                   ; {11103}
    LDA $@data_002B74, X  ; {11104}
    PLX                   ; {11108}
    SEP #$20              ; {11109}
    STA $7EF005, X        ; {11111}
    REP #$20              ; {11115}
    TXA                   ; {11117}
    CLC                   ; {11118}
    ADC #$0007            ; {11119}
    TAX                   ; {11122}
    RTS                   ; {11123}
}
---------------------------------------------

data_002B74 #B7C8C9D8D9CECFDEDFA7
---------------------------------------------

code_002B7E {
    LDY $0032, X          ; {11134}
    BNE code_002B84       ; {11137}
    BRL loc_002D40        ; {11139}
}
---------------------------------------------

code_002B84 {
    SEP #$20              ; {11142}
    LDA $002E, Y          ; {11144}
    BEQ loc_002B91        ; {11147}
    DEC                   ; {11149}
    STA $002E, Y          ; {11150}

  loc_002B91:
    REP #$20              ; {11153}
    COP [86]              ; {11155}
    RTL                   ; {11157}

  loc_002B96:
    LDA #$0700            ; {11158}
    STA $0016, X          ; {11161}
    STZ $0004, X          ; {11164}
    STZ $0006, X          ; {11167}
    INC $042D             ; {11170}
    LDA $0000, X          ; {11173}
    SEC                   ; {11176}
    SBC $0008, X          ; {11177}
    STA $0425             ; {11180}
    LDA $0002, X          ; {11183}
    SEC                   ; {11186}
    SBC $000A, X          ; {11187}
    STA $0427             ; {11190}
    LDA $0008, X          ; {11193}
    CLC                   ; {11196}
    ADC $000C, X          ; {11197}
    STA $0429             ; {11200}
    LDA $000A, X          ; {11203}
    CLC                   ; {11206}
    ADC $000E, X          ; {11207}
    STA $042B             ; {11210}
    COP [03] ( #20 )      ; {11213}
    COP [84] ( @code_002BFE ) ; {11216}
    LDA #$0003            ; {11221}
    STA $0014, X          ; {11224}
    COP [04]              ; {11227}
    CPX $039A             ; {11229}
    BNE code_002B7E       ; {11232}
    JSR $&code_002C63     ; {11234}
    LDA $1C6A             ; {11237}
    CMP #$007D            ; {11240}
    BNE loc_002BF9        ; {11243}
    SEP #$20              ; {11245}
    LDA #$^code_005354    ; {11247}
    PHA                   ; {11249}
    REP #$20              ; {11250}
    LDA #$&code_005354-1  ; {11252}
    PHA                   ; {11255}
    RTL                   ; {11256}

  loc_002BF9:
    COP [31] ( #02 )      ; {11257}
    BRA code_002B7E       ; {11260}
}

code_002BFE {
    COP [A8] ( #$8000, #0E ) ; {11262}
    COP [A3]              ; {11267}
    LDA $0372             ; {11269}
    STA $001C, X          ; {11272}
    LDA $0016, X          ; {11275}
    AND #$DFFF            ; {11278}
    STA $0016, X          ; {11281}
    COP [1F]              ; {11284}
    SEP #$20              ; {11286}
    LDA $0302             ; {11288}
    AND #$7F              ; {11291}

  loc_002C1D:
    SEC                   ; {11293}
    SBC $0429             ; {11294}
    BPL loc_002C1D        ; {11297}
    CLC                   ; {11299}
    ADC $0429             ; {11300}
    REP #$20              ; {11303}
    AND #$00FF            ; {11305}
    CLC                   ; {11308}
    ADC $0425             ; {11309}
    STA $0000, X          ; {11312}
    COP [1F]              ; {11315}
    SEP #$20              ; {11317}
    LDA $0302             ; {11319}
    AND #$7F              ; {11322}

  loc_002C3C:
    SEC                   ; {11324}
    SBC $042B             ; {11325}
    BPL loc_002C3C        ; {11328}
    CLC                   ; {11330}
    ADC $042B             ; {11331}
    REP #$20              ; {11334}
    PHA                   ; {11336}
    AND #$00FF            ; {11337}
    CLC                   ; {11340}
    ADC $0427             ; {11341}
    STA $0002, X          ; {11344}
    PLA                   ; {11347}
    AND #$0001            ; {11348}
    BNE loc_002C5B        ; {11351}
    BRK #$85              ; {11353}

  loc_002C5B:
    COP [80] ( #00 )      ; {11355}
    COP [82]              ; {11358}
    COP [86]              ; {11360}
    RTL                   ; {11362}
}

code_002C63 {
    PHX                   ; {11363}
    LDA $06A6             ; {11364}
    BRA loc_002C6C        ; {11367}

  loc_002C69:
    LDA $003E, X          ; {11369}

  loc_002C6C:
    TAX                   ; {11372}
    BEQ loc_002C7B        ; {11373}
    LDA $0016, X          ; {11375}
    BIT #$24D0            ; {11378}
    BNE loc_002C69        ; {11381}
    COP [86]              ; {11383}
    BRA loc_002C69        ; {11385}

  loc_002C7B:
    PLX                   ; {11387}
    RTS                   ; {11388}
}

code_002C7D {
    PHP                   ; {11389}
    PHX                   ; {11390}
    REP #$20              ; {11391}
    LDA $06A6             ; {11393}
    BRA loc_002C89        ; {11396}

  loc_002C86:
    LDA $003E, X          ; {11398}

  loc_002C89:
    TAX                   ; {11401}
    BEQ loc_002C98        ; {11402}
    LDA $0016, X          ; {11404}
    BIT #$0020            ; {11407}
    BEQ loc_002C86        ; {11410}
    COP [86]              ; {11412}
    BRA loc_002C86        ; {11414}

  loc_002C98:
    PLX                   ; {11416}
    PLP                   ; {11417}
    RTL                   ; {11418}
}
---------------------------------------------

code_002C9B {
    SEP #$20              ; {11419}
    LDA #$F1              ; {11421}
    STA $APUIO0           ; {11423}
    REP #$20              ; {11426}
    COP [27] ( &code_002CA8 ) ; {11428}
}

code_002CA8 {
    LDA $APUIO0           ; {11432}
    AND #$00FF            ; {11435}
    CMP #$00F1            ; {11438}
    BEQ loc_002CB4        ; {11441}
    RTL                   ; {11443}

  loc_002CB4:
    SEP #$20              ; {11444}
    LDA #$01              ; {11446}
    STA $APUIO0           ; {11448}
    REP #$20              ; {11451}
    COP [27] ( &code_002CC1 ) ; {11453}
}

code_002CC1 {
    SEP #$20              ; {11457}
    LDA $APUIO0           ; {11459}
    REP #$20              ; {11462}
    BEQ code_002CCB       ; {11464}
    RTL                   ; {11466}
}
---------------------------------------------

code_002CCB {
    SEP #$20              ; {11467}
    LDA #$F0              ; {11469}
    STA $APUIO0           ; {11471}
    REP #$20              ; {11474}
    COP [27] ( &code_002CD8 ) ; {11476}
}

code_002CD8 {
    SEP #$20              ; {11480}
    LDA $APUIO0           ; {11482}
    REP #$20              ; {11485}
    BEQ loc_002CE2        ; {11487}
    RTL                   ; {11489}

  loc_002CE2:
    COP [1B] ( &code_002CE8, #$0002 ) ; {11490}
}
---------------------------------------------

code_002CE8 {
    SEP #$20              ; {11496}
    LDA #$FF              ; {11498}
    STA $APUIO0           ; {11500}
    REP #$20              ; {11503}
    LDA $0030, X          ; {11505}
    ASL                   ; {11508}
    CLC                   ; {11509}
    ADC $0030, X          ; {11510}
    TAY                   ; {11513}
    STZ $0030, X          ; {11514}
    LDA $&data_00F9F7.table_00FB49, Y ; {11517}
    STA $29               ; {11520}
    STA $0422             ; {11522}
    SEP #$20              ; {11525}
    LDA $&data_00F9F7.table_00FB49+2, Y ; {11527}
    STA $2B               ; {11530}
    STA $0424             ; {11532}
    REP #$20              ; {11535}
    PHX                   ; {11537}
    SEP #$20              ; {11538}
    JSL $@chunk_010000.code_0131B7 ; {11540}
    JSL $@chunk_010000.code_0131AE ; {11544}
    JSL $@chunk_0FAA49.code_0FEFF5 ; {11548}
    JSL $@chunk_010000.code_0131B7 ; {11552}
    JSL $@chunk_010000.code_0131A2 ; {11556}
    REP #$20              ; {11560}
    PLX                   ; {11562}
    COP [1B] ( &code_002D31, #$0002 ) ; {11563}
}

code_002D31 {
    SEP #$20              ; {11569}
    LDA #$01              ; {11571}
    STA $APUIO0           ; {11573}
    REP #$20              ; {11576}
    STZ $0458             ; {11578}
    COP [86]              ; {11581}
    RTL                   ; {11583}

  loc_002D40:
    LDA $001A, X          ; {11584}
    BIT #$1000            ; {11587}
    BEQ loc_002D64        ; {11590}
    LDA #$0258            ; {11592}
    STA $0026, X          ; {11595}
    COP [91]              ; {11598}
    LDA $0016, X          ; {11600}
    BIT #$8000            ; {11603}
    BNE loc_002D59        ; {11606}
    RTL                   ; {11608}

  loc_002D59:
    DEC $0026, X          ; {11609}
    BMI loc_002D5F        ; {11612}
    RTL                   ; {11614}

  loc_002D5F:
    JSL $@code_0013AB     ; {11615}
    RTL                   ; {11619}

  loc_002D64:
    COP [86]              ; {11620}
    RTL                   ; {11622}
}
---------------------------------------------

code_002D67 {
    TYA                   ; {11623}
    STA $001E, X          ; {11624}
    STZ $0020, X          ; {11627}
    COP [85] ( @code_002D96 ) ; {11630}
    CPY #$06AA            ; {11635}
    BEQ loc_002D93        ; {11638}
    SEP #$20              ; {11640}
    LDA #$00              ; {11642}
    STA $0036, X          ; {11644}
    REP #$20              ; {11647}
    COP [91]              ; {11649}

  loc_002D83:
    COP [82]              ; {11651}
    LDA $0016, X          ; {11653}
    BIT #$8000            ; {11656}
    BEQ loc_002D83        ; {11659}
    LDY $003E, X          ; {11661}
    STA $0030, Y          ; {11664}

  loc_002D93:
    COP [86]              ; {11667}
    RTL                   ; {11669}
}

code_002D96 {
    LDA $003C, X          ; {11670}
    STA $0030, X          ; {11673}
    LDA $0374             ; {11676}
    SEC                   ; {11679}
    SBC $0000, X          ; {11680}
    BMI loc_002DC4        ; {11683}
    STA $16               ; {11685}
    LDA $0376             ; {11687}
    SEC                   ; {11690}
    SBC $0002, X          ; {11691}
    BMI loc_002DB8        ; {11694}
    STA $18               ; {11696}
    CMP $16               ; {11698}
    BCS loc_002E23        ; {11700}
    BRA loc_002E11        ; {11702}

  loc_002DB8:
    EOR #$FFFF            ; {11704}
    INC                   ; {11707}
    STA $18               ; {11708}
    CMP $16               ; {11710}
    BCS loc_002DEA        ; {11712}
    BRA loc_002DFF        ; {11714}

  loc_002DC4:
    EOR #$FFFF            ; {11716}
    INC                   ; {11719}
    STA $16               ; {11720}
    LDA $0376             ; {11722}
    SEC                   ; {11725}
    SBC $0002, X          ; {11726}
    BMI loc_002DDB        ; {11729}
    STA $18               ; {11731}
    CMP $16               ; {11733}
    BCS loc_002E35        ; {11735}
    BRA loc_002E47        ; {11737}

  loc_002DDB:
    EOR #$FFFF            ; {11739}
    INC                   ; {11742}
    STA $18               ; {11743}
    CMP $16               ; {11745}
    BCC loc_002DE8        ; {11747}
    BRL loc_002E6B        ; {11749}

  loc_002DE8:
    BRA loc_002E59        ; {11752}

  loc_002DEA:
    JSR $&code_002E9C     ; {11754}
    COP [91]              ; {11757}
    DEC $0002, X          ; {11759}
    DEC $0010, X          ; {11762}
    BEQ loc_002DFA        ; {11765}
    BRL loc_002E83        ; {11767}

  loc_002DFA:
    INC $0000, X          ; {11770}
    BRA loc_002E7D        ; {11773}

  loc_002DFF:
    JSR $&code_002EA4     ; {11775}
    COP [91]              ; {11778}
    INC $0000, X          ; {11780}
    DEC $0010, X          ; {11783}
    BNE loc_002E83        ; {11786}
    DEC $0002, X          ; {11788}
    BRA loc_002E7D        ; {11791}

  loc_002E11:
    JSR $&code_002EA4     ; {11793}
    COP [91]              ; {11796}
    INC $0000, X          ; {11798}
    DEC $0010, X          ; {11801}
    BNE loc_002E83        ; {11804}
    INC $0002, X          ; {11806}
    BRA loc_002E7D        ; {11809}

  loc_002E23:
    JSR $&code_002E9C     ; {11811}
    COP [91]              ; {11814}
    INC $0002, X          ; {11816}
    DEC $0010, X          ; {11819}
    BNE loc_002E83        ; {11822}
    INC $0000, X          ; {11824}
    BRA loc_002E7D        ; {11827}

  loc_002E35:
    JSR $&code_002E9C     ; {11829}
    COP [91]              ; {11832}
    INC $0002, X          ; {11834}
    DEC $0010, X          ; {11837}
    BNE loc_002E83        ; {11840}
    DEC $0000, X          ; {11842}
    BRA loc_002E7D        ; {11845}

  loc_002E47:
    JSR $&code_002EA4     ; {11847}
    COP [91]              ; {11850}
    DEC $0000, X          ; {11852}
    DEC $0010, X          ; {11855}
    BNE loc_002E83        ; {11858}
    INC $0002, X          ; {11860}
    BRA loc_002E7D        ; {11863}

  loc_002E59:
    JSR $&code_002EA4     ; {11865}
    COP [91]              ; {11868}
    DEC $0000, X          ; {11870}
    DEC $0010, X          ; {11873}
    BNE loc_002E83        ; {11876}
    DEC $0002, X          ; {11878}
    BRA loc_002E7D        ; {11881}

  loc_002E6B:
    JSR $&code_002E9C     ; {11883}
    COP [91]              ; {11886}
    DEC $0002, X          ; {11888}
    DEC $0010, X          ; {11891}
    BNE loc_002E83        ; {11894}
    DEC $0000, X          ; {11896}
    BRA loc_002E7D        ; {11899}

  loc_002E7D:
    LDA $0012, X          ; {11901}
    STA $0010, X          ; {11904}

  loc_002E83:
    LDA $003C, X          ; {11907}
    CMP $0030, X          ; {11910}
    BNE loc_002E99        ; {11913}
    TAY                   ; {11915}
    LDA $0000, X          ; {11916}
    STA $0000, Y          ; {11919}
    LDA $0002, X          ; {11922}
    STA $0002, Y          ; {11925}
    RTL                   ; {11928}

  loc_002E99:
    COP [86]              ; {11929}
    RTL                   ; {11931}
}

code_002E9C {
    SEP #$20              ; {11932}
    LDY $18               ; {11934}
    LDA $16               ; {11936}
    BRA loc_002EAA        ; {11938}
}

code_002EA4 {
    SEP #$20              ; {11940}
    LDY $16               ; {11942}
    LDA $18               ; {11944}

  loc_002EAA:
    BNE loc_002EAD        ; {11946}
    INC                   ; {11948}

  loc_002EAD:
    JSL $@chunk_010000.code_0131E8 ; {11949}
    REP #$20              ; {11953}
    AND #$00FF            ; {11955}
    BNE loc_002EB9        ; {11958}
    INC                   ; {11960}

  loc_002EB9:
    STA $0010, X          ; {11961}
    STA $0012, X          ; {11964}
    RTS                   ; {11967}
}

code_002EC0 {
    COP [A8] ( #$8000, #0E ) ; {11968}
    LDA #$4000            ; {11973}
    STA $0016, X          ; {11976}
    COP [A4]              ; {11979}
    LDA $0372             ; {11981}
    STA $001C, X          ; {11984}

  loc_002ED3:
    COP [80] ( #07 )      ; {11987}
    COP [82]              ; {11990}
    BRA loc_002ED3        ; {11992}
}

code_002EDA {
    COP [A4]              ; {11994}
    COP [80] ( #04 )      ; {11996}
    COP [82]              ; {11999}
    COP [81] ( #09, #04 ) ; {12001}
    COP [83]              ; {12005}
    COP [86]              ; {12007}
    RTL                   ; {12009}
}

code_002EEA {
    COP [A4]              ; {12010}
    COP [80] ( #05 )      ; {12012}
    COP [82]              ; {12015}
    COP [81] ( #0A, #04 ) ; {12017}
    COP [83]              ; {12021}
    COP [86]              ; {12023}
    RTL                   ; {12025}
}

code_002EFA {
    COP [A4]              ; {12026}
    COP [80] ( #06 )      ; {12028}
    COP [82]              ; {12031}
    COP [81] ( #0B, #04 ) ; {12033}
    COP [83]              ; {12037}
    COP [86]              ; {12039}
    RTL                   ; {12041}
}

code_002F0A {
    PHP                   ; {12042}
    PHY                   ; {12043}
    REP #$20              ; {12044}
    BRK #$4D              ; {12046}
    LDA $001E, X          ; {12048}
    CMP #$0006            ; {12051}
    BEQ loc_002F31        ; {12054}
    CMP #$0005            ; {12056}
    BEQ loc_002F36        ; {12059}
    CMP #$0004            ; {12061}
    BEQ loc_002F3B        ; {12064}
    CMP #$000B            ; {12066}
    BEQ loc_002F31        ; {12069}
    CMP #$000A            ; {12071}
    BEQ loc_002F36        ; {12074}
    CMP #$0009            ; {12076}
    BEQ loc_002F3B        ; {12079}

  loc_002F31:
    LDA #$0010            ; {12081}
    BRA loc_002F3E        ; {12084}

  loc_002F36:
    LDA #$0005            ; {12086}
    BRA loc_002F3E        ; {12089}

  loc_002F3B:
    LDA #$0001            ; {12091}

  loc_002F3E:
    JSL $@chunk_0270E4.code_0276A5 ; {12094}
    LDA #$0010            ; {12098}
    TSB $0332             ; {12101}
    LDA $0016, X          ; {12104}
    ORA #$2000            ; {12107}
    STA $0016, X          ; {12110}
    COP [86]              ; {12113}
    PLY                   ; {12115}
    PLP                   ; {12116}
    RTL                   ; {12117}
}

code_002F56 {
    LDA $1B86             ; {12118}
    CMP #$0032            ; {12121}
    BCC loc_002F61        ; {12124}
    BRL loc_003002        ; {12126}

  loc_002F61:
    ASL                   ; {12129}
    ASL                   ; {12130}
    TAY                   ; {12131}
    LDA $&data_00F9F7.word_00FBB8, Y ; {12132}
    STA $1B7E             ; {12135}
    LDA $&data_00F9F7.word_00FBB8+2, Y ; {12138}
    STA $1B7C             ; {12141}
    COP [91]              ; {12144}
    LDA $1B78             ; {12146}
    SEC                   ; {12149}
    SBC $1B7C             ; {12150}
    LDA $1B7A             ; {12153}
    SBC $1B7E             ; {12156}
    BCS loc_002F82        ; {12159}
    RTL                   ; {12161}

  loc_002F82:
    LDA $1B8A             ; {12162}
    CLC                   ; {12165}
    ADC #$0002            ; {12166}
    CMP #$0065            ; {12169}
    BCC loc_002F91        ; {12172}
    LDA #$0064            ; {12174}

  loc_002F91:
    STA $1B8A             ; {12177}
    LDA $1B88             ; {12180}
    CLC                   ; {12183}
    ADC #$0002            ; {12184}
    CMP #$0065            ; {12187}
    BCC loc_002FA3        ; {12190}
    LDA #$0064            ; {12192}

  loc_002FA3:
    STA $1B88             ; {12195}
    COP [37]              ; {12198}
    INC $1B86             ; {12200}
    SED                   ; {12203}
    LDA $1B6A             ; {12204}
    CLC                   ; {12207}
    ADC #$0001            ; {12208}
    STA $1B6A             ; {12211}
    CLD                   ; {12214}
    LSR                   ; {12215}
    BCS loc_002FBF        ; {12216}
    INC $1B72             ; {12218}
    BRA loc_002FC2        ; {12221}

  loc_002FBF:
    INC $1B76             ; {12223}

  loc_002FC2:
    LDA #$001F            ; {12226}
    TSB $0332             ; {12229}
    LDA $1B86             ; {12232}
    ASL                   ; {12235}
    ASL                   ; {12236}
    TAY                   ; {12237}
    LDA $&data_00F9F7.word_00FBB8, Y ; {12238}
    STA $1B7E             ; {12241}
    LDA $&data_00F9F7.word_00FBB8+2, Y ; {12244}
    STA $1B7C             ; {12247}
    BRK #$97              ; {12250}
    COP [03] ( #03 )      ; {12252}
    PHX                   ; {12255}
    LDY #$&chunk_010000.asciistring_014516 ; {12256}
    JSL $@chunk_010000.code_012769 ; {12259}
    PLX                   ; {12263}
    COP [1B] ( &code_002FEE, #$0014 ) ; {12264}
}

code_002FEE {
    PHX                   ; {12270}
    LDY #$&chunk_010000.asciistring_014527 ; {12271}
    JSL $@chunk_010000.code_012769 ; {12274}
    PLX                   ; {12278}
    COP [1B] ( &code_002FFD, #$000A ) ; {12279}
}

code_002FFD {
    COP [04]              ; {12285}
    BRL code_002F56       ; {12287}

  loc_003002:
    COP [86]              ; {12290}
    RTL                   ; {12292}
}

code_003005 {
    PHP                   ; {12293}
    REP #$20              ; {12294}
    LDX $039C             ; {12296}
    LDA $0016, X          ; {12299}
    BIT #$0400            ; {12302}
    BNE loc_00305D        ; {12305}
    LDA $1B88             ; {12307}
    ORA $043B             ; {12310}
    BNE loc_00305D        ; {12313}
    COP [19] ( #38, &code_00302B ) ; {12315}
    LDA $1B8A             ; {12320}
    STA $043B             ; {12323}
    COP [0B] ( #38 )      ; {12326}
    BRA loc_00305D        ; {12329}
}

code_00302B {
    COP [19] ( #39, &code_003035 ) ; {12331}
    COP [0B] ( #39 )      ; {12336}
    BRA loc_003042        ; {12339}
}

code_003035 {
    COP [19] ( #40, &code_00303C ) ; {12341}
    BRA loc_003042        ; {12346}
}

code_00303C {
    STZ $1B66             ; {12348}
    STZ $1B68             ; {12351}

  loc_003042:
    LDA $0016, X          ; {12354}
    AND #$F7FF            ; {12357}
    STA $0016, X          ; {12360}
    LDA $0016, X          ; {12363}
    ORA #$0400            ; {12366}
    STA $0016, X          ; {12369}
    LDA #$2080            ; {12372}
    STA $0326             ; {12375}
    INC $043F             ; {12378}

  loc_00305D:
    PLP                   ; {12381}
    RTL                   ; {12382}
}
---------------------------------------------

code_00305F {
    SEP #$20              ; {12383}
    LDA #$00              ; {12385}
    STA $0036, X          ; {12387}
    REP #$20              ; {12390}
    LDA $0016, X          ; {12392}
    AND #$DFF7            ; {12395}
    STA $0016, X          ; {12398}
    COP [A8] ( #$8000, #0E ) ; {12401}
    LDA $001C, X          ; {12406}
    STA $0032, X          ; {12409}
    AND #$FEFF            ; {12412}
    STA $001C, X          ; {12415}
    COP [15]              ; {12418}

  loc_003084:
    COP [80] ( #0D )      ; {12420}
    COP [82]              ; {12423}
    LDA $0034, X          ; {12425}
    ASL                   ; {12428}
    ASL                   ; {12429}
    ASL                   ; {12430}
    ASL                   ; {12431}
    ASL                   ; {12432}
    TAY                   ; {12433}
    LDA $&data_00BA0D+1E, Y ; {12434}
    LDY #$1ADE            ; {12437}
    JSL $@chunk_0270E4.code_0273A2 ; {12440}
    BCC loc_003084        ; {12444}
    COP [16]              ; {12446}
    LDA $0034, X          ; {12448}
    LDY #$1A9E            ; {12451}
    JSL $@chunk_0270E4.code_027348 ; {12454}
    LDY #$1ADE            ; {12458}
    JSL $@chunk_0270E4.code_027348 ; {12461}
    PHX                   ; {12465}
    TAX                   ; {12466}
    LDA $7F0203, X        ; {12467}
    AND #$FFBF            ; {12471}
    STA $7F0203, X        ; {12474}
    PLX                   ; {12478}
    COP [A8] ( #$3800, #7E ) ; {12479}
    LDA $0032, X          ; {12484}
    STA $001C, X          ; {12487}
    LDY $0038, X          ; {12490}
    SEP #$20              ; {12493}
    LDA $&meta_tables_008000+5, Y ; {12495}
    STA $001E, X          ; {12498}
    LDA $&meta_tables_008000+A, Y ; {12501}
    STA $0024, X          ; {12504}
    LDA $&meta_tables_008000+D, Y ; {12507}
    STA $0036, X          ; {12510}
    REP #$20              ; {12513}
    LDA $&meta_tables_008000+6, Y ; {12515}
    ORA #$8000            ; {12518}
    AND #$DFFF            ; {12521}
    STA $0016, X          ; {12524}
    LDA $&meta_tables_008000+8, Y ; {12527}
    STA $0022, X          ; {12530}
    LDA $&meta_tables_008000+B, Y ; {12533}
    STA $0018, X          ; {12536}
    STZ $0030, X          ; {12539}
    STZ $0020, X          ; {12542}
    JSL $@code_0008F3     ; {12545}
    STZ $0014, X          ; {12549}
    STZ $0004, X          ; {12552}
    STZ $0006, X          ; {12555}
    RTL                   ; {12558}
}

code_00310F {
    PHX                   ; {12559}
    LDX $03A0             ; {12560}
    LDA $0000, X          ; {12563}
    SEC                   ; {12566}
    SBC #$0030            ; {12567}
    BPL loc_00311F        ; {12570}
    LDA #$0000            ; {12572}

  loc_00311F:
    STA $16               ; {12575}
    LDA $0000, X          ; {12577}
    CLC                   ; {12580}
    ADC #$0030            ; {12581}
    SEC                   ; {12584}
    SBC $16               ; {12585}
    STA $1A               ; {12587}
    BMI loc_003186        ; {12589}
    LDA $0002, X          ; {12591}
    SEC                   ; {12594}
    SBC #$0030            ; {12595}
    BPL loc_00313B        ; {12598}
    LDA #$0000            ; {12600}

  loc_00313B:
    STA $18               ; {12603}
    LDA $0002, X          ; {12605}
    CLC                   ; {12608}
    ADC #$0030            ; {12609}
    SEC                   ; {12612}
    SBC $18               ; {12613}
    STA $1C               ; {12615}
    BMI loc_003186        ; {12617}
    LDA $06A6             ; {12619}
    BRA loc_003153        ; {12622}

  loc_003150:
    LDA $003E, X          ; {12624}

  loc_003153:
    TAX                   ; {12627}
    BEQ loc_003186        ; {12628}
    LDA $0016, X          ; {12630}
    CMP #$0301            ; {12633}
    BNE loc_003150        ; {12636}
    LDA $0000, X          ; {12638}
    SEC                   ; {12641}
    SBC $16               ; {12642}
    CMP $1A               ; {12644}
    BCS loc_003150        ; {12646}
    LDA $0002, X          ; {12648}
    SEC                   ; {12651}
    SBC $18               ; {12652}
    CMP $1C               ; {12654}
    BCS loc_003150        ; {12656}
    SEP #$20              ; {12658}
    LDA #$^code_0029EC    ; {12660}
    STA $0036, X          ; {12662}
    REP #$20              ; {12665}
    LDA #$&code_0029EC    ; {12667}
    STA $0018, X          ; {12670}
    STZ $0014, X          ; {12673}
    BRA loc_003150        ; {12676}

  loc_003186:
    PLX                   ; {12678}
    RTL                   ; {12679}
}

code_003188 {
    LDA #$FFFF            ; {12680}
    STA $0326             ; {12683}
    COP [1B] ( &code_003194, #$0001 ) ; {12686}
}

code_003194 {
    LDA $1C7B             ; {12692}
    BEQ loc_00319A        ; {12695}
    RTL                   ; {12697}

  loc_00319A:
    BRK #$83              ; {12698}
    LDA $0030, X          ; {12700}
    JSL $@chunk_010000.code_0108BB ; {12703}
    COP [27] ( &code_0031A7 ) ; {12707}
}

code_0031A7 {
    STZ $0326             ; {12711}
    COP [86]              ; {12714}
    RTL                   ; {12716}
}

code_0031AD {
    STZ $03B2             ; {12717}
    INC $0458             ; {12720}
    STX $039A             ; {12723}
    COP [85] ( @code_003188 ) ; {12726}
    LDA #$0000            ; {12731}
    STA $0030, Y          ; {12734}

  loc_0031C1:
    COP [80] ( #00 )      ; {12737}
    COP [82]              ; {12740}

  loc_0031C6:
    LDA $0376             ; {12742}
    CMP #$0070            ; {12745}
    BCS loc_0031D1        ; {12748}
    BRL loc_0032B2        ; {12750}

  loc_0031D1:
    COP [9F] ( #$0010 )   ; {12753}
    COP [9A] ( #$0010, &code_003210, &code_0031DF, &code_003210 ) ; {12757}
}

code_0031DF {
    COP [9F] ( #$FFF0 )   ; {12767}
    COP [80] ( #0E )      ; {12771}
    COP [82]              ; {12774}
    COP [B2] ( &code_003348, #00, #$0008, #$FFE8, #$0200 ) ; {12776}
    COP [B2] ( &code_003359, #00, #$0008, #$FFE8, #$0200 ) ; {12787}
    COP [B2] ( &code_003367, #00, #$0008, #$FFE8, #$0200 ) ; {12798}
    COP [80] ( #16 )      ; {12809}
    COP [82]              ; {12812}
    BRA loc_0031C1        ; {12814}
}

code_003210 {
    COP [9A] ( #$0050, &code_00321A, &code_003290, &code_00321A ) ; {12816}
}

code_00321A {
    COP [9A] ( #$0070, &code_003290, &code_003224, &code_003290 ) ; {12826}
}

code_003224 {
    COP [9A] ( #$0000, &code_00322E, &code_00325F, &code_00325F ) ; {12836}
}

code_00322E {
    COP [9F] ( #$FFF0 )   ; {12846}
    COP [80] ( #0D )      ; {12850}
    COP [82]              ; {12853}
    COP [B2] ( &code_00337F, #00, #$FFFC, #$FFE6, #$0200 ) ; {12855}
    COP [80] ( #17 )      ; {12866}
    COP [82]              ; {12869}
    COP [80] ( #0D )      ; {12871}
    COP [82]              ; {12874}
    COP [B2] ( &code_00337F, #00, #$FFFC, #$FFE6, #$0200 ) ; {12876}
    COP [80] ( #17 )      ; {12887}
    COP [82]              ; {12890}
    BRL loc_0031C6        ; {12892}
}

code_00325F {
    COP [9F] ( #$FFF0 )   ; {12895}
    COP [80] ( #0F )      ; {12899}
    COP [82]              ; {12902}
    COP [B2] ( &code_003394, #00, #$0014, #$FFE6, #$0200 ) ; {12904}
    COP [80] ( #18 )      ; {12915}
    COP [82]              ; {12918}
    COP [80] ( #0F )      ; {12920}
    COP [82]              ; {12923}
    COP [B2] ( &code_003394, #00, #$0014, #$FFE6, #$0200 ) ; {12925}
    COP [80] ( #18 )      ; {12936}
    COP [82]              ; {12939}
    BRL loc_0031C6        ; {12941}
}

code_003290 {
    COP [9A] ( #$0000, &code_00329A, &code_0032A6, &code_0032A6 ) ; {12944}
}

code_00329A {
    COP [9F] ( #$FFF0 )   ; {12954}
    COP [80] ( #07 )      ; {12958}
    COP [82]              ; {12961}
    BRL loc_0031C6        ; {12963}
}

code_0032A6 {
    COP [9F] ( #$FFF0 )   ; {12966}
    COP [80] ( #05 )      ; {12970}
    COP [82]              ; {12973}
    BRL loc_0031C6        ; {12975}

  loc_0032B2:
    COP [9F] ( #$0010 )   ; {12978}
    COP [9A] ( #$0040, &code_003330, &code_0032C0, &code_00333C ) ; {12982}
}

code_0032C0 {
    COP [9A] ( #$0000, &code_0032CA, &code_0032FD, &code_0032FD ) ; {12992}
}

code_0032CA {
    COP [9F] ( #$FFF0 )   ; {13002}
    LDA $0016, X          ; {13006}
    ORA #$0002            ; {13009}
    STA $0016, X          ; {13012}
    COP [85] ( @code_0033B9 ) ; {13015}
    COP [80] ( #09 )      ; {13020}
    COP [82]              ; {13023}
    COP [B2] ( &code_0033A9, #00, #$FFD8, #$FFE8, #$0200 ) ; {13025}
    COP [80] ( #0A )      ; {13036}
    COP [82]              ; {13039}
    LDA $0016, X          ; {13041}
    AND #$FFFD            ; {13044}
    STA $0016, X          ; {13047}
    BRL loc_0031C6        ; {13050}
}

code_0032FD {
    COP [9F] ( #$FFF0 )   ; {13053}
    LDA $0016, X          ; {13057}
    ORA #$0002            ; {13060}
    STA $0016, X          ; {13063}
    COP [85] ( @code_0033B9 ) ; {13066}
    COP [80] ( #0B )      ; {13071}
    COP [82]              ; {13074}
    COP [B2] ( &code_0033B1, #00, #$0028, #$FFE8, #$0200 ) ; {13076}
    COP [80] ( #0C )      ; {13087}
    COP [82]              ; {13090}
    LDA $0016, X          ; {13092}
    AND #$FFFD            ; {13095}
    STA $0016, X          ; {13098}
    BRL loc_0031C6        ; {13101}
}

code_003330 {
    COP [9F] ( #$FFF0 )   ; {13104}
    COP [80] ( #08 )      ; {13108}
    COP [82]              ; {13111}
    BRL loc_0031C6        ; {13113}
}

code_00333C {
    COP [9F] ( #$FFF0 )   ; {13116}
    COP [80] ( #06 )      ; {13120}
    COP [82]              ; {13123}
    BRL loc_0031C6        ; {13125}
}

code_003348 {
    COP [A3]              ; {13128}
    COP [A2] ( #30 )      ; {13130}
    COP [80] ( #10 )      ; {13133}
    COP [82]              ; {13136}
    COP [80] ( #1B )      ; {13138}
    COP [82]              ; {13141}
    BRA loc_003376        ; {13143}
}

code_003359 {
    COP [A3]              ; {13145}
    COP [A2] ( #30 )      ; {13147}
    BRK #$61              ; {13150}
    COP [80] ( #10 )      ; {13152}
    COP [82]              ; {13155}
    BRA loc_003376        ; {13157}
}

code_003367 {
    COP [A3]              ; {13159}
    COP [A2] ( #30 )      ; {13161}
    COP [80] ( #10 )      ; {13164}
    COP [82]              ; {13167}
    COP [80] ( #1C )      ; {13169}
    COP [82]              ; {13172}

  loc_003376:
    COP [81] ( #13, #0C ) ; {13174}
    COP [83]              ; {13178}
    COP [86]              ; {13180}
    RTL                   ; {13182}
}

code_00337F {
    COP [A3]              ; {13183}
    COP [A2] ( #30 )      ; {13185}
    BRK #$61              ; {13188}
    COP [80] ( #11 )      ; {13190}
    COP [82]              ; {13193}
    COP [81] ( #14, #0C ) ; {13195}
    COP [83]              ; {13199}
    COP [86]              ; {13201}
    RTL                   ; {13203}
}

code_003394 {
    COP [A3]              ; {13204}
    COP [A2] ( #30 )      ; {13206}
    BRK #$61              ; {13209}
    COP [80] ( #12 )      ; {13211}
    COP [82]              ; {13214}
    COP [81] ( #15, #0C ) ; {13216}
    COP [83]              ; {13220}
    COP [86]              ; {13222}
    RTL                   ; {13224}
}

code_0033A9 {
    COP [80] ( #19 )      ; {13225}
    COP [82]              ; {13228}
    COP [86]              ; {13230}
    RTL                   ; {13232}
}

code_0033B1 {
    COP [80] ( #1A )      ; {13233}
    COP [82]              ; {13236}
    COP [86]              ; {13238}
    RTL                   ; {13240}
}

code_0033B9 {
    COP [A8] ( #$8000, #0D ) ; {13241}
    COP [92] ( #4E )      ; {13246}
    COP [94]              ; {13249}
    COP [86]              ; {13251}
    RTL                   ; {13253}
}

code_0033C6 {
    STZ $03B2             ; {13254}
    INC $0458             ; {13257}
    LDA $0016, X          ; {13260}
    ORA #$0200            ; {13263}
    STA $0016, X          ; {13266}
    COP [85] ( @code_003188 ) ; {13269}
    LDA #$0001            ; {13274}
    STA $0030, Y          ; {13277}
    COP [A5] ( &code_0033EA, &code_003732, &code_003A3D, &code_003A3D ) ; {13280}
}

code_0033EA {
    COP [80] ( #21 )      ; {13290}
    COP [82]              ; {13293}
    COP [91]              ; {13295}
    TXA                   ; {13297}
    CLC                   ; {13298}
    ADC #$0080            ; {13299}
    CMP $039A             ; {13302}
    BEQ loc_0033FC        ; {13305}
    RTL                   ; {13307}

  loc_0033FC:
    COP [91]              ; {13308}
    LDY $039A             ; {13310}
    LDA $0016, Y          ; {13313}
    BIT #$0400            ; {13316}
    BNE loc_00340A        ; {13319}
    RTL                   ; {13321}

  loc_00340A:
    COP [1B] ( &code_003410, #$0008 ) ; {13322}
}

code_003410 {
    STX $039A             ; {13328}
    COP [91]              ; {13331}
    COP [0C] ( #00, #04, &code_00341C ) ; {13333}
    RTL                   ; {13339}
}

code_00341C {
    COP [85] ( @code_003E1C ) ; {13340}
    COP [09] ( #$1905 )   ; {13345}
    SEP #$20              ; {13349}
    STZ $1A5E             ; {13351}
    REP #$20              ; {13354}
    LDA $0016, X          ; {13356}
    AND #$FCFF            ; {13359}
    STA $0016, X          ; {13362}
    STZ $042D             ; {13365}
    COP [1B] ( &code_00347F, #$003C ) ; {13368}

  loc_00343E:
    COP [9B] ( #$0060, &code_003448, &code_003448, &code_0035F4 ) ; {13374}
}

code_003448 {
    COP [9A] ( #$0020, &code_0035EA, &code_0034C0, &code_003501 ) ; {13384}

  loc_003452:
    COP [07] ( #$9905, &code_00346B ) ; {13394}
    COP [24] ( &code_00346B ) ; {13400}
    COP [09] ( #$9905 )   ; {13404}
    COP [85] ( @code_003661 ) ; {13408}
    COP [1B] ( &code_00346B, #$0028 ) ; {13413}
}

code_00346B {
    COP [9A] ( #$0060, &code_003621, &code_003475, &code_003475 ) ; {13419}
}

code_003475 {
    COP [9B] ( #$0010, &code_00350B, &code_003515, &code_003553 ) ; {13429}
}

code_00347F {
    COP [9B] ( #$0060, &code_003603, &code_003489, &code_003489 ) ; {13439}
}

code_003489 {
    COP [9A] ( #$0020, &code_0035B2, &code_003567, &code_00355D ) ; {13449}

  loc_003493:
    COP [07] ( #$9905, &code_0034AC ) ; {13459}
    COP [23] ( &code_0034AC ) ; {13465}
    COP [09] ( #$9905 )   ; {13469}
    COP [85] ( @code_0036BF ) ; {13473}
    COP [1B] ( &code_0034AC, #$0028 ) ; {13478}
}

code_0034AC {
    COP [9A] ( #$0060, &code_0034B6, &code_0034B6, &code_003612 ) ; {13484}
}

code_0034B6 {
    COP [9B] ( #$0010, &code_0035E0, &code_0035BC, &code_0035A8 ) ; {13494}
}

code_0034C0 {
    COP [97]              ; {13504}
    COP [80] ( #2C )      ; {13506}
    COP [82]              ; {13509}

  loc_0034C7:
    COP [9B] ( #$0000, &code_0034D1, &code_0034DA, &code_0034DA ) ; {13511}
}

code_0034D1 {
    COP [9D] ( #1D )      ; {13521}
    COP [9E] ( &code_0034E4 ) ; {13524}

  loc_0034D8:
    BRA loc_0034C7        ; {13528}
}

code_0034DA {
    COP [9D] ( #2D )      ; {13530}
    COP [9E] ( &code_0034E4 ) ; {13533}

  loc_0034E1:
    BRL loc_00343E        ; {13537}
}

code_0034E4 {
    COP [9A] ( #$0000, &code_0034EE, &code_0034EE, &code_0034F8 ) ; {13540}
}

code_0034EE {
    COP [97]              ; {13550}
    COP [80] ( #0B )      ; {13552}
    COP [82]              ; {13555}
    BRL code_0035BC       ; {13557}
}

code_0034F8 {
    COP [96]              ; {13560}
    COP [80] ( #0B )      ; {13562}
    COP [82]              ; {13565}
    BRA code_003515       ; {13567}
}

code_003501 {
    COP [96]              ; {13569}
    COP [80] ( #0B )      ; {13571}
    COP [82]              ; {13574}
    BRL code_003515       ; {13576}
}

code_00350B {
    COP [96]              ; {13579}
    COP [80] ( #09 )      ; {13581}
    COP [82]              ; {13584}
    BRL code_0034C0       ; {13586}
}

code_003515 {
    COP [96]              ; {13589}
    COP [80] ( #2A )      ; {13591}
    COP [82]              ; {13594}

  loc_00351C:
    COP [9A] ( #$0000, &code_003530, &code_003530, &code_003526 ) ; {13596}
}

code_003526 {
    COP [9D] ( #1C )      ; {13606}
    COP [9E] ( &code_00353A ) ; {13609}

  loc_00352D:
    BRL loc_00351C        ; {13613}
}

code_003530 {
    COP [9D] ( #2B )      ; {13616}
    COP [9E] ( &code_00353A ) ; {13619}

  loc_003537:
    BRL loc_003452        ; {13623}
}

code_00353A {
    COP [9B] ( #$0000, &code_003544, &code_003544, &code_00354C ) ; {13626}
}

code_003544 {
    COP [80] ( #09 )      ; {13636}
    COP [82]              ; {13639}
    BRL code_0034C0       ; {13641}
}

code_00354C {
    COP [80] ( #0A )      ; {13644}
    COP [82]              ; {13647}
    BRA code_003567       ; {13649}
}

code_003553 {
    COP [96]              ; {13651}
    COP [80] ( #0A )      ; {13653}
    COP [82]              ; {13656}
    BRL code_003567       ; {13658}
}

code_00355D {
    COP [96]              ; {13661}
    COP [80] ( #08 )      ; {13663}
    COP [82]              ; {13666}
    BRL code_003515       ; {13668}
}

code_003567 {
    COP [97]              ; {13671}
    COP [80] ( #2E )      ; {13673}
    COP [82]              ; {13676}

  loc_00356E:
    COP [9B] ( #$0000, &code_003581, &code_003581, &code_003578 ) ; {13678}
}

code_003578 {
    COP [9D] ( #1E )      ; {13688}
    COP [9E] ( &code_00358B ) ; {13691}

  loc_00357F:
    BRA loc_00356E        ; {13695}
}

code_003581 {
    COP [9D] ( #2F )      ; {13697}
    COP [9E] ( &code_00358B ) ; {13700}

  loc_003588:
    BRL code_00347F       ; {13704}
}

code_00358B {
    COP [9A] ( #$0000, &code_003595, &code_003595, &code_00359E ) ; {13707}
}

code_003595 {
    COP [97]              ; {13717}
    COP [80] ( #08 )      ; {13719}
    COP [82]              ; {13722}
    BRA code_0035BC       ; {13724}
}

code_00359E {
    COP [96]              ; {13726}
    COP [80] ( #08 )      ; {13728}
    COP [82]              ; {13731}
    BRL code_003515       ; {13733}
}

code_0035A8 {
    COP [97]              ; {13736}
    COP [80] ( #0A )      ; {13738}
    COP [82]              ; {13741}
    BRL code_003567       ; {13743}
}

code_0035B2 {
    COP [97]              ; {13746}
    COP [80] ( #08 )      ; {13748}
    COP [82]              ; {13751}
    BRL code_0035BC       ; {13753}
}

code_0035BC {
    COP [97]              ; {13756}
    COP [80] ( #2A )      ; {13758}
    COP [82]              ; {13761}

  loc_0035C3:
    COP [9A] ( #$0000, &code_0035CD, &code_0035D6, &code_0035D6 ) ; {13763}
}

code_0035CD {
    COP [9D] ( #1C )      ; {13773}
    COP [9E] ( &code_00353A ) ; {13776}

  loc_0035D4:
    BRA loc_0035C3        ; {13780}
}

code_0035D6 {
    COP [9D] ( #2B )      ; {13782}
    COP [9E] ( &code_00353A ) ; {13785}

  loc_0035DD:
    BRL loc_003493        ; {13789}
}

code_0035E0 {
    COP [97]              ; {13792}
    COP [80] ( #09 )      ; {13794}
    COP [82]              ; {13797}
    BRL code_0034C0       ; {13799}
}

code_0035EA {
    COP [97]              ; {13802}
    COP [80] ( #0B )      ; {13804}
    COP [82]              ; {13807}
    BRL code_0035BC       ; {13809}
}

code_0035F4 {
    COP [97]              ; {13812}
    COP [80] ( #0B )      ; {13814}
    COP [82]              ; {13817}
    COP [80] ( #0A )      ; {13819}
    COP [82]              ; {13822}
    BRL code_003567       ; {13824}
}

code_003603 {
    COP [97]              ; {13827}
    COP [80] ( #08 )      ; {13829}
    COP [82]              ; {13832}
    COP [80] ( #09 )      ; {13834}
    COP [82]              ; {13837}
    BRL code_0034C0       ; {13839}
}

code_003612 {
    COP [80] ( #09 )      ; {13842}
    COP [82]              ; {13845}
    COP [96]              ; {13847}
    COP [80] ( #0B )      ; {13849}
    COP [82]              ; {13852}
    BRL code_003515       ; {13854}
}

code_003621 {
    COP [80] ( #09 )      ; {13857}
    COP [82]              ; {13860}
    COP [97]              ; {13862}
    COP [80] ( #0B )      ; {13864}
    COP [82]              ; {13867}
    BRL code_0035BC       ; {13869}

  code_003630:
    JSR $&code_00372B     ; {13872}
    COP [A0] ( #$FFF0 )   ; {13875}
    COP [80] ( #27 )      ; {13879}
    COP [82]              ; {13882}
    LDA $1A5E             ; {13884}
    AND #$00FF            ; {13887}
    CMP #$0004            ; {13890}
    BCC loc_00364A        ; {13893}
    BRL code_0036FF       ; {13895}

  loc_00364A:
    COP [9C] ( &code_003650, &code_0036FF ) ; {13898}
}

code_003650 {
    SEP #$20              ; {13904}
    INC $1A5E             ; {13906}
    REP #$20              ; {13909}
    COP [9A] ( #$0000, &code_003720, &code_003720, &code_00370A ) ; {13911}
}

code_003661 {
    JSR $&code_00372B     ; {13921}
    COP [9F] ( #$0020 )   ; {13924}
    BRK #$5D              ; {13928}
    COP [80] ( #29 )      ; {13930}
    COP [82]              ; {13933}
    BRA loc_003678        ; {13935}

  code_003671:
    JSR $&code_00372B     ; {13937}
    COP [9F] ( #$0010 )   ; {13940}

  loc_003678:
    COP [80] ( #27 )      ; {13944}
    COP [82]              ; {13947}
    LDA $1A5E             ; {13949}
    AND #$00FF            ; {13952}
    CMP #$0004            ; {13955}
    BCC loc_00368B        ; {13958}
    BRL code_00370A       ; {13960}

  loc_00368B:
    COP [9C] ( &code_00370A, &code_003691 ) ; {13963}
}

code_003691 {
    SEP #$20              ; {13969}
    INC $1A5E             ; {13971}
    REP #$20              ; {13974}
    COP [9B] ( #$0000, &code_0036FF, &code_0036FF, &code_003715 ) ; {13976}

  code_0036A2:
    JSR $&code_00372B     ; {13986}
    COP [A0] ( #$0010 )   ; {13989}
    COP [80] ( #27 )      ; {13993}
    COP [82]              ; {13996}
    LDA $1A5E             ; {13998}
    AND #$00FF            ; {14001}
    CMP #$0004            ; {14004}
    BCS code_003715       ; {14007}
    COP [9C] ( &code_003650, &code_003715 ) ; {14009}
}

code_0036BF {
    JSR $&code_00372B     ; {14015}
    COP [9F] ( #$FFF0 )   ; {14018}
    BRK #$5D              ; {14022}
    COP [80] ( #29 )      ; {14024}
    COP [82]              ; {14027}
    BRA loc_0036D6        ; {14029}

  code_0036CF:
    JSR $&code_00372B     ; {14031}
    COP [9F] ( #$FFF0 )   ; {14034}

  loc_0036D6:
    COP [80] ( #27 )      ; {14038}
    COP [82]              ; {14041}
    LDA $1A5E             ; {14043}
    AND #$00FF            ; {14046}
    CMP #$0004            ; {14049}
    BCS code_003720       ; {14052}
    COP [9C] ( &code_003720, &code_003691 ) ; {14054}

  code_0036EC:
    COP [09] ( #$1905 )   ; {14060}
    SEP #$20              ; {14064}
    STZ $1A5E             ; {14066}
    REP #$20              ; {14069}

  loc_0036F7:
    COP [80] ( #28 )      ; {14071}
    COP [82]              ; {14074}
    COP [86]              ; {14076}
    RTL                   ; {14078}
}

code_0036FF {
    COP [21] ( &code_0036EC ) ; {14079}
    COP [85] ( @code_003630 ) ; {14083}
    BRA loc_0036F7        ; {14088}
}

code_00370A {
    COP [24] ( &code_0036EC ) ; {14090}
    COP [85] ( @code_003671 ) ; {14094}
    BRA loc_0036F7        ; {14099}
}

code_003715 {
    COP [22] ( &code_0036EC ) ; {14101}
    COP [85] ( @code_0036A2 ) ; {14105}
    BRA loc_0036F7        ; {14110}
}

code_003720 {
    COP [23] ( &code_0036EC ) ; {14112}
    COP [85] ( @code_0036CF ) ; {14116}
    BRA loc_0036F7        ; {14121}
}

code_00372B {
    LDA #$0200            ; {14123}
    STA $0016, X          ; {14126}
    RTS                   ; {14129}
}

code_003732 {
    STX $039A             ; {14130}
    COP [80] ( #19 )      ; {14133}
    COP [82]              ; {14136}
    COP [91]              ; {14138}
    COP [0C] ( #00, #04, &code_003743 ) ; {14140}
    RTL                   ; {14146}
}

code_003743 {
    COP [85] ( @code_003E29 ) ; {14147}
    LDA $0016, X          ; {14152}
    AND #$FCFF            ; {14155}
    STA $0016, X          ; {14158}
    STZ $042D             ; {14161}
    COP [1B] ( &code_0037A3, #$003C ) ; {14164}

  loc_00375A:
    COP [0C] ( #00, #04, &code_003774 ) ; {14170}
    COP [9B] ( #$0060, &code_00376A, &code_00376A, &code_003972 ) ; {14176}
}

code_00376A {
    COP [9A] ( #$0020, &code_003968, &code_003836, &code_003879 ) ; {14186}
}

code_003774 {
    COP [97]              ; {14196}
    COP [80] ( #06 )      ; {14198}
    COP [82]              ; {14201}
    COP [80] ( #07 )      ; {14203}
    COP [82]              ; {14206}
    BRA code_0037D7       ; {14208}

  loc_003782:
    COP [0C] ( #00, #04, &code_00379C ) ; {14210}
    COP [9A] ( #$0060, &code_00399F, &code_003792, &code_003792 ) ; {14216}
}

code_003792 {
    COP [9B] ( #$0020, &code_003883, &code_00388D, &code_0038CD ) ; {14226}
}

code_00379C {
    COP [80] ( #07 )      ; {14236}
    COP [82]              ; {14239}
    BRA code_0037D7       ; {14241}
}

code_0037A3 {
    COP [0C] ( #00, #04, &code_0037D7 ) ; {14243}

  code_0037A9:
    COP [9B] ( #$0060, &code_003981, &code_0037B3, &code_0037B3 ) ; {14249}
}

code_0037B3 {
    COP [9A] ( #$0020, &code_00392E, &code_0038E1, &code_0038D7 ) ; {14259}

  loc_0037BD:
    COP [0C] ( #00, #04, &code_00379C ) ; {14269}
    COP [9A] ( #$0060, &code_0037CD, &code_0037CD, &code_003990 ) ; {14275}
}

code_0037CD {
    COP [9B] ( #$0020, &code_00395E, &code_003938, &code_003924 ) ; {14285}
}

code_0037D7 {
    COP [81] ( #19, #02 ) ; {14295}
    COP [83]              ; {14299}
    COP [85] ( @code_0039AE ) ; {14301}
    COP [85] ( @code_0039BD ) ; {14306}
    COP [80] ( #19 )      ; {14311}
    COP [82]              ; {14314}
    COP [97]              ; {14316}
    COP [80] ( #04 )      ; {14318}
    COP [82]              ; {14321}
    COP [85] ( @code_0039CA ) ; {14323}
    COP [85] ( @code_0039D9 ) ; {14328}
    COP [80] ( #1A )      ; {14333}
    COP [82]              ; {14336}
    COP [80] ( #05 )      ; {14338}
    COP [82]              ; {14341}
    COP [85] ( @code_0039E6 ) ; {14343}
    COP [85] ( @code_0039F5 ) ; {14348}
    COP [80] ( #1B )      ; {14353}
    COP [82]              ; {14356}
    COP [96]              ; {14358}
    COP [80] ( #06 )      ; {14360}
    COP [82]              ; {14363}
    COP [85] ( @code_003A04 ) ; {14365}
    COP [85] ( @code_003A15 ) ; {14370}
    COP [81] ( #1A, #05 ) ; {14375}
    COP [83]              ; {14379}
    COP [80] ( #07 )      ; {14381}
    COP [82]              ; {14384}
    COP [27] ( &code_0037A9 ) ; {14386}
}

code_003836 {
    COP [97]              ; {14390}
    COP [80] ( #32 )      ; {14392}
    COP [82]              ; {14395}

  loc_00383D:
    COP [9B] ( #$0000, &code_003847, &code_003850, &code_003850 ) ; {14397}
}

code_003847 {
    COP [9D] ( #18 )      ; {14407}
    COP [9E] ( &code_00385C ) ; {14410}

  loc_00384E:
    BRA loc_00383D        ; {14414}
}

code_003850 {
    COP [21] ( &code_00385C ) ; {14416}
    COP [80] ( #33 )      ; {14420}
    COP [82]              ; {14423}
    BRL loc_00375A        ; {14425}
}

code_00385C {
    COP [9A] ( #$0000, &code_003866, &code_003866, &code_003870 ) ; {14428}
}

code_003866 {
    COP [97]              ; {14438}
    COP [80] ( #06 )      ; {14440}
    COP [82]              ; {14443}
    BRL code_003938       ; {14445}
}

code_003870 {
    COP [96]              ; {14448}
    COP [80] ( #06 )      ; {14450}
    COP [82]              ; {14453}
    BRA code_00388D       ; {14455}
}

code_003879 {
    COP [96]              ; {14457}
    COP [80] ( #06 )      ; {14459}
    COP [82]              ; {14462}
    BRL code_00388D       ; {14464}
}

code_003883 {
    COP [96]              ; {14467}
    COP [80] ( #05 )      ; {14469}
    COP [82]              ; {14472}
    BRL code_003836       ; {14474}
}

code_00388D {
    COP [96]              ; {14477}
    COP [80] ( #30 )      ; {14479}
    COP [82]              ; {14482}

  loc_003894:
    COP [9A] ( #$0000, &code_0038A8, &code_0038A8, &code_00389E ) ; {14484}
}

code_00389E {
    COP [9D] ( #17 )      ; {14494}
    COP [9E] ( &code_0038B4 ) ; {14497}

  loc_0038A5:
    BRL loc_003894        ; {14501}
}

code_0038A8 {
    COP [24] ( &code_0038B4 ) ; {14504}
    COP [80] ( #31 )      ; {14508}
    COP [82]              ; {14511}
    BRL loc_003782        ; {14513}
}

code_0038B4 {
    COP [9B] ( #$0000, &code_0038BE, &code_0038BE, &code_0038C6 ) ; {14516}
}

code_0038BE {
    COP [80] ( #05 )      ; {14526}
    COP [82]              ; {14529}
    BRL code_003836       ; {14531}
}

code_0038C6 {
    COP [80] ( #07 )      ; {14534}
    COP [82]              ; {14537}
    BRA code_0038E1       ; {14539}
}

code_0038CD {
    COP [96]              ; {14541}
    COP [80] ( #07 )      ; {14543}
    COP [82]              ; {14546}
    BRL code_0038E1       ; {14548}
}

code_0038D7 {
    COP [96]              ; {14551}
    COP [80] ( #04 )      ; {14553}
    COP [82]              ; {14556}
    BRL code_00388D       ; {14558}
}

code_0038E1 {
    COP [97]              ; {14561}
    COP [80] ( #34 )      ; {14563}
    COP [82]              ; {14566}

  loc_0038E8:
    COP [9B] ( #$0000, &code_0038FB, &code_0038FB, &code_0038F2 ) ; {14568}
}

code_0038F2 {
    COP [9D] ( #16 )      ; {14578}
    COP [9E] ( &code_003907 ) ; {14581}

  loc_0038F9:
    BRA loc_0038E8        ; {14585}
}

code_0038FB {
    COP [22] ( &code_003907 ) ; {14587}
    COP [80] ( #35 )      ; {14591}
    COP [82]              ; {14594}
    BRL code_0037A3       ; {14596}
}

code_003907 {
    COP [9A] ( #$0000, &code_003911, &code_003911, &code_00391A ) ; {14599}
}

code_003911 {
    COP [97]              ; {14609}
    COP [80] ( #04 )      ; {14611}
    COP [82]              ; {14614}
    BRA code_003938       ; {14616}
}

code_00391A {
    COP [96]              ; {14618}
    COP [80] ( #04 )      ; {14620}
    COP [82]              ; {14623}
    BRL code_00388D       ; {14625}
}

code_003924 {
    COP [97]              ; {14628}
    COP [80] ( #07 )      ; {14630}
    COP [82]              ; {14633}
    BRL code_0038E1       ; {14635}
}

code_00392E {
    COP [97]              ; {14638}
    COP [80] ( #04 )      ; {14640}
    COP [82]              ; {14643}
    BRL code_003938       ; {14645}
}

code_003938 {
    COP [97]              ; {14648}
    COP [80] ( #30 )      ; {14650}
    COP [82]              ; {14653}

  loc_00393F:
    COP [9A] ( #$0000, &code_003949, &code_003952, &code_003952 ) ; {14655}
}

code_003949 {
    COP [9D] ( #17 )      ; {14665}
    COP [9E] ( &code_0038B4 ) ; {14668}

  loc_003950:
    BRA loc_00393F        ; {14672}
}

code_003952 {
    COP [23] ( &code_0038B4 ) ; {14674}
    COP [80] ( #31 )      ; {14678}
    COP [82]              ; {14681}
    BRL loc_0037BD        ; {14683}
}

code_00395E {
    COP [97]              ; {14686}
    COP [80] ( #05 )      ; {14688}
    COP [82]              ; {14691}
    BRL code_003836       ; {14693}
}

code_003968 {
    COP [97]              ; {14696}
    COP [80] ( #06 )      ; {14698}
    COP [82]              ; {14701}
    BRL code_003938       ; {14703}
}

code_003972 {
    COP [97]              ; {14706}
    COP [80] ( #06 )      ; {14708}
    COP [82]              ; {14711}
    COP [80] ( #07 )      ; {14713}
    COP [82]              ; {14716}
    BRL code_0038E1       ; {14718}
}

code_003981 {
    COP [97]              ; {14721}
    COP [80] ( #04 )      ; {14723}
    COP [82]              ; {14726}
    COP [80] ( #05 )      ; {14728}
    COP [82]              ; {14731}
    BRL code_003836       ; {14733}
}

code_003990 {
    COP [80] ( #05 )      ; {14736}
    COP [82]              ; {14739}
    COP [96]              ; {14741}
    COP [80] ( #06 )      ; {14743}
    COP [82]              ; {14746}
    BRL code_00388D       ; {14748}
}

code_00399F {
    COP [80] ( #05 )      ; {14751}
    COP [82]              ; {14754}
    COP [97]              ; {14756}
    COP [80] ( #06 )      ; {14758}
    COP [82]              ; {14761}
    BRL code_003938       ; {14763}
}

code_0039AE {
    BRK #$5A              ; {14766}
    COP [A3]              ; {14768}
    COP [A1] ( #$0008, #$0048 ) ; {14770}
    LDA #$0000            ; {14776}
    BRA loc_003A24        ; {14779}
}

code_0039BD {
    COP [A3]              ; {14781}
    COP [A1] ( #$FFE8, #$0048 ) ; {14783}
    LDA #$0003            ; {14789}
    BRA loc_003A24        ; {14792}
}

code_0039CA {
    BRK #$5A              ; {14794}
    COP [A3]              ; {14796}
    COP [A1] ( #$FFC0, #$FFF8 ) ; {14798}
    LDA #$0002            ; {14804}
    BRA loc_003A24        ; {14807}
}

code_0039D9 {
    COP [A3]              ; {14809}
    COP [A1] ( #$FFC8, #$0018 ) ; {14811}
    LDA #$0001            ; {14817}
    BRA loc_003A24        ; {14820}
}

code_0039E6 {
    BRK #$5A              ; {14822}
    COP [A1] ( #$0008, #$FFE8 ) ; {14824}
    COP [88]              ; {14830}
    LDA #$0000            ; {14832}
    BRA loc_003A24        ; {14835}
}

code_0039F5 {
    COP [A3]              ; {14837}
    COP [A1] ( #$FFE8, #$FFB0 ) ; {14839}
    COP [88]              ; {14845}
    LDA #$0003            ; {14847}
    BRA loc_003A24        ; {14850}
}

code_003A04 {
    BRK #$5A              ; {14852}
    COP [A3]              ; {14854}
    COP [A1] ( #$0020, #$FFF8 ) ; {14856}
    COP [96]              ; {14862}
    LDA #$0002            ; {14864}
    BRA loc_003A24        ; {14867}
}

code_003A15 {
    COP [A3]              ; {14869}
    COP [A1] ( #$0050, #$0018 ) ; {14871}
    COP [96]              ; {14877}
    LDA #$0001            ; {14879}
    BRA loc_003A24        ; {14882}

  loc_003A24:
    STA $001E, X          ; {14884}
    STZ $0020, X          ; {14887}
    LDA #$0200            ; {14890}
    STA $0016, X          ; {14893}
    LDA #$0004            ; {14896}
    STA $002A, X          ; {14899}
    COP [91]              ; {14902}
    COP [83]              ; {14904}
    COP [86]              ; {14906}
    RTL                   ; {14908}
}

code_003A3D {
    COP [80] ( #13 )      ; {14909}
    COP [82]              ; {14912}
    COP [91]              ; {14914}
    LDY $039A             ; {14916}
    LDA $0016, Y          ; {14919}
    BIT #$0400            ; {14922}
    BNE loc_003A50        ; {14925}
    RTL                   ; {14927}

  loc_003A50:
    COP [1B] ( &code_003A56, #$0008 ) ; {14928}
}

code_003A56 {
    STX $039A             ; {14934}
    COP [91]              ; {14937}
    COP [0C] ( #00, #04, &code_003A62 ) ; {14939}
    RTL                   ; {14945}
}

code_003A62 {
    COP [85] ( @code_003E36 ) ; {14946}
    LDA $0016, X          ; {14951}
    AND #$FCFF            ; {14954}
    STA $0016, X          ; {14957}
    STZ $042D             ; {14960}
    COP [1B] ( &code_003B0B, #$003C ) ; {14963}

  loc_003A79:
    COP [0C] ( #00, #04, &code_003A93 ) ; {14969}

  code_003A7F:
    COP [9B] ( #$0060, &code_003A89, &code_003A89, &code_003CD1 ) ; {14975}
}

code_003A89 {
    COP [9A] ( #$0010, &code_003CC7, &code_003B9D, &code_003BDE ) ; {14985}
}

code_003A93 {
    COP [21] ( &code_003A7F ) ; {14995}
    COP [AE] ( #$0000, #$FFC0, &code_003A7F ) ; {14999}
    COP [AE] ( #$0000, #$FFB0, &code_003A7F ) ; {15007}
    COP [AE] ( #$0010, #$FFC0, &code_003A7F ) ; {15015}
    COP [AE] ( #$0010, #$FFB0, &code_003A7F ) ; {15023}
    COP [85] ( @code_003D3C ) ; {15031}
    COP [1B] ( &code_003A7F, #$001E ) ; {15036}

  loc_003AC2:
    COP [0C] ( #00, #04, &code_003ADC ) ; {15042}

  code_003AC8:
    COP [9A] ( #$0060, &code_003CFE, &code_003AD2, &code_003AD2 ) ; {15048}
}

code_003AD2 {
    COP [9B] ( #$0010, &code_003BE8, &code_003BF2, &code_003C30 ) ; {15058}
}

code_003ADC {
    COP [24] ( &code_003AC8 ) ; {15068}
    COP [AE] ( #$0050, #$0000, &code_003AC8 ) ; {15072}
    COP [AE] ( #$0050, #$FFF0, &code_003AC8 ) ; {15080}
    COP [AE] ( #$0060, #$0000, &code_003AC8 ) ; {15088}
    COP [AE] ( #$0060, #$FFF0, &code_003AC8 ) ; {15096}
    COP [85] ( @code_003DA1 ) ; {15104}
    COP [1B] ( &code_003AC8, #$001E ) ; {15109}
}

code_003B0B {
    COP [0C] ( #00, #04, &code_003B25 ) ; {15115}

  code_003B11:
    COP [9B] ( #$0060, &code_003CE0, &code_003B1B, &code_003B1B ) ; {15121}
}

code_003B1B {
    COP [9A] ( #$0010, &code_003C8F, &code_003C44, &code_003C3A ) ; {15131}
}

code_003B25 {
    COP [22] ( &code_003B11 ) ; {15141}
    COP [AE] ( #$0000, #$0030, &code_003B11 ) ; {15145}
    COP [AE] ( #$0000, #$0040, &code_003B11 ) ; {15153}
    COP [AE] ( #$0010, #$0030, &code_003B11 ) ; {15161}
    COP [AE] ( #$0010, #$0040, &code_003B11 ) ; {15169}
    COP [85] ( @code_003D0D ) ; {15177}
    COP [1B] ( &code_003B11, #$001E ) ; {15182}

  loc_003B54:
    COP [0C] ( #00, #04, &code_003B6E ) ; {15188}

  code_003B5A:
    COP [9A] ( #$0060, &code_003B64, &code_003B64, &code_003CEF ) ; {15194}
}

code_003B64 {
    COP [9B] ( #$0010, &code_003CBD, &code_003C99, &code_003C85 ) ; {15204}
}

code_003B6E {
    COP [23] ( &code_003B5A ) ; {15214}
    COP [AE] ( #$FFC0, #$0000, &code_003B5A ) ; {15218}
    COP [AE] ( #$FFC0, #$FFF0, &code_003B5A ) ; {15226}
    COP [AE] ( #$FFB0, #$0000, &code_003B5A ) ; {15234}
    COP [AE] ( #$FFB0, #$FFF0, &code_003B5A ) ; {15242}
    COP [85] ( @code_003D6F ) ; {15250}
    COP [1B] ( &code_003B5A, #$001E ) ; {15255}
}

code_003B9D {
    COP [97]              ; {15261}
    COP [80] ( #38 )      ; {15263}
    COP [82]              ; {15266}

  loc_003BA4:
    COP [9B] ( #$0000, &code_003BAE, &code_003BB7, &code_003BB7 ) ; {15268}
}

code_003BAE {
    COP [9D] ( #11 )      ; {15278}
    COP [9E] ( &code_003BC1 ) ; {15281}

  loc_003BB5:
    BRA loc_003BA4        ; {15285}
}

code_003BB7 {
    COP [9D] ( #39 )      ; {15287}
    COP [9E] ( &code_003BC1 ) ; {15290}

  loc_003BBE:
    BRL loc_003A79        ; {15294}
}

code_003BC1 {
    COP [9A] ( #$0000, &code_003BCB, &code_003BCB, &code_003BD5 ) ; {15297}
}

code_003BCB {
    COP [97]              ; {15307}
    COP [80] ( #0F )      ; {15309}
    COP [82]              ; {15312}
    BRL code_003C99       ; {15314}
}

code_003BD5 {
    COP [96]              ; {15317}
    COP [80] ( #0F )      ; {15319}
    COP [82]              ; {15322}
    BRA code_003BF2       ; {15324}
}

code_003BDE {
    COP [96]              ; {15326}
    COP [80] ( #0F )      ; {15328}
    COP [82]              ; {15331}
    BRL code_003BF2       ; {15333}
}

code_003BE8 {
    COP [96]              ; {15336}
    COP [80] ( #0D )      ; {15338}
    COP [82]              ; {15341}
    BRL code_003B9D       ; {15343}
}

code_003BF2 {
    COP [96]              ; {15346}
    COP [80] ( #36 )      ; {15348}
    COP [82]              ; {15351}

  loc_003BF9:
    COP [9A] ( #$0000, &code_003C0D, &code_003C0D, &code_003C03 ) ; {15353}
}

code_003C03 {
    COP [9D] ( #12 )      ; {15363}
    COP [9E] ( &code_003C17 ) ; {15366}

  loc_003C0A:
    BRL loc_003BF9        ; {15370}
}

code_003C0D {
    COP [9D] ( #37 )      ; {15373}
    COP [9E] ( &code_003C17 ) ; {15376}

  loc_003C14:
    BRL loc_003AC2        ; {15380}
}

code_003C17 {
    COP [9B] ( #$0000, &code_003C21, &code_003C21, &code_003C29 ) ; {15383}
}

code_003C21 {
    COP [80] ( #0D )      ; {15393}
    COP [82]              ; {15396}
    BRL code_003B9D       ; {15398}
}

code_003C29 {
    COP [80] ( #0E )      ; {15401}
    COP [82]              ; {15404}
    BRA code_003C44       ; {15406}
}

code_003C30 {
    COP [96]              ; {15408}
    COP [80] ( #0E )      ; {15410}
    COP [82]              ; {15413}
    BRL code_003C44       ; {15415}
}

code_003C3A {
    COP [96]              ; {15418}
    COP [80] ( #0C )      ; {15420}
    COP [82]              ; {15423}
    BRL code_003BF2       ; {15425}
}

code_003C44 {
    COP [97]              ; {15428}
    COP [80] ( #3A )      ; {15430}
    COP [82]              ; {15433}

  loc_003C4B:
    COP [9B] ( #$0000, &code_003C5E, &code_003C5E, &code_003C55 ) ; {15435}
}

code_003C55 {
    COP [9D] ( #10 )      ; {15445}
    COP [9E] ( &code_003C68 ) ; {15448}

  loc_003C5C:
    BRA loc_003C4B        ; {15452}
}

code_003C5E {
    COP [9D] ( #3B )      ; {15454}
    COP [9E] ( &code_003C68 ) ; {15457}

  loc_003C65:
    BRL code_003B0B       ; {15461}
}

code_003C68 {
    COP [9A] ( #$0000, &code_003C72, &code_003C72, &code_003C7B ) ; {15464}
}

code_003C72 {
    COP [97]              ; {15474}
    COP [80] ( #0C )      ; {15476}
    COP [82]              ; {15479}
    BRA code_003C99       ; {15481}
}

code_003C7B {
    COP [96]              ; {15483}
    COP [80] ( #0C )      ; {15485}
    COP [82]              ; {15488}
    BRL code_003BF2       ; {15490}
}

code_003C85 {
    COP [97]              ; {15493}
    COP [80] ( #0E )      ; {15495}
    COP [82]              ; {15498}
    BRL code_003C44       ; {15500}
}

code_003C8F {
    COP [97]              ; {15503}
    COP [80] ( #0C )      ; {15505}
    COP [82]              ; {15508}
    BRL code_003C99       ; {15510}
}

code_003C99 {
    COP [97]              ; {15513}
    COP [80] ( #36 )      ; {15515}
    COP [82]              ; {15518}

  loc_003CA0:
    COP [9A] ( #$0000, &code_003CAA, &code_003CB3, &code_003CB3 ) ; {15520}
}

code_003CAA {
    COP [9D] ( #12 )      ; {15530}
    COP [9E] ( &code_003C17 ) ; {15533}

  loc_003CB1:
    BRA loc_003CA0        ; {15537}
}

code_003CB3 {
    COP [9D] ( #37 )      ; {15539}
    COP [9E] ( &code_003C17 ) ; {15542}

  loc_003CBA:
    BRL loc_003B54        ; {15546}
}

code_003CBD {
    COP [97]              ; {15549}
    COP [80] ( #0D )      ; {15551}
    COP [82]              ; {15554}
    BRL code_003B9D       ; {15556}
}

code_003CC7 {
    COP [97]              ; {15559}
    COP [80] ( #0F )      ; {15561}
    COP [82]              ; {15564}
    BRL code_003C99       ; {15566}
}

code_003CD1 {
    COP [97]              ; {15569}
    COP [80] ( #0F )      ; {15571}
    COP [82]              ; {15574}
    COP [80] ( #0E )      ; {15576}
    COP [82]              ; {15579}
    BRL code_003C44       ; {15581}
}

code_003CE0 {
    COP [97]              ; {15584}
    COP [80] ( #0C )      ; {15586}
    COP [82]              ; {15589}
    COP [80] ( #0D )      ; {15591}
    COP [82]              ; {15594}
    BRL code_003B9D       ; {15596}
}

code_003CEF {
    COP [80] ( #0D )      ; {15599}
    COP [82]              ; {15602}
    COP [96]              ; {15604}
    COP [80] ( #0F )      ; {15606}
    COP [82]              ; {15609}
    BRL code_003BF2       ; {15611}
}

code_003CFE {
    COP [80] ( #0D )      ; {15614}
    COP [82]              ; {15617}
    COP [97]              ; {15619}
    COP [80] ( #0F )      ; {15621}
    COP [82]              ; {15624}
    BRL code_003C99       ; {15626}
}

code_003D0D {
    JSR $&code_003E02     ; {15629}
    COP [9F] ( #$0008 )   ; {15632}
    COP [80] ( #3C )      ; {15636}
    COP [82]              ; {15639}
    COP [85] ( @code_003D2C ) ; {15641}
    COP [80] ( #25 )      ; {15646}
    COP [82]              ; {15649}
    COP [A1] ( #$FFF8, #$0010 ) ; {15651}
    BRL loc_003E0D        ; {15657}
}

code_003D2C {
    LDA #$0200            ; {15660}
    STA $0016, X          ; {15663}
    COP [A3]              ; {15666}
    COP [80] ( #3E )      ; {15668}
    COP [82]              ; {15671}
    COP [86]              ; {15673}
    RTL                   ; {15675}
}

code_003D3C {
    LDA #$0200            ; {15676}
    STA $0016, X          ; {15679}
    COP [A1] ( #$0008, #$FFE8 ) ; {15682}
    COP [98]              ; {15688}
    COP [80] ( #3C )      ; {15690}
    COP [82]              ; {15693}
    BRK #$5B              ; {15695}
    COP [80] ( #25 )      ; {15697}
    COP [82]              ; {15700}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {15702}
    COP [85] ( @code_003DE4 ) ; {15708}
    COP [A0] ( #$FFE0 )   ; {15713}
    COP [A4]              ; {15717}
    COP [80] ( #26 )      ; {15719}
    COP [82]              ; {15722}
    COP [86]              ; {15724}
    RTL                   ; {15726}
}

code_003D6F {
    JSR $&code_003E02     ; {15727}
    COP [A1] ( #$FFF8, #$FFF4 ) ; {15730}
    COP [80] ( #3C )      ; {15736}
    COP [82]              ; {15739}
    COP [85] ( @code_003D8F ) ; {15741}
    COP [80] ( #24 )      ; {15746}
    COP [82]              ; {15749}
    COP [A1] ( #$FFF0, #$0008 ) ; {15751}
    BRA loc_003E0D        ; {15757}
}

code_003D8F {
    LDA #$0200            ; {15759}
    STA $0016, X          ; {15762}
    COP [A3]              ; {15765}
    COP [97]              ; {15767}
    COP [80] ( #3D )      ; {15769}
    COP [82]              ; {15772}
    COP [86]              ; {15774}
    RTL                   ; {15776}
}

code_003DA1 {
    JSR $&code_003E02     ; {15777}
    COP [A1] ( #$0020, #$FFF4 ) ; {15780}
    COP [80] ( #3C )      ; {15786}
    COP [82]              ; {15789}
    COP [85] ( @code_003DD2 ) ; {15791}
    COP [96]              ; {15796}
    COP [80] ( #24 )      ; {15798}
    COP [82]              ; {15801}
    COP [A0] ( #$0008 )   ; {15803}
    COP [85] ( @code_003DE4 ) ; {15807}
    COP [9F] ( #$0018 )   ; {15812}
    COP [A4]              ; {15816}
    COP [80] ( #26 )      ; {15818}
    COP [82]              ; {15821}
    COP [86]              ; {15823}
    RTL                   ; {15825}
}

code_003DD2 {
    LDA #$0200            ; {15826}
    STA $0016, X          ; {15829}
    COP [A3]              ; {15832}
    COP [96]              ; {15834}
    COP [80] ( #3D )      ; {15836}
    COP [82]              ; {15839}
    COP [86]              ; {15841}
    RTL                   ; {15843}
}

code_003DE4 {
    LDA #$0200            ; {15844}
    STA $0016, X          ; {15847}
    COP [A4]              ; {15850}
    COP [99]              ; {15852}
    COP [80] ( #22 )      ; {15854}
    COP [82]              ; {15857}
    COP [81] ( #40, #14 ) ; {15859}
    COP [83]              ; {15863}
    COP [81] ( #3F, #14 ) ; {15865}
    COP [83]              ; {15869}
    COP [86]              ; {15871}
    RTL                   ; {15873}
}

code_003E02 {
    LDA #$0200            ; {15874}
    STA $0016, X          ; {15877}
    COP [A3]              ; {15880}
    BRK #$5B              ; {15882}
    RTS                   ; {15884}

  loc_003E0D:
    COP [85] ( @code_003DE4 ) ; {15885}
    COP [A4]              ; {15890}
    COP [80] ( #26 )      ; {15892}
    COP [82]              ; {15895}
    COP [86]              ; {15897}
    RTL                   ; {15899}
}

code_003E1C {
    COP [A8] ( #$8000, #0D ) ; {15900}
    COP [92] ( #3A )      ; {15905}
    COP [94]              ; {15908}
    COP [86]              ; {15910}
    RTL                   ; {15912}
}

code_003E29 {
    COP [A8] ( #$8000, #0D ) ; {15913}
    COP [92] ( #3C )      ; {15918}
    COP [94]              ; {15921}
    COP [86]              ; {15923}
    RTL                   ; {15925}
}

code_003E36 {
    COP [A8] ( #$8000, #0D ) ; {15926}
    COP [92] ( #3E )      ; {15931}
    COP [94]              ; {15934}
    COP [86]              ; {15936}
    RTL                   ; {15938}
}

code_003E43 {
    INC $0458             ; {15939}
    STX $039A             ; {15942}

  code_003E49:
    COP [A3]              ; {15945}
    COP [AD] ( #08 )      ; {15947}
    COP [0C] ( #00, #04, &code_003E5A ) ; {15950}
    COP [1B] ( &code_003E49, #$0008 ) ; {15956}
}

code_003E5A {
    COP [80] ( #00 )      ; {15962}
    COP [82]              ; {15965}
    COP [85] ( @code_00409B ) ; {15967}
    COP [B0] ( @code_003EC0, #$0200 ) ; {15972}
    COP [AF] ( @code_003F3F, #$0201 ) ; {15979}
    COP [AF] ( @code_003FEC, #$0201 ) ; {15986}

  loc_003E79:
    COP [03] ( #04 )      ; {15993}
    COP [97]              ; {15996}
    COP [80] ( #01 )      ; {15998}
    COP [82]              ; {16001}
    COP [96]              ; {16003}
    COP [80] ( #01 )      ; {16005}
    COP [82]              ; {16008}
    COP [04]              ; {16010}
    COP [80] ( #20 )      ; {16012}
    COP [82]              ; {16015}
    COP [80] ( #1E )      ; {16017}
    COP [82]              ; {16020}
    COP [09] ( #$8000 )   ; {16022}
    COP [05] ( #$8000 )   ; {16026}
    COP [80] ( #1F )      ; {16030}
    COP [82]              ; {16033}
    LDY $039C             ; {16035}
    LDA $0000, Y          ; {16038}
    CMP #$0080            ; {16041}
    BCS loc_003EB7        ; {16044}
    COP [97]              ; {16046}
    COP [80] ( #21 )      ; {16048}
    COP [82]              ; {16051}
    BRA loc_003E79        ; {16053}

  loc_003EB7:
    COP [96]              ; {16055}
    COP [80] ( #21 )      ; {16057}
    COP [82]              ; {16060}
    BRA loc_003E79        ; {16062}
}

code_003EC0 {
    COP [A3]              ; {16064}

  loc_003EC2:
    COP [80] ( #22 )      ; {16066}
    COP [82]              ; {16069}
    COP [05] ( #$0000 )   ; {16071}
    COP [80] ( #03 )      ; {16075}
    COP [82]              ; {16078}
    COP [AF] ( @code_003EE8, #$0200 ) ; {16080}
    COP [1B] ( &code_003EDD, #$0018 ) ; {16087}
}

code_003EDD {
    COP [80] ( #04 )      ; {16093}
    COP [82]              ; {16096}
    COP [09] ( #$0000 )   ; {16098}
    BRA loc_003EC2        ; {16102}
}

code_003EE8 {
    COP [A3]              ; {16104}
    COP [A1] ( #$0008, #$FFFC ) ; {16106}
    COP [80] ( #18 )      ; {16112}
    COP [82]              ; {16115}
    BRK #$51              ; {16117}
    COP [B0] ( @code_003F14, #$0200 ) ; {16119}
    COP [B0] ( @code_003F1D, #$0200 ) ; {16126}
    COP [B0] ( @code_003F26, #$0200 ) ; {16133}
    COP [80] ( #17 )      ; {16140}
    COP [82]              ; {16143}
    COP [86]              ; {16145}
    RTL                   ; {16147}
}

code_003F14 {
    COP [A3]              ; {16148}
    COP [80] ( #16 )      ; {16150}
    COP [82]              ; {16153}
    BRA loc_003F2F        ; {16155}
}

code_003F1D {
    COP [A3]              ; {16157}
    COP [80] ( #15 )      ; {16159}
    COP [82]              ; {16162}
    BRA loc_003F2F        ; {16164}
}

code_003F26 {
    COP [A3]              ; {16166}
    COP [96]              ; {16168}
    COP [80] ( #15 )      ; {16170}
    COP [82]              ; {16173}

  loc_003F2F:
    COP [80] ( #14 )      ; {16175}
    COP [82]              ; {16178}
    COP [1C] ( #$8000, &code_003F3C ) ; {16180}
    BRA loc_003F2F        ; {16186}
}

code_003F3C {
    COP [86]              ; {16188}
    RTL                   ; {16190}
}

code_003F3F {
    COP [A3]              ; {16191}
    LDA $001A, X          ; {16193}
    ORA #$0100            ; {16196}
    STA $001A, X          ; {16199}

  code_003F4A:
    COP [99]              ; {16202}
    COP [97]              ; {16204}
    LDA #$0030            ; {16206}
    STA $0000, X          ; {16209}
    LDA #$0070            ; {16212}
    STA $0002, X          ; {16215}
    COP [81] ( #25, #14 ) ; {16218}
    COP [83]              ; {16222}
    SEP #$20              ; {16224}
    LDA #$63              ; {16226}
    STA $0025, X          ; {16228}
    REP #$20              ; {16231}
    LDA $0016, X          ; {16233}
    AND #$FCFF            ; {16236}
    STA $0016, X          ; {16239}

  loc_003F72:
    LDA $0025, X          ; {16242}
    AND #$00FF            ; {16245}
    CMP #$005A            ; {16248}
    BCC loc_003FD7        ; {16251}
    COP [9C] ( &code_003F83, &code_003FAD ) ; {16253}
}

code_003F83 {
    COP [9A] ( #$0000, &code_003F8D, &code_003F9D, &code_003F9D ) ; {16259}
}

code_003F8D {
    COP [97]              ; {16269}
    COP [99]              ; {16271}
    COP [80] ( #27 )      ; {16273}
    COP [82]              ; {16276}
    COP [80] ( #29 )      ; {16278}
    COP [82]              ; {16281}
    BRA loc_003F72        ; {16283}
}

code_003F9D {
    COP [96]              ; {16285}
    COP [99]              ; {16287}
    COP [80] ( #10 )      ; {16289}
    COP [82]              ; {16292}
    COP [80] ( #12 )      ; {16294}
    COP [82]              ; {16297}
    BRA loc_003F72        ; {16299}
}

code_003FAD {
    COP [9B] ( #$0000, &code_003FB7, &code_003FC7, &code_003FC7 ) ; {16301}
}

code_003FB7 {
    COP [97]              ; {16311}
    COP [98]              ; {16313}
    COP [80] ( #0F )      ; {16315}
    COP [82]              ; {16318}
    COP [80] ( #11 )      ; {16320}
    COP [82]              ; {16323}
    BRA loc_003F72        ; {16325}
}

code_003FC7 {
    COP [97]              ; {16327}
    COP [99]              ; {16329}
    COP [80] ( #26 )      ; {16331}
    COP [82]              ; {16334}
    COP [80] ( #28 )      ; {16336}
    COP [82]              ; {16339}
    BRA loc_003F72        ; {16341}

  loc_003FD7:
    LDA $0016, X          ; {16343}
    ORA #$0300            ; {16346}
    STA $0016, X          ; {16349}
    COP [81] ( #25, #14 ) ; {16352}
    COP [83]              ; {16356}
    COP [1B] ( &code_003F4A, #$012C ) ; {16358}
}

code_003FEC {
    COP [A3]              ; {16364}
    COP [96]              ; {16366}
    LDA $001A, X          ; {16368}
    ORA #$0100            ; {16371}
    STA $001A, X          ; {16374}

  code_003FF9:
    COP [99]              ; {16377}
    COP [97]              ; {16379}
    LDA #$00B0            ; {16381}
    STA $0000, X          ; {16384}
    LDA #$0070            ; {16387}
    STA $0002, X          ; {16390}
    COP [81] ( #0E, #14 ) ; {16393}
    COP [83]              ; {16397}
    SEP #$20              ; {16399}
    LDA #$63              ; {16401}
    STA $0025, X          ; {16403}
    REP #$20              ; {16406}
    LDA $0016, X          ; {16408}
    AND #$FCFF            ; {16411}
    STA $0016, X          ; {16414}

  loc_004021:
    LDA $0025, X          ; {16417}
    AND #$00FF            ; {16420}
    CMP #$005A            ; {16423}
    BCC loc_004086        ; {16426}
    COP [9C] ( &code_004032, &code_00405C ) ; {16428}
}

code_004032 {
    COP [9A] ( #$0000, &code_00403C, &code_00404C, &code_00404C ) ; {16434}
}

code_00403C {
    COP [97]              ; {16444}
    COP [99]              ; {16446}
    COP [80] ( #10 )      ; {16448}
    COP [82]              ; {16451}
    COP [80] ( #12 )      ; {16453}
    COP [82]              ; {16456}
    BRA loc_004021        ; {16458}
}

code_00404C {
    COP [96]              ; {16460}
    COP [99]              ; {16462}
    COP [80] ( #27 )      ; {16464}
    COP [82]              ; {16467}
    COP [80] ( #29 )      ; {16469}
    COP [82]              ; {16472}
    BRA loc_004021        ; {16474}
}

code_00405C {
    COP [9B] ( #$0000, &code_004066, &code_004076, &code_004076 ) ; {16476}
}

code_004066 {
    COP [97]              ; {16486}
    COP [98]              ; {16488}
    COP [80] ( #26 )      ; {16490}
    COP [82]              ; {16493}
    COP [80] ( #28 )      ; {16495}
    COP [82]              ; {16498}
    BRA loc_004021        ; {16500}
}

code_004076 {
    COP [97]              ; {16502}
    COP [99]              ; {16504}
    COP [80] ( #0F )      ; {16506}
    COP [82]              ; {16509}
    COP [80] ( #11 )      ; {16511}
    COP [82]              ; {16514}
    BRA loc_004021        ; {16516}

  loc_004086:
    LDA $0016, X          ; {16518}
    ORA #$0300            ; {16521}
    STA $0016, X          ; {16524}
    COP [81] ( #0E, #14 ) ; {16527}
    COP [83]              ; {16531}
    COP [1B] ( &code_003FF9, #$012C ) ; {16533}
}

code_00409B {
    LDA $003C, X          ; {16539}
    STA $0002, X          ; {16542}
    TAY                   ; {16545}
    LDA $003C, Y          ; {16546}
    STA $0000, X          ; {16549}
    COP [91]              ; {16552}
    PHX                   ; {16554}
    COP [07] ( #$8000, &code_0040C4 ) ; {16555}
    LDA $0000, X          ; {16561}
    LDY $0002, X          ; {16564}
    TAX                   ; {16567}
    LDA $0000, X          ; {16568}
    STA $0000, Y          ; {16571}
    LDA $0002, X          ; {16574}
    STA $0002, Y          ; {16577}
}

code_0040C4 {
    PLX                   ; {16580}
    PHX                   ; {16581}
    LDA $0000, X          ; {16582}
    LDY $0002, X          ; {16585}
    TAX                   ; {16588}
    LDA $0026, X          ; {16589}
    STA $0026, Y          ; {16592}
    LDA $0016, X          ; {16595}
    BIT #$0400            ; {16598}
    BNE loc_0040ED        ; {16601}
    AND #$0800            ; {16603}
    PHA                   ; {16606}
    LDA $0016, Y          ; {16607}
    AND #$F7FF            ; {16610}
    ORA $01, S            ; {16613}
    STA $0016, Y          ; {16615}
    PLA                   ; {16618}
    PLX                   ; {16619}
    RTL                   ; {16620}

  loc_0040ED:
    TYX                   ; {16621}
    LDA #$&code_0040FB    ; {16622}
    STA $0018, X          ; {16625}
    STZ $0014, X          ; {16628}
    PLX                   ; {16631}
    COP [86]              ; {16632}
    RTL                   ; {16634}
}
---------------------------------------------

code_0040FB {
    STZ $0004, X          ; {16635}
    STZ $0006, X          ; {16638}
    RTL                   ; {16641}
}

code_004102 {
    COP [14] ( #$00B6, &code_00419D ) ; {16642}

  loc_004108:
    COP [AD] ( #08 )      ; {16648}
    COP [0C] ( #00, #03, &code_004118 ) ; {16651}
    COP [80] ( #1A )      ; {16657}
    COP [82]              ; {16660}
    BRA loc_004108        ; {16662}
}

code_004118 {
    BRK #$A1              ; {16664}
    COP [B0] ( @code_004281, #$0200 ) ; {16666}
    COP [B0] ( @code_004289, #$0200 ) ; {16673}
    COP [B0] ( @code_004291, #$0200 ) ; {16680}
    STZ $0016, X          ; {16687}
    COP [80] ( #0B )      ; {16690}
    COP [82]              ; {16693}

  loc_004137:
    COP [AD] ( #08 )      ; {16695}
    COP [0C] ( #00, #04, &code_004147 ) ; {16698}

  code_004140:
    COP [80] ( #2A )      ; {16704}
    COP [82]              ; {16707}
    BRA loc_004137        ; {16709}
}

code_004147 {
    COP [9C] ( &code_00414D, &code_004175 ) ; {16711}
}

code_00414D {
    COP [9A] ( #$0010, &code_004157, &code_004166, &code_004166 ) ; {16717}
}

code_004157 {
    COP [23] ( &code_004140 ) ; {16727}
    COP [97]              ; {16731}
    COP [99]              ; {16733}
    COP [80] ( #0D )      ; {16735}
    COP [82]              ; {16738}
    BRA code_004140       ; {16740}
}

code_004166 {
    COP [24] ( &code_004140 ) ; {16742}
    COP [96]              ; {16746}
    COP [99]              ; {16748}
    COP [80] ( #0D )      ; {16750}
    COP [82]              ; {16753}
    BRA code_004140       ; {16755}
}

code_004175 {
    COP [9B] ( #$0010, &code_00417F, &code_00418E, &code_00418E ) ; {16757}
}

code_00417F {
    COP [21] ( &code_004140 ) ; {16767}
    COP [97]              ; {16771}
    COP [98]              ; {16773}
    COP [80] ( #0C )      ; {16775}
    COP [82]              ; {16778}
    BRA code_004140       ; {16780}
}

code_00418E {
    COP [22] ( &code_004140 ) ; {16782}
    COP [97]              ; {16786}
    COP [99]              ; {16788}
    COP [80] ( #0C )      ; {16790}
    COP [82]              ; {16793}
    BRA code_004140       ; {16795}
}

code_00419D {
    COP [86]              ; {16797}
    RTL                   ; {16799}
}

code_0041A0 {
    COP [14] ( #$00B6, &code_004245 ) ; {16800}
    COP [A0] ( #$FFF8 )   ; {16806}
    LDA $001A, X          ; {16810}
    ORA #$0100            ; {16813}
    STA $001A, X          ; {16816}

  loc_0041B3:
    COP [AD] ( #08 )      ; {16819}
    COP [9B] ( #$0040, &code_0041C0, &code_0041C7, &code_0041C0 ) ; {16822}
}

code_0041C0 {
    COP [80] ( #23 )      ; {16832}
    COP [82]              ; {16835}
    BRA loc_0041B3        ; {16837}
}

code_0041C7 {
    COP [AD] ( #08 )      ; {16839}
    COP [80] ( #05 )      ; {16842}
    COP [82]              ; {16845}
    SEP #$20              ; {16847}
    LDA #$63              ; {16849}
    STA $0025, X          ; {16851}
    REP #$20              ; {16854}
    LDA $0016, X          ; {16856}
    AND #$FDFF            ; {16859}
    STA $0016, X          ; {16862}

  loc_0041E1:
    COP [03] ( #0F )      ; {16865}
    LDA $0025, X          ; {16868}
    AND #$00FF            ; {16871}
    CMP #$0063            ; {16874}
    BCC loc_004218        ; {16877}
    COP [9B] ( #$0010, &code_0041F9, &code_004200, &code_0041F9 ) ; {16879}
}

code_0041F9 {
    COP [80] ( #06 )      ; {16889}
    COP [82]              ; {16892}
    COP [04]              ; {16894}
}

code_004200 {
    COP [80] ( #07 )      ; {16896}
    COP [82]              ; {16899}
    COP [B0] ( @code_004231, #$0200 ) ; {16901}
    COP [80] ( #08 )      ; {16908}
    COP [82]              ; {16911}
    COP [80] ( #06 )      ; {16913}
    COP [82]              ; {16916}
    BRA loc_0041E1        ; {16918}

  loc_004218:
    LDA $0016, X          ; {16920}
    ORA #$0200            ; {16923}
    STA $0016, X          ; {16926}
    COP [80] ( #09 )      ; {16929}
    COP [82]              ; {16932}
    COP [80] ( #23 )      ; {16934}
    COP [82]              ; {16937}
    COP [1B] ( &code_0041C7, #$012C ) ; {16939}
}

code_004231 {
    COP [8F]              ; {16945}
    BRK #$5B              ; {16947}

  loc_004235:
    COP [80] ( #13 )      ; {16949}
    COP [82]              ; {16952}
    COP [1C] ( #$8000, &code_004242 ) ; {16954}
    BRA loc_004235        ; {16960}
}

code_004242 {
    COP [86]              ; {16962}
    RTL                   ; {16964}
}

code_004245 {
    COP [86]              ; {16965}
    RTL                   ; {16967}
}

code_004248 {
    COP [A4]              ; {16968}
    COP [16]              ; {16970}
    COP [14] ( #$00B6, &code_00427E ) ; {16972}

  code_004252:
    COP [9B] ( #$0030, &code_004262, &code_00425C, &code_00425C ) ; {16978}
}

code_00425C {
    COP [1B] ( &code_004252, #$0008 ) ; {16988}
}

code_004262 {
    BRK #$A1              ; {16994}
    COP [B0] ( @code_004281, #$0200 ) ; {16996}
    COP [B0] ( @code_004289, #$0200 ) ; {17003}
    COP [B0] ( @code_004291, #$0200 ) ; {17010}
    COP [15]              ; {17017}
    COP [86]              ; {17019}
    RTL                   ; {17021}
}

code_00427E {
    COP [91]              ; {17022}
    RTL                   ; {17024}
}

code_004281 {
    COP [80] ( #1B )      ; {17025}
    COP [82]              ; {17028}
    COP [86]              ; {17030}
    RTL                   ; {17032}
}

code_004289 {
    COP [80] ( #1C )      ; {17033}
    COP [82]              ; {17036}
    COP [86]              ; {17038}
    RTL                   ; {17040}
}

code_004291 {
    COP [80] ( #1D )      ; {17041}
    COP [82]              ; {17044}
    COP [86]              ; {17046}
    RTL                   ; {17048}
}

code_004299 {
    STZ $03B2             ; {17049}
    INC $0458             ; {17052}
    STX $039A             ; {17055}
    COP [9F] ( #$0008 )   ; {17058}
    COP [85] ( @code_003188 ) ; {17062}
    LDA #$0002            ; {17067}
    STA $0030, Y          ; {17070}

  loc_0042B1:
    LDA #$0002            ; {17073}
    STA $0030, X          ; {17076}

  loc_0042B7:
    COP [97]              ; {17079}
    LDA $0016, X          ; {17081}
    ORA #$0300            ; {17084}
    STA $0016, X          ; {17087}
    COP [B2] ( &code_004528, #00, #$0010, #$FFF0, #$0300 ) ; {17090}
    COP [03] ( #15 )      ; {17101}
    COP [04]              ; {17104}
    COP [B2] ( &code_004528, #00, #$0008, #$FFFA, #$0300 ) ; {17106}
    COP [03] ( #15 )      ; {17117}
    COP [04]              ; {17120}
    COP [B2] ( &code_004528, #00, #$0014, #$FFF6, #$0300 ) ; {17122}
    COP [03] ( #15 )      ; {17133}
    COP [04]              ; {17136}
    COP [85] ( @code_0045F5 ) ; {17138}
    COP [80] ( #0A )      ; {17143}
    COP [82]              ; {17146}
    LDA $0016, X          ; {17148}
    AND #$FCFF            ; {17151}
    STA $0016, X          ; {17154}
    COP [1F]              ; {17157}
    LDA $0302             ; {17159}
    BMI loc_00433D        ; {17162}
    COP [80] ( #01 )      ; {17164}
    COP [82]              ; {17167}
    COP [B2] ( &code_004497, #00, #$FFEA, #$000D, #$0200 ) ; {17169}
    COP [03] ( #1F )      ; {17180}
    COP [04]              ; {17183}
    COP [80] ( #0D )      ; {17185}
    COP [82]              ; {17188}
    COP [80] ( #05 )      ; {17190}
    COP [82]              ; {17193}
    COP [B2] ( &code_004487, #00, #$FFED, #$0010, #$0200 ) ; {17195}
    COP [80] ( #06 )      ; {17206}
    COP [82]              ; {17209}
    BRA loc_00436C        ; {17211}

  loc_00433D:
    COP [80] ( #00 )      ; {17213}
    COP [82]              ; {17216}
    COP [B2] ( &code_004497, #00, #$0015, #$000F, #$0300 ) ; {17218}
    COP [03] ( #1F )      ; {17229}
    COP [04]              ; {17232}
    COP [80] ( #0B )      ; {17234}
    COP [82]              ; {17237}
    COP [80] ( #02 )      ; {17239}
    COP [82]              ; {17242}
    COP [B2] ( &code_00448F, #00, #$0012, #$0010, #$0200 ) ; {17244}
    COP [80] ( #03 )      ; {17255}
    COP [82]              ; {17258}

  loc_00436C:
    COP [1F]              ; {17260}
    LDA $0302             ; {17262}
    BMI loc_0043C6        ; {17265}
    COP [80] ( #05 )      ; {17267}
    COP [82]              ; {17270}
    COP [B2] ( &code_004487, #00, #$FFED, #$0010, #$0200 ) ; {17272}
    COP [80] ( #06 )      ; {17283}
    COP [82]              ; {17286}
    COP [80] ( #0E )      ; {17288}
    COP [82]              ; {17291}
    LDA $0016, X          ; {17293}
    ORA #$0200            ; {17296}
    STA $0016, X          ; {17299}
    COP [B2] ( &code_004532, #00, #$FFE4, #$FFCD, #$0200 ) ; {17302}
    COP [B2] ( &code_004546, #00, #$FFE4, #$FFCD, #$0200 ) ; {17313}
    COP [03] ( #29 )      ; {17324}
    COP [04]              ; {17327}
    LDA $0016, X          ; {17329}
    ORA #$0300            ; {17332}
    STA $0016, X          ; {17335}
    COP [85] ( @code_0045F5 ) ; {17338}
    COP [80] ( #08 )      ; {17343}
    COP [82]              ; {17346}
    BRA loc_004417        ; {17348}

  loc_0043C6:
    COP [80] ( #02 )      ; {17350}
    COP [82]              ; {17353}
    COP [B2] ( &code_00448F, #00, #$0012, #$0010, #$0200 ) ; {17355}
    COP [80] ( #03 )      ; {17366}
    COP [82]              ; {17369}
    COP [80] ( #0C )      ; {17371}
    COP [82]              ; {17374}
    LDA $0016, X          ; {17376}
    ORA #$0200            ; {17379}
    STA $0016, X          ; {17382}
    COP [B2] ( &code_004532, #00, #$001B, #$FFCD, #$0200 ) ; {17385}
    COP [B2] ( &code_004546, #00, #$001B, #$FFCD, #$0200 ) ; {17396}
    COP [03] ( #29 )      ; {17407}
    COP [04]              ; {17410}
    LDA $0016, X          ; {17412}
    ORA #$0300            ; {17415}
    STA $0016, X          ; {17418}
    COP [85] ( @code_0045F5 ) ; {17421}
    COP [80] ( #09 )      ; {17426}
    COP [82]              ; {17429}

  loc_004417:
    LDA $0030, X          ; {17431}
    CMP #$0001            ; {17434}
    BEQ loc_004455        ; {17437}
    COP [1F]              ; {17439}
    LDA $0302             ; {17441}
    BMI loc_00442A        ; {17444}
    COP [97]              ; {17446}
    BRA loc_00442C        ; {17448}

  loc_00442A:
    COP [96]              ; {17450}

  loc_00442C:
    COP [AF] ( @code_0044D3, #$0300 ) ; {17452}
    COP [AF] ( @code_0044D3, #$0300 ) ; {17459}
    COP [AF] ( @code_0044D3, #$0300 ) ; {17466}
    COP [AF] ( @code_0044FF, #$0300 ) ; {17473}
    COP [80] ( #14 )      ; {17480}
    COP [82]              ; {17483}
    DEC $0030, X          ; {17485}
    BEQ loc_004455        ; {17488}
    BRL loc_0042B7        ; {17490}

  loc_004455:
    LDA $0000, X          ; {17493}
    CMP #$00F0            ; {17496}
    BCS loc_004461        ; {17499}
    COP [97]              ; {17501}
    BRA loc_004463        ; {17503}

  loc_004461:
    COP [96]              ; {17505}

  loc_004463:
    COP [AF] ( @code_0044D3, #$0300 ) ; {17507}
    COP [AF] ( @code_0044D3, #$0300 ) ; {17514}
    COP [AF] ( @code_0044D3, #$0300 ) ; {17521}
    COP [AF] ( @code_0044FF, #$0300 ) ; {17528}
    COP [80] ( #15 )      ; {17535}
    COP [82]              ; {17538}
    BRL loc_0042B1        ; {17540}
}

code_004487 {
    COP [80] ( #07 )      ; {17543}
    COP [82]              ; {17546}
    COP [86]              ; {17548}
    RTL                   ; {17550}
}

code_00448F {
    COP [80] ( #04 )      ; {17551}
    COP [82]              ; {17554}
    COP [86]              ; {17556}
    RTL                   ; {17558}
}

code_004497 {
    COP [A3]              ; {17559}
    COP [81] ( #16, #06 ) ; {17561}
    COP [83]              ; {17565}
    BRK #$4B              ; {17567}
    COP [B0] ( @code_0044BF, #$0200 ) ; {17569}
    COP [B0] ( @code_0044C1, #$0200 ) ; {17576}

  loc_0044AF:
    COP [80] ( #12 )      ; {17583}
    COP [82]              ; {17586}
    LDA $0016, X          ; {17588}
    BIT #$8000            ; {17591}
    BEQ loc_0044AF        ; {17594}
    COP [86]              ; {17596}
    RTL                   ; {17598}
}

code_0044BF {
    COP [96]              ; {17599}
}

code_0044C1 {
    COP [A3]              ; {17601}

  loc_0044C3:
    COP [80] ( #13 )      ; {17603}
    COP [82]              ; {17606}
    LDA $0016, X          ; {17608}
    BIT #$8000            ; {17611}
    BEQ loc_0044C3        ; {17614}
    COP [86]              ; {17616}
    RTL                   ; {17618}
}

code_0044D3 {
    COP [A4]              ; {17619}
    COP [80] ( #1D )      ; {17621}
    COP [82]              ; {17624}
    COP [91]              ; {17626}
    LDY $039A             ; {17628}
    LDA $001E, Y          ; {17631}
    CMP #$0014            ; {17634}
    BEQ loc_0044EC        ; {17637}
    CMP #$0015            ; {17639}
    BNE loc_0044FC        ; {17642}

  loc_0044EC:
    LDY $003E, X          ; {17644}
    LDA $0000, Y          ; {17647}
    STA $0000, X          ; {17650}
    LDA $0002, Y          ; {17653}
    STA $0002, X          ; {17656}
    RTL                   ; {17659}

  loc_0044FC:
    COP [86]              ; {17660}
    RTL                   ; {17662}
}

code_0044FF {
    COP [A4]              ; {17663}
    COP [80] ( #1D )      ; {17665}
    COP [82]              ; {17668}
    COP [91]              ; {17670}
    LDY $039A             ; {17672}
    LDA $001E, Y          ; {17675}
    CMP #$0014            ; {17678}
    BEQ loc_004518        ; {17681}
    CMP #$0015            ; {17683}
    BNE loc_004525        ; {17686}

  loc_004518:
    LDA $0000, Y          ; {17688}
    STA $0000, X          ; {17691}
    LDA $0002, Y          ; {17694}
    STA $0002, X          ; {17697}
    RTL                   ; {17700}

  loc_004525:
    COP [86]              ; {17701}
    RTL                   ; {17703}
}

code_004528 {
    COP [A3]              ; {17704}
    COP [80] ( #0F )      ; {17706}
    COP [82]              ; {17709}
    COP [86]              ; {17711}
    RTL                   ; {17713}
}

code_004532 {
    COP [A3]              ; {17714}
    COP [81] ( #16, #06 ) ; {17716}
    COP [83]              ; {17720}
    BRK #$4B              ; {17722}
    COP [97]              ; {17724}
    COP [81] ( #19, #02 ) ; {17726}
    COP [83]              ; {17730}
    BRA loc_00455B        ; {17732}
}

code_004546 {
    COP [A3]              ; {17734}
    COP [81] ( #16, #06 ) ; {17736}
    COP [83]              ; {17740}
    BRK #$4B              ; {17742}
    COP [96]              ; {17744}
    COP [81] ( #19, #02 ) ; {17746}
    COP [83]              ; {17750}
    BRL loc_0045A8        ; {17752}

  loc_00455B:
    COP [97]              ; {17755}

  loc_00455D:
    COP [9B] ( #$0020, &code_004588, &code_004567, &code_004588 ) ; {17757}
}

code_004567 {
    COP [9A] ( #$0000, &code_004571, &code_004578, &code_004578 ) ; {17767}
}

code_004571 {
    COP [80] ( #1B )      ; {17777}
    COP [82]              ; {17780}
    BRA loc_00457F        ; {17782}
}

code_004578 {
    COP [80] ( #1C )      ; {17784}
    COP [82]              ; {17787}
    COP [96]              ; {17789}

  loc_00457F:
    COP [81] ( #17, #2A ) ; {17791}
    COP [83]              ; {17795}
    COP [86]              ; {17797}
    RTL                   ; {17799}
}

code_004588 {
    COP [9A] ( #$0018, &code_0045A0, &code_004592, &code_0045A0 ) ; {17800}
}

code_004592 {
    COP [80] ( #1A )      ; {17810}
    COP [82]              ; {17813}
    COP [81] ( #18, #0A ) ; {17815}
    COP [83]              ; {17819}
    COP [86]              ; {17821}
    RTL                   ; {17823}
}

code_0045A0 {
    COP [80] ( #19 )      ; {17824}
    COP [82]              ; {17827}
    BRL loc_00455D        ; {17829}

  loc_0045A8:
    COP [96]              ; {17832}

  loc_0045AA:
    COP [9B] ( #$0020, &code_0045D5, &code_0045B4, &code_0045D5 ) ; {17834}
}

code_0045B4 {
    COP [9A] ( #$0000, &code_0045BE, &code_0045C7, &code_0045C7 ) ; {17844}
}

code_0045BE {
    COP [80] ( #1C )      ; {17854}
    COP [82]              ; {17857}
    COP [97]              ; {17859}
    BRA loc_0045CC        ; {17861}
}

code_0045C7 {
    COP [80] ( #1B )      ; {17863}
    COP [82]              ; {17866}

  loc_0045CC:
    COP [81] ( #17, #2A ) ; {17868}
    COP [83]              ; {17872}
    COP [86]              ; {17874}
    RTL                   ; {17876}
}

code_0045D5 {
    COP [9A] ( #$0018, &code_0045ED, &code_0045DF, &code_0045ED ) ; {17877}
}

code_0045DF {
    COP [80] ( #1A )      ; {17887}
    COP [82]              ; {17890}
    COP [81] ( #18, #0A ) ; {17892}
    COP [83]              ; {17896}
    COP [86]              ; {17898}
    RTL                   ; {17900}
}

code_0045ED {
    COP [80] ( #19 )      ; {17901}
    COP [82]              ; {17904}
    BRL loc_0045AA        ; {17906}
}

code_0045F5 {
    COP [03] ( #10 )      ; {17909}
    COP [B0] ( @code_004617, #$0300 ) ; {17912}
    COP [1B] ( &code_004605, #$0002 ) ; {17919}
}

code_004605 {
    COP [B0] ( @code_004622, #$0300 ) ; {17925}
    COP [1B] ( &code_004612, #$0002 ) ; {17932}
}

code_004612 {
    COP [04]              ; {17938}
    COP [86]              ; {17940}
    RTL                   ; {17942}
}

code_004617 {
    JSR $&code_00462D     ; {17943}
    COP [80] ( #10 )      ; {17946}
    COP [82]              ; {17949}
    COP [86]              ; {17951}
    RTL                   ; {17953}
}

code_004622 {
    JSR $&code_00462D     ; {17954}
    COP [80] ( #11 )      ; {17957}
    COP [82]              ; {17960}
    COP [86]              ; {17962}
    RTL                   ; {17964}
}

code_00462D {
    LDY $039A             ; {17965}
    COP [1F]              ; {17968}
    COP [35] ( #20 )      ; {17970}
    LDA $0437             ; {17973}
    SEC                   ; {17976}
    SBC #$0008            ; {17977}
    CLC                   ; {17980}
    ADC $0000, Y          ; {17981}
    STA $0000, X          ; {17984}
    COP [1F]              ; {17987}
    COP [35] ( #10 )      ; {17989}
    LDA $0437             ; {17992}
    SEC                   ; {17995}
    SBC #$000C            ; {17996}
    CLC                   ; {17999}
    ADC $0002, Y          ; {18000}
    STA $0002, X          ; {18003}
    COP [A3]              ; {18006}
    RTS                   ; {18008}
}

code_004659 {
    STZ $03B2             ; {18009}
    INC $0458             ; {18012}
    STX $039A             ; {18015}
    LDA $001A, X          ; {18018}
    ORA #$0400            ; {18021}
    STA $001A, X          ; {18024}
    COP [85] ( @code_003188 ) ; {18027}
    LDA #$0003            ; {18032}
    STA $0030, Y          ; {18035}
    BRL code_00477D       ; {18038}

  loc_004679:
    LDA $0025, X          ; {18041}
    AND #$00FF            ; {18044}
    CMP $0030, X          ; {18047}
    BEQ loc_004688        ; {18050}
    COP [09] ( #$8000 )   ; {18052}

  loc_004688:
    COP [0C] ( #00, #02, &code_0046A8 ) ; {18056}
    COP [9A] ( #$0028, &code_004698, &code_00477D, &code_0046A0 ) ; {18062}
}

code_004698 {
    COP [80] ( #10 )      ; {18072}
    COP [82]              ; {18075}
    BRL code_00480B       ; {18077}
}

code_0046A0 {
    COP [80] ( #0D )      ; {18080}
    COP [82]              ; {18083}
    BRL code_004842       ; {18085}
}

code_0046A8 {
    COP [07] ( #$8001, &code_004879 ) ; {18088}
    COP [80] ( #10 )      ; {18094}
    COP [82]              ; {18097}
    COP [80] ( #11 )      ; {18099}
    COP [82]              ; {18102}
    COP [09] ( #$8001 )   ; {18104}
    BRL loc_004A01        ; {18108}

  loc_0046BF:
    LDA $0025, X          ; {18111}
    AND #$00FF            ; {18114}
    CMP $0030, X          ; {18117}
    BEQ loc_0046CE        ; {18120}
    COP [09] ( #$8000 )   ; {18122}

  loc_0046CE:
    COP [0C] ( #00, #02, &code_0046EE ) ; {18126}
    COP [9B] ( #$0028, &code_0046DE, &code_00480B, &code_0046E6 ) ; {18132}
}

code_0046DE {
    COP [80] ( #0C )      ; {18142}
    COP [82]              ; {18145}
    BRL code_00477D       ; {18147}
}

code_0046E6 {
    COP [80] ( #11 )      ; {18150}
    COP [82]              ; {18153}
    BRL code_0047C4       ; {18155}
}

code_0046EE {
    COP [07] ( #$8001, &code_0048DB ) ; {18158}
    COP [80] ( #11 )      ; {18164}
    COP [82]              ; {18167}
    COP [09] ( #$8001 )   ; {18169}
    BRL loc_004A01        ; {18173}

  loc_004700:
    LDA $0025, X          ; {18176}
    AND #$00FF            ; {18179}
    CMP $0030, X          ; {18182}
    BEQ loc_00470F        ; {18185}
    COP [09] ( #$8000 )   ; {18187}

  loc_00470F:
    COP [0C] ( #00, #02, &code_00472F ) ; {18191}
    COP [9B] ( #$0028, &code_00471F, &code_004842, &code_004727 ) ; {18197}
}

code_00471F {
    COP [80] ( #0F )      ; {18207}
    COP [82]              ; {18210}
    BRL code_00477D       ; {18212}
}

code_004727 {
    COP [80] ( #12 )      ; {18215}
    COP [82]              ; {18218}
    BRL code_0047C4       ; {18220}
}

code_00472F {
    COP [07] ( #$8001, &code_00493D ) ; {18223}
    COP [80] ( #12 )      ; {18229}
    COP [82]              ; {18232}
    COP [09] ( #$8001 )   ; {18234}
    BRL loc_004A01        ; {18238}

  loc_004741:
    LDA $0025, X          ; {18241}
    AND #$00FF            ; {18244}
    CMP $0030, X          ; {18247}
    BEQ loc_004750        ; {18250}
    COP [09] ( #$8000 )   ; {18252}

  loc_004750:
    COP [0C] ( #00, #02, &code_004770 ) ; {18256}
    COP [9A] ( #$0028, &code_004760, &code_0047C4, &code_004768 ) ; {18262}
}

code_004760 {
    COP [80] ( #13 )      ; {18272}
    COP [82]              ; {18275}
    BRL code_00480B       ; {18277}
}

code_004768 {
    COP [80] ( #0E )      ; {18280}
    COP [82]              ; {18283}
    BRL code_004842       ; {18285}
}

code_004770 {
    COP [07] ( #$8001, &code_00499F ) ; {18288}
    COP [09] ( #$8001 )   ; {18294}
    BRL loc_004A01        ; {18298}
}

code_00477D {
    LDA $0002, X          ; {18301}
    CMP #$00A0            ; {18304}
    BEQ loc_00479D        ; {18307}
    COP [07] ( #$8000, &code_004794 ) ; {18309}
    COP [81] ( #0A, #04 ) ; {18315}
    COP [83]              ; {18319}
    BRL loc_004679        ; {18321}
}

code_004794 {
    COP [81] ( #0B, #04 ) ; {18324}
    COP [83]              ; {18328}
    BRL loc_004679        ; {18330}

  loc_00479D:
    COP [9A] ( #$0020, &code_0047A7, &code_0047AF, &code_0047BC ) ; {18333}
}

code_0047A7 {
    COP [80] ( #10 )      ; {18343}
    COP [82]              ; {18346}
    BRL loc_0046BF        ; {18348}
}

code_0047AF {
    COP [80] ( #10 )      ; {18351}
    COP [82]              ; {18354}
    COP [80] ( #11 )      ; {18356}
    COP [82]              ; {18359}
    BRL loc_004741        ; {18361}
}

code_0047BC {
    COP [80] ( #0D )      ; {18364}
    COP [82]              ; {18367}
    BRL loc_004700        ; {18369}
}

code_0047C4 {
    LDA $0002, X          ; {18372}
    CMP #$01A0            ; {18375}
    BEQ loc_0047E4        ; {18378}
    COP [07] ( #$8000, &code_0047DB ) ; {18380}
    COP [81] ( #08, #04 ) ; {18386}
    COP [83]              ; {18390}
    BRL loc_004741        ; {18392}
}

code_0047DB {
    COP [81] ( #09, #04 ) ; {18395}
    COP [83]              ; {18399}
    BRL loc_004741        ; {18401}

  loc_0047E4:
    COP [9A] ( #$0020, &code_0047EE, &code_0047F6, &code_004803 ) ; {18404}
}

code_0047EE {
    COP [80] ( #13 )      ; {18414}
    COP [82]              ; {18417}
    BRL loc_0046BF        ; {18419}
}

code_0047F6 {
    COP [80] ( #0E )      ; {18422}
    COP [82]              ; {18425}
    COP [80] ( #0F )      ; {18427}
    COP [82]              ; {18430}
    BRL loc_004679        ; {18432}
}

code_004803 {
    COP [80] ( #0E )      ; {18435}
    COP [82]              ; {18438}
    BRL loc_004700        ; {18440}
}

code_00480B {
    COP [07] ( #$8000, &code_004821 ) ; {18443}
    LDA $0000, X          ; {18449}
    CMP #$0070            ; {18452}
    BEQ loc_004830        ; {18455}
    COP [80] ( #06 )      ; {18457}
    COP [82]              ; {18460}
    BRL loc_0046BF        ; {18462}
}

code_004821 {
    LDA $0000, X          ; {18465}
    CMP #$0070            ; {18468}
    BEQ loc_004830        ; {18471}
    COP [80] ( #07 )      ; {18473}
    COP [82]              ; {18476}
    BRA code_004821       ; {18478}

  loc_004830:
    LDA $0016, X          ; {18480}
    ORA #$0300            ; {18483}
    STA $0016, X          ; {18486}
    COP [81] ( #07, #04 ) ; {18489}
    COP [83]              ; {18493}
    BRL loc_004A31        ; {18495}
}

code_004842 {
    COP [07] ( #$8000, &code_004858 ) ; {18498}
    LDA $0000, X          ; {18504}
    CMP #$0160            ; {18507}
    BEQ loc_004867        ; {18510}
    COP [80] ( #04 )      ; {18512}
    COP [82]              ; {18515}
    BRL loc_004700        ; {18517}
}

code_004858 {
    LDA $0000, X          ; {18520}
    CMP #$0160            ; {18523}
    BEQ loc_004867        ; {18526}
    COP [80] ( #05 )      ; {18528}
    COP [82]              ; {18531}
    BRA code_004858       ; {18533}

  loc_004867:
    LDA $0016, X          ; {18535}
    ORA #$0300            ; {18538}
    STA $0016, X          ; {18541}
    COP [81] ( #05, #04 ) ; {18544}
    COP [83]              ; {18548}
    BRL loc_004A4C        ; {18550}
}

code_004879 {
    COP [80] ( #1A )      ; {18553}
    COP [82]              ; {18556}
    COP [B2] ( &code_004BAB, #00, #$0008, #$FFE0, #$0200 ) ; {18558}
    COP [03] ( #11 )      ; {18569}
    COP [04]              ; {18572}
    COP [9A] ( #$0020, &code_004898, &code_0048B0, &code_0048C3 ) ; {18574}
}

code_004898 {
    COP [80] ( #10 )      ; {18584}
    COP [82]              ; {18587}
    COP [80] ( #19 )      ; {18589}
    COP [82]              ; {18592}
    COP [B2] ( &code_004BC1, #00, #$FFFE, #$FFE0, #$0200 ) ; {18594}
    BRL code_00480B       ; {18605}
}

code_0048B0 {
    COP [80] ( #1A )      ; {18608}
    COP [82]              ; {18611}
    COP [B2] ( &code_004BAB, #00, #$0008, #$FFE0, #$0200 ) ; {18613}
    BRL code_00477D       ; {18624}
}

code_0048C3 {
    COP [80] ( #0D )      ; {18627}
    COP [82]              ; {18630}
    COP [80] ( #18 )      ; {18632}
    COP [82]              ; {18635}
    COP [B2] ( &code_004BB6, #00, #$0012, #$FFE0, #$0200 ) ; {18637}
    BRL code_004842       ; {18648}
}

code_0048DB {
    COP [80] ( #19 )      ; {18651}
    COP [82]              ; {18654}
    COP [B2] ( &code_004BC1, #00, #$FFFE, #$FFE0, #$0200 ) ; {18656}
    COP [03] ( #11 )      ; {18667}
    COP [04]              ; {18670}
    COP [9B] ( #$0020, &code_0048FA, &code_004912, &code_004925 ) ; {18672}
}

code_0048FA {
    COP [80] ( #0C )      ; {18682}
    COP [82]              ; {18685}
    COP [80] ( #1A )      ; {18687}
    COP [82]              ; {18690}
    COP [B2] ( &code_004BAB, #00, #$0008, #$FFE0, #$0200 ) ; {18692}
    BRL code_00477D       ; {18703}
}

code_004912 {
    COP [80] ( #19 )      ; {18706}
    COP [82]              ; {18709}
    COP [B2] ( &code_004BC1, #00, #$FFFE, #$FFE0, #$0200 ) ; {18711}
    BRL code_00480B       ; {18722}
}

code_004925 {
    COP [80] ( #12 )      ; {18725}
    COP [82]              ; {18728}
    COP [80] ( #1B )      ; {18730}
    COP [82]              ; {18733}
    COP [B2] ( &code_004BCC, #00, #$0008, #$FFE2, #$0200 ) ; {18735}
    BRL code_0047C4       ; {18746}
}

code_00493D {
    COP [80] ( #18 )      ; {18749}
    COP [82]              ; {18752}
    COP [B2] ( &code_004BB6, #00, #$0012, #$FFE0, #$0200 ) ; {18754}
    COP [03] ( #11 )      ; {18765}
    COP [04]              ; {18768}
    COP [9B] ( #$0020, &code_00495C, &code_004974, &code_004987 ) ; {18770}
}

code_00495C {
    COP [80] ( #0F )      ; {18780}
    COP [82]              ; {18783}
    COP [80] ( #1A )      ; {18785}
    COP [82]              ; {18788}
    COP [B2] ( &code_004BAB, #00, #$0008, #$FFE0, #$0200 ) ; {18790}
    BRL code_00477D       ; {18801}
}

code_004974 {
    COP [80] ( #18 )      ; {18804}
    COP [82]              ; {18807}
    COP [B2] ( &code_004BB6, #00, #$0012, #$FFE0, #$0200 ) ; {18809}
    BRL code_004842       ; {18820}
}

code_004987 {
    COP [80] ( #12 )      ; {18823}
    COP [82]              ; {18826}
    COP [80] ( #1B )      ; {18828}
    COP [82]              ; {18831}
    COP [B2] ( &code_004BCC, #00, #$0008, #$FFE2, #$0200 ) ; {18833}
    BRL code_0047C4       ; {18844}
}

code_00499F {
    COP [80] ( #1B )      ; {18847}
    COP [82]              ; {18850}
    COP [B2] ( &code_004BCC, #00, #$0008, #$FFE2, #$0200 ) ; {18852}
    COP [03] ( #11 )      ; {18863}
    COP [04]              ; {18866}
    COP [9A] ( #$0020, &code_0049BE, &code_0049D6, &code_0049E9 ) ; {18868}
}

code_0049BE {
    COP [80] ( #13 )      ; {18878}
    COP [82]              ; {18881}
    COP [80] ( #19 )      ; {18883}
    COP [82]              ; {18886}
    COP [B2] ( &code_004BC1, #00, #$FFFE, #$FFE0, #$0200 ) ; {18888}
    BRL code_00480B       ; {18899}
}

code_0049D6 {
    COP [80] ( #1B )      ; {18902}
    COP [82]              ; {18905}
    COP [B2] ( &code_004BCC, #00, #$0008, #$FFE2, #$0200 ) ; {18907}
    BRL code_0047C4       ; {18918}
}

code_0049E9 {
    COP [80] ( #0E )      ; {18921}
    COP [82]              ; {18924}
    COP [80] ( #18 )      ; {18926}
    COP [82]              ; {18929}
    COP [B2] ( &code_004BB6, #00, #$0012, #$FFE0, #$0200 ) ; {18931}
    BRL code_004842       ; {18942}

  loc_004A01:
    LDA $0016, X          ; {18945}
    ORA #$0200            ; {18948}
    STA $0016, X          ; {18951}
    COP [80] ( #16 )      ; {18954}
    COP [82]              ; {18957}
    COP [B2] ( &code_004B1C, #00, #$0000, #$FFF0, #$0200 ) ; {18959}
    COP [80] ( #17 )      ; {18970}
    COP [82]              ; {18973}
    COP [81] ( #14, #02 ) ; {18975}
    COP [83]              ; {18979}
    LDA $0016, X          ; {18981}
    AND #$FDFF            ; {18984}
    STA $0016, X          ; {18987}
    BRL loc_004741        ; {18990}

  loc_004A31:
    COP [80] ( #11 )      ; {18993}
    COP [82]              ; {18996}
    BRK #$5F              ; {18998}
    COP [81] ( #22, #10 ) ; {19000}
    COP [83]              ; {19004}
    COP [81] ( #23, #08 ) ; {19006}
    COP [83]              ; {19010}
    COP [03] ( #3D )      ; {19012}
    COP [04]              ; {19015}
    BRL loc_004A67        ; {19017}

  loc_004A4C:
    COP [80] ( #12 )      ; {19020}
    COP [82]              ; {19023}
    BRK #$5F              ; {19025}
    COP [81] ( #22, #10 ) ; {19027}
    COP [83]              ; {19031}
    COP [81] ( #23, #08 ) ; {19033}
    COP [83]              ; {19037}
    COP [03] ( #3D )      ; {19039}
    COP [04]              ; {19042}
    BRL loc_004AA9        ; {19044}

  loc_004A67:
    JSR $&code_004AEB     ; {19047}
    STA $0002, X          ; {19050}
    LDA #$0030            ; {19053}
    STA $0000, X          ; {19056}
    BRK #$5F              ; {19059}
    COP [81] ( #23, #08 ) ; {19061}
    COP [83]              ; {19065}
    COP [81] ( #22, #10 ) ; {19067}
    COP [83]              ; {19071}
    LDA $0025, X          ; {19073}
    AND #$00FF            ; {19076}
    STA $0030, X          ; {19079}
    COP [09] ( #$0000 )   ; {19082}
    COP [09] ( #$0001 )   ; {19086}
    LDA $0016, X          ; {19090}
    AND #$FCFF            ; {19093}
    STA $0016, X          ; {19096}
    COP [80] ( #0E )      ; {19099}
    COP [82]              ; {19102}
    COP [81] ( #04, #04 ) ; {19104}
    COP [83]              ; {19108}
    BRL loc_004700        ; {19110}

  loc_004AA9:
    JSR $&code_004AEB     ; {19113}
    STA $0002, X          ; {19116}
    LDA #$01A0            ; {19119}
    STA $0000, X          ; {19122}
    BRK #$5F              ; {19125}
    COP [81] ( #23, #08 ) ; {19127}
    COP [83]              ; {19131}
    COP [81] ( #22, #10 ) ; {19133}
    COP [83]              ; {19137}
    LDA $0025, X          ; {19139}
    AND #$00FF            ; {19142}
    STA $0030, X          ; {19145}
    COP [09] ( #$0000 )   ; {19148}
    COP [09] ( #$0001 )   ; {19152}
    LDA $0016, X          ; {19156}
    AND #$FCFF            ; {19159}
    STA $0016, X          ; {19162}
    COP [80] ( #13 )      ; {19165}
    COP [82]              ; {19168}
    COP [81] ( #06, #04 ) ; {19170}
    COP [83]              ; {19174}
    BRL loc_0046BF        ; {19176}
}

code_004AEB {
    COP [1F]              ; {19179}
    LDA $0302             ; {19181}
    AND #$00FF            ; {19184}
    LDY #$00A0            ; {19187}
    SEC                   ; {19190}
    SBC #$0033            ; {19191}
    BMI loc_004B1A        ; {19194}
    LDY #$00E0            ; {19196}
    SEC                   ; {19199}
    SBC #$0033            ; {19200}
    BMI loc_004B1A        ; {19203}
    LDY #$0120            ; {19205}
    SEC                   ; {19208}
    SBC #$0033            ; {19209}
    BMI loc_004B1A        ; {19212}
    LDY #$0160            ; {19214}
    SEC                   ; {19217}
    SBC #$0033            ; {19218}
    BMI loc_004B1A        ; {19221}
    LDY #$01A0            ; {19223}

  loc_004B1A:
    TYA                   ; {19226}
    RTS                   ; {19227}
}

code_004B1C {
    COP [A3]              ; {19228}
    COP [80] ( #20 )      ; {19230}
    COP [82]              ; {19233}
    COP [B2] ( &code_004B36, #00, #$0008, #$FFF8, #$0300 ) ; {19235}
    COP [80] ( #21 )      ; {19246}
    COP [82]              ; {19249}
    COP [86]              ; {19251}
    RTL                   ; {19253}
}

code_004B36 {
    BRK #$61              ; {19254}
    COP [80] ( #1C )      ; {19256}
    COP [82]              ; {19259}

  loc_004B3D:
    COP [80] ( #1D )      ; {19261}
    COP [82]              ; {19264}
    LDA $0002, X          ; {19266}
    BPL loc_004B3D        ; {19269}
    COP [80] ( #1D )      ; {19271}
    COP [82]              ; {19274}
    COP [03] ( #0C )      ; {19276}
    BRK #$52              ; {19279}
    COP [B0] ( @code_004B63, #$0300 ) ; {19281}
    COP [1B] ( &code_004B5E, #$000C ) ; {19288}
}

code_004B5E {
    COP [04]              ; {19294}
    COP [86]              ; {19296}
    RTL                   ; {19298}
}

code_004B63 {
    COP [1F]              ; {19299}
    LDA $0302             ; {19301}
    AND #$007F            ; {19304}
    SEC                   ; {19307}
    SBC #$0040            ; {19308}
    CLC                   ; {19311}
    ADC $0374             ; {19312}
    STA $0000, X          ; {19315}
    COP [1F]              ; {19318}
    LDA $0302             ; {19320}
    AND #$007F            ; {19323}
    SEC                   ; {19326}
    SBC #$0040            ; {19327}
    CLC                   ; {19330}
    ADC $0376             ; {19331}
    SEC                   ; {19334}
    SBC #$00FF            ; {19335}
    STA $0002, X          ; {19338}
    COP [81] ( #1E, #10 ) ; {19341}
    COP [83]              ; {19345}
    LDA #$0200            ; {19347}
    STA $0016, X          ; {19350}
    BRK #$5A              ; {19353}
    COP [A4]              ; {19355}
    COP [A1] ( #$FFF8, #$FFF8 ) ; {19357}
    COP [80] ( #1F )      ; {19363}
    COP [82]              ; {19366}
    COP [86]              ; {19368}
    RTL                   ; {19370}
}

code_004BAB {
    BRK #$5D              ; {19371}
    COP [97]              ; {19373}
    COP [80] ( #02 )      ; {19375}
    COP [82]              ; {19378}
    BRA loc_004BD7        ; {19380}
}

code_004BB6 {
    BRK #$5D              ; {19382}
    COP [96]              ; {19384}
    COP [80] ( #00 )      ; {19386}
    COP [82]              ; {19389}
    BRA loc_004BD7        ; {19391}
}

code_004BC1 {
    BRK #$5D              ; {19393}
    COP [97]              ; {19395}
    COP [80] ( #00 )      ; {19397}
    COP [82]              ; {19400}
    BRA loc_004BD7        ; {19402}
}

code_004BCC {
    BRK #$5D              ; {19404}
    COP [A3]              ; {19406}
    COP [97]              ; {19408}
    COP [80] ( #01 )      ; {19410}
    COP [82]              ; {19413}

  loc_004BD7:
    COP [A3]              ; {19415}
    COP [81] ( #03, #03 ) ; {19417}
    COP [83]              ; {19421}
    LDY #$0003            ; {19423}
    SEP #$20              ; {19426}
    LDA #$^code_002D67    ; {19428}
    PHA                   ; {19430}
    REP #$20              ; {19431}
    LDA #$&code_002D67-1  ; {19433}
    PHA                   ; {19436}
    RTL                   ; {19437}
}

code_004BEE {
    INC $0458             ; {19438}
    STX $039A             ; {19441}
    COP [85] ( @code_004D09 ) ; {19444}

  loc_004BF9:
    COP [80] ( #08 )      ; {19449}
    COP [82]              ; {19452}

  loc_004BFE:
    COP [9B] ( #$0070, &code_004C08, &code_004C08, &code_004C0F ) ; {19454}
}

code_004C08 {
    COP [80] ( #09 )      ; {19464}
    COP [82]              ; {19467}
    BRA loc_004BFE        ; {19469}
}

code_004C0F {
    COP [80] ( #0A )      ; {19471}
    COP [82]              ; {19474}
    COP [87]              ; {19476}
    COP [80] ( #03 )      ; {19478}
    COP [82]              ; {19481}
    COP [80] ( #04 )      ; {19483}
    COP [82]              ; {19486}

  loc_004C20:
    COP [81] ( #00, #02 ) ; {19488}
    COP [83]              ; {19492}
    COP [1F]              ; {19494}
    LDA $0302             ; {19496}
    AND #$0007            ; {19499}
    CMP #$0005            ; {19502}
    BCS loc_004C4D        ; {19505}
    COP [80] ( #0E )      ; {19507}
    COP [82]              ; {19510}
    BRK #$56              ; {19512}
    COP [81] ( #0F, #0D ) ; {19514}
    COP [83]              ; {19518}
    COP [80] ( #10 )      ; {19520}
    COP [82]              ; {19523}
    COP [80] ( #02 )      ; {19525}
    COP [82]              ; {19528}
    BRL loc_004BF9        ; {19530}

  loc_004C4D:
    COP [80] ( #01 )      ; {19533}
    COP [82]              ; {19536}
    COP [80] ( #1B )      ; {19538}
    COP [82]              ; {19541}

  loc_004C57:
    LDA $0000, X          ; {19543}
    CMP #$00F0            ; {19546}
    BEQ loc_004CA0        ; {19549}
    CMP #$01E0            ; {19551}
    BEQ loc_004CA0        ; {19554}
    COP [9A] ( #$0018, &code_004C6E, &code_004C75, &code_004C6E ) ; {19556}
}

code_004C6E {
    COP [80] ( #1B )      ; {19566}
    COP [82]              ; {19569}
    BRA loc_004C57        ; {19571}
}

code_004C75 {
    COP [80] ( #04 )      ; {19573}
    COP [82]              ; {19576}
    COP [B2] ( &code_004CAA, #00, #$0008, #$0008, #$0200 ) ; {19578}
    COP [80] ( #00 )      ; {19589}
    COP [82]              ; {19592}
    BRA code_004C6E       ; {19594}

  loc_004C8C:
    LDA $0000, X          ; {19596}
    CMP #$00F0            ; {19599}
    BEQ loc_004CA0        ; {19602}
    CMP #$01E0            ; {19604}
    BEQ loc_004CA0        ; {19607}
    COP [80] ( #1B )      ; {19609}
    COP [82]              ; {19612}
    BRA loc_004C8C        ; {19614}

  loc_004CA0:
    COP [80] ( #04 )      ; {19616}
    COP [82]              ; {19619}
    COP [87]              ; {19621}
    BRL loc_004C20        ; {19623}
}

code_004CAA {
    COP [80] ( #18 )      ; {19626}
    COP [82]              ; {19629}
    COP [80] ( #19 )      ; {19631}
    COP [82]              ; {19634}
    COP [80] ( #1A )      ; {19636}
    COP [82]              ; {19639}
    BRK #$65              ; {19641}
    COP [B0] ( @code_004CCF, #$0200 ) ; {19643}
    COP [80] ( #19 )      ; {19650}
    COP [82]              ; {19653}
    COP [80] ( #18 )      ; {19655}
    COP [82]              ; {19658}
    COP [86]              ; {19660}
    RTL                   ; {19662}
}

code_004CCF {
    COP [81] ( #17, #02 ) ; {19663}
    COP [83]              ; {19667}
    COP [B0] ( @code_004CDF, #$0200 ) ; {19669}
    COP [86]              ; {19676}
    RTL                   ; {19678}
}

code_004CDF {
    COP [80] ( #16 )      ; {19679}
    COP [82]              ; {19682}
    COP [9B] ( #$0000, &code_004CEE, &code_004CF6, &code_004CF6 ) ; {19684}
}

code_004CEE {
    LDA $0016, X          ; {19694}
    BIT #$8000            ; {19697}
    BNE loc_004D06        ; {19700}
}

code_004CF6 {
    COP [B2] ( &code_004CDF, #00, #$0000, #$0010, #$0200 ) ; {19702}
    COP [80] ( #1C )      ; {19713}
    COP [82]              ; {19716}

  loc_004D06:
    COP [86]              ; {19718}
    RTL                   ; {19720}
}

code_004D09 {
    LDY $039A             ; {19721}
    LDA $0025, Y          ; {19724}
    AND #$00FF            ; {19727}
    STA $0030, X          ; {19730}
    COP [91]              ; {19733}
    LDY $039A             ; {19735}
    LDA $0016, Y          ; {19738}
    BIT #$0400            ; {19741}
    BNE loc_004D5C        ; {19744}
    LDA $0025, Y          ; {19746}
    AND #$00FF            ; {19749}
    CMP $0030, X          ; {19752}
    BNE loc_004D2E        ; {19755}
    RTL                   ; {19757}

  loc_004D2E:
    LDA $0000, Y          ; {19758}
    STA $0000, X          ; {19761}
    LDA $0002, Y          ; {19764}
    SEC                   ; {19767}
    SBC #$0008            ; {19768}
    STA $0002, X          ; {19771}
    COP [B0] ( @code_004D5F, #$0300 ) ; {19774}
    COP [B0] ( @code_004D5F, #$0300 ) ; {19781}
    COP [B0] ( @code_004D6B, #$0300 ) ; {19788}
    COP [B0] ( @code_004D6B, #$0300 ) ; {19795}
    BRA code_004D09       ; {19802}

  loc_004D5C:
    COP [86]              ; {19804}
    RTL                   ; {19806}
}

code_004D5F {
    JSR $&code_004D77     ; {19807}
    COP [81] ( #14, #04 ) ; {19810}
    COP [83]              ; {19814}
    COP [86]              ; {19816}
    RTL                   ; {19818}
}

code_004D6B {
    JSR $&code_004D77     ; {19819}
    COP [81] ( #15, #04 ) ; {19822}
    COP [83]              ; {19826}
    COP [86]              ; {19828}
    RTL                   ; {19830}
}

code_004D77 {
    COP [1F]              ; {19831}
    COP [35] ( #30 )      ; {19833}
    LDA $0437             ; {19836}
    SEC                   ; {19839}
    SBC #$0010            ; {19840}
    CLC                   ; {19843}
    ADC $0000             ; {19844}
    STA $0000, X          ; {19847}
    RTS                   ; {19850}
}

code_004D8B {
    STX $039A             ; {19851}
    LDA $001A, X          ; {19854}
    ORA #$0200            ; {19857}
    STA $001A, X          ; {19860}
    COP [9F] ( #$0008 )   ; {19863}
    COP [91]              ; {19867}
    LDY $039C             ; {19869}
    LDA $0002, Y          ; {19872}
    CMP #$0080            ; {19875}
    BCC loc_004DA9        ; {19878}
    RTL                   ; {19880}

  loc_004DA9:
    COP [85] ( @code_003188 ) ; {19881}
    LDA #$0004            ; {19886}
    STA $0030, Y          ; {19889}
    COP [1B] ( &code_004DBA, #$0004 ) ; {19892}
}

code_004DBA {
    LDA #$2FC0            ; {19898}
    TSB $0326             ; {19901}
    BRK #$A0              ; {19904}
    COP [80] ( #01 )      ; {19906}
    COP [82]              ; {19909}
    LDA #$0100            ; {19911}
    STA $0344             ; {19914}
    COP [01] ( &asciistring_004EF8 ) ; {19917}
    LDA #$2FC0            ; {19921}
    TRB $0326             ; {19924}
    LDA $0016, X          ; {19927}
    AND #$FDFF            ; {19930}
    STA $0016, X          ; {19933}
    COP [32] ( #0D )      ; {19936}
    BRA loc_004E44        ; {19939}

  loc_004DE5:
    COP [1F]              ; {19941}
    COP [35] ( #A0 )      ; {19943}
    LDA $0437             ; {19946}
    CLC                   ; {19949}
    ADC #$0028            ; {19950}
    STA $0000, X          ; {19953}
    LDA #$0060            ; {19956}
    STA $0002, X          ; {19959}
    COP [80] ( #01 )      ; {19962}
    COP [82]              ; {19965}
    LDA $0016, X          ; {19967}
    AND #$FDFF            ; {19970}
    STA $0016, X          ; {19973}
    COP [80] ( #02 )      ; {19976}
    COP [82]              ; {19979}
    BRK #$4B              ; {19981}
    COP [B2] ( &code_004E4B, #00, #$0000, #$FFEE, #$0200 ) ; {19983}
    COP [B2] ( &code_004E8A, #00, #$0000, #$FFEE, #$0200 ) ; {19994}
    COP [B2] ( &code_004EC9, #00, #$0000, #$FFEE, #$0200 ) ; {20005}
    COP [80] ( #03 )      ; {20016}
    COP [82]              ; {20019}
    COP [1B] ( &code_004E3B, #$0050 ) ; {20021}
}

code_004E3B {
    LDA $0016, X          ; {20027}
    ORA #$0200            ; {20030}
    STA $0016, X          ; {20033}

  loc_004E44:
    COP [80] ( #04 )      ; {20036}
    COP [82]              ; {20039}
    BRA loc_004DE5        ; {20041}
}

code_004E4B {
    COP [A3]              ; {20043}
    COP [97]              ; {20045}
    COP [90]              ; {20047}
    COP [88]              ; {20049}

  loc_004E53:
    COP [9A] ( #$0020, &code_004E5D, &code_004E64, &code_004E64 ) ; {20051}
}

code_004E5D {
    COP [80] ( #0A )      ; {20061}
    COP [82]              ; {20064}
    BRA loc_004E53        ; {20066}
}

code_004E64 {
    COP [80] ( #05 )      ; {20068}
    COP [82]              ; {20071}

  loc_004E69:
    COP [9B] ( #$0020, &code_004E73, &code_004E7A, &code_004E73 ) ; {20073}
}

code_004E73 {
    COP [80] ( #09 )      ; {20083}
    COP [82]              ; {20086}
    BRA loc_004E69        ; {20088}
}

code_004E7A {
    COP [96]              ; {20090}
    COP [80] ( #06 )      ; {20092}
    COP [82]              ; {20095}
    COP [81] ( #0A, #10 ) ; {20097}
    COP [83]              ; {20101}
    COP [86]              ; {20103}
    RTL                   ; {20105}
}

code_004E8A {
    COP [A3]              ; {20106}
    COP [96]              ; {20108}
    COP [90]              ; {20110}
    COP [88]              ; {20112}

  loc_004E92:
    COP [9A] ( #$0020, &code_004EA3, &code_004EA3, &code_004E9C ) ; {20114}
}

code_004E9C {
    COP [80] ( #0A )      ; {20124}
    COP [82]              ; {20127}
    BRA loc_004E92        ; {20129}
}

code_004EA3 {
    COP [80] ( #05 )      ; {20131}
    COP [82]              ; {20134}

  loc_004EA8:
    COP [9B] ( #$0020, &code_004EB2, &code_004EB9, &code_004EB2 ) ; {20136}
}

code_004EB2 {
    COP [80] ( #09 )      ; {20146}
    COP [82]              ; {20149}
    BRA loc_004EA8        ; {20151}
}

code_004EB9 {
    COP [97]              ; {20153}
    COP [80] ( #06 )      ; {20155}
    COP [82]              ; {20158}
    COP [81] ( #0A, #10 ) ; {20160}
    COP [83]              ; {20164}
    COP [86]              ; {20166}
    RTL                   ; {20168}
}

code_004EC9 {
    COP [A3]              ; {20169}
    COP [97]              ; {20171}

  loc_004ECD:
    COP [9B] ( #$0020, &code_004EDE, &code_004EDE, &code_004ED7 ) ; {20173}
}

code_004ED7 {
    COP [80] ( #08 )      ; {20183}
    COP [82]              ; {20186}
    BRA loc_004ECD        ; {20188}
}

code_004EDE {
    COP [9A] ( #$0000, &code_004EEA, &code_004EEA, &code_004EE8 ) ; {20190}
}

code_004EE8 {
    COP [96]              ; {20200}
}

code_004EEA {
    COP [80] ( #07 )      ; {20202}
    COP [82]              ; {20205}
    COP [81] ( #0B, #08 ) ; {20207}
    COP [83]              ; {20211}
    COP [86]              ; {20213}
    RTL                   ; {20215}
}

asciistring_004EF8 |[10]The poor creature that[N]repeats transmigration[N]of the soul and cannot[N]die- [FIN]I will put you in [N]a deep sleep- [12][08:408][END]|

code_004F4D {
    LDY $039A             ; {20301}
    LDA $0016, Y          ; {20304}
    BIT #$0400            ; {20307}
    BNE loc_004F59        ; {20310}
    RTL                   ; {20312}

  loc_004F59:
    STX $039A             ; {20313}
    LDA $0000, Y          ; {20316}
    STA $0000, X          ; {20319}
    LDA $0002, Y          ; {20322}
    STA $0002, X          ; {20325}
    COP [1B] ( &code_004F6E, #$00B4 ) ; {20328}
}

code_004F6E {
    LDA $0016, X          ; {20334}
    AND #$DFFF            ; {20337}
    STA $0016, X          ; {20340}
    COP [85] ( @code_004F9E ) ; {20343}

  code_004F7C:
    COP [80] ( #1F )      ; {20348}
    COP [82]              ; {20351}
    COP [08] ( #$8000, &code_004F7C ) ; {20353}
    COP [85] ( @code_004FA9 ) ; {20359}
    COP [81] ( #1F, #03 ) ; {20364}
    COP [83]              ; {20368}
    COP [10] ( #$0215, #01, #$0078, #$00C8 ) ; {20370}
    COP [91]              ; {20379}
    RTL                   ; {20381}
}

code_004F9E {
    COP [01] ( &asciistring_004FB6 ) ; {20382}
    COP [09] ( #$8000 )   ; {20386}
    COP [86]              ; {20390}
    RTL                   ; {20392}
}

code_004FA9 {
    COP [A8] ( #$8000, #0D ) ; {20393}
    COP [92] ( #48 )      ; {20398}
    COP [94]              ; {20401}
    COP [86]              ; {20403}
    RTL                   ; {20405}
}

asciistring_004FB6 |[10]Some people believe [N]being constantly [N]reincarnated means [N]everlasting suffering-[FIN]Being alive is [N]suffering for some [N]creatures- [FIN]You will find out what[N]I mean- [12][08:408][END]|

code_005043 {
    STX $039A             ; {20547}
    LDA $001A, X          ; {20550}
    ORA #$0200            ; {20553}
    STA $001A, X          ; {20556}
    STZ $0466             ; {20559}
    COP [85] ( @code_0055C6 ) ; {20562}
    COP [AC] ( @code_005344, #$0038, #$0070, #$0200 ) ; {20567}
    COP [AC] ( @code_00534C, #$00B8, #$0070, #$0200 ) ; {20578}
    COP [AC] ( @code_0051C4, #$0038, #$0040, #$0200 ) ; {20589}
    COP [AC] ( @code_0051F2, #$00B8, #$0040, #$0200 ) ; {20600}
    COP [03] ( #3D )      ; {20611}
    COP [04]              ; {20614}
    BRA loc_0050ED        ; {20616}

  loc_00508A:
    COP [91]              ; {20618}
    LDA $1A5E             ; {20620}
    AND #$00FF            ; {20623}
    CMP #$0004            ; {20626}
    BEQ loc_005098        ; {20629}
    RTL                   ; {20631}

  loc_005098:
    SEP #$20              ; {20632}
    STZ $1A5E             ; {20634}
    REP #$20              ; {20637}
    COP [80] ( #14 )      ; {20639}
    COP [82]              ; {20642}
    LDA $0016, X          ; {20644}
    AND #$FDFF            ; {20647}
    STA $0016, X          ; {20650}
    COP [80] ( #12 )      ; {20653}
    COP [82]              ; {20656}
    COP [B0] ( @code_0051B6, #$0300 ) ; {20658}
    COP [80] ( #13 )      ; {20665}
    COP [82]              ; {20668}
    COP [B2] ( &code_005194, #00, #$0008, #$0010, #$0200 ) ; {20670}
    COP [B2] ( &code_0051A4, #00, #$0008, #$0010, #$0200 ) ; {20681}
    COP [B2] ( &code_0051B2, #00, #$0008, #$0010, #$0200 ) ; {20692}
    LDA $0016, X          ; {20703}
    ORA #$0200            ; {20706}
    STA $0016, X          ; {20709}
    COP [80] ( #15 )      ; {20712}
    COP [82]              ; {20715}

  loc_0050ED:
    COP [03] ( #04 )      ; {20717}
    COP [B0] ( @code_005101, #$0301 ) ; {20720}
    COP [1B] ( &code_0050FD, #$0028 ) ; {20727}
}

code_0050FD {
    COP [04]              ; {20733}
    BRA loc_00508A        ; {20735}
}

code_005101 {
    LDA $001A, X          ; {20737}
    ORA #$0100            ; {20740}
    STA $001A, X          ; {20743}
    COP [1F]              ; {20746}
    COP [35] ( #A0 )      ; {20748}
    LDA $0437             ; {20751}
    CLC                   ; {20754}
    ADC #$0020            ; {20755}
    STA $0000, X          ; {20758}
    COP [1F]              ; {20761}
    COP [35] ( #1E )      ; {20763}
    LDA $0437             ; {20766}
    CLC                   ; {20769}
    ADC #$00B0            ; {20770}
    STA $0002, X          ; {20773}
    SEP #$20              ; {20776}
    LDA #$FF              ; {20778}
    STA $0025, X          ; {20780}
    REP #$20              ; {20783}
    COP [80] ( #16 )      ; {20785}
    COP [82]              ; {20788}
    LDA $0016, X          ; {20790}
    AND #$FCFF            ; {20793}
    STA $0016, X          ; {20796}

  loc_00513F:
    LDA $0025, X          ; {20799}
    AND #$00FF            ; {20802}
    CMP #$00FC            ; {20805}
    BCC loc_005151        ; {20808}
    COP [80] ( #17 )      ; {20810}
    COP [82]              ; {20813}
    BRA loc_00513F        ; {20815}

  loc_005151:
    LDA $0016, X          ; {20817}
    ORA #$0300            ; {20820}
    STA $0016, X          ; {20823}
    COP [80] ( #18 )      ; {20826}
    COP [82]              ; {20829}
    SEP #$20              ; {20831}
    INC $1A5E             ; {20833}
    REP #$20              ; {20836}
    COP [B0] ( @code_005170, #$4000 ) ; {20838}
    COP [86]              ; {20845}
    RTL                   ; {20847}
}

code_005170 {
    COP [A8] ( #$8000, #0E ) ; {20848}
    LDA $0005             ; {20853}
    STA $001E, X          ; {20856}
    STZ $0020, X          ; {20859}
    LDA $0372             ; {20862}
    STA $001C, X          ; {20865}
    COP [A4]              ; {20868}
    COP [80] ( #05 )      ; {20870}
    COP [82]              ; {20873}
    COP [81] ( #0A, #04 ) ; {20875}
    COP [83]              ; {20879}
    COP [86]              ; {20881}
    RTL                   ; {20883}
}

code_005194 {
    BRK #$51              ; {20884}
    COP [80] ( #1A )      ; {20886}
    COP [82]              ; {20889}
    COP [81] ( #1C, #08 ) ; {20891}
    COP [83]              ; {20895}
    COP [86]              ; {20897}
    RTL                   ; {20899}
}

code_0051A4 {
    COP [80] ( #1B )      ; {20900}
    COP [82]              ; {20903}
    COP [81] ( #1C, #08 ) ; {20905}
    COP [83]              ; {20909}
    COP [86]              ; {20911}
    RTL                   ; {20913}
}

code_0051B2 {
    COP [96]              ; {20914}
    BRA code_0051A4       ; {20916}
}

code_0051B6 {
    COP [A3]              ; {20918}
    COP [A0] ( #$FFFE )   ; {20920}
    COP [80] ( #19 )      ; {20924}
    COP [82]              ; {20927}
    COP [86]              ; {20929}
    RTL                   ; {20931}
}

code_0051C4 {
    COP [81] ( #0E, #0E ) ; {20932}
    COP [83]              ; {20936}
    COP [80] ( #0D )      ; {20938}
    COP [82]              ; {20941}
    BRK #$4B              ; {20943}
    COP [B0] ( @code_005220, #$0200 ) ; {20945}
    COP [1B] ( &code_0051DE, #$0002 ) ; {20952}
}

code_0051DE {
    COP [03] ( #03 )      ; {20958}
    COP [B0] ( @code_00526F, #$0200 ) ; {20961}
    COP [1B] ( &code_0051EE, #$0003 ) ; {20968}
}

code_0051EE {
    COP [04]              ; {20974}
    BRA code_0051C4       ; {20976}
}

code_0051F2 {
    COP [81] ( #0E, #0E ) ; {20978}
    COP [83]              ; {20982}
    COP [80] ( #0D )      ; {20984}
    COP [82]              ; {20987}
    BRK #$4B              ; {20989}
    COP [B0] ( @code_0052B2, #$0200 ) ; {20991}
    COP [1B] ( &code_00520C, #$0002 ) ; {20998}
}

code_00520C {
    COP [03] ( #03 )      ; {21004}
    COP [B0] ( @code_005301, #$0200 ) ; {21007}
    COP [1B] ( &code_00521C, #$0003 ) ; {21014}
}

code_00521C {
    COP [04]              ; {21020}
    BRA code_0051F2       ; {21022}
}

code_005220 {
    LDA $0016, X          ; {21024}
    BIT #$8000            ; {21027}
    BNE loc_00526C        ; {21030}
    COP [81] ( #0C, #02 ) ; {21032}
    COP [83]              ; {21036}
    COP [9A] ( #$0000, &code_005238, &code_005252, &code_005252 ) ; {21038}
}

code_005238 {
    COP [09] ( #$9906 )   ; {21048}
    COP [A1] ( #$FFF8, #$0008 ) ; {21052}
    COP [97]              ; {21058}
    COP [81] ( #1D, #02 ) ; {21060}
    COP [83]              ; {21064}
    COP [A1] ( #$FFF8, #$0008 ) ; {21066}
    BRA code_005220       ; {21072}
}

code_005252 {
    COP [09] ( #$1906 )   ; {21074}
    COP [A1] ( #$0008, #$0008 ) ; {21078}
    COP [96]              ; {21084}
    COP [81] ( #1D, #02 ) ; {21086}
    COP [83]              ; {21090}
    COP [A1] ( #$0008, #$0008 ) ; {21092}
    BRA code_005220       ; {21098}

  loc_00526C:
    COP [86]              ; {21100}
    RTL                   ; {21102}
}

code_00526F {
    LDA $0016, X          ; {21103}
    BIT #$8000            ; {21106}
    BNE loc_0052AF        ; {21109}
    COP [81] ( #0C, #02 ) ; {21111}
    COP [83]              ; {21115}
    COP [07] ( #$1906, &code_005299 ) ; {21117}
    COP [A1] ( #$FFF8, #$0008 ) ; {21123}
    COP [97]              ; {21129}
    COP [81] ( #1D, #02 ) ; {21131}
    COP [83]              ; {21135}
    COP [A1] ( #$FFF8, #$0008 ) ; {21137}
    BRA code_00526F       ; {21143}
}

code_005299 {
    COP [A1] ( #$0008, #$0008 ) ; {21145}
    COP [96]              ; {21151}
    COP [81] ( #1D, #02 ) ; {21153}
    COP [83]              ; {21157}
    COP [A1] ( #$0008, #$0008 ) ; {21159}
    BRA code_00526F       ; {21165}

  loc_0052AF:
    COP [86]              ; {21167}
    RTL                   ; {21169}
}

code_0052B2 {
    LDA $0016, X          ; {21170}
    BIT #$8000            ; {21173}
    BNE loc_0052FE        ; {21176}
    COP [81] ( #0C, #02 ) ; {21178}
    COP [83]              ; {21182}
    COP [9A] ( #$0000, &code_0052CA, &code_0052E4, &code_0052E4 ) ; {21184}
}

code_0052CA {
    COP [09] ( #$9907 )   ; {21194}
    COP [A1] ( #$FFF8, #$0008 ) ; {21198}
    COP [97]              ; {21204}
    COP [81] ( #1D, #02 ) ; {21206}
    COP [83]              ; {21210}
    COP [A1] ( #$FFF8, #$0008 ) ; {21212}
    BRA code_0052B2       ; {21218}
}

code_0052E4 {
    COP [09] ( #$1907 )   ; {21220}
    COP [A1] ( #$0008, #$0008 ) ; {21224}
    COP [96]              ; {21230}
    COP [81] ( #1D, #02 ) ; {21232}
    COP [83]              ; {21236}
    COP [A1] ( #$0008, #$0008 ) ; {21238}
    BRA code_0052B2       ; {21244}

  loc_0052FE:
    COP [86]              ; {21246}
    RTL                   ; {21248}
}

code_005301 {
    LDA $0016, X          ; {21249}
    BIT #$8000            ; {21252}
    BNE loc_005341        ; {21255}
    COP [81] ( #0C, #02 ) ; {21257}
    COP [83]              ; {21261}
    COP [07] ( #$1907, &code_00532B ) ; {21263}
    COP [A1] ( #$FFF8, #$0008 ) ; {21269}
    COP [97]              ; {21275}
    COP [81] ( #1D, #02 ) ; {21277}
    COP [83]              ; {21281}
    COP [A1] ( #$FFF8, #$0008 ) ; {21283}
    BRA code_005301       ; {21289}
}

code_00532B {
    COP [A1] ( #$0008, #$0008 ) ; {21291}
    COP [96]              ; {21297}
    COP [81] ( #1D, #02 ) ; {21299}
    COP [83]              ; {21303}
    COP [A1] ( #$0008, #$0008 ) ; {21305}
    BRA code_005301       ; {21311}

  loc_005341:
    COP [86]              ; {21313}
    RTL                   ; {21315}
}

code_005344 {
    COP [80] ( #11 )      ; {21316}
    COP [82]              ; {21319}
    COP [91]              ; {21321}
    RTL                   ; {21323}
}

code_00534C {
    COP [80] ( #10 )      ; {21324}
    COP [82]              ; {21327}
    COP [91]              ; {21329}
    RTL                   ; {21331}
}
---------------------------------------------

code_005354 {
    SEP #$20              ; {21332}
    LDA #$00              ; {21334}
    STA $0036, X          ; {21336}
    REP #$20              ; {21339}
    LDA #$2010            ; {21341}
    STA $0016, X          ; {21344}
    INC $0466             ; {21347}
    COP [37]              ; {21350}
    COP [31] ( #00 )      ; {21352}
    COP [03] ( #F1 )      ; {21355}
    COP [04]              ; {21358}
    LDA $0016, X          ; {21360}
    AND #$FFEF            ; {21363}
    STA $0016, X          ; {21366}
    COP [01] ( &asciistring_0053C6 ) ; {21369}
    LDA $1B82             ; {21373}
    AND #$001F            ; {21376}
    DEC                   ; {21379}
    BEQ loc_00538C        ; {21380}
    COP [01] ( &asciistring_00543B ) ; {21382}
    BRA loc_005390        ; {21386}

  loc_00538C:
    COP [01] ( &asciistring_00540B ) ; {21388}

  loc_005390:
    SEP #$20              ; {21392}
    STZ $1B82             ; {21394}
    REP #$20              ; {21397}
    COP [03] ( #3D )      ; {21399}
    COP [04]              ; {21402}
    COP [01] ( &asciistring_005593 ) ; {21404}
    COP [85] ( @code_0055B9 ) ; {21408}
    COP [03] ( #F1 )      ; {21413}
    COP [04]              ; {21416}
    COP [09] ( #$9F02 )   ; {21418}
    LDA #$0006            ; {21422}
    STA $1B84             ; {21425}
    LDA #$0001            ; {21428}
    STA $031E             ; {21431}
    COP [10] ( #$0700, #01, #$0070, #$0060 ) ; {21434}
    COP [91]              ; {21443}
    RTL                   ; {21445}
}

asciistring_0053C6 |[10]Finally, [02:2] [N]defeated Deathtoll! [FIN]Suddenly [02:2][N]heard a small voice- [FIN][END]|

asciistring_00540B |[10][02:2],I decided to [N]stay here and seal the[N]World of Evil- [FIN][JMP:&asciistring_00543B+M]|

asciistring_00543B |[10][02:2], we decided [N]to stay here and seal [N]the World of Evil-----[FIN][::]The World of Evil is [N]a dark world that [N]exists in the back of [N]creatures  minds- [FIN]As long as there are [N]inventions in this [N]world the same thing [N]will happen- [FIN]I will stay and try to[N]stop as much as [N]possible- [FIN]You are still young, [N]you should experience [N]more- [FIN]And if you figure out [N]reasons for, [N]all feelings, [FIN]all connections [FIN]and existences, [N]you will be wise like [N]the Master- [FIN][02:2], get going- [12][08:408][END]|

asciistring_005593 |[10]The World of Evil [N]began to disappear- [12][08:408][END]|

code_0055B9 {
    COP [A8] ( #$8000, #0D ) ; {21945}
    COP [92] ( #4D )      ; {21950}
    COP [94]              ; {21953}
    COP [86]              ; {21955}
    RTL                   ; {21957}
}

code_0055C6 {
    LDA $0016, X          ; {21958}
    ORA #$0010            ; {21961}
    STA $0016, X          ; {21964}
    COP [91]              ; {21967}
    SEP #$20              ; {21969}
    LDA $0466             ; {21971}
    BNE loc_0055E6        ; {21974}
    LDA #$2C              ; {21976}
    XBA                   ; {21978}
    LDA #$^binary_0055F5  ; {21979}
    LDY #$&binary_0055F5+4 ; {21981}
    JSL $@chunk_010000.code_01188A ; {21984}
    BRA loc_0055F2        ; {21988}

  loc_0055E6:
    LDA #$2C              ; {21990}
    XBA                   ; {21992}
    LDA #$^binary_0055F5  ; {21993}
    LDY #$&binary_0055F5  ; {21995}
    JSL $@chunk_010000.code_01188A ; {21998}

  loc_0055F2:
    REP #$20              ; {22002}
    RTL                   ; {22004}
}
---------------------------------------------

binary_0055F5 #7F161016011700
---------------------------------------------

native_mode_cop_00561E {
    SEP #$20              ; {22046}
    TXY                   ; {22048}
    LDA $04, S            ; {22049}
    STA $3A               ; {22051}
    REP #$20              ; {22053}
    LDA $02, S            ; {22055}
    DEC                   ; {22057}
    STA $38               ; {22058}
    LDA [$38]             ; {22060}
    INC $38               ; {22062}
    AND #$00FF            ; {22064}
    ASL                   ; {22067}
    TAX                   ; {22068}
    JMP ($&code_list_005638, X) ; {22069}
}

code_list_005638 [
  &code_00579E   ;00
  &code_0057A2   ;01
  &code_0057BD   ;02
  &code_0057F5   ;03
  &code_00580B   ;04
  &code_00581D   ;05
  &code_005838   ;06
  &code_00583E   ;07
  &code_005843   ;08
  &code_005867   ;09
  &code_005874   ;0A
  &code_005888   ;0B
  &code_0058A9   ;0C
  &code_00590D   ;0D
  #$0000   ;0E
  #$0000   ;0F
  &code_005946   ;10
  &code_005970   ;11
  &code_00599E   ;12
  &code_0059B5   ;13
  &code_0059CC   ;14
  &code_0059F4   ;15
  &code_0059FB   ;16
  &code_005A02   ;17
  &code_005A0F   ;18
  &code_005A28   ;19
  &code_005A43   ;1A
  &code_005A88   ;1B
  &code_005A9E   ;1C
  &code_005AB6   ;1D
  &code_005AC6   ;1E
  &code_005AD6   ;1F
  &code_005AFD   ;20
  &code_005B15   ;21
  &code_005B2B   ;22
  &code_005B39   ;23
  &code_005B4F   ;24
  &code_005B65   ;25
  &code_005B79   ;26
  &code_005BB1   ;27
  &code_005BC1   ;28
  &code_005BEB   ;29
  &code_005C1F   ;2A
  &code_005C50   ;2B
  #$0000   ;2C
  #$0000   ;2D
  &code_005C81   ;2E
  &code_005C97   ;2F
  &code_005CD6   ;30
  &code_005CF0   ;31
  &code_005D10   ;32
  &code_005D30   ;33
  &code_005D53   ;34
  &code_005D76   ;35
  &code_005D94   ;36
  &code_005DB0   ;37
  &code_005DBE   ;38
  &code_005DCB   ;39
  &code_005E05   ;3A
  &code_005E0D   ;3B
  &code_005E6C   ;3C
]
---------------------------------------------

cop_junk [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0000   ;04
  #$0000   ;05
  #$0000   ;06
  #$FFFF   ;07
  #$FFFF   ;08
  #$FFFF   ;09
  #$FFFF   ;0A
  #$FFFF   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$FFFF   ;10
  #$FFFF   ;11
  #$FFFF   ;12
  #$FFFF   ;13
  #$FFFF   ;14
  #$FFFF   ;15
  #$FFFF   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0000   ;24
  #$0000   ;25
  #$0020   ;26
  #$FFFF   ;27
  #$FFFF   ;28
  #$FFFF   ;29
  #$FFFF   ;2A
  #$FFFF   ;2B
  #$FFFF   ;2C
  #$FFFF   ;2D
  #$FFFF   ;2E
  #$FFFF   ;2F
  #$FFFF   ;30
  #$FFFF   ;31
  #$FFFF   ;32
  #$FFFF   ;33
  #$FFFF   ;34
  #$FFFF   ;35
  #$FFFF   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  #$0000   ;3C
  #$0000   ;3D
  #$0000   ;3E
  #$0000   ;3F
  #$0000   ;40
  #$0000   ;41
  #$0000   ;42
]
---------------------------------------------

cop_tail_80 [
  &code_005E7A   ;00
  &code_005E90   ;01
  &code_005EB0   ;02
  &code_005EBD   ;03
  &code_005ECF   ;04
  &code_005EEE   ;05
  &code_005F0D   ;06
  &code_005F45   ;07
  &code_005F52   ;08
  &code_005F5F   ;09
  &code_005F85   ;0A
  &code_005FAB   ;0B
  &code_005FD1   ;0C
  &code_005FF7   ;0D
  &code_00600C   ;0E
  &code_006021   ;0F
  &code_006042   ;10
  &code_006063   ;11
  &code_006075   ;12
  &code_00608E   ;13
  &code_0060B1   ;14
  &code_0060CD   ;15
  &code_0060EE   ;16
  &code_006100   ;17
  &code_006112   ;18
  &code_006124   ;19
  &code_006136   ;1A
  &code_00615D   ;1B
  &code_006184   ;1C
  &code_0061B2   ;1D
  &code_0061D1   ;1E
  &code_0061EF   ;1F
  &code_006200   ;20
  &code_006211   ;21
  &code_00622F   ;22
  &code_006248   ;23
  &code_006255   ;24
  &code_006262   ;25
  &code_00628B   ;26
  &code_006298   ;27
  &code_0062A5   ;28
  &code_0062C1   ;29
  &code_0062E6   ;2A
  &code_0062FF   ;2B
  &code_006339   ;2C
  &code_006373   ;2D
  &code_0063A9   ;2E
  &code_0063E1   ;2F
  &code_006409   ;30
  &code_006431   ;31
  &code_006473   ;32
]

code_00579E {
    TYX                   ; {22430}
    BRL loc_0064C9        ; {22431}
}

code_0057A2 {
    TYX                   ; {22434}
    LDA [$38]             ; {22435}
    INC $38               ; {22437}
    INC $38               ; {22439}
    TAY                   ; {22441}
    SEP #$20              ; {22442}
    PHX                   ; {22444}
    PHB                   ; {22445}
    LDA $3A               ; {22446}
    PHA                   ; {22448}
    PLB                   ; {22449}
    JSL $@chunk_010000.code_012C27 ; {22450}
    PLB                   ; {22454}
    PLX                   ; {22455}
    REP #$20              ; {22456}
    BRL loc_0064BF        ; {22458}
}

code_0057BD {
    TYX                   ; {22461}
    PHX                   ; {22462}
    LDY #$&chunk_010000.asciistring_014F02 ; {22463}
    JSL $@chunk_010000.code_012769 ; {22466}
    SEP #$20              ; {22470}
    LDA #$00              ; {22472}
    XBA                   ; {22474}
    LDA #$02              ; {22475}
    JSL $@chunk_010000.code_012281 ; {22477}
    PHP                   ; {22481}
    LDX $03F7             ; {22482}
    JSL $@chunk_010000.code_012BDA ; {22485}
    LDA #$01              ; {22489}
    STA $03B8             ; {22491}
    PLP                   ; {22494}
    REP #$20              ; {22495}
    PLX                   ; {22497}
    BCS loc_0057EC        ; {22498}
    AND #$00FF            ; {22500}
    BNE loc_0057EC        ; {22503}
    BRL loc_0064BB        ; {22505}

  loc_0057EC:
    LDA [$38]             ; {22508}
    INC $38               ; {22510}
    INC $38               ; {22512}
    BRL loc_0064C1        ; {22514}
}

code_0057F5 {
    TYX                   ; {22517}
    LDA [$38]             ; {22518}
    INC $38               ; {22520}
    AND #$00FF            ; {22522}
    STA $002E, X          ; {22525}
    LDA $38               ; {22528}
    STA $002C, X          ; {22530}
    STA $0018, X          ; {22533}
    BRL loc_0064C1        ; {22536}
}

code_00580B {
    TYX                   ; {22539}
    DEC $002E, X          ; {22540}
    BNE loc_005814        ; {22543}
    BRL loc_0064BF        ; {22545}

  loc_005814:
    LDA $002C, X          ; {22548}
    STA $0018, X          ; {22551}
    BRL loc_0064C9        ; {22554}
}

code_00581D {
    TYX                   ; {22557}
    LDA [$38]             ; {22558}
    BMI loc_005829        ; {22560}
    JSR $&code_0064F8     ; {22562}
    BCC loc_00582E        ; {22565}
    BRA loc_005835        ; {22567}

  loc_005829:
    JSR $&code_0064F8     ; {22569}
    BCC loc_005835        ; {22572}

  loc_00582E:
    DEC $38               ; {22574}
    DEC $38               ; {22576}
    BRL loc_0064C4        ; {22578}

  loc_005835:
    BRL loc_0064BB        ; {22581}
}

code_005838 {
    TYX                   ; {22584}
    LDA [$38]             ; {22585}
    BRL loc_0064C1        ; {22587}
}

code_00583E {
    TYX                   ; {22590}
    LDA [$38]             ; {22591}
    BRA loc_005849        ; {22593}
}

code_005843 {
    TYX                   ; {22595}
    LDA [$38]             ; {22596}
    EOR #$8000            ; {22598}

  loc_005849:
    BMI loc_005852        ; {22601}
    JSR $&code_0064F8     ; {22603}
    BCS loc_005857        ; {22606}
    BRA loc_00585A        ; {22608}

  loc_005852:
    JSR $&code_0064F8     ; {22610}
    BCS loc_00585A        ; {22613}

  loc_005857:
    BRL loc_0064B7        ; {22615}

  loc_00585A:
    INC $38               ; {22618}
    INC $38               ; {22620}
    LDA [$38]             ; {22622}
    INC $38               ; {22624}
    INC $38               ; {22626}
    BRL loc_0064C1        ; {22628}
}

code_005867 {
    TYX                   ; {22631}
    LDA [$38]             ; {22632}
    INC $38               ; {22634}
    INC $38               ; {22636}
    JSR $&code_0064CC     ; {22638}
    BRL loc_0064BF        ; {22641}
}

code_005874 {
    TYX                   ; {22644}
    LDA [$38]             ; {22645}
    INC $38               ; {22647}
    AND #$00FF            ; {22649}
    JSR $&code_00651E     ; {22652}
    BCC loc_005885        ; {22655}
    JSL $@chunk_010000.code_0120F9 ; {22657}

  loc_005885:
    BRL loc_0064BF        ; {22661}
}

code_005888 {
    TYX                   ; {22664}
    LDA [$38]             ; {22665}
    INC $38               ; {22667}
    AND #$00FF            ; {22669}
    JSR $&code_00651E     ; {22672}
    BCS loc_0058A6        ; {22675}
    SEP #$20              ; {22677}
    BPL loc_00589E        ; {22679}
    AND #$7F              ; {22681}
    STZ $1B64             ; {22683}

  loc_00589E:
    EOR $1B1E, Y          ; {22686}
    STA $1B1E, Y          ; {22689}
    REP #$20              ; {22692}

  loc_0058A6:
    BRL loc_0064BF        ; {22694}
}

code_0058A9 {
    TYX                   ; {22697}
    LDA [$38]             ; {22698}
    INC $38               ; {22700}
    AND #$00FF            ; {22702}
    JSR $&code_006617     ; {22705}
    LDA [$38]             ; {22708}
    INC $38               ; {22710}
    AND #$00FF            ; {22712}
    JSR $&code_006628     ; {22715}
    STA $00               ; {22718}

  loc_0058C0:
    LDA $0000, X          ; {22720}
    SEC                   ; {22723}
    SBC $00               ; {22724}
    STA $16               ; {22726}
    LDA $00               ; {22728}
    ASL                   ; {22730}
    CLC                   ; {22731}
    ADC $0010, X          ; {22732}
    SEC                   ; {22735}
    SBC #$000F            ; {22736}
    STA $18               ; {22739}
    LDA $0000, Y          ; {22741}
    SEC                   ; {22744}
    SBC $16               ; {22745}
    CMP $18               ; {22747}
    BCC loc_0058E2        ; {22749}
    BRL loc_0064BB        ; {22751}

  loc_0058E2:
    LDA $0002, X          ; {22754}
    CLC                   ; {22757}
    ADC $00               ; {22758}
    STA $16               ; {22760}
    LDA $00               ; {22762}
    ASL                   ; {22764}
    CLC                   ; {22765}
    ADC $0012, X          ; {22766}
    SEC                   ; {22769}
    SBC #$000F            ; {22770}
    STA $18               ; {22773}
    LDA $16               ; {22775}
    SEC                   ; {22777}
    SBC $0002, Y          ; {22778}
    CMP $18               ; {22781}
    BCC loc_005904        ; {22783}
    BRL loc_0064BB        ; {22785}

  loc_005904:
    LDA [$38]             ; {22788}
    INC $38               ; {22790}
    INC $38               ; {22792}
    BRL loc_0064C1        ; {22794}
}

code_00590D {
    TYX                   ; {22797}
    LDA [$38]             ; {22798}
    INC $38               ; {22800}
    AND #$00FF            ; {22802}
    JSR $&code_006617     ; {22805}
    LDA [$38]             ; {22808}
    INC $38               ; {22810}
    AND #$00FF            ; {22812}
    JSR $&code_006628     ; {22815}
    CMP $0000, Y          ; {22818}
    BEQ loc_00592A        ; {22821}
    BRL loc_0064B9        ; {22823}

  loc_00592A:
    LDA [$38]             ; {22826}
    INC $38               ; {22828}
    AND #$00FF            ; {22830}
    INC                   ; {22833}
    JSR $&code_006628     ; {22834}
    CMP $0002, Y          ; {22837}
    BEQ loc_00593D        ; {22840}
    BRL loc_0064BB        ; {22842}

  loc_00593D:
    LDA [$38]             ; {22845}
    INC $38               ; {22847}
    INC $38               ; {22849}
    BRL loc_0064C1        ; {22851}
}

code_005946 {
    TYX                   ; {22854}
    LDA [$38]             ; {22855}
    INC $38               ; {22857}
    INC $38               ; {22859}
    XBA                   ; {22861}
    STA $scene_next       ; {22862}
    LDA [$38]             ; {22865}
    INC $38               ; {22867}
    AND #$00FF            ; {22869}
    STA $0380             ; {22872}
    LDA [$38]             ; {22875}
    INC $38               ; {22877}
    INC $38               ; {22879}
    STA $037C             ; {22881}
    LDA [$38]             ; {22884}
    INC $38               ; {22886}
    INC $38               ; {22888}
    STA $037E             ; {22890}
    BRL loc_0064BF        ; {22893}
}

code_005970 {
    TYX                   ; {22896}
    LDA [$38]             ; {22897}
    INC $38               ; {22899}
    AND #$00FF            ; {22901}
    JSR $&code_006617     ; {22904}
    LDA [$38]             ; {22907}
    INC $38               ; {22909}
    AND #$00FF            ; {22911}
    JSR $&code_006628     ; {22914}
    STA $0000, Y          ; {22917}
    LDA [$38]             ; {22920}
    INC $38               ; {22922}
    AND #$00FF            ; {22924}
    JSR $&code_006628     ; {22927}
    STA $0002, Y          ; {22930}
    PHX                   ; {22933}
    TYX                   ; {22934}
    JSR $&code_0065A7     ; {22935}
    PLX                   ; {22938}
    BRL loc_0064BF        ; {22939}
}

code_00599E {
    TYX                   ; {22942}
    LDA [$38]             ; {22943}
    INC $38               ; {22945}
    AND #$00FF            ; {22947}
    JSR $&code_006617     ; {22950}
    LDA [$38]             ; {22953}
    INC $38               ; {22955}
    INC $38               ; {22957}
    STA $0018, Y          ; {22959}
    BRL loc_0064BF        ; {22962}
}

code_0059B5 {
    TYX                   ; {22965}
    LDA [$38]             ; {22966}
    INC $38               ; {22968}
    AND #$00FF            ; {22970}
    JSR $&code_006617     ; {22973}
    LDA [$38]             ; {22976}
    INC $38               ; {22978}
    INC $38               ; {22980}
    STA $0030, Y          ; {22982}
    BRL loc_0064BF        ; {22985}
}

code_0059CC {
    TYX                   ; {22988}
    LDA [$38]             ; {22989}
    INC $38               ; {22991}
    INC $38               ; {22993}
    JSR $&code_00662D     ; {22995}
    LDY #$1ADE            ; {22998}
    JSL $@chunk_0270E4.code_0273A2 ; {23001}
    BCC loc_0059F1        ; {23005}
    LDA $0016, X          ; {23007}
    AND #$DFFF            ; {23010}
    STA $0016, X          ; {23013}
    LDA [$38]             ; {23016}
    INC $38               ; {23018}
    INC $38               ; {23020}
    BRL loc_0064C1        ; {23022}

  loc_0059F1:
    BRL loc_0064BB        ; {23025}
}

code_0059F4 {
    TYX                   ; {23028}
    JSR $&code_006537     ; {23029}
    BRL loc_0064BF        ; {23032}
}

code_0059FB {
    TYX                   ; {23035}
    JSR $&code_0065A7     ; {23036}
    BRL loc_0064BF        ; {23039}
}

code_005A02 {
    TYX                   ; {23042}
    LDA [$38]             ; {23043}
    INC $38               ; {23045}
    INC $38               ; {23047}
    STA $0030, X          ; {23049}
    BRL loc_0064BF        ; {23052}
}

code_005A0F {
    TYX                   ; {23055}
    LDA [$38]             ; {23056}
    INC $38               ; {23058}
    AND #$00FF            ; {23060}
    JSR $&code_00651E     ; {23063}
    BCS loc_005A1F        ; {23066}
    BRL loc_0064BB        ; {23068}

  loc_005A1F:
    LDA [$38]             ; {23071}
    INC $38               ; {23073}
    INC $38               ; {23075}
    BRL loc_0064C1        ; {23077}
}

code_005A28 {
    TYX                   ; {23080}
    LDA [$38]             ; {23081}
    INC $38               ; {23083}
    AND #$00FF            ; {23085}
    JSR $&code_00651E     ; {23088}
    BCS loc_005A3A        ; {23091}
    BPL loc_005A3A        ; {23093}
    BRL loc_0064BB        ; {23095}

  loc_005A3A:
    LDA [$38]             ; {23098}
    INC $38               ; {23100}
    INC $38               ; {23102}
    BRL loc_0064C1        ; {23104}
}

code_005A43 {
    TYX                   ; {23107}
    PHX                   ; {23108}
    LDA [$38]             ; {23109}
    INC $38               ; {23111}
    INC $38               ; {23113}
    TAY                   ; {23115}
    JSL $@chunk_010000.code_012769 ; {23116}
    SEP #$20              ; {23120}
    LDA #$00              ; {23122}
    XBA                   ; {23124}
    LDA [$38]             ; {23125}
    INC $38               ; {23127}
    BNE loc_005A5D        ; {23129}
    INC $39               ; {23131}

  loc_005A5D:
    JSL $@chunk_010000.code_012281 ; {23133}
    PHA                   ; {23137}
    PHP                   ; {23138}
    LDX $03F7             ; {23139}
    JSL $@chunk_010000.code_012BDA ; {23142}
    LDA #$01              ; {23146}
    STA $03B8             ; {23148}
    PLP                   ; {23151}
    PLA                   ; {23152}
    REP #$20              ; {23153}
    PLX                   ; {23155}
    BCS loc_005A7F        ; {23156}
    AND #$00FF            ; {23158}
    STA $03D0             ; {23161}
    BRL loc_0064BB        ; {23164}

  loc_005A7F:
    LDA [$38]             ; {23167}
    INC $38               ; {23169}
    INC $38               ; {23171}
    BRL loc_0064C1        ; {23173}
}

code_005A88 {
    TYX                   ; {23176}
    LDA [$38]             ; {23177}
    INC $38               ; {23179}
    INC $38               ; {23181}
    STA $0018, X          ; {23183}
    LDA [$38]             ; {23186}
    INC $38               ; {23188}
    INC $38               ; {23190}
    STA $0014, X          ; {23192}
    BRL loc_0064C9        ; {23195}
}

code_005A9E {
    TYX                   ; {23198}
    LDA [$38]             ; {23199}
    INC $38               ; {23201}
    INC $38               ; {23203}
    AND $0016, X          ; {23205}
    BNE loc_005AAD        ; {23208}
    BRL loc_0064BB        ; {23210}

  loc_005AAD:
    LDA [$38]             ; {23213}
    INC $38               ; {23215}
    INC $38               ; {23217}
    BRL loc_0064C1        ; {23219}
}

code_005AB6 {
    TYX                   ; {23222}
    LDA [$38]             ; {23223}
    INC $38               ; {23225}
    INC $38               ; {23227}
    ORA $0016, X          ; {23229}
    STA $0016, X          ; {23232}
    BRL loc_0064BF        ; {23235}
}

code_005AC6 {
    TYX                   ; {23238}
    LDA [$38]             ; {23239}
    INC $38               ; {23241}
    INC $38               ; {23243}
    AND $0016, X          ; {23245}
    STA $0016, X          ; {23248}
    BRL loc_0064BF        ; {23251}
}

code_005AD6 {
    PHY                   ; {23254}
    SEP #$20              ; {23255}
    LDX #$000F            ; {23257}
    LDA #$00              ; {23260}
    XBA                   ; {23262}
    CLC                   ; {23263}

  loc_005AE0:
    LDA $0302, X          ; {23264}
    ADC $0301, X          ; {23267}
    STA $0301, X          ; {23270}
    DEX                   ; {23273}
    BNE loc_005AE0        ; {23274}
    LDX #$0010            ; {23276}

  loc_005AEF:
    INC $0301, X          ; {23279}
    BNE loc_005AF7        ; {23282}
    DEX                   ; {23284}
    BNE loc_005AEF        ; {23285}

  loc_005AF7:
    REP #$20              ; {23287}
    PLX                   ; {23289}
    BRL loc_0064BF        ; {23290}
}

code_005AFD {
    TYX                   ; {23293}
    LDA $0374             ; {23294}
    ORA $0376             ; {23297}
    AND #$000F            ; {23300}
    BEQ loc_005B12        ; {23303}
    LDA [$38]             ; {23305}
    INC $38               ; {23307}
    INC $38               ; {23309}
    BRL loc_0064C1        ; {23311}

  loc_005B12:
    BRL loc_0064BB        ; {23314}
}

code_005B15 {
    TYX                   ; {23317}
    LDA $0000, X          ; {23318}
    STA $16               ; {23321}
    LDA $0002, X          ; {23323}
    SEC                   ; {23326}
    SBC #$0010            ; {23327}
    SEC                   ; {23330}
    SBC $0012, X          ; {23331}
    STA $18               ; {23334}
    BRL loc_005BD0        ; {23336}
}

code_005B2B {
    TYX                   ; {23339}
    LDA $0000, X          ; {23340}
    STA $16               ; {23343}
    LDA $0002, X          ; {23345}
    STA $18               ; {23348}
    BRL loc_005BD0        ; {23350}
}

code_005B39 {
    TYX                   ; {23353}
    LDA $0000, X          ; {23354}
    SEC                   ; {23357}
    SBC #$0010            ; {23358}
    STA $16               ; {23361}
    LDA $0002, X          ; {23363}
    SEC                   ; {23366}
    SBC #$0010            ; {23367}
    STA $18               ; {23370}
    BRL loc_005BD0        ; {23372}
}

code_005B4F {
    TYX                   ; {23375}
    LDA $0000, X          ; {23376}
    CLC                   ; {23379}
    ADC $0010, X          ; {23380}
    STA $16               ; {23383}
    LDA $0002, X          ; {23385}
    SEC                   ; {23388}
    SBC #$0010            ; {23389}
    STA $18               ; {23392}
    BRL loc_005BD0        ; {23394}
}

code_005B65 {
    TYX                   ; {23397}
    LDA [$38]             ; {23398}
    INC $38               ; {23400}
    INC $38               ; {23402}
    JSL $@chunk_0270E4.code_0276A5 ; {23404}
    LDA #$0010            ; {23408}
    TSB $0332             ; {23411}
    BRL loc_0064BF        ; {23414}
}

code_005B79 {
    TYX                   ; {23417}
    LDA [$38]             ; {23418}
    INC $38               ; {23420}
    INC $38               ; {23422}
    LDY $1B64             ; {23424}
    CPY #$0040            ; {23427}
    BNE loc_005B8D        ; {23430}
    LDA #$0000            ; {23432}
    BRA loc_005B99        ; {23435}

  loc_005B8D:
    LDY $1B60             ; {23437}
    CPY #$000C            ; {23440}
    BNE loc_005B99        ; {23443}
    LSR                   ; {23445}
    BNE loc_005B99        ; {23446}
    INC                   ; {23448}

  loc_005B99:
    JSL $@chunk_0270E4.code_0276C9 ; {23449}
    BCS loc_005BA8        ; {23453}
    LDA #$0010            ; {23455}
    TSB $0332             ; {23458}
    BRL loc_0064BB        ; {23461}

  loc_005BA8:
    LDA [$38]             ; {23464}
    INC $38               ; {23466}
    INC $38               ; {23468}
    BRL loc_0064C1        ; {23470}
}

code_005BB1 {
    TYX                   ; {23473}
    LDA [$38]             ; {23474}
    INC $38               ; {23476}
    INC $38               ; {23478}
    STA $0018, X          ; {23480}
    STZ $0014, X          ; {23483}
    BRL loc_0064C9        ; {23486}
}

code_005BC1 {
    TYX                   ; {23489}
    LDA $0000, X          ; {23490}
    STA $16               ; {23493}
    LDA $0002, X          ; {23495}
    SEC                   ; {23498}
    SBC #$0010            ; {23499}
    STA $18               ; {23502}

  loc_005BD0:
    PHX                   ; {23504}
    JSL $@chunk_0270E4.code_0272B8 ; {23505}
    LDA $7F8000, X        ; {23509}
    PLX                   ; {23513}
    AND #$00FF            ; {23514}
    BNE loc_005BE2        ; {23517}
    BRL loc_0064BB        ; {23519}

  loc_005BE2:
    LDA [$38]             ; {23522}
    INC $38               ; {23524}
    INC $38               ; {23526}
    BRL loc_0064C1        ; {23528}
}

code_005BEB {
    TYX                   ; {23531}
    LDA $0000, X          ; {23532}
    STA $16               ; {23535}
    LDA $0002, X          ; {23537}
    SEC                   ; {23540}
    SBC #$0010            ; {23541}
    STA $18               ; {23544}
    PHX                   ; {23546}
    JSL $@chunk_0270E4.code_0272B8 ; {23547}
    SEP #$20              ; {23551}
    LDA [$38]             ; {23553}
    INC $38               ; {23555}
    BNE loc_005C09        ; {23557}
    INC $39               ; {23559}

  loc_005C09:
    CMP $7E8000, X        ; {23561}
    REP #$20              ; {23565}
    BNE loc_005C15        ; {23567}
    PLX                   ; {23569}
    BRL loc_0064BB        ; {23570}

  loc_005C15:
    PLX                   ; {23573}
    LDA [$38]             ; {23574}
    INC $38               ; {23576}
    INC $38               ; {23578}
    BRL loc_0064C1        ; {23580}
}

code_005C1F {
    TYX                   ; {23583}
    PHX                   ; {23584}
    LDA [$38]             ; {23585}
    INC $38               ; {23587}
    INC $38               ; {23589}
    CLC                   ; {23591}
    ADC $0000, X          ; {23592}
    STA $16               ; {23595}
    LDA [$38]             ; {23597}
    INC $38               ; {23599}
    INC $38               ; {23601}
    CLC                   ; {23603}
    ADC $0002, X          ; {23604}
    SEC                   ; {23607}
    SBC #$0010            ; {23608}
    STA $18               ; {23611}
    JSL $@chunk_0270E4.code_0272B8 ; {23613}
    LDA $7F8000, X        ; {23617}
    ORA #$00F0            ; {23621}
    STA $7F8000, X        ; {23624}
    PLX                   ; {23628}
    BRL loc_0064BF        ; {23629}
}

code_005C50 {
    TYX                   ; {23632}
    PHX                   ; {23633}
    LDA [$38]             ; {23634}
    INC $38               ; {23636}
    INC $38               ; {23638}
    CLC                   ; {23640}
    ADC $0000, X          ; {23641}
    STA $16               ; {23644}
    LDA [$38]             ; {23646}
    INC $38               ; {23648}
    INC $38               ; {23650}
    CLC                   ; {23652}
    ADC $0002, X          ; {23653}
    SEC                   ; {23656}
    SBC #$0010            ; {23657}
    STA $18               ; {23660}
    JSL $@chunk_0270E4.code_0272B8 ; {23662}
    LDA $7F8000, X        ; {23666}
    AND #$FF00            ; {23670}
    STA $7F8000, X        ; {23673}
    PLX                   ; {23677}
    BRL loc_0064BF        ; {23678}
}

code_005C81 {
    TYX                   ; {23681}
    LDA [$38]             ; {23682}
    INC $38               ; {23684}
    AND #$00FF            ; {23686}
    JSR $&code_006617     ; {23689}
    LDA [$38]             ; {23692}
    INC $38               ; {23694}
    INC $38               ; {23696}
    STA $00               ; {23698}
    BRL loc_0058C0        ; {23700}
}

code_005C97 {
    TYX                   ; {23703}
    LDA [$38]             ; {23704}
    INC $38               ; {23706}
    INC $38               ; {23708}
    STA $16               ; {23710}
    LDA [$38]             ; {23712}
    INC $38               ; {23714}
    INC $38               ; {23716}
    STA $18               ; {23718}
    LDY $039C             ; {23720}
    LDA $0000, Y          ; {23723}
    CLC                   ; {23726}
    ADC $16               ; {23727}
    STA $0000, Y          ; {23729}
    LDA $0002, Y          ; {23732}
    CLC                   ; {23735}
    ADC $18               ; {23736}
    STA $0002, Y          ; {23738}
    LDA $003E, Y          ; {23741}
    TAY                   ; {23744}
    LDA $0000, Y          ; {23745}
    CLC                   ; {23748}
    ADC $16               ; {23749}
    STA $0000, Y          ; {23751}
    LDA $0002, Y          ; {23754}
    CLC                   ; {23757}
    ADC $18               ; {23758}
    STA $0002, Y          ; {23760}
    BRL loc_0064BF        ; {23763}
}

code_005CD6 {
    TYX                   ; {23766}
    LDA $03FB             ; {23767}
    BNE loc_005CDF        ; {23770}
    BRL loc_0064B5        ; {23772}

  loc_005CDF:
    LDA [$38]             ; {23775}
    INC $38               ; {23777}
    INC $38               ; {23779}
    CMP $0405             ; {23781}
    BEQ loc_005CED        ; {23784}
    BRL loc_0064B9        ; {23786}

  loc_005CED:
    BRL code_005EEE       ; {23789}
}

code_005CF0 {
    TYX                   ; {23792}
    JSR $&code_006662     ; {23793}
    LDA #$&code_002C9B    ; {23796}
    STA $0018, Y          ; {23799}
    SEP #$20              ; {23802}
    LDA #$^code_002C9B    ; {23804}
    STA $0036, Y          ; {23806}
    REP #$20              ; {23809}
    LDA [$38]             ; {23811}
    INC $38               ; {23813}
    AND #$00FF            ; {23815}
    STA $0030, Y          ; {23818}
    BRL loc_0064BF        ; {23821}
}

code_005D10 {
    TYX                   ; {23824}
    JSR $&code_006662     ; {23825}
    LDA #$&code_002CCB    ; {23828}
    STA $0018, Y          ; {23831}
    SEP #$20              ; {23834}
    LDA #$^code_002CCB    ; {23836}
    STA $0036, Y          ; {23838}
    REP #$20              ; {23841}
    LDA [$38]             ; {23843}
    INC $38               ; {23845}
    AND #$00FF            ; {23847}
    STA $0030, Y          ; {23850}
    BRL loc_0064BF        ; {23853}
}

code_005D30 {
    TYX                   ; {23856}
    LDY $039C             ; {23857}
    JSR $&code_005D49     ; {23860}
    LDY $039E             ; {23863}
    JSR $&code_005D49     ; {23866}
    LDY $03A0             ; {23869}
    JSR $&code_005D49     ; {23872}
    STZ $0464             ; {23875}
    BRL loc_0064BF        ; {23878}
}

code_005D49 {
    LDA $001A, Y          ; {23881}
    AND #$FF7F            ; {23884}
    STA $001A, Y          ; {23887}
    RTS                   ; {23890}
}

code_005D53 {
    TYX                   ; {23891}
    LDY $039C             ; {23892}
    JSR $&code_005D6C     ; {23895}
    LDY $039E             ; {23898}
    JSR $&code_005D6C     ; {23901}
    LDY $03A0             ; {23904}
    JSR $&code_005D6C     ; {23907}
    INC $0464             ; {23910}
    BRL loc_0064BF        ; {23913}
}

code_005D6C {
    LDA $001A, Y          ; {23916}
    ORA #$0080            ; {23919}
    STA $001A, Y          ; {23922}
    RTS                   ; {23925}
}

code_005D76 {
    TYX                   ; {23926}
    LDA [$38]             ; {23927}
    INC $38               ; {23929}
    AND #$00FF            ; {23931}
    STA $00               ; {23934}
    LDA $0302             ; {23936}
    AND #$00FF            ; {23939}

  loc_005D86:
    SEC                   ; {23942}
    SBC $00               ; {23943}
    BPL loc_005D86        ; {23945}
    CLC                   ; {23947}
    ADC $00               ; {23948}
    STA $0437             ; {23950}
    BRL loc_0064BF        ; {23953}
}

code_005D94 {
    TYX                   ; {23956}
    LDA [$38]             ; {23957}
    INC $38               ; {23959}
    INC $38               ; {23961}
    SED                   ; {23963}
    CLC                   ; {23964}
    ADC $1B78             ; {23965}
    STA $1B78             ; {23968}
    LDA $1B7A             ; {23971}
    ADC #$0000            ; {23974}
    STA $1B7A             ; {23977}
    CLD                   ; {23980}
    BRL loc_0064BF        ; {23981}
}

code_005DB0 {
    TYX                   ; {23984}
    LDA $1B8A             ; {23985}
    SEC                   ; {23988}
    SBC $1B88             ; {23989}
    STA $043B             ; {23992}
    BRL loc_0064BF        ; {23995}
}

code_005DBE {
    TYX                   ; {23998}
    LDA [$38]             ; {23999}
    INC $38               ; {24001}
    INC $38               ; {24003}
    STA $043D             ; {24005}
    BRL loc_0064BF        ; {24008}
}

code_005DCB {
    TYX                   ; {24011}
    PHX                   ; {24012}
    LDA [$38]             ; {24013}
    INC $38               ; {24015}
    AND #$00FF            ; {24017}
    SEP #$20              ; {24020}
    PHA                   ; {24022}
    LDA $1B88             ; {24023}
    SEC                   ; {24026}
    SBC $01, S            ; {24027}
    BPL loc_005DE1        ; {24029}
    LDA #$00              ; {24031}

  loc_005DE1:
    STA $1B88             ; {24033}
    PLA                   ; {24036}
    REP #$20              ; {24037}
    LDA #$0004            ; {24039}
    TSB $0332             ; {24042}
    LDX $039C             ; {24045}
    LDA #$FFE0            ; {24048}
    STA $0026, X          ; {24051}
    BRK #$04              ; {24054}
    LDA $0016, X          ; {24056}
    ORA #$0800            ; {24059}
    STA $0016, X          ; {24062}
    PLX                   ; {24065}
    BRL loc_0064BF        ; {24066}
}

code_005E05 {
    TYX                   ; {24069}
    JSL $@chunk_010000.code_0124EE ; {24070}
    BRL loc_0064BF        ; {24074}
}

code_005E0D {
    TYX                   ; {24077}
    LDA [$38]             ; {24078}
    JSR $&code_00662D     ; {24080}
    ASL                   ; {24083}
    ASL                   ; {24084}
    ASL                   ; {24085}
    ASL                   ; {24086}
    ASL                   ; {24087}
    TAY                   ; {24088}
    LDA $&data_00BA0D+1E, Y ; {24089}
    BEQ loc_005E27        ; {24092}
    LDY #$1ADE            ; {24094}
    JSL $@chunk_0270E4.code_0273A2 ; {24097}
    BCC loc_005E4B        ; {24101}

  loc_005E27:
    LDA [$38]             ; {24103}
    INC $38               ; {24105}
    INC $38               ; {24107}
    LDY #$1ADE            ; {24109}
    JSL $@chunk_0270E4.code_0273A2 ; {24112}
    BCC loc_005E48        ; {24116}
    LDA $0016, X          ; {24118}
    AND #$DFFF            ; {24121}
    STA $0016, X          ; {24124}
    LDA [$38]             ; {24127}
    INC $38               ; {24129}
    INC $38               ; {24131}
    BRL loc_0064C1        ; {24133}

  loc_005E48:
    BRL loc_0064C9        ; {24136}

  loc_005E4B:
    LDA [$38]             ; {24139}
    INC $38               ; {24141}
    INC $38               ; {24143}
    STA $0034, X          ; {24145}
    PHX                   ; {24148}
    TAX                   ; {24149}
    LDA $7F0203, X        ; {24150}
    PLX                   ; {24154}
    BIT #$0040            ; {24155}
    BEQ loc_005E48        ; {24158}
    LDA $0016, X          ; {24160}
    ORA #$0010            ; {24163}
    STA $0016, X          ; {24166}
    BRL loc_0064BB        ; {24169}
}

code_005E6C {
    TYX                   ; {24172}
    LDA [$38]             ; {24173}
    INC $38               ; {24175}
    AND #$00FF            ; {24177}
    STA $03E3             ; {24180}
    BRL loc_0064BF        ; {24183}
}

code_005E7A {
    TYX                   ; {24186}
    LDA [$38]             ; {24187}
    INC $38               ; {24189}
    AND #$00FF            ; {24191}
    STA $001E, X          ; {24194}
    STZ $0020, X          ; {24197}
    LDA $38               ; {24200}
    STA $0018, X          ; {24202}
    BRL loc_0064BF        ; {24205}
}

code_005E90 {
    TYX                   ; {24208}
    LDA [$38]             ; {24209}
    INC $38               ; {24211}
    AND #$00FF            ; {24213}
    STA $001E, X          ; {24216}
    STZ $0020, X          ; {24219}
    LDA [$38]             ; {24222}
    INC $38               ; {24224}
    AND #$00FF            ; {24226}
    STA $002A, X          ; {24229}
    LDA $38               ; {24232}
    STA $0018, X          ; {24234}
    BRL loc_0064BF        ; {24237}
}

code_005EB0 {
    TYX                   ; {24240}
    JSL $@code_0008F3     ; {24241}
    BCC loc_005EBA        ; {24245}
    BRL loc_0064BF        ; {24247}

  loc_005EBA:
    BRL loc_0064C9        ; {24250}
}

code_005EBD {
    TYX                   ; {24253}

  loc_005EBE:
    JSL $@code_0008F3     ; {24254}
    BCC loc_005ECC        ; {24258}
    DEC $002A, X          ; {24260}
    BNE loc_005EBE        ; {24263}
    BRL loc_0064BF        ; {24265}

  loc_005ECC:
    BRL loc_0064C9        ; {24268}
}

code_005ECF {
    TYX                   ; {24271}
    JSR $&code_00663A     ; {24272}
    LDA [$38]             ; {24275}
    INC $38               ; {24277}
    INC $38               ; {24279}
    STA $0018, Y          ; {24281}
    TXA                   ; {24284}
    LDA [$38]             ; {24285}
    INC $38               ; {24287}
    AND #$00FF            ; {24289}
    SEP #$20              ; {24292}
    STA $0036, Y          ; {24294}
    REP #$20              ; {24297}
    BRL loc_0064BF        ; {24299}
}

code_005EEE {
    TYX                   ; {24302}
    JSR $&code_006662     ; {24303}
    LDA [$38]             ; {24306}
    INC $38               ; {24308}
    INC $38               ; {24310}
    STA $0018, Y          ; {24312}
    TXA                   ; {24315}
    LDA [$38]             ; {24316}
    INC $38               ; {24318}
    AND #$00FF            ; {24320}
    SEP #$20              ; {24323}
    STA $0036, Y          ; {24325}
    REP #$20              ; {24328}
    BRL loc_0064BF        ; {24330}
}

code_005F0D {
    TYX                   ; {24333}
    LDY $003C, X          ; {24334}
    BNE loc_005F23        ; {24337}
    LDY $003E, X          ; {24339}
    STY $06A6             ; {24342}
    BEQ loc_005F37        ; {24345}
    LDA #$0000            ; {24347}
    STA $003C, Y          ; {24350}
    BRA loc_005F37        ; {24353}

  loc_005F23:
    LDA $003E, X          ; {24355}
    STA $003E, Y          ; {24358}
    BNE loc_005F30        ; {24361}
    STY $06A8             ; {24363}
    BRA loc_005F37        ; {24366}

  loc_005F30:
    TAY                   ; {24368}
    LDA $003C, X          ; {24369}
    STA $003C, Y          ; {24372}

  loc_005F37:
    SEP #$20              ; {24375}
    DEC $4A               ; {24377}
    DEC $4A               ; {24379}
    REP #$20              ; {24381}
    TXA                   ; {24383}
    STA ($4A)             ; {24384}
    BRL loc_0064BF        ; {24386}
}

code_005F45 {
    TYX                   ; {24389}
    LDA $001C, X          ; {24390}
    EOR #$4000            ; {24393}
    STA $001C, X          ; {24396}
    BRL loc_0064BF        ; {24399}
}

code_005F52 {
    TYX                   ; {24402}
    LDA $001C, X          ; {24403}
    EOR #$8000            ; {24406}
    STA $001C, X          ; {24409}
    BRL loc_0064BF        ; {24412}
}

code_005F5F {
    TYX                   ; {24415}
    LDA $0374             ; {24416}
    SEC                   ; {24419}
    SBC $0000, X          ; {24420}
    BPL loc_005F6D        ; {24423}
    EOR #$FFFF            ; {24425}
    INC                   ; {24428}

  loc_005F6D:
    STA $00               ; {24429}
    LDA [$38]             ; {24431}
    INC $38               ; {24433}
    INC $38               ; {24435}
    CMP $00               ; {24437}
    BCS loc_005F7C        ; {24439}
    BRL loc_0064BB        ; {24441}

  loc_005F7C:
    LDA [$38]             ; {24444}
    INC $38               ; {24446}
    INC $38               ; {24448}
    BRL loc_0064C1        ; {24450}
}

code_005F85 {
    TYX                   ; {24453}
    LDA $0376             ; {24454}
    SEC                   ; {24457}
    SBC $0002, X          ; {24458}
    BPL loc_005F93        ; {24461}
    EOR #$FFFF            ; {24463}
    INC                   ; {24466}

  loc_005F93:
    STA $00               ; {24467}
    LDA [$38]             ; {24469}
    INC $38               ; {24471}
    INC $38               ; {24473}
    CMP $00               ; {24475}
    BCS loc_005FA2        ; {24477}
    BRL loc_0064BB        ; {24479}

  loc_005FA2:
    LDA [$38]             ; {24482}
    INC $38               ; {24484}
    INC $38               ; {24486}
    BRL loc_0064C1        ; {24488}
}

code_005FAB {
    TYX                   ; {24491}
    LDA $0374             ; {24492}
    SEC                   ; {24495}
    SBC $0000, X          ; {24496}
    BPL loc_005FB9        ; {24499}
    EOR #$FFFF            ; {24501}
    INC                   ; {24504}

  loc_005FB9:
    STA $00               ; {24505}
    LDA [$38]             ; {24507}
    INC $38               ; {24509}
    INC $38               ; {24511}
    CMP $00               ; {24513}
    BCC loc_005FC8        ; {24515}
    BRL loc_0064BB        ; {24517}

  loc_005FC8:
    LDA [$38]             ; {24520}
    INC $38               ; {24522}
    INC $38               ; {24524}
    BRL loc_0064C1        ; {24526}
}

code_005FD1 {
    TYX                   ; {24529}
    LDA $0376             ; {24530}
    SEC                   ; {24533}
    SBC $0002, X          ; {24534}
    BPL loc_005FDF        ; {24537}
    EOR #$FFFF            ; {24539}
    INC                   ; {24542}

  loc_005FDF:
    STA $00               ; {24543}
    LDA [$38]             ; {24545}
    INC $38               ; {24547}
    INC $38               ; {24549}
    CMP $00               ; {24551}
    BCC loc_005FEE        ; {24553}
    BRL loc_0064BB        ; {24555}

  loc_005FEE:
    LDA [$38]             ; {24558}
    INC $38               ; {24560}
    INC $38               ; {24562}
    BRL loc_0064C1        ; {24564}
}

code_005FF7 {
    TYX                   ; {24567}
    LDA $0016, X          ; {24568}
    BIT #$8000            ; {24571}
    BEQ loc_006003        ; {24574}
    BRL loc_0064BF        ; {24576}

  loc_006003:
    LDA [$38]             ; {24579}
    INC $38               ; {24581}
    INC $38               ; {24583}
    BRL loc_0064C1        ; {24585}
}

code_00600C {
    TYX                   ; {24588}
    LDA $0016, X          ; {24589}
    BIT #$8000            ; {24592}
    BNE loc_006018        ; {24595}
    BRL loc_0064BF        ; {24597}

  loc_006018:
    LDA [$38]             ; {24600}
    INC $38               ; {24602}
    INC $38               ; {24604}
    BRL loc_0064C1        ; {24606}
}

code_006021 {
    TYX                   ; {24609}
    LDA $0374             ; {24610}
    CMP $0000, X          ; {24613}
    BCC loc_006036        ; {24616}
    LDA $001C, X          ; {24618}
    ORA #$4000            ; {24621}
    STA $001C, X          ; {24624}
    BRL loc_0064BF        ; {24627}

  loc_006036:
    LDA $001C, X          ; {24630}
    AND #$BFFF            ; {24633}
    STA $001C, X          ; {24636}
    BRL loc_0064BF        ; {24639}
}

code_006042 {
    TYX                   ; {24642}
    LDA $0376             ; {24643}
    CMP $0002, X          ; {24646}
    BCC loc_006057        ; {24649}
    LDA $001C, X          ; {24651}
    ORA #$8000            ; {24654}
    STA $001C, X          ; {24657}
    BRL loc_0064BF        ; {24660}

  loc_006057:
    LDA $001C, X          ; {24663}
    AND #$7FFF            ; {24666}
    STA $001C, X          ; {24669}
    BRL loc_0064BF        ; {24672}
}

code_006063 {
    TYX                   ; {24675}
    SEP #$20              ; {24676}
    LDA $3A               ; {24678}
    STA $0036, X          ; {24680}
    REP #$20              ; {24683}
    LDA $38               ; {24685}
    STA $0018, X          ; {24687}
    BRL loc_0064C1        ; {24690}
}

code_006075 {
    TYX                   ; {24693}
    LDA [$38]             ; {24694}
    INC $38               ; {24696}
    AND #$00FF            ; {24698}
    STA $001E, X          ; {24701}
    STZ $0020, X          ; {24704}
    JSL $@chunk_010000.code_01065B ; {24707}
    JSL $@chunk_010000.code_0106CD ; {24711}
    BRL loc_0064C4        ; {24715}
}

code_00608E {
    TYX                   ; {24718}
    LDA [$38]             ; {24719}
    INC $38               ; {24721}
    AND #$00FF            ; {24723}
    STA $001E, X          ; {24726}
    STZ $0020, X          ; {24729}
    LDA [$38]             ; {24732}
    INC $38               ; {24734}
    AND #$00FF            ; {24736}
    STA $002A, X          ; {24739}
    JSL $@chunk_010000.code_01065B ; {24742}
    JSL $@chunk_010000.code_0106CD ; {24746}
    BRL loc_0064C4        ; {24750}
}

code_0060B1 {
    TYX                   ; {24753}
    DEC $0026, X          ; {24754}
    BPL loc_0060C0        ; {24757}
    JSL $@chunk_010000.code_01065B ; {24759}
    BCC loc_0060C6        ; {24763}
    BRL loc_0064BF        ; {24765}

  loc_0060C0:
    LDA $000E, X          ; {24768}
    STA $0014, X          ; {24771}

  loc_0060C6:
    JSL $@chunk_010000.code_0106CD ; {24774}
    BRL loc_0064C9        ; {24778}
}

code_0060CD {
    TYX                   ; {24781}
    DEC $0026, X          ; {24782}
    BPL loc_0060E1        ; {24785}

  loc_0060D3:
    JSL $@chunk_010000.code_01065B ; {24787}
    BCC loc_0060E7        ; {24791}
    DEC $002A, X          ; {24793}
    BNE loc_0060D3        ; {24796}
    BRL loc_0064BF        ; {24798}

  loc_0060E1:
    LDA $000E, X          ; {24801}
    STA $0014, X          ; {24804}

  loc_0060E7:
    JSL $@chunk_010000.code_0106CD ; {24807}
    BRL loc_0064C9        ; {24811}
}

code_0060EE {
    TYX                   ; {24814}
    LDA $001C, X          ; {24815}
    BIT #$4000            ; {24818}
    BNE loc_0060FD        ; {24821}
    ORA #$4000            ; {24823}
    STA $001C, X          ; {24826}

  loc_0060FD:
    BRL loc_0064BF        ; {24829}
}

code_006100 {
    TYX                   ; {24832}
    LDA $001C, X          ; {24833}
    BIT #$4000            ; {24836}
    BEQ loc_00610F        ; {24839}
    AND #$BFFF            ; {24841}
    STA $001C, X          ; {24844}

  loc_00610F:
    BRL loc_0064BF        ; {24847}
}

code_006112 {
    TYX                   ; {24850}
    LDA $001C, X          ; {24851}
    BIT #$8000            ; {24854}
    BNE loc_006121        ; {24857}
    ORA #$8000            ; {24859}
    STA $001C, X          ; {24862}

  loc_006121:
    BRL loc_0064BF        ; {24865}
}

code_006124 {
    TYX                   ; {24868}
    LDA $001C, X          ; {24869}
    BIT #$8000            ; {24872}
    BEQ loc_006133        ; {24875}
    AND #$7FFF            ; {24877}
    STA $001C, X          ; {24880}

  loc_006133:
    BRL loc_0064BF        ; {24883}
}

code_006136 {
    TYX                   ; {24886}
    LDY #$0004            ; {24887}
    LDA $0374             ; {24890}
    SEC                   ; {24893}
    SBC $0000, X          ; {24894}
    BEQ loc_006158        ; {24897}
    BPL loc_006151        ; {24899}
    EOR #$FFFF            ; {24901}
    CMP [$38]             ; {24904}
    BCC loc_006158        ; {24906}
    LDY #$0002            ; {24908}
    BRA loc_006158        ; {24911}

  loc_006151:
    CMP [$38]             ; {24913}
    BCC loc_006158        ; {24915}
    LDY #$0006            ; {24917}

  loc_006158:
    LDA [$38], Y          ; {24920}
    BRL loc_0064C1        ; {24922}
}

code_00615D {
    TYX                   ; {24925}
    LDY #$0004            ; {24926}
    LDA $0376             ; {24929}
    SEC                   ; {24932}
    SBC $0002, X          ; {24933}
    BEQ loc_00617F        ; {24936}
    BPL loc_006178        ; {24938}
    EOR #$FFFF            ; {24940}
    CMP [$38]             ; {24943}
    BCC loc_00617F        ; {24945}
    LDY #$0002            ; {24947}
    BRA loc_00617F        ; {24950}

  loc_006178:
    CMP [$38]             ; {24952}
    BCC loc_00617F        ; {24954}
    LDY #$0006            ; {24956}

  loc_00617F:
    LDA [$38], Y          ; {24959}
    BRL loc_0064C1        ; {24961}
}

code_006184 {
    TYX                   ; {24964}
    LDY #$0000            ; {24965}
    LDA $0374             ; {24968}
    SEC                   ; {24971}
    SBC $0000, X          ; {24972}
    BPL loc_006195        ; {24975}
    EOR #$FFFF            ; {24977}
    INC                   ; {24980}

  loc_006195:
    PHA                   ; {24981}
    LDA $0376             ; {24982}
    SEC                   ; {24985}
    SBC $0002, X          ; {24986}
    BPL loc_0061A3        ; {24989}
    EOR #$FFFF            ; {24991}
    INC                   ; {24994}

  loc_0061A3:
    CMP $01, S            ; {24995}
    BCC loc_0061AC        ; {24997}
    LDY #$0002            ; {24999}
    BRA loc_0061AC        ; {25002}

  loc_0061AC:
    PLA                   ; {25004}
    LDA [$38], Y          ; {25005}
    BRL loc_0064C1        ; {25007}
}

code_0061B2 {
    TYX                   ; {25010}
    LDA [$38]             ; {25011}
    INC $38               ; {25013}
    AND #$00FF            ; {25015}
    STA $001E, X          ; {25018}
    STZ $0020, X          ; {25021}
    LDA $38               ; {25024}
    STA $0018, X          ; {25026}
    LDA $0016, X          ; {25029}
    AND #$FFFB            ; {25032}
    STA $0016, X          ; {25035}
    BRL loc_0064BF        ; {25038}
}

code_0061D1 {
    TYX                   ; {25041}
    LDA $0016, X          ; {25042}
    BIT #$0004            ; {25045}
    BNE loc_0061E6        ; {25048}
    JSL $@code_0008F3     ; {25050}
    BCC loc_0061E3        ; {25054}
    BRL loc_0064BB        ; {25056}

  loc_0061E3:
    BRL loc_0064C9        ; {25059}

  loc_0061E6:
    LDA [$38]             ; {25062}
    INC $38               ; {25064}
    INC $38               ; {25066}
    BRL loc_0064C1        ; {25068}
}

code_0061EF {
    TYX                   ; {25071}
    LDA [$38]             ; {25072}
    INC $38               ; {25074}
    INC $38               ; {25076}
    CLC                   ; {25078}
    ADC $0000, X          ; {25079}
    STA $0000, X          ; {25082}
    BRL loc_0064BF        ; {25085}
}

code_006200 {
    TYX                   ; {25088}
    LDA [$38]             ; {25089}
    INC $38               ; {25091}
    INC $38               ; {25093}
    CLC                   ; {25095}
    ADC $0002, X          ; {25096}
    STA $0002, X          ; {25099}
    BRL loc_0064BF        ; {25102}
}

code_006211 {
    TYX                   ; {25105}
    LDA [$38]             ; {25106}
    INC $38               ; {25108}
    INC $38               ; {25110}
    CLC                   ; {25112}
    ADC $0000, X          ; {25113}
    STA $0000, X          ; {25116}
    LDA [$38]             ; {25119}
    INC $38               ; {25121}
    INC $38               ; {25123}
    CLC                   ; {25125}
    ADC $0002, X          ; {25126}
    STA $0002, X          ; {25129}
    BRL loc_0064BF        ; {25132}
}

code_00622F {
    TYX                   ; {25135}
    LDA $001C, X          ; {25136}
    AND #$CFFF            ; {25139}
    PHA                   ; {25142}
    LDA [$38]             ; {25143}
    INC $38               ; {25145}
    AND #$00FF            ; {25147}
    XBA                   ; {25150}
    ORA $01, S            ; {25151}
    STA $001C, X          ; {25153}
    PLA                   ; {25156}
    BRL loc_0064BF        ; {25157}
}

code_006248 {
    TYX                   ; {25160}
    LDA $001A, X          ; {25161}
    ORA #$4000            ; {25164}
    STA $001A, X          ; {25167}
    BRL loc_0064BF        ; {25170}
}

code_006255 {
    TYX                   ; {25173}
    LDA $001A, X          ; {25174}
    ORA #$2000            ; {25177}
    STA $001A, X          ; {25180}
    BRL loc_0064BF        ; {25183}
}

code_006262 {
    TYX                   ; {25186}
    LDA $001C, X          ; {25187}
    PHA                   ; {25190}
    AND #$3FFF            ; {25191}
    STA $001C, X          ; {25194}
    PLA                   ; {25197}
    LDY #$0000            ; {25198}
    AND #$C000            ; {25201}
    BEQ loc_006286        ; {25204}
    INY                   ; {25206}
    INY                   ; {25207}
    CMP #$4000            ; {25208}
    BEQ loc_006286        ; {25211}
    INY                   ; {25213}
    INY                   ; {25214}
    CMP #$8000            ; {25215}
    BEQ loc_006286        ; {25218}
    INY                   ; {25220}
    INY                   ; {25221}

  loc_006286:
    LDA [$38], Y          ; {25222}
    BRL loc_0064C1        ; {25224}
}

code_00628B {
    TYX                   ; {25227}
    LDA $001A, X          ; {25228}
    AND #$BFFF            ; {25231}
    STA $001A, X          ; {25234}
    BRL loc_0064BF        ; {25237}
}

code_006298 {
    TYX                   ; {25240}
    LDA $001A, X          ; {25241}
    AND #$DFFF            ; {25244}
    STA $001A, X          ; {25247}
    BRL loc_0064BF        ; {25250}
}

code_0062A5 {
    TYX                   ; {25253}
    LDA [$38]             ; {25254}
    INC $38               ; {25256}
    INC $38               ; {25258}
    STA $0022, X          ; {25260}
    SEP #$20              ; {25263}
    LDA [$38]             ; {25265}
    INC $38               ; {25267}
    BNE loc_0062B9        ; {25269}
    INC $39               ; {25271}

  loc_0062B9:
    STA $0024, X          ; {25273}
    REP #$20              ; {25276}
    BRL loc_0064BF        ; {25278}
}

code_0062C1 {
    TYX                   ; {25281}
    LDA [$38]             ; {25282}
    INC $38               ; {25284}
    INC $38               ; {25286}
    STA $0034, X          ; {25288}
    SEP #$20              ; {25291}
    LDA [$38]             ; {25293}
    INC $38               ; {25295}
    BNE loc_0062D5        ; {25297}
    INC $39               ; {25299}

  loc_0062D5:
    STA $002C, X          ; {25301}
    REP #$20              ; {25304}
    LDA $001A, X          ; {25306}
    ORA #$8000            ; {25309}
    STA $001A, X          ; {25312}
    BRL loc_0064BF        ; {25315}
}

code_0062E6 {
    TYX                   ; {25318}
    LDA $001C, X          ; {25319}
    AND #$F1FF            ; {25322}
    PHA                   ; {25325}
    LDA [$38]             ; {25326}
    INC $38               ; {25328}
    AND #$00FF            ; {25330}
    XBA                   ; {25333}
    ORA $01, S            ; {25334}
    STA $001C, X          ; {25336}
    PLA                   ; {25339}
    BRL loc_0064BF        ; {25340}
}

code_0062FF {
    TYX                   ; {25343}
    JSR $&code_00663A     ; {25344}
    LDA [$38]             ; {25347}
    INC $38               ; {25349}
    INC $38               ; {25351}
    STA $0018, Y          ; {25353}
    TXA                   ; {25356}
    LDA [$38]             ; {25357}
    INC $38               ; {25359}
    AND #$00FF            ; {25361}
    SEP #$20              ; {25364}
    STA $0036, Y          ; {25366}
    REP #$20              ; {25369}
    LDA [$38]             ; {25371}
    INC $38               ; {25373}
    INC $38               ; {25375}
    STA $0000, Y          ; {25377}
    LDA [$38]             ; {25380}
    INC $38               ; {25382}
    INC $38               ; {25384}
    STA $0002, Y          ; {25386}
    LDA [$38]             ; {25389}
    INC $38               ; {25391}
    INC $38               ; {25393}
    STA $0016, Y          ; {25395}
    BRL loc_0064BF        ; {25398}
}

code_006339 {
    TYX                   ; {25401}
    JSR $&code_006662     ; {25402}
    LDA [$38]             ; {25405}
    INC $38               ; {25407}
    INC $38               ; {25409}
    STA $0018, Y          ; {25411}
    TXA                   ; {25414}
    LDA [$38]             ; {25415}
    INC $38               ; {25417}
    AND #$00FF            ; {25419}
    SEP #$20              ; {25422}
    STA $0036, Y          ; {25424}
    REP #$20              ; {25427}
    LDA [$38]             ; {25429}
    INC $38               ; {25431}
    INC $38               ; {25433}
    STA $0000, Y          ; {25435}
    LDA [$38]             ; {25438}
    INC $38               ; {25440}
    INC $38               ; {25442}
    STA $0002, Y          ; {25444}
    LDA [$38]             ; {25447}
    INC $38               ; {25449}
    INC $38               ; {25451}
    STA $0016, Y          ; {25453}
    BRL loc_0064BF        ; {25456}
}

code_006373 {
    TYX                   ; {25459}
    LDA $0016, X          ; {25460}
    BIT #$8000            ; {25463}
    BNE loc_00637F        ; {25466}
    BRL loc_0064BD        ; {25468}

  loc_00637F:
    LDA $0000, X          ; {25471}
    CMP $0342             ; {25474}
    BCC loc_00638A        ; {25477}
    BRL loc_0064BD        ; {25479}

  loc_00638A:
    LDA $0002, X          ; {25482}
    CMP $0344             ; {25485}
    BCC loc_006395        ; {25488}
    BRL loc_0064BD        ; {25490}

  loc_006395:
    LDA $38               ; {25493}
    DEC                   ; {25495}
    DEC                   ; {25496}
    STA $0018, X          ; {25497}
    LDA [$38]             ; {25500}
    INC $38               ; {25502}
    AND #$00FF            ; {25504}
    STA $0014, X          ; {25507}
    BRL loc_0064C9        ; {25510}
}

code_0063A9 {
    TYX                   ; {25513}
    PHX                   ; {25514}
    LDA [$38]             ; {25515}
    INC $38               ; {25517}
    INC $38               ; {25519}
    CLC                   ; {25521}
    ADC $0000, X          ; {25522}
    STA $16               ; {25525}
    LDA [$38]             ; {25527}
    INC $38               ; {25529}
    INC $38               ; {25531}
    CLC                   ; {25533}
    ADC $0002, X          ; {25534}
    SEC                   ; {25537}
    SBC #$0010            ; {25538}
    STA $18               ; {25541}
    JSL $@chunk_0270E4.code_0272B8 ; {25543}
    LDA $7F8000, X        ; {25547}
    PLX                   ; {25551}
    AND #$000F            ; {25552}
    BEQ loc_0063DE        ; {25555}
    LDA [$38]             ; {25557}
    INC $38               ; {25559}
    INC $38               ; {25561}
    BRL loc_0064C1        ; {25563}

  loc_0063DE:
    BRL loc_0064BB        ; {25566}
}

code_0063E1 {
    TYX                   ; {25569}
    JSR $&code_00663A     ; {25570}
    LDA [$38]             ; {25573}
    INC $38               ; {25575}
    INC $38               ; {25577}
    STA $0018, Y          ; {25579}
    TXA                   ; {25582}
    LDA [$38]             ; {25583}
    INC $38               ; {25585}
    AND #$00FF            ; {25587}
    SEP #$20              ; {25590}
    STA $0036, Y          ; {25592}
    REP #$20              ; {25595}
    LDA [$38]             ; {25597}
    INC $38               ; {25599}
    INC $38               ; {25601}
    STA $0016, Y          ; {25603}
    BRL loc_0064BF        ; {25606}
}

code_006409 {
    TYX                   ; {25609}
    JSR $&code_006662     ; {25610}
    LDA [$38]             ; {25613}
    INC $38               ; {25615}
    INC $38               ; {25617}
    STA $0018, Y          ; {25619}
    TXA                   ; {25622}
    LDA [$38]             ; {25623}
    INC $38               ; {25625}
    AND #$00FF            ; {25627}
    SEP #$20              ; {25630}
    STA $0036, Y          ; {25632}
    REP #$20              ; {25635}
    LDA [$38]             ; {25637}
    INC $38               ; {25639}
    INC $38               ; {25641}
    STA $0016, Y          ; {25643}
    BRL loc_0064BF        ; {25646}
}

code_006431 {
    TYX                   ; {25649}
    JSR $&code_00663A     ; {25650}
    LDA [$38]             ; {25653}
    INC $38               ; {25655}
    INC $38               ; {25657}
    STA $0018, Y          ; {25659}
    TXA                   ; {25662}
    LDA [$38]             ; {25663}
    INC $38               ; {25665}
    AND #$00FF            ; {25667}
    SEP #$20              ; {25670}
    STA $0036, Y          ; {25672}
    REP #$20              ; {25675}
    LDA [$38]             ; {25677}
    INC $38               ; {25679}
    INC $38               ; {25681}
    CLC                   ; {25683}
    ADC $0000, X          ; {25684}
    STA $0000, Y          ; {25687}
    LDA [$38]             ; {25690}
    INC $38               ; {25692}
    INC $38               ; {25694}
    CLC                   ; {25696}
    ADC $0002, X          ; {25697}
    STA $0002, Y          ; {25700}
    LDA [$38]             ; {25703}
    INC $38               ; {25705}
    INC $38               ; {25707}
    STA $0016, Y          ; {25709}
    BRL loc_0064BF        ; {25712}
}

code_006473 {
    TYX                   ; {25715}
    JSR $&code_006662     ; {25716}
    LDA [$38]             ; {25719}
    INC $38               ; {25721}
    INC $38               ; {25723}
    STA $0018, Y          ; {25725}
    TXA                   ; {25728}
    LDA [$38]             ; {25729}
    INC $38               ; {25731}
    AND #$00FF            ; {25733}
    SEP #$20              ; {25736}
    STA $0036, Y          ; {25738}
    REP #$20              ; {25741}
    LDA [$38]             ; {25743}
    INC $38               ; {25745}
    INC $38               ; {25747}
    CLC                   ; {25749}
    ADC $0000, X          ; {25750}
    STA $0000, Y          ; {25753}
    LDA [$38]             ; {25756}
    INC $38               ; {25758}
    INC $38               ; {25760}
    CLC                   ; {25762}
    ADC $0002, X          ; {25763}
    STA $0002, Y          ; {25766}
    LDA [$38]             ; {25769}
    INC $38               ; {25771}
    INC $38               ; {25773}
    STA $0016, Y          ; {25775}
    BRL loc_0064BF        ; {25778}

  loc_0064B5:
    INC $38               ; {25781}

  loc_0064B7:
    INC $38               ; {25783}

  loc_0064B9:
    INC $38               ; {25785}

  loc_0064BB:
    INC $38               ; {25787}

  loc_0064BD:
    INC $38               ; {25789}

  loc_0064BF:
    LDA $38               ; {25791}

  loc_0064C1:
    STA $02, S            ; {25793}
    RTI                   ; {25795}

  loc_0064C4:
    LDA $38               ; {25796}
    STA $0018, X          ; {25798}

  loc_0064C9:
    PLA                   ; {25801}
    PLA                   ; {25802}
    RTL                   ; {25803}
}

code_0064CC {
    PHX                   ; {25804}
    STA $00               ; {25805}
    AND #$00FF            ; {25807}
    TAX                   ; {25810}
    LDA $01               ; {25811}
    AND #$007F            ; {25813}
    TAY                   ; {25816}
    SEP #$20              ; {25817}
    LDA $01               ; {25819}
    BPL loc_0064E8        ; {25821}
    LDA $@binary_06516, X ; {25823}
    ORA $1A5E, Y          ; {25827}
    BRA loc_0064F1        ; {25830}

  loc_0064E8:
    LDA $@binary_06516, X ; {25832}
    EOR #$FF              ; {25836}
    AND $1A5E, Y          ; {25838}

  loc_0064F1:
    STA $1A5E, Y          ; {25841}
    PLX                   ; {25844}
    REP #$20              ; {25845}
    RTS                   ; {25847}
}

code_0064F8 {
    PHX                   ; {25848}
    STA $00               ; {25849}
    AND #$00FF            ; {25851}
    TAX                   ; {25854}
    LDA $01               ; {25855}
    AND #$007F            ; {25857}
    TAY                   ; {25860}
    SEP #$20              ; {25861}
    LDA $@binary_06516, X ; {25863}
    AND $1A5E, Y          ; {25867}
    SEC                   ; {25870}
    BNE loc_006512        ; {25871}
    CLC                   ; {25873}

  loc_006512:
    PLX                   ; {25874}
    REP #$20              ; {25875}
    RTS                   ; {25877}
}
---------------------------------------------

binary_06516 #0102040810204080
---------------------------------------------

code_00651E {
    SEP #$20              ; {25886}
    PHA                   ; {25888}
    TAY                   ; {25889}
    DEY                   ; {25890}
    LDA $1B1E, Y          ; {25891}
    AND #$7F              ; {25894}
    BNE loc_00652F        ; {25896}
    PLA                   ; {25898}
    REP #$20              ; {25899}
    SEC                   ; {25901}
    RTS                   ; {25902}

  loc_00652F:
    PLA                   ; {25903}
    LDA $1B1E, Y          ; {25904}
    REP #$20              ; {25907}
    CLC                   ; {25909}
    RTS                   ; {25910}
}

code_006537 {
    LDA $0010, X          ; {25911}
    CLC                   ; {25914}
    ADC $0012, X          ; {25915}
    CMP #$0021            ; {25918}
    BCS loc_006563        ; {25921}
    PHX                   ; {25923}
    LDA $0000, X          ; {25924}
    STA $16               ; {25927}
    LDA $0002, X          ; {25929}
    SEC                   ; {25932}
    SBC #$0010            ; {25933}
    STA $18               ; {25936}
    JSL $@chunk_0270E4.code_0272B8 ; {25938}
    LDA $7F8000, X        ; {25942}
    ORA #$00F0            ; {25946}
    STA $7F8000, X        ; {25949}
    PLX                   ; {25953}
    RTS                   ; {25954}

  loc_006563:
    TXY                   ; {25955}
    LDA $0012, Y          ; {25956}
    LSR                   ; {25959}
    LSR                   ; {25960}
    LSR                   ; {25961}
    LSR                   ; {25962}
    STA $0C               ; {25963}
    LDA $0000, X          ; {25965}
    STA $16               ; {25968}
    LDA $0002, X          ; {25970}
    SEC                   ; {25973}
    SBC $0012, X          ; {25974}

  loc_006579:
    STA $18               ; {25977}
    JSL $@chunk_0270E4.code_0272B8 ; {25979}
    LDA $0010, Y          ; {25983}
    LSR                   ; {25986}
    LSR                   ; {25987}
    LSR                   ; {25988}
    LSR                   ; {25989}
    STA $0E               ; {25990}

  loc_006588:
    LDA $7F8000, X        ; {25992}
    ORA #$00F0            ; {25996}
    STA $7F8000, X        ; {25999}
    JSL $@chunk_0270E4.code_02731A ; {26003}
    DEC $0E               ; {26007}
    BNE loc_006588        ; {26009}
    LDA $18               ; {26011}
    CLC                   ; {26013}
    ADC #$0010            ; {26014}
    DEC $0C               ; {26017}
    BNE loc_006579        ; {26019}
    TYX                   ; {26021}
    RTS                   ; {26022}
}

code_0065A7 {
    LDA $0010, X          ; {26023}
    CLC                   ; {26026}
    ADC $0012, X          ; {26027}
    CMP #$0021            ; {26030}
    BCS loc_0065D3        ; {26033}
    PHX                   ; {26035}
    LDA $0000, X          ; {26036}
    STA $16               ; {26039}
    LDA $0002, X          ; {26041}
    SEC                   ; {26044}
    SBC #$0010            ; {26045}
    STA $18               ; {26048}
    JSL $@chunk_0270E4.code_0272B8 ; {26050}
    LDA $7F8000, X        ; {26054}
    AND #$FF00            ; {26058}
    STA $7F8000, X        ; {26061}
    PLX                   ; {26065}
    RTS                   ; {26066}

  loc_0065D3:
    TXY                   ; {26067}
    LDA $0012, Y          ; {26068}
    LSR                   ; {26071}
    LSR                   ; {26072}
    LSR                   ; {26073}
    LSR                   ; {26074}
    STA $0C               ; {26075}
    LDA $0000, X          ; {26077}
    STA $16               ; {26080}
    LDA $0002, X          ; {26082}
    SEC                   ; {26085}
    SBC $0012, X          ; {26086}

  loc_0065E9:
    STA $18               ; {26089}
    JSL $@chunk_0270E4.code_0272B8 ; {26091}
    LDA $0010, Y          ; {26095}
    LSR                   ; {26098}
    LSR                   ; {26099}
    LSR                   ; {26100}
    LSR                   ; {26101}
    STA $0E               ; {26102}

  loc_0065F8:
    LDA $7F8000, X        ; {26104}
    AND #$FF00            ; {26108}
    STA $7F8000, X        ; {26111}
    JSL $@chunk_0270E4.code_02731A ; {26115}
    DEC $0E               ; {26119}
    BNE loc_0065F8        ; {26121}
    LDA $18               ; {26123}
    CLC                   ; {26125}
    ADC #$0010            ; {26126}
    DEC $0C               ; {26129}
    BNE loc_0065E9        ; {26131}
    TYX                   ; {26133}
    RTS                   ; {26134}
}

code_006617 {
    SEP #$20              ; {26135}
    XBA                   ; {26137}
    LDA #$40              ; {26138}
    JSL $@chunk_010000.code_0131D1 ; {26140}
    REP #$20              ; {26144}
    CLC                   ; {26146}
    ADC #$0800            ; {26147}
    TAY                   ; {26150}
    RTS                   ; {26151}
}

code_006628 {
    ASL                   ; {26152}
    ASL                   ; {26153}
    ASL                   ; {26154}
    ASL                   ; {26155}
    RTS                   ; {26156}
}

code_00662D {
    PHA                   ; {26157}
    PHX                   ; {26158}
    ASL                   ; {26159}
    TAX                   ; {26160}
    LDA $01, S            ; {26161}
    STA $7F0483, X        ; {26163}
    PLX                   ; {26167}
    PLA                   ; {26168}
    RTS                   ; {26169}
}

code_00663A {
    JSL $@code_00668A     ; {26170}
    BCS loc_006661        ; {26174}
    TXA                   ; {26176}
    STA $003E, Y          ; {26177}
    LDA $003C, X          ; {26180}
    STA $003C, Y          ; {26183}
    TYA                   ; {26186}
    STA $003C, X          ; {26187}
    PHX                   ; {26190}
    LDX $003C, Y          ; {26191}
    BNE loc_006659        ; {26194}
    STY $06A6             ; {26196}
    BRA loc_00665D        ; {26199}

  loc_006659:
    TYA                   ; {26201}
    STA $003E, X          ; {26202}

  loc_00665D:
    PLX                   ; {26205}
    JSR $&code_0066A3     ; {26206}

  loc_006661:
    RTS                   ; {26209}
}

code_006662 {
    JSL $@code_00668A     ; {26210}
    BCS loc_006689        ; {26214}
    TXA                   ; {26216}
    STA $003C, Y          ; {26217}
    LDA $003E, X          ; {26220}
    STA $003E, Y          ; {26223}
    TYA                   ; {26226}
    STA $003E, X          ; {26227}
    PHX                   ; {26230}
    LDX $003E, Y          ; {26231}
    BEQ loc_006682        ; {26234}
    TYA                   ; {26236}
    STA $003C, X          ; {26237}
    BRA loc_006685        ; {26240}

  loc_006682:
    STY $06A8             ; {26242}

  loc_006685:
    PLX                   ; {26245}
    JSR $&code_0066A3     ; {26246}

  loc_006689:
    RTS                   ; {26249}
}

code_00668A {
    LDA ($4A)             ; {26250}
    BEQ loc_00669E        ; {26252}
    TAY                   ; {26254}
    LDA #$0000            ; {26255}
    STA ($4A)             ; {26258}
    SEP #$20              ; {26260}
    INC $4A               ; {26262}
    INC $4A               ; {26264}
    REP #$20              ; {26266}
    CLC                   ; {26268}
    RTL                   ; {26269}

  loc_00669E:
    SEC                   ; {26270}
    LDY #$06AA            ; {26271}
    RTL                   ; {26274}
}

code_0066A3 {
    PHX                   ; {26275}
    PHY                   ; {26276}
    LDA #$003B            ; {26277}
    MVN #$01, #$01        ; {26280}
    PLY                   ; {26283}
    PLX                   ; {26284}
    LDA $0016, Y          ; {26285}
    ORA #$2000            ; {26288}
    AND #$FFEF            ; {26291}
    STA $0016, Y          ; {26294}
    LDA #$0000            ; {26297}
    STA $001A, Y          ; {26300}
    STA $0030, Y          ; {26303}
    STA $0014, Y          ; {26306}
    RTS                   ; {26309}
}

code_0066C6 {
    LDA #$3080            ; {26310}
    TSB $0326             ; {26313}
    STX $039C             ; {26316}
    PHX                   ; {26319}
    LDY #$&chunk_010000.asciistring_014176 ; {26320}
    JSL $@chunk_010000.code_012769 ; {26323}
    PLX                   ; {26327}
    COP [1B] ( &code_0066DE, #$0001 ) ; {26328}
}

code_0066DE {
    SEP #$20              ; {26334}
    PHX                   ; {26336}
    JSL $@chunk_0FAA49.code_0FEFBC ; {26337}
    JSL $@chunk_010000.code_012463 ; {26341}
    JSL $@chunk_0270E4.code_02719F ; {26345}
    PLX                   ; {26349}
    REP #$20              ; {26350}
    COP [10] ( #$0A00, #01, #$0000, #$0000 ) ; {26352}
    COP [91]              ; {26361}
    RTL                   ; {26363}
}

code_0066FC {
    LDA #$3000            ; {26364}
    TSB $0326             ; {26367}
    STZ $0322             ; {26370}
    STX $039C             ; {26373}
    LDA $0445             ; {26376}
    BEQ loc_006710        ; {26379}
    BRL loc_006CC1        ; {26381}

  loc_006710:
    COP [85] ( @code_006B61 ) ; {26384}

  code_006715:
    STZ $0482             ; {26389}
    SEP #$20              ; {26392}
    LDA #$E0              ; {26394}
    STA $7F0200           ; {26396}
    LDA #$0F              ; {26400}
    STA $BGMODE           ; {26402}
    LDA #$11              ; {26405}
    STA $TM               ; {26407}
    REP #$20              ; {26410}
    LDA #$FFC8            ; {26412}
    STA $046A             ; {26415}
    LDA #$003E            ; {26418}
    STA $046C             ; {26421}
    LDA #$0083            ; {26424}
    STA $0480             ; {26427}
    COP [91]              ; {26430}
    INC $046A             ; {26432}
    LDA $046A             ; {26435}
    CMP #$013E            ; {26438}
    BEQ loc_00674C        ; {26441}
    RTL                   ; {26443}

  loc_00674C:
    LDA #$0002            ; {26444}
    STA $0480             ; {26447}
    COP [03] ( #1F )      ; {26450}
    COP [04]              ; {26453}
    LDA #$0080            ; {26455}
    STA $046A             ; {26458}
    COP [91]              ; {26461}
    LDA $0480             ; {26463}
    CLC                   ; {26466}
    ADC #$0004            ; {26467}
    STA $0480             ; {26470}
    CMP #$0206            ; {26473}
    BEQ loc_00676F        ; {26476}
    RTL                   ; {26478}

  loc_00676F:
    COP [03] ( #1F )      ; {26479}
    COP [04]              ; {26482}
    PHX                   ; {26484}
    LDY #$&chunk_010000.asciistring_013B36 ; {26485}
    JSL $@chunk_010000.code_012769 ; {26488}
    PLX                   ; {26492}
    COP [85] ( @code_006A5E ) ; {26493}
    COP [03] ( #1F )      ; {26498}
    COP [04]              ; {26501}
    COP [AC] ( @code_006B51, #$FF50, #$0080, #$2300 ) ; {26503}
    COP [AC] ( @code_006B29, #$0198, #$0078, #$0300 ) ; {26514}
    COP [AC] ( @code_006B01, #$0198, #$0078, #$0300 ) ; {26525}
    COP [85] ( @code_006A90 ) ; {26536}
    COP [03] ( #F1 )      ; {26541}
    COP [04]              ; {26544}
    PHX                   ; {26546}
    LDY #$&chunk_010000.asciistring_013B27 ; {26547}
    JSL $@chunk_010000.code_012769 ; {26550}
    PLX                   ; {26554}
    LDA #$3000            ; {26555}
    TRB $0326             ; {26558}
    COP [03] ( #F1 )      ; {26561}
    COP [04]              ; {26564}
    COP [03] ( #79 )      ; {26566}
    COP [04]              ; {26569}
    COP [85] ( @code_006A25 ) ; {26571}
    COP [03] ( #3D )      ; {26576}
    COP [04]              ; {26579}
    INC $0482             ; {26581}
    COP [03] ( #79 )      ; {26584}
    COP [04]              ; {26587}
    PHX                   ; {26589}
    JSL $@chunk_0270E4.code_0276EE ; {26590}
    LDY #$&chunk_010000.asciistring_013B85 ; {26594}
    JSL $@chunk_010000.code_012769 ; {26597}
    PLX                   ; {26601}
    COP [85] ( @code_006A40 ) ; {26602}
    COP [03] ( #F1 )      ; {26607}
    COP [04]              ; {26610}
    COP [03] ( #F1 )      ; {26612}
    COP [04]              ; {26615}
    COP [85] ( @code_006A25 ) ; {26617}
    COP [03] ( #21 )      ; {26622}
    COP [04]              ; {26625}
    PHX                   ; {26627}
    JSL $@chunk_0270E4.code_0276EE ; {26628}
    LDY #$&chunk_010000.asciistring_013BE1 ; {26632}
    JSL $@chunk_010000.code_012769 ; {26635}
    PLX                   ; {26639}
    COP [85] ( @code_006A40 ) ; {26640}
    COP [03] ( #F1 )      ; {26645}
    COP [04]              ; {26648}
    COP [03] ( #F1 )      ; {26650}
    COP [04]              ; {26653}
    COP [85] ( @code_006A25 ) ; {26655}
    COP [03] ( #21 )      ; {26660}
    COP [04]              ; {26663}
    PHX                   ; {26665}
    JSL $@chunk_0270E4.code_0276EE ; {26666}
    LDY #$&chunk_010000.asciistring_013C3D ; {26670}
    JSL $@chunk_010000.code_012769 ; {26673}
    PLX                   ; {26677}
    COP [85] ( @code_006A40 ) ; {26678}
    COP [03] ( #F1 )      ; {26683}
    COP [04]              ; {26686}
    COP [03] ( #F1 )      ; {26688}
    COP [04]              ; {26691}
    COP [85] ( @code_006A25 ) ; {26693}
    COP [03] ( #21 )      ; {26698}
    COP [04]              ; {26701}
    PHX                   ; {26703}
    JSL $@chunk_0270E4.code_0276EE ; {26704}
    LDY #$&chunk_010000.asciistring_013CB6 ; {26708}
    JSL $@chunk_010000.code_012769 ; {26711}
    PLX                   ; {26715}
    COP [85] ( @code_006A40 ) ; {26716}
    COP [03] ( #F1 )      ; {26721}
    COP [04]              ; {26724}
    COP [03] ( #F1 )      ; {26726}
    COP [04]              ; {26729}
    COP [85] ( @code_006A25 ) ; {26731}
    COP [03] ( #21 )      ; {26736}
    COP [04]              ; {26739}
    PHX                   ; {26741}
    JSL $@chunk_0270E4.code_0276EE ; {26742}
    LDY #$&chunk_010000.asciistring_013D4D ; {26746}
    JSL $@chunk_010000.code_012769 ; {26749}
    PLX                   ; {26753}
    COP [85] ( @code_006A40 ) ; {26754}
    COP [03] ( #F1 )      ; {26759}
    COP [04]              ; {26762}
    COP [03] ( #F1 )      ; {26764}
    COP [04]              ; {26767}
    COP [85] ( @code_006A25 ) ; {26769}
    COP [03] ( #21 )      ; {26774}
    COP [04]              ; {26777}
    PHX                   ; {26779}
    JSL $@chunk_0270E4.code_0276EE ; {26780}
    LDY #$&chunk_010000.asciistring_013DBA ; {26784}
    JSL $@chunk_010000.code_012769 ; {26787}
    PLX                   ; {26791}
    COP [85] ( @code_006A40 ) ; {26792}
    COP [03] ( #F1 )      ; {26797}
    COP [04]              ; {26800}
    COP [03] ( #F1 )      ; {26802}
    COP [04]              ; {26805}
    COP [85] ( @code_006A25 ) ; {26807}
    COP [03] ( #21 )      ; {26812}
    COP [04]              ; {26815}
    PHX                   ; {26817}
    JSL $@chunk_0270E4.code_0276EE ; {26818}
    LDY #$&chunk_010000.asciistring_013E2A ; {26822}
    JSL $@chunk_010000.code_012769 ; {26825}
    PLX                   ; {26829}
    COP [85] ( @code_006A40 ) ; {26830}
    COP [03] ( #F1 )      ; {26835}
    COP [04]              ; {26838}
    COP [03] ( #F1 )      ; {26840}
    COP [04]              ; {26843}
    COP [85] ( @code_006A25 ) ; {26845}
    COP [03] ( #21 )      ; {26850}
    COP [04]              ; {26853}
    PHX                   ; {26855}
    JSL $@chunk_0270E4.code_0276EE ; {26856}
    LDY #$&chunk_010000.asciistring_013E51 ; {26860}
    JSL $@chunk_010000.code_012769 ; {26863}
    PLX                   ; {26867}
    COP [85] ( @code_006A40 ) ; {26868}
    COP [03] ( #F1 )      ; {26873}
    COP [04]              ; {26876}
    COP [03] ( #F1 )      ; {26878}
    COP [04]              ; {26881}
    COP [85] ( @code_006A25 ) ; {26883}
    COP [03] ( #21 )      ; {26888}
    COP [04]              ; {26891}
    PHX                   ; {26893}
    JSL $@chunk_0270E4.code_0276EE ; {26894}
    LDY #$&chunk_010000.asciistring_013EBF ; {26898}
    JSL $@chunk_010000.code_012769 ; {26901}
    PLX                   ; {26905}
    COP [85] ( @code_006A40 ) ; {26906}
    COP [03] ( #F1 )      ; {26911}
    COP [04]              ; {26914}
    COP [03] ( #F1 )      ; {26916}
    COP [04]              ; {26919}
    COP [85] ( @code_006A25 ) ; {26921}
    COP [03] ( #21 )      ; {26926}
    COP [04]              ; {26929}
    PHX                   ; {26931}
    JSL $@chunk_0270E4.code_0276EE ; {26932}
    LDY #$&chunk_010000.asciistring_013F35 ; {26936}
    JSL $@chunk_010000.code_012769 ; {26939}
    PLX                   ; {26943}
    COP [85] ( @code_006A40 ) ; {26944}
    COP [03] ( #F1 )      ; {26949}
    COP [04]              ; {26952}
    COP [03] ( #F1 )      ; {26954}
    COP [04]              ; {26957}
    COP [85] ( @code_006A25 ) ; {26959}
    COP [03] ( #21 )      ; {26964}
    COP [04]              ; {26967}
    PHX                   ; {26969}
    JSL $@chunk_0270E4.code_0276EE ; {26970}
    LDY #$&chunk_010000.asciistring_013FCD ; {26974}
    JSL $@chunk_010000.code_012769 ; {26977}
    PLX                   ; {26981}
    COP [85] ( @code_006A40 ) ; {26982}
    COP [03] ( #F1 )      ; {26987}
    COP [04]              ; {26990}
    COP [03] ( #F1 )      ; {26992}
    COP [04]              ; {26995}
    COP [85] ( @code_006A25 ) ; {26997}
    COP [03] ( #21 )      ; {27002}
    COP [04]              ; {27005}
    PHX                   ; {27007}
    JSL $@chunk_0270E4.code_0276EE ; {27008}
    LDY #$&chunk_010000.asciistring_014023 ; {27012}
    JSL $@chunk_010000.code_012769 ; {27015}
    PLX                   ; {27019}
    COP [85] ( @code_006A40 ) ; {27020}
    COP [03] ( #F1 )      ; {27025}
    COP [04]              ; {27028}
    COP [03] ( #F1 )      ; {27030}
    COP [04]              ; {27033}
    COP [85] ( @code_006A25 ) ; {27035}
    COP [03] ( #21 )      ; {27040}
    COP [04]              ; {27043}
    PHX                   ; {27045}
    JSL $@chunk_0270E4.code_0276EE ; {27046}
    LDY #$&chunk_010000.asciistring_01406A ; {27050}
    JSL $@chunk_010000.code_012769 ; {27053}
    PLX                   ; {27057}
    COP [85] ( @code_006A40 ) ; {27058}
    COP [03] ( #F1 )      ; {27063}
    COP [04]              ; {27066}
    COP [03] ( #F1 )      ; {27068}
    COP [04]              ; {27071}
    COP [85] ( @code_006A25 ) ; {27073}
    COP [03] ( #21 )      ; {27078}
    COP [04]              ; {27081}
    PHX                   ; {27083}
    JSL $@chunk_0270E4.code_0276EE ; {27084}
    LDY #$&chunk_010000.asciistring_0140FA ; {27088}
    JSL $@chunk_010000.code_012769 ; {27091}
    PLX                   ; {27095}
    COP [85] ( @code_006A40 ) ; {27096}
    COP [03] ( #F1 )      ; {27101}
    COP [04]              ; {27104}
    COP [03] ( #F1 )      ; {27106}
    COP [04]              ; {27109}
    COP [03] ( #F1 )      ; {27111}
    COP [04]              ; {27114}
    COP [85] ( @code_006A25 ) ; {27116}
    COP [03] ( #21 )      ; {27121}
    COP [04]              ; {27124}
    JSL $@chunk_0270E4.code_0276EE ; {27126}
    COP [03] ( #1F )      ; {27130}
    COP [04]              ; {27133}
    STZ $0482             ; {27135}
    COP [03] ( #81 )      ; {27138}
    COP [04]              ; {27141}
    LDA #$FFFF            ; {27143}
    STA $0482             ; {27146}
    LDA #$FFC8            ; {27149}
    STA $046A             ; {27152}
    LDA #$003E            ; {27155}
    STA $046C             ; {27158}
    LDA #$0083            ; {27161}
    STA $0480             ; {27164}
    COP [1B] ( &code_006715, #$0001 ) ; {27167}
}

code_006A25 {
    STZ $0030, X          ; {27173}
    COP [03] ( #20 )      ; {27176}
    SEP #$20              ; {27179}
    LDA $0030, X          ; {27181}
    ORA #$E0              ; {27184}
    STA $7F0200           ; {27186}
    REP #$20              ; {27190}
    INC $0030, X          ; {27192}
    COP [04]              ; {27195}
    COP [86]              ; {27197}
    RTL                   ; {27199}
}

code_006A40 {
    LDA #$001F            ; {27200}
    STA $0030, X          ; {27203}
    COP [03] ( #20 )      ; {27206}
    SEP #$20              ; {27209}
    LDA $0030, X          ; {27211}
    ORA #$E0              ; {27214}
    STA $7F0200           ; {27216}
    REP #$20              ; {27220}
    DEC $0030, X          ; {27222}
    COP [04]              ; {27225}
    COP [86]              ; {27227}
    RTL                   ; {27229}
}

code_006A5E {
    SEP #$20              ; {27230}
    LDA #$05              ; {27232}
    XBA                   ; {27234}
    LDA #$^binary_006A86  ; {27235}
    LDY #$&binary_006A86  ; {27237}
    JSL $@chunk_010000.code_01188A ; {27240}
    LDA #$2C              ; {27244}
    XBA                   ; {27246}
    LDA #$^binary_006A8B  ; {27247}
    LDY #$&binary_006A8B  ; {27249}
    JSL $@chunk_010000.code_01188A ; {27252}
    REP #$20              ; {27256}
    LDA $0482             ; {27258}
    BNE loc_006A80        ; {27261}
    RTL                   ; {27263}

  loc_006A80:
    STZ $0042             ; {27264}
    COP [86]              ; {27267}
    RTL                   ; {27269}
}
---------------------------------------------

binary_006A86 #7F0F600900
---------------------------------------------

binary_006A8B #7F11601400

code_006A90 {
    COP [03] ( #80 )      ; {27280}
    LDY $003E, X          ; {27283}
    LDA $0000, Y          ; {27286}
    DEC                   ; {27289}
    DEC                   ; {27290}
    STA $0000, Y          ; {27291}
    LDA $003E, Y          ; {27294}
    TAY                   ; {27297}
    LDA $0000, Y          ; {27298}
    DEC                   ; {27301}
    DEC                   ; {27302}
    STA $0000, Y          ; {27303}
    LDA $003E, Y          ; {27306}
    TAY                   ; {27309}
    LDA $0000, Y          ; {27310}
    INC                   ; {27313}
    INC                   ; {27314}
    STA $0000, Y          ; {27315}
    COP [04]              ; {27318}
    COP [91]              ; {27320}
    LDA $0482             ; {27322}
    BNE loc_006AC0        ; {27325}
    RTL                   ; {27327}

  loc_006AC0:
    COP [03] ( #40 )      ; {27328}
    LDY $003E, X          ; {27331}
    LDA $0002, Y          ; {27334}
    DEC                   ; {27337}
    STA $0002, Y          ; {27338}
    LDA $003E, Y          ; {27341}
    TAY                   ; {27344}
    LDA $0002, Y          ; {27345}
    DEC                   ; {27348}
    STA $0002, Y          ; {27349}
    COP [04]              ; {27352}
    COP [91]              ; {27354}
    LDA $0482             ; {27356}
    BEQ loc_006AE2        ; {27359}
    RTL                   ; {27361}

  loc_006AE2:
    COP [03] ( #80 )      ; {27362}
    LDY $003E, X          ; {27365}
    LDA $0000, Y          ; {27368}
    DEC                   ; {27371}
    DEC                   ; {27372}
    STA $0000, Y          ; {27373}
    LDA $003E, Y          ; {27376}
    TAY                   ; {27379}
    LDA $0000, Y          ; {27380}
    DEC                   ; {27383}
    DEC                   ; {27384}
    STA $0000, Y          ; {27385}
    COP [04]              ; {27388}
    COP [86]              ; {27390}
    RTL                   ; {27392}
}

code_006B01 {
    COP [80] ( #00 )      ; {27393}
    COP [82]              ; {27396}
    COP [91]              ; {27398}
    LDA $0482             ; {27400}
    BMI loc_006B26        ; {27403}
    LDA $0000, X          ; {27405}
    CMP #$0098            ; {27408}
    BEQ loc_006B16        ; {27411}
    RTL                   ; {27413}

  loc_006B16:
    COP [80] ( #03 )      ; {27414}
    COP [82]              ; {27417}
    COP [80] ( #00 )      ; {27419}
    COP [82]              ; {27422}
    COP [1B] ( &code_006B01, #$012C ) ; {27424}

  loc_006B26:
    COP [86]              ; {27430}
    RTL                   ; {27432}
}

code_006B29 {
    COP [80] ( #01 )      ; {27433}
    COP [82]              ; {27436}
    COP [91]              ; {27438}
    LDA $0482             ; {27440}
    BMI loc_006B4E        ; {27443}
    LDA $0000, X          ; {27445}
    CMP #$0098            ; {27448}
    BEQ loc_006B3E        ; {27451}
    RTL                   ; {27453}

  loc_006B3E:
    COP [80] ( #04 )      ; {27454}
    COP [82]              ; {27457}
    COP [80] ( #01 )      ; {27459}
    COP [82]              ; {27462}
    COP [1B] ( &code_006B29, #$012C ) ; {27464}

  loc_006B4E:
    COP [86]              ; {27470}
    RTL                   ; {27472}
}

code_006B51 {
    COP [80] ( #02 )      ; {27473}
    COP [82]              ; {27476}
    COP [91]              ; {27478}
    LDA $0482             ; {27480}
    BNE loc_006B5E        ; {27483}
    RTL                   ; {27485}

  loc_006B5E:
    COP [86]              ; {27486}
    RTL                   ; {27488}
}

code_006B61 {
    LDA $0322             ; {27489}
    BIT #$1000            ; {27492}
    BNE loc_006B6A        ; {27495}
    RTL                   ; {27497}

  loc_006B6A:
    COP [10] ( #$0A00, #01, #$0000, #$0000 ) ; {27498}
    LDA #$0001            ; {27507}
    STA $031E             ; {27510}
    STA $0445             ; {27513}
    COP [86]              ; {27516}
    RTL                   ; {27518}
}

code_006B7F {
    LDA $1C6A             ; {27519}
    CMP #$10              ; {27522}
    BNE loc_006BA4        ; {27524}
    JSR $&code_006BF1     ; {27526}
    JSR $&code_006BA8     ; {27529}
    LDX $0476             ; {27532}
    STX $046E             ; {27535}
    LDX $0478             ; {27538}
    STX $0470             ; {27541}
    LDX $047A             ; {27544}
    STX $0472             ; {27547}
    LDX $047C             ; {27550}
    STX $0474             ; {27553}

  loc_006BA4:
    RTL                   ; {27556}
}

code_006BA5 {
    JSR $&code_006C50     ; {27557}
}

code_006BA8 {
    LDA $046E             ; {27560}
    STA $M7A              ; {27563}
    LDA $046F             ; {27566}
    STA $M7A              ; {27569}
    LDA $0470             ; {27572}
    STA $M7B              ; {27575}
    LDA $0471             ; {27578}
    STA $M7B              ; {27581}
    LDA $0472             ; {27584}
    STA $M7C              ; {27587}
    LDA $0473             ; {27590}
    STA $M7C              ; {27593}
    LDA $0474             ; {27596}
    STA $M7D              ; {27599}
    LDA $0475             ; {27602}
    STA $M7D              ; {27605}
    LDA $046A             ; {27608}
    STA $M7X              ; {27611}
    LDA $046B             ; {27614}
    STA $M7X              ; {27617}
    LDA $046C             ; {27620}
    STA $M7Y              ; {27623}
    LDA $046D             ; {27626}
    STA $M7Y              ; {27629}
    RTS                   ; {27632}
}

code_006BF1 {
    SEP #$10              ; {27633}
    LDX $047E             ; {27635}
    REP #$10              ; {27638}
    LDY $0480             ; {27640}
    STY $00               ; {27643}
    XBA                   ; {27645}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27646}
    STA $02               ; {27650}
    JSR $&code_006CA0     ; {27652}
    LDY $MPYM             ; {27655}
    STY $0476             ; {27658}
    LDY $0480             ; {27661}
    STY $00               ; {27664}
    XBA                   ; {27666}
    LDA $@data_00F9F7.binary_00FC84, X ; {27667}
    STA $02               ; {27671}
    JSR $&code_006CA0     ; {27673}
    LDY $MPYM             ; {27676}
    STY $0478             ; {27679}
    LDY $0480             ; {27682}
    STY $00               ; {27685}
    XBA                   ; {27687}
    LDA $@data_00F9F7.binary_00FC84, X ; {27688}
    EOR #$FF              ; {27692}
    INC                   ; {27694}
    STA $02               ; {27695}
    JSR $&code_006CA0     ; {27697}
    LDY $MPYM             ; {27700}
    STY $047A             ; {27703}
    LDY $0480             ; {27706}
    STY $00               ; {27709}
    XBA                   ; {27711}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27712}
    STA $02               ; {27716}
    JSR $&code_006CA0     ; {27718}
    LDY $MPYM             ; {27721}
    STY $047C             ; {27724}
    RTS                   ; {27727}
}

code_006C50 {
    REP #$20              ; {27728}
    TXA                   ; {27730}
    XBA                   ; {27731}
    LSR                   ; {27732}
    LSR                   ; {27733}
    CLC                   ; {27734}
    ADC #$0041            ; {27735}
    ASL                   ; {27738}
    PHA                   ; {27739}
    SEP #$20              ; {27740}
    STA $M7A              ; {27742}
    XBA                   ; {27745}
    STA $M7A              ; {27746}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27749}
    STA $M7B              ; {27753}
    STA $M7B              ; {27756}
    REP #$20              ; {27759}
    LDA $MPYM             ; {27761}
    STA $046E             ; {27764}
    STA $0474             ; {27767}
    PLA                   ; {27770}
    SEP #$20              ; {27771}
    STA $M7A              ; {27773}
    XBA                   ; {27776}
    STA $M7A              ; {27777}
    LDA $@data_00F9F7.binary_00FC84, X ; {27780}
    STA $M7B              ; {27784}
    STA $M7B              ; {27787}
    REP #$20              ; {27790}
    LDA $MPYM             ; {27792}
    STA $0470             ; {27795}
    EOR #$FFFF            ; {27798}
    INC                   ; {27801}
    STA $0472             ; {27802}
    SEP #$20              ; {27805}
    RTS                   ; {27807}
}

code_006CA0 {
    PHP                   ; {27808}
    SEP #$20              ; {27809}
    LDA $00               ; {27811}
    STA $M7A              ; {27813}
    LDA $01               ; {27816}
    STA $M7A              ; {27818}
    LDA $02               ; {27821}
    STA $M7B              ; {27823}
    STA $M7B              ; {27826}
    LDA $MPYL             ; {27829}
    STA $00               ; {27832}
    LDA $MPYM             ; {27834}
    STA $01               ; {27837}
    PLP                   ; {27839}
    RTS                   ; {27840}

  loc_006CC1:
    PHX                   ; {27841}
    JSL $@chunk_010000.code_01232B ; {27842}
    JSR $&code_006D4E     ; {27846}
    PLX                   ; {27849}
    COP [1B] ( &code_006CD0, #$0001 ) ; {27850}
}

code_006CD0 {
    PHX                   ; {27856}
    LDA $701FFE           ; {27857}
    CMP #$0004            ; {27861}
    BCC loc_006CDD        ; {27864}
    LDA #$0000            ; {27866}

  loc_006CDD:
    XBA                   ; {27869}
    CLC                   ; {27870}
    ADC #$0005            ; {27871}
    BRA loc_006CE7        ; {27874}

  loc_006CE4:
    LDA #$0005            ; {27876}

  loc_006CE7:
    JSL $@chunk_010000.code_0121E8 ; {27879}
    BCS loc_006CE4        ; {27883}
    AND #$00FF            ; {27885}
    CMP #$0004            ; {27888}
    BNE loc_006D20        ; {27891}
    LDA #$03FF            ; {27893}
    STA $7F0006           ; {27896}
    LDA #$0004            ; {27900}
    JSL $@chunk_010000.code_0121E8 ; {27903}
    BCS loc_006D14        ; {27907}
    AND #$00FF            ; {27909}
    XBA                   ; {27912}
    ASL                   ; {27913}
    ASL                   ; {27914}
    TAX                   ; {27915}
    STA $700000, X        ; {27916}
    STA $701000, X        ; {27920}

  loc_006D14:
    LDA #$7FFF            ; {27924}
    STA $7F0006           ; {27927}
    JSR $&code_006D4E     ; {27931}
    BRA loc_006CE4        ; {27934}

  loc_006D20:
    STA $03A4             ; {27936}
    JSL $@chunk_0270E4.code_027132 ; {27939}
    PLX                   ; {27943}
    LDA #$0001            ; {27944}
    BCS loc_006D30        ; {27947}
    LDA $1B90             ; {27949}

  loc_006D30:
    STA $scene_next       ; {27952}
    LDA #$0001            ; {27955}
    STA $0380             ; {27958}
    LDA #$0070            ; {27961}
    STA $037C             ; {27964}
    LDA #$0060            ; {27967}
    STA $037E             ; {27970}
    STZ $0445             ; {27973}
    INC $0454             ; {27976}
    COP [91]              ; {27979}
    RTL                   ; {27981}
}

code_006D4E {
    LDY #$&chunk_010000.asciistring_0143B0 ; {27982}
    JSL $@chunk_010000.code_012769 ; {27985}
    STZ $03A4             ; {27989}
    LDX #$0000            ; {27992}
    LDY #$&chunk_010000.binary_01440D ; {27995}
    LDA #$0000            ; {27998}
    PHA                   ; {28001}

  loc_006D62:
    JSL $@chunk_0270E4.code_02716E ; {28002}
    LDA $16               ; {28006}
    CMP $7003FA, X        ; {28008}
    BNE loc_006D8B        ; {28012}
    LDA $18               ; {28014}
    CMP $7003FC, X        ; {28016}
    BNE loc_006D8B        ; {28020}
    PHX                   ; {28022}
    PHY                   ; {28023}
    PHB                   ; {28024}
    TXY                   ; {28025}
    TYA                   ; {28026}
    CLC                   ; {28027}
    ADC #$1000            ; {28028}
    TAY                   ; {28031}
    LDA #$03FD            ; {28032}
    MVN #$70, #$70        ; {28035}
    PLB                   ; {28038}
    PLY                   ; {28039}
    PLX                   ; {28040}
    BRA loc_006DB2        ; {28041}

  loc_006D8B:
    PHX                   ; {28043}
    PHY                   ; {28044}
    PHB                   ; {28045}
    TXY                   ; {28046}
    TXA                   ; {28047}
    CLC                   ; {28048}
    ADC #$1000            ; {28049}
    TAX                   ; {28052}
    LDA #$03FD            ; {28053}
    MVN #$70, #$70        ; {28056}
    PLB                   ; {28059}
    PLY                   ; {28060}
    PLX                   ; {28061}
    JSL $@chunk_0270E4.code_02716E ; {28062}
    LDA $16               ; {28066}
    CMP $7003FA, X        ; {28068}
    BNE loc_006E06        ; {28072}
    LDA $18               ; {28074}
    CMP $7003FC, X        ; {28076}
    BNE loc_006E06        ; {28080}

  loc_006DB2:
    PHY                   ; {28082}
    PHX                   ; {28083}
    TXA                   ; {28084}
    SEC                   ; {28085}
    SBC #$1A5E            ; {28086}
    PHA                   ; {28089}
    CLC                   ; {28090}
    ADC #$1B92            ; {28091}
    TAX                   ; {28094}
    LDA $700200, X        ; {28095}
    STA $0447             ; {28099}
    LDA $700202, X        ; {28102}
    STA $0449             ; {28106}
    LDA $700204, X        ; {28109}
    STA $044B             ; {28113}
    LDA $700206, X        ; {28116}
    STA $044D             ; {28120}
    LDA $700207, X        ; {28123}
    STA $044E             ; {28127}
    LDA $01, S            ; {28130}
    CLC                   ; {28132}
    ADC #$1B6A            ; {28133}
    TAX                   ; {28136}
    LDA $700200, X        ; {28137}
    STA $0450             ; {28141}
    PLA                   ; {28144}
    CLC                   ; {28145}
    ADC #$1B90            ; {28146}
    TAX                   ; {28149}
    LDA $700200, X        ; {28150}
    STA $0452             ; {28154}
    JSL $@chunk_010000.code_012769 ; {28157}
    PLX                   ; {28161}
    PLY                   ; {28162}
    PLA                   ; {28163}
    INC                   ; {28164}
    PHA                   ; {28165}

  loc_006E06:
    INC $03A4             ; {28166}
    TXA                   ; {28169}
    CLC                   ; {28170}
    ADC #$0400            ; {28171}
    TAX                   ; {28174}
    TYA                   ; {28175}
    CLC                   ; {28176}
    ADC #$0014            ; {28177}
    TAY                   ; {28180}
    CPX #$1000            ; {28181}
    BEQ loc_006E1D        ; {28184}
    BRL loc_006D62        ; {28186}

  loc_006E1D:
    STZ $03A4             ; {28189}
    PLA                   ; {28192}
    BNE loc_006E27        ; {28193}
    STA $701FFE           ; {28195}

  loc_006E27:
    RTS                   ; {28199}
}

code_006E28 {
    COP [07] ( #$9F05, &code_006E34 ) ; {28200}
    COP [07] ( #$9F04, &code_007264 ) ; {28206}
}

code_006E34 {
    INC $0454             ; {28212}
    COP [85] ( @code_007141 ) ; {28215}
    LDA #$3080            ; {28220}
    TSB $0326             ; {28223}
    COP [A3]              ; {28226}
    STX $039C             ; {28228}
    STZ $040D             ; {28231}
    STZ $0410             ; {28234}
    COP [85] ( @code_00708E ) ; {28237}
    LDA $0000, X          ; {28242}
    CMP #$0070            ; {28245}
    BEQ code_006EA0       ; {28248}
    CMP #$0030            ; {28250}
    BNE loc_006E62        ; {28253}
    BRL code_006EDE       ; {28255}

  loc_006E62:
    CMP #$01B0            ; {28258}
    BNE loc_006E6A        ; {28261}
    BRL code_006FD4       ; {28263}

  loc_006E6A:
    CMP #$0170            ; {28266}
    BNE loc_006E72        ; {28269}
    BRL code_007026       ; {28271}

  loc_006E72:
    LDA $0002, X          ; {28274}
    CMP #$0170            ; {28277}
    BNE loc_006E7D        ; {28280}
    BRL code_006F30       ; {28282}

  loc_006E7D:
    CMP #$0070            ; {28285}
    BNE loc_006E85        ; {28288}
    BRL code_006F82       ; {28290}

  loc_006E85:
    BRL loc_007073        ; {28293}

  loc_006E88:
    LDA $0322             ; {28296}
    BIT #$0400            ; {28299}
    BNE loc_006EA7        ; {28302}
    BIT #$8000            ; {28304}
    BEQ code_006EA0       ; {28307}
    BRK #$98              ; {28309}
    COP [10] ( #$0100, #00, #$0070, #$0050 ) ; {28311}

  code_006EA0:
    COP [80] ( #10 )      ; {28320}
    COP [82]              ; {28323}
    BRA loc_006E88        ; {28325}

  loc_006EA7:
    COP [08] ( #$9B00, &code_006EA0 ) ; {28327}
    COP [80] ( #01 )      ; {28333}
    COP [82]              ; {28336}
    BRK #$96              ; {28338}
    COP [80] ( #24 )      ; {28340}
    COP [82]              ; {28343}
    COP [80] ( #2F )      ; {28345}
    COP [82]              ; {28348}
    BRL code_006EDE       ; {28350}

  loc_006EC1:
    LDA $0322             ; {28353}
    BIT #$0800            ; {28356}
    BNE loc_006EE5        ; {28359}
    BIT #$0100            ; {28361}
    BNE loc_006EF9        ; {28364}
    BIT #$8000            ; {28366}
    BEQ code_006EDE       ; {28369}
    BRK #$98              ; {28371}
    COP [10] ( #$0200, #00, #$0070, #$0050 ) ; {28373}

  code_006EDE:
    COP [80] ( #02 )      ; {28382}
    COP [82]              ; {28385}
    BRA loc_006EC1        ; {28387}

  loc_006EE5:
    COP [80] ( #03 )      ; {28389}
    COP [82]              ; {28392}
    BRK #$96              ; {28394}
    COP [80] ( #25 )      ; {28396}
    COP [82]              ; {28399}
    COP [80] ( #2E )      ; {28401}
    COP [82]              ; {28404}
    BRL code_006EA0       ; {28406}

  loc_006EF9:
    COP [08] ( #$9B01, &code_006EDE ) ; {28409}
    COP [80] ( #03 )      ; {28415}
    COP [82]              ; {28418}
    BRK #$96              ; {28420}
    COP [80] ( #26 )      ; {28422}
    COP [82]              ; {28425}
    COP [80] ( #2F )      ; {28427}
    COP [82]              ; {28430}
    BRL code_006F30       ; {28432}

  loc_006F13:
    LDA $0322             ; {28435}
    BIT #$0200            ; {28438}
    BNE loc_006F37        ; {28441}
    BIT #$0800            ; {28443}
    BNE loc_006F4B        ; {28446}
    BIT #$8000            ; {28448}
    BEQ code_006F30       ; {28451}
    BRK #$98              ; {28453}
    COP [10] ( #$0300, #00, #$0070, #$0050 ) ; {28455}

  code_006F30:
    COP [80] ( #02 )      ; {28464}
    COP [82]              ; {28467}
    BRA loc_006F13        ; {28469}

  loc_006F37:
    COP [80] ( #03 )      ; {28471}
    COP [82]              ; {28474}
    BRK #$96              ; {28476}
    COP [80] ( #27 )      ; {28478}
    COP [82]              ; {28481}
    COP [80] ( #2F )      ; {28483}
    COP [82]              ; {28486}
    BRL loc_006EC1        ; {28488}

  loc_006F4B:
    COP [08] ( #$9B02, &code_006F30 ) ; {28491}
    COP [80] ( #03 )      ; {28497}
    COP [82]              ; {28500}
    BRK #$96              ; {28502}
    COP [80] ( #29 )      ; {28504}
    COP [82]              ; {28507}
    COP [80] ( #2E )      ; {28509}
    COP [82]              ; {28512}
    BRL loc_006F65        ; {28514}

  loc_006F65:
    LDA $0322             ; {28517}
    BIT #$0400            ; {28520}
    BNE loc_006F89        ; {28523}
    BIT #$0100            ; {28525}
    BNE loc_006F9D        ; {28528}
    BIT #$8000            ; {28530}
    BEQ code_006F82       ; {28533}
    BRK #$98              ; {28535}
    COP [10] ( #$0400, #00, #$0070, #$0050 ) ; {28537}

  code_006F82:
    COP [80] ( #10 )      ; {28546}
    COP [82]              ; {28549}
    BRA loc_006F65        ; {28551}

  loc_006F89:
    COP [80] ( #01 )      ; {28553}
    COP [82]              ; {28556}
    BRK #$96              ; {28558}
    COP [80] ( #28 )      ; {28560}
    COP [82]              ; {28563}
    COP [80] ( #2F )      ; {28565}
    COP [82]              ; {28568}
    BRL loc_006F13        ; {28570}

  loc_006F9D:
    COP [08] ( #$9B03, &code_006F82 ) ; {28573}
    COP [80] ( #01 )      ; {28579}
    COP [82]              ; {28582}
    BRK #$96              ; {28584}
    COP [80] ( #2A )      ; {28586}
    COP [82]              ; {28589}
    COP [80] ( #2F )      ; {28591}
    COP [82]              ; {28594}
    BRL loc_006FB7        ; {28596}

  loc_006FB7:
    LDA $0322             ; {28599}
    BIT #$0200            ; {28602}
    BNE loc_006FDB        ; {28605}
    BIT #$0800            ; {28607}
    BNE loc_006FEF        ; {28610}
    BIT #$8000            ; {28612}
    BEQ code_006FD4       ; {28615}
    BRK #$98              ; {28617}
    COP [10] ( #$0500, #00, #$0070, #$0050 ) ; {28619}

  code_006FD4:
    COP [80] ( #02 )      ; {28628}
    COP [82]              ; {28631}
    BRA loc_006FB7        ; {28633}

  loc_006FDB:
    COP [80] ( #03 )      ; {28635}
    COP [82]              ; {28638}
    BRK #$96              ; {28640}
    COP [80] ( #2B )      ; {28642}
    COP [82]              ; {28645}
    COP [80] ( #2E )      ; {28647}
    COP [82]              ; {28650}
    BRL loc_006F65        ; {28652}

  loc_006FEF:
    COP [08] ( #$9B04, &code_006FD4 ) ; {28655}
    COP [80] ( #03 )      ; {28661}
    COP [82]              ; {28664}
    BRK #$96              ; {28666}
    COP [80] ( #2C )      ; {28668}
    COP [82]              ; {28671}
    COP [80] ( #2E )      ; {28673}
    COP [82]              ; {28676}
    BRL loc_007009        ; {28678}

  loc_007009:
    LDA $0322             ; {28681}
    BIT #$0400            ; {28684}
    BNE loc_00702D        ; {28687}
    BIT #$0800            ; {28689}
    BNE loc_007041        ; {28692}
    BIT #$8000            ; {28694}
    BEQ code_007026       ; {28697}
    BRK #$98              ; {28699}
    COP [10] ( #$0600, #00, #$0070, #$0050 ) ; {28701}

  code_007026:
    COP [80] ( #10 )      ; {28710}
    COP [82]              ; {28713}
    BRA loc_007009        ; {28715}

  loc_00702D:
    COP [80] ( #01 )      ; {28717}
    COP [82]              ; {28720}
    BRK #$96              ; {28722}
    COP [80] ( #2D )      ; {28724}
    COP [82]              ; {28727}
    COP [80] ( #2F )      ; {28729}
    COP [82]              ; {28732}
    BRL loc_006FB7        ; {28734}

  loc_007041:
    COP [08] ( #$9B05, &code_007026 ) ; {28737}
    COP [80] ( #01 )      ; {28743}
    COP [82]              ; {28746}
    BRK #$96              ; {28748}
    COP [80] ( #1F )      ; {28750}
    COP [82]              ; {28753}
    COP [80] ( #2E )      ; {28755}
    COP [82]              ; {28758}
    BRL loc_00705B        ; {28760}

  loc_00705B:
    LDA $0322             ; {28763}
    BIT #$0100            ; {28766}
    BNE loc_00707A        ; {28769}
    BIT #$8000            ; {28771}
    BEQ loc_007073        ; {28774}
    BRK #$98              ; {28776}
    COP [10] ( #$0700, #00, #$0070, #$0050 ) ; {28778}

  loc_007073:
    COP [80] ( #10 )      ; {28787}
    COP [82]              ; {28790}
    BRA loc_00705B        ; {28792}

  loc_00707A:
    COP [80] ( #01 )      ; {28794}
    COP [82]              ; {28797}
    BRK #$96              ; {28799}
    COP [80] ( #1E )      ; {28801}
    COP [82]              ; {28804}
    COP [80] ( #2E )      ; {28806}
    COP [82]              ; {28809}
    BRL loc_007009        ; {28811}
}

code_00708E {
    LDY $039C             ; {28814}
    LDA $0000, Y          ; {28817}
    STA $0374             ; {28820}
    LSR                   ; {28823}
    LSR                   ; {28824}
    LSR                   ; {28825}
    LSR                   ; {28826}
    STA $0378             ; {28827}
    LDA $0002, Y          ; {28830}
    STA $0376             ; {28833}
    LSR                   ; {28836}
    LSR                   ; {28837}
    LSR                   ; {28838}
    LSR                   ; {28839}
    DEC                   ; {28840}
    STA $037A             ; {28841}
    PHX                   ; {28844}
    JSL $@chunk_010000.code_010000 ; {28845}
    PLX                   ; {28849}
    RTL                   ; {28850}
}

code_0070B3 {
    COP [07] ( #$9F05, &code_0070BF ) ; {28851}
    COP [07] ( #$9F04, &code_0070C2 ) ; {28857}
}

code_0070BF {
    COP [91]              ; {28863}
    RTL                   ; {28865}
}

code_0070C2 {
    COP [86]              ; {28866}
    RTL                   ; {28868}
}

code_0070C5 {
    RTL                   ; {28869}
}

code_0070C6 {
    COP [A3]              ; {28870}
    RTL                   ; {28872}
}

code_0070C9 {
    BRA code_0070B3       ; {28873}

  code_0070CB:
    RTL                   ; {28875}
}

code_0070CC {
    RTL                   ; {28876}
}

code_0070CD {
    BRA code_0070B3       ; {28877}

  code_0070CF:
    COP [80] ( #04 )      ; {28879}
    COP [82]              ; {28882}
    RTL                   ; {28884}
}

code_0070D5 {
    COP [80] ( #05 )      ; {28885}
    COP [82]              ; {28888}
    RTL                   ; {28890}
}

code_0070DB {
    COP [80] ( #30 )      ; {28891}
    COP [82]              ; {28894}
    RTL                   ; {28896}
}

code_0070E1 {
    RTL                   ; {28897}
}

code_0070E2 {
    RTL                   ; {28898}
}

code_0070E3 {
    COP [14] ( #$00B6, &code_0070EC ) ; {28899}
    COP [91]              ; {28905}
    RTL                   ; {28907}
}

code_0070EC {
    COP [80] ( #18 )      ; {28908}
    COP [82]              ; {28911}
    COP [91]              ; {28913}
    RTL                   ; {28915}
}

code_0070F4 {
    COP [14] ( #$0009, &code_0070FB ) ; {28916}
    RTL                   ; {28922}
}

code_0070FB {
    COP [80] ( #14 )      ; {28923}
    COP [82]              ; {28926}
    COP [91]              ; {28928}
    RTL                   ; {28930}
}

code_007103 {
    RTL                   ; {28931}
}

code_007104 {
    COP [14] ( #$012F, &code_00710D ) ; {28932}
    COP [91]              ; {28938}
    RTL                   ; {28940}
}

code_00710D {
    COP [80] ( #12 )      ; {28941}
    COP [82]              ; {28944}
    COP [91]              ; {28946}
    RTL                   ; {28948}
}

code_007115 {
    COP [80] ( #31 )      ; {28949}
    COP [82]              ; {28952}
    RTL                   ; {28954}
}

code_00711B {
    COP [80] ( #32 )      ; {28955}
    COP [82]              ; {28958}
    RTL                   ; {28960}
}

code_007121 {
    COP [80] ( #33 )      ; {28961}
    COP [82]              ; {28964}
    RTL                   ; {28966}
}

code_007127 {
    COP [07] ( #$9F05, &code_007133 ) ; {28967}
    COP [07] ( #$9F04, &code_00713A ) ; {28973}
}

code_007133 {
    COP [92] ( #2D )      ; {28979}
    COP [94]              ; {28982}
    BRA code_007133       ; {28984}
}

code_00713A {
    COP [92] ( #4B )      ; {28986}
    COP [94]              ; {28989}
    BRA code_00713A       ; {28991}
}

code_007141 {
    COP [07] ( #$9B00, &code_007149 ) ; {28993}
    BRA loc_00716F        ; {28999}
}

code_007149 {
    COP [AC] ( @code_007161, #$0070, #$00D0, #$0040 ) ; {29001}
    COP [AC] ( @code_007169, #$0030, #$0150, #$0040 ) ; {29012}
    BRA loc_00716F        ; {29023}
}

code_007161 {
    COP [96]              ; {29025}
    LDA #$000E            ; {29027}
    BRL loc_007254        ; {29030}
}

code_007169 {
    LDA #$000B            ; {29033}
    BRL loc_007254        ; {29036}

  loc_00716F:
    COP [07] ( #$9B01, &code_007177 ) ; {29039}
    BRA loc_00719D        ; {29045}
}

code_007177 {
    COP [AC] ( @code_00718F, #$0040, #$0160, #$0040 ) ; {29047}
    COP [AC] ( @code_007195, #$00E0, #$0160, #$0040 ) ; {29058}
    BRA loc_00719D        ; {29069}
}

code_00718F {
    LDA #$0008            ; {29071}
    BRL loc_007254        ; {29074}
}

code_007195 {
    COP [96]              ; {29077}
    LDA #$0008            ; {29079}
    BRL loc_007254        ; {29082}

  loc_00719D:
    COP [07] ( #$9B02, &code_0071A5 ) ; {29085}
    BRA loc_0071CB        ; {29091}
}

code_0071A5 {
    COP [AC] ( @code_0071BD, #$00F0, #$0150, #$0040 ) ; {29093}
    COP [AC] ( @code_0071C3, #$00F0, #$0080, #$0040 ) ; {29104}
    BRA loc_0071CB        ; {29115}
}

code_0071BD {
    LDA #$0007            ; {29117}
    BRL loc_007254        ; {29120}
}

code_0071C3 {
    COP [98]              ; {29123}
    LDA #$0007            ; {29125}
    BRL loc_007254        ; {29128}

  loc_0071CB:
    COP [07] ( #$9B03, &code_0071D3 ) ; {29131}
    BRA loc_0071F7        ; {29137}
}

code_0071D3 {
    COP [AC] ( @code_0071EB, #$0100, #$0070, #$0040 ) ; {29139}
    COP [AC] ( @code_0071F1, #$01A0, #$0140, #$0040 ) ; {29150}
    BRA loc_0071F7        ; {29161}
}

code_0071EB {
    LDA #$000C            ; {29163}
    BRL loc_007254        ; {29166}
}

code_0071F1 {
    LDA #$000F            ; {29169}
    BRL loc_007254        ; {29172}

  loc_0071F7:
    COP [07] ( #$9B04, &code_0071FF ) ; {29175}
    BRA loc_007225        ; {29181}
}

code_0071FF {
    COP [AC] ( @code_007217, #$01B0, #$0130, #$0040 ) ; {29183}
    COP [AC] ( @code_00721F, #$0170, #$0090, #$0040 ) ; {29194}
    BRA loc_007225        ; {29205}
}

code_007217 {
    COP [96]              ; {29207}
    LDA #$000B            ; {29209}
    BRL loc_007254        ; {29212}
}

code_00721F {
    LDA #$000E            ; {29215}
    BRL loc_007254        ; {29218}

  loc_007225:
    COP [07] ( #$9B05, &code_00722D ) ; {29221}
    BRA loc_007243        ; {29227}
}

code_00722D {
    COP [AC] ( @code_007246, #$0170, #$0050, #$0040 ) ; {29229}
    COP [AC] ( @code_00724E, #$0100, #$0030, #$0040 ) ; {29240}

  loc_007243:
    COP [86]              ; {29251}
    RTL                   ; {29253}
}

code_007246 {
    COP [96]              ; {29254}
    LDA #$000A            ; {29256}
    BRL loc_007254        ; {29259}
}

code_00724E {
    LDA #$0009            ; {29262}
    BRL loc_007254        ; {29265}

  loc_007254:
    STA $001E, X          ; {29268}
    STZ $0020, X          ; {29271}
    COP [91]              ; {29274}
    COP [82]              ; {29276}

  code_00725E:
    COP [1B] ( &code_00725E, #$00FF ) ; {29278}
}

code_007264 {
    LDA #$BF80            ; {29284}
    TSB $0326             ; {29287}
    COP [85] ( @code_007290 ) ; {29290}
    COP [34]              ; {29295}
    BRK #$86              ; {29297}
    COP [1B] ( &code_007279, #$01A4 ) ; {29299}
}

code_007279 {
    INC $0454             ; {29305}
    STZ $040D             ; {29308}
    STZ $0410             ; {29311}
    COP [09] ( #$9F05 )   ; {29314}
    COP [10] ( #$0700, #00, #$0070, #$0060 ) ; {29318}
    RTL                   ; {29327}
}

code_007290 {
    COP [A8] ( #$8000, #0D ) ; {29328}
    COP [92] ( #44 )      ; {29333}
    COP [94]              ; {29336}
    COP [86]              ; {29338}
    RTL                   ; {29340}
}

code_00729D {
    LDA $0016, X          ; {29341}
    ORA #$2010            ; {29344}
    STA $0016, X          ; {29347}
    STX $039C             ; {29350}
    STZ $0386             ; {29353}
    LDA #$00FF            ; {29356}
    STA $0388             ; {29359}
    STZ $046A             ; {29362}
    STZ $0466             ; {29365}
    STZ $0482             ; {29368}
    SEP #$20              ; {29371}
    LDA #$93              ; {29373}
    STA $CGADSUB          ; {29375}
    LDA #$FF              ; {29378}
    STA $7F0200           ; {29380}
    REP #$20              ; {29384}
    LDA #$FFFF            ; {29386}
    TSB $0326             ; {29389}
    COP [85] ( @code_00758C ) ; {29392}
    COP [85] ( @code_0074E8 ) ; {29397}
    COP [1B] ( &code_0072E0, #$0002 ) ; {29402}
}

code_0072E0 {
    LDA #$001F            ; {29408}
    STA $0030, X          ; {29411}
    COP [03] ( #20 )      ; {29414}
    SEP #$20              ; {29417}
    LDA $0030, X          ; {29419}
    ORA #$E0              ; {29422}
    STA $7F0200           ; {29424}
    REP #$20              ; {29428}
    DEC $0030, X          ; {29430}
    COP [1B] ( &code_0072FF, #$0004 ) ; {29433}
}

code_0072FF {
    COP [04]              ; {29439}
    COP [1B] ( &code_007307, #$0078 ) ; {29441}
}

code_007307 {
    PHX                   ; {29447}
    LDY #$&chunk_010000.asciistring_014192 ; {29448}
    JSL $@chunk_010000.code_012769 ; {29451}
    PLX                   ; {29455}
    INC $0466             ; {29456}
    COP [1B] ( &code_007319, #$02D0 ) ; {29459}
}

code_007319 {
    STZ $0466             ; {29465}
    JSL $@chunk_0270E4.code_0276EE ; {29468}
    COP [1B] ( &code_007326, #$0070 ) ; {29472}
}

code_007326 {
    PHX                   ; {29478}
    LDY #$&chunk_010000.asciistring_0141F1 ; {29479}
    JSL $@chunk_010000.code_012769 ; {29482}
    PLX                   ; {29486}
    INC $0466             ; {29487}
    COP [1B] ( &code_007338, #$02D0 ) ; {29490}
}

code_007338 {
    STZ $0466             ; {29496}
    JSL $@chunk_0270E4.code_0276EE ; {29499}
    COP [1B] ( &code_007345, #$0070 ) ; {29503}
}

code_007345 {
    PHX                   ; {29509}
    LDY #$&chunk_010000.asciistring_014228 ; {29510}
    JSL $@chunk_010000.code_012769 ; {29513}
    PLX                   ; {29517}
    INC $0466             ; {29518}
    COP [1B] ( &code_007357, #$02D0 ) ; {29521}
}

code_007357 {
    STZ $0466             ; {29527}
    JSL $@chunk_0270E4.code_0276EE ; {29530}
    COP [1B] ( &code_007364, #$0070 ) ; {29534}
}

code_007364 {
    PHX                   ; {29540}
    LDY #$&chunk_010000.asciistring_01426F ; {29541}
    JSL $@chunk_010000.code_012769 ; {29544}
    PLX                   ; {29548}
    INC $0466             ; {29549}
    COP [1B] ( &code_007376, #$02D0 ) ; {29552}
}

code_007376 {
    STZ $0466             ; {29558}
    JSL $@chunk_0270E4.code_0276EE ; {29561}
    COP [1B] ( &code_007383, #$0070 ) ; {29565}
}

code_007383 {
    COP [1B] ( &code_007389, #$0078 ) ; {29571}
}

code_007389 {
    COP [B0] ( @code_0074D3, #$2010 ) ; {29577}
    COP [AC] ( @code_00748F, #$0190, #$0080, #$0050 ) ; {29584}
    COP [AC] ( @code_007460, #$0190, #$0070, #$0050 ) ; {29595}
    COP [91]              ; {29606}
    LDA $0482             ; {29608}
    BNE loc_0073AE        ; {29611}
    RTL                   ; {29613}

  loc_0073AE:
    COP [1B] ( &code_0073B4, #$0078 ) ; {29614}
}

code_0073B4 {
    PHX                   ; {29620}
    LDY #$&chunk_010000.asciistring_0142BB ; {29621}
    JSL $@chunk_010000.code_012769 ; {29624}
    PLX                   ; {29628}
    INC $0466             ; {29629}
    COP [1B] ( &code_0073C6, #$0438 ) ; {29632}
}

code_0073C6 {
    STZ $0466             ; {29638}
    JSL $@chunk_0270E4.code_0276EE ; {29641}
    COP [1B] ( &code_0073D3, #$0070 ) ; {29645}
}

code_0073D3 {
    PHX                   ; {29651}
    LDY #$&chunk_010000.asciistring_0142E1 ; {29652}
    JSL $@chunk_010000.code_012769 ; {29655}
    PLX                   ; {29659}
    INC $0466             ; {29660}
    COP [1B] ( &code_0073E5, #$0438 ) ; {29663}
}

code_0073E5 {
    STZ $0466             ; {29669}
    JSL $@chunk_0270E4.code_0276EE ; {29672}
    COP [1B] ( &code_0073F2, #$0070 ) ; {29676}
}

code_0073F2 {
    PHX                   ; {29682}
    LDY #$&chunk_010000.asciistring_014339 ; {29683}
    JSL $@chunk_010000.code_012769 ; {29686}
    PLX                   ; {29690}
    INC $0466             ; {29691}
    COP [1B] ( &code_007404, #$0438 ) ; {29694}
}

code_007404 {
    STZ $0466             ; {29700}
    JSL $@chunk_0270E4.code_0276EE ; {29703}
    COP [1B] ( &code_007411, #$0070 ) ; {29707}
}

code_007411 {
    LDA #$0001            ; {29713}
    TSB $03B8             ; {29716}
    COP [1B] ( &code_00741D, #$0078 ) ; {29719}
}

code_00741D {
    INC $0482             ; {29725}
    COP [91]              ; {29728}
    LDA $0482             ; {29730}
    CMP #$0004            ; {29733}
    BEQ loc_00742B        ; {29736}
    RTL                   ; {29738}

  loc_00742B:
    COP [1B] ( &code_007431, #$0078 ) ; {29739}
}

code_007431 {
    DEC $0466             ; {29745}
    COP [85] ( @code_007638 ) ; {29748}
    COP [1B] ( &code_00743F, #$00F0 ) ; {29753}
}

code_00743F {
    STZ $0030, X          ; {29759}
    COP [03] ( #20 )      ; {29762}
    SEP #$20              ; {29765}
    LDA $0030, X          ; {29767}
    ORA #$E0              ; {29770}
    STA $7F0200           ; {29772}
    REP #$20              ; {29776}
    INC $0030, X          ; {29778}
    COP [1B] ( &code_00745B, #$0010 ) ; {29781}
}

code_00745B {
    COP [04]              ; {29787}
    COP [91]              ; {29789}
    RTL                   ; {29791}
}

code_007460 {
    COP [80] ( #00 )      ; {29792}
    COP [82]              ; {29795}
    LDA $0482             ; {29797}
    CMP #$0001            ; {29800}
    BNE code_007460       ; {29803}
    COP [80] ( #02 )      ; {29805}
    COP [82]              ; {29808}
    LDA $0482             ; {29810}
    CMP #$0002            ; {29813}
    BNE code_007460       ; {29816}
    COP [80] ( #00 )      ; {29818}
    COP [82]              ; {29821}
    COP [80] ( #03 )      ; {29823}
    COP [82]              ; {29826}
    COP [80] ( #01 )      ; {29828}
    COP [82]              ; {29831}
    INC $0482             ; {29833}
    COP [91]              ; {29836}
    RTL                   ; {29838}
}

code_00748F {
    COP [80] ( #04 )      ; {29839}
    COP [82]              ; {29842}
    LDA $0482             ; {29844}
    CMP #$0003            ; {29847}
    BNE code_00748F       ; {29850}
    COP [80] ( #04 )      ; {29852}
    COP [82]              ; {29855}
    COP [80] ( #06 )      ; {29857}
    COP [82]              ; {29860}
    COP [80] ( #05 )      ; {29862}
    COP [82]              ; {29865}
    INC $0482             ; {29867}
    COP [91]              ; {29870}
    RTL                   ; {29872}
}

code_0074B1 {
    COP [80] ( #07 )      ; {29873}
    COP [82]              ; {29876}
    LDA $0482             ; {29878}
    CMP #$0004            ; {29881}
    BNE code_0074B1       ; {29884}
    COP [80] ( #07 )      ; {29886}
    COP [82]              ; {29889}
    COP [80] ( #08 )      ; {29891}
    COP [82]              ; {29894}
    COP [80] ( #09 )      ; {29896}
    COP [82]              ; {29899}
    INC $0482             ; {29901}
    COP [91]              ; {29904}
    RTL                   ; {29906}
}

code_0074D3 {
    INC $046A             ; {29907}
    LDA $046A             ; {29910}
    STA $033A             ; {29913}
    CMP #$0100            ; {29916}
    BEQ loc_0074E2        ; {29919}
    RTL                   ; {29921}

  loc_0074E2:
    INC $0482             ; {29922}
    COP [91]              ; {29925}
    RTL                   ; {29927}
}

code_0074E8 {
    LDA $0016, X          ; {29928}
    ORA #$0010            ; {29931}
    STA $0016, X          ; {29934}
    STZ $0030, X          ; {29937}
    PHX                   ; {29940}
    LDX #$0000            ; {29941}
    LDA #$0070            ; {29944}
    STA $7E7800, X        ; {29947}
    LDA #$0030            ; {29951}
    STA $7E7803, X        ; {29954}
    LDA #$0010            ; {29958}
    STA $7E7806, X        ; {29961}
    LDA #$0010            ; {29965}
    STA $7E7809, X        ; {29968}
    LDA #$0010            ; {29972}
    STA $7E780C, X        ; {29975}
    LDA #$0008            ; {29979}
    STA $7E780F, X        ; {29982}
    LDA #$0001            ; {29986}
    STA $7E7812, X        ; {29989}
    LDA #$0000            ; {29993}
    STA $7E7815, X        ; {29996}
    STA $7E7801, X        ; {30000}
    PLX                   ; {30004}
    COP [91]              ; {30005}
    PHX                   ; {30007}
    TXY                   ; {30008}
    LDX #$0000            ; {30009}
    LDA $046A             ; {30012}
    LSR                   ; {30015}
    STA $16               ; {30016}
    STA $7E780A, X        ; {30018}
    LDA $0030, Y          ; {30022}
    LSR                   ; {30025}
    PHA                   ; {30026}
    LSR                   ; {30027}
    CLC                   ; {30028}
    ADC $01, S            ; {30029}
    LSR                   ; {30031}
    CLC                   ; {30032}
    ADC $16               ; {30033}
    STA $7E7810, X        ; {30035}
    PLA                   ; {30039}
    LDA $0030, Y          ; {30040}
    LSR                   ; {30043}
    CLC                   ; {30044}
    ADC $16               ; {30045}
    STA $7E7804, X        ; {30047}
    STA $7E7813, X        ; {30051}
    LDA $0030, Y          ; {30055}
    LSR                   ; {30058}
    LSR                   ; {30059}
    CLC                   ; {30060}
    ADC $16               ; {30061}
    STA $7E7807, X        ; {30063}
    STA $7E780D, X        ; {30067}
    SEP #$20              ; {30071}
    LDA #$0F              ; {30073}
    XBA                   ; {30075}
    LDA #$7E              ; {30076}
    LDY #$7800            ; {30078}
    JSL $@chunk_010000.code_01188A ; {30081}
    REP #$20              ; {30085}
    PLX                   ; {30087}
    INC $0030, X          ; {30088}
    RTL                   ; {30091}
}

code_00758C {
    LDA $0016, X          ; {30092}
    ORA #$0010            ; {30095}
    STA $0016, X          ; {30098}

  loc_007595:
    COP [91]              ; {30101}
    LDA $0466             ; {30103}
    BMI loc_0075DE        ; {30106}
    BNE loc_0075A2        ; {30108}
    JSR $&code_0075E7     ; {30110}
    RTL                   ; {30113}

  loc_0075A2:
    STZ $0030, X          ; {30114}
    COP [03] ( #E0 )      ; {30117}
    LDA $0030, X          ; {30120}
    JSR $&code_0075E7     ; {30123}
    COP [27] ( &code_0075B2 ) ; {30126}
}

code_0075B2 {
    LDA $0030, X          ; {30130}
    JSR $&code_0075E7     ; {30133}
    INC $0030, X          ; {30136}
    COP [04]              ; {30139}
    COP [91]              ; {30141}
    LDA $0466             ; {30143}
    BEQ loc_0075CB        ; {30146}
    LDA #$00E0            ; {30148}
    JSR $&code_0075E7     ; {30151}
    RTL                   ; {30154}

  loc_0075CB:
    COP [03] ( #70 )      ; {30155}
    LDA $0030, X          ; {30158}
    JSR $&code_0075E7     ; {30161}
    DEC $0030, X          ; {30164}
    DEC $0030, X          ; {30167}
    COP [04]              ; {30170}
    BRA loc_007595        ; {30172}

  loc_0075DE:
    COP [91]              ; {30174}
    LDA #$00E0            ; {30176}
    JSR $&code_0075E7     ; {30179}
    RTL                   ; {30182}
}

code_0075E7 {
    PHX                   ; {30183}
    SEP #$20              ; {30184}
    LDX #$0000            ; {30186}
    CMP #$00              ; {30189}
    BEQ loc_007614        ; {30191}
    CMP #$80              ; {30193}
    BCC loc_007608        ; {30195}
    SEC                   ; {30197}
    SBC #$7F              ; {30198}
    PHA                   ; {30200}
    LDA #$7F              ; {30201}
    STA $7E7000, X        ; {30203}
    LDA #$17              ; {30207}
    STA $7E7001, X        ; {30209}
    INX                   ; {30213}
    INX                   ; {30214}
    PLA                   ; {30215}

  loc_007608:
    STA $7E7000, X        ; {30216}
    LDA #$17              ; {30220}
    STA $7E7001, X        ; {30222}
    INX                   ; {30226}
    INX                   ; {30227}

  loc_007614:
    LDA #$01              ; {30228}
    STA $7E7000, X        ; {30230}
    LDA #$13              ; {30234}
    STA $7E7001, X        ; {30236}
    INX                   ; {30240}
    INX                   ; {30241}
    LDA #$00              ; {30242}
    STA $7E7000, X        ; {30244}
    LDA #$2C              ; {30248}
    XBA                   ; {30250}
    LDA #$7E              ; {30251}
    LDY #$7000            ; {30253}
    JSL $@chunk_010000.code_01188A ; {30256}
    REP #$20              ; {30260}
    PLX                   ; {30262}
    RTS                   ; {30263}
}

code_007638 {
    PHX                   ; {30264}
    LDY #$&chunk_010000.asciistring_016264 ; {30265}
    JSL $@chunk_010000.code_0126CF ; {30268}
    PLX                   ; {30272}
    COP [1B] ( &code_007647, #$00F0 ) ; {30273}
}

code_007647 {
    COP [31] ( #00 )      ; {30279}
    COP [1B] ( &code_007650, #$00F0 ) ; {30282}
}

code_007650 {
    COP [10] ( #$0D00, #02, #$0000, #$0000 ) ; {30288}
    SEP #$20              ; {30297}
    STZ $1B82             ; {30299}
    REP #$20              ; {30302}
    LDA #$0020            ; {30304}
    STA $03B4             ; {30307}
    INC $0454             ; {30310}
    COP [91]              ; {30313}
    RTL                   ; {30315}
}

code_00766C {
    COP [37]              ; {30316}

  code_00766E:
    COP [91]              ; {30318}
    COP [0D] ( #00, #07, #04, &code_00767F ) ; {30320}
    COP [0D] ( #00, #07, #06, &code_007765 ) ; {30327}
    RTL                   ; {30334}
}

code_00767F {
    COP [01] ( &asciistring_0077B0 ) ; {30335}
    COP [07] ( #$9B00, &code_00769C ) ; {30339}
    COP [1A] ( &chunk_010000.asciistring_014F43, #02, &code_007754 ) ; {30345}
    LDA $0003D0           ; {30352}
    BNE loc_007699        ; {30356}
    BRL code_0076EF       ; {30358}

  loc_007699:
    BRL code_007754       ; {30361}
}

code_00769C {
    COP [1A] ( &chunk_010000.asciistring_014F23, #03, &code_007754 ) ; {30364}
    LDA $0003D0           ; {30371}
    BNE loc_0076AC        ; {30375}
    BRL code_0076EF       ; {30377}

  loc_0076AC:
    DEC                   ; {30380}
    BEQ loc_0076B2        ; {30381}
    BRL code_007754       ; {30383}

  loc_0076B2:
    COP [01] ( &asciistring_007866 ) ; {30386}
    PHX                   ; {30390}
    LDA #$0009            ; {30391}
    STA $scene_next       ; {30394}
    LDA $03BA             ; {30397}
    ASL                   ; {30400}
    ASL                   ; {30401}
    TAX                   ; {30402}
    LDA $@data_0076D3, X  ; {30403}
    STA $037C             ; {30407}
    LDA $@data_0076D3+2, X ; {30410}
    STA $037E             ; {30414}
    PLX                   ; {30417}
    RTL                   ; {30418}
}
---------------------------------------------

data_0076D3 [
  unk4 < #$0070, #$00A0 >   ;00
  unk4 < #$0030, #$0160 >   ;01
  unk4 < #$00F0, #$0160 >   ;02
  unk4 < #$00F0, #$0060 >   ;03
  unk4 < #$01B0, #$0140 >   ;04
  unk4 < #$0170, #$0060 >   ;05
  unk4 < #$00F0, #$0020 >   ;06
]
---------------------------------------------

code_0076EF {
    COP [01] ( &asciistring_0077D4 ) ; {30447}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_007754 ) ; {30451}
    LDA $0003D0           ; {30458}
    DEC                   ; {30462}
    BEQ code_007754       ; {30463}
    BRK #$66              ; {30465}
    PHX                   ; {30467}
    JSL $@chunk_0270E4.code_0270E4 ; {30468}
    PLX                   ; {30472}
    LDA #$7FC0            ; {30473}
    TSB $0326             ; {30476}
    COP [03] ( #3D )      ; {30479}
    COP [04]              ; {30482}
    LDA #$7FC0            ; {30484}
    TRB $0326             ; {30487}
    COP [01] ( &asciistring_0077FA ) ; {30490}
    COP [1A] ( &chunk_010000.asciistring_014F02, #02, &code_007754 ) ; {30494}
    LDA $0003D0           ; {30501}
    BEQ code_007754       ; {30505}
    COP [01] ( &asciistring_007825 ) ; {30507}
    LDA #$7F80            ; {30511}
    TSB $0326             ; {30514}
    COP [03] ( #1F )      ; {30517}
    COP [04]              ; {30520}
    BRK #$8E              ; {30522}
    COP [AC] ( @code_007798, #$0070, #$0050, #$0050 ) ; {30524}
    COP [34]              ; {30535}
    COP [03] ( #3D )      ; {30537}
    COP [04]              ; {30540}
    COP [31] ( #13 )      ; {30542}
    COP [91]              ; {30545}
    RTL                   ; {30547}
}

code_007754 {
    COP [01] ( &asciistring_007848 ) ; {30548}
    COP [91]              ; {30552}
    COP [0D] ( #00, #07, #04, &code_007764 ) ; {30554}
    BRL code_00766E       ; {30561}
}

code_007764 {
    RTL                   ; {30564}
}

code_007765 {
    LDA $043F             ; {30565}
    BEQ loc_00777B        ; {30568}
    STZ $043F             ; {30570}
    COP [1B] ( &code_007773, #$0002 ) ; {30573}
}

code_007773 {
    COP [01] ( &asciistring_00786A ) ; {30579}
    COP [27] ( &code_00766E ) ; {30583}

  loc_00777B:
    COP [07] ( #$8602, &code_007794 ) ; {30587}
    COP [07] ( #$1B00, &code_007794 ) ; {30593}
    COP [03] ( #03 )      ; {30599}
    COP [04]              ; {30602}
    COP [09] ( #$8602 )   ; {30604}
    COP [01] ( &asciistring_0078BB ) ; {30608}
}

code_007794 {
    COP [27] ( &code_00766E ) ; {30612}
}

code_007798 {
    COP [A8] ( #$8000, #0E ) ; {30616}
    LDA $0372             ; {30621}
    STA $001C, X          ; {30624}
    COP [A3]              ; {30627}
    COP [A2] ( #30 )      ; {30629}
    COP [80] ( #02 )      ; {30632}
    COP [82]              ; {30635}
    COP [86]              ; {30637}
    RTL                   ; {30639}
}

asciistring_0077B0 |[10]A voice came from [N]above- [FIN][JMP:&asciistring_0077C1+M]|

asciistring_0077C1 |[10][::][02:2], [N]how can I help you? [END]|

asciistring_0077D4 |I will record all [N]you have accomplished-[N]Is this okay? [END]|

asciistring_0077FA |Finished recording- [FIN]Do you wish to [N]continue? [END]|

asciistring_007825 |Rest well, there is [N]still much to be done-[JMP:&asciistring_007A52]|

asciistring_007848 |[02:2][N]you are doing well- [N]Do not give up- [JMP:&asciistring_007A52]|

asciistring_007866 |[08:448][END]|

asciistring_00786A |[10]A voice came from [N]above- [FIN]"Do not rush, but be [N]patient- You must [N]continue making steady[N]progress-ˮ [JMP:&asciistring_007A52]|

asciistring_0078BB |[10]A voice came from [N]above- [FIN]"The Brown Stone you [N]received is one of 6 [N]stones in this world- [FIN]When all six of these [N]stones are gathered, [FIN]the gate leading to [N]the World of Evil [N]shall be opened- [FIN]Now, you must go to [N]GreenWood where the [N]next stone awaits [N]you-ˮ [JMP:&asciistring_007A52]|
---------------------------------------------

code_00797B {
    COP [07] ( #$9F06, &code_007995 ) ; {31099}
    COP [09] ( #$9F06 )   ; {31105}
    COP [1B] ( &code_00798B, #$0002 ) ; {31109}
}

code_00798B {
    COP [01] ( &asciistring_007998 ) ; {31115}
    COP [3A]              ; {31119}
    COP [01] ( &asciistring_007A06 ) ; {31121}
}

code_007995 {
    COP [86]              ; {31125}
    RTL                   ; {31127}
}

asciistring_007998 |[10]A voice came from [N]above- [FIN]"My follower, since [N]you will be able to [N]speak with all living [N]things, [FIN]you should have a [N]name- Please choose a [N]name for yourself- [JMP:&asciistring_007A52]|

asciistring_007A06 |[10][02:2],------- [N]What an interesting [N]name- [FIN]Allright, go and save [N]the world for all [N]creatures- [JMP:&asciistring_007A52]|

asciistring_007A52 |[12][08:408][END]|