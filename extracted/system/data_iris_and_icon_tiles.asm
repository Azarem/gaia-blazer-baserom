; Iris frames and the 2x2 icon tile records (file offsets 294912-295423 and 296960-297983, SNES $09:8000-$81FF and $09:8800-$8BFF, bank 04; 512 + 1024 bytes).
; 
; === WHAT IS HERE ===
; IrisFrames: 32 frames of 16 bytes (an 8 x 8 tile mask in 2 bits per pixel each), written one per step by the iris transition into VRAM word $4000 (RunIrisTransition in lib_scene_change_init): the iris closes (frames $1E down to 0) and opens (0 up to $1F) over about a second. IconTileRecords: 128 records of 8 bytes, one per inventory icon: 4 words of BG tilemap entries (top-left, top-right, bottom-left, bottom-right) of a 2 x 2 icon, read by DrawInventoryIcon with the item id and $7F x 8.
---------------------------------------------

---------------------------------------------

; The 32 tile masks of the iris transition.
; 
; When: PlayTransitionIn and PlayTransitionOut, once per step of the iris (transition types $80 and up: the return trips).
; Sees: a circle that closes in on the screen and opens again.
; Why: the iris is a tile whose shape changes every step; the shapes are data.
; In: n/a (data): 16 bytes per frame (2 bits per pixel), offset ((2 x type + bit 4 of iris_frame) << 8) | ((iris_frame and $0F) << 4); the type's bit 7 drops out of the 8-bit add, so only these 512 bytes are used by the shipped game.
; Out: the frame is written to VRAM word $4000 and the two sub-frames run.
; Clobbers: n/a (data).

IrisFrames [
  #FF00FF00FF00FF00FF00FF00FF00FF00   ;00
  #FF00FF00FF00E700E700FF00FF00FF00   ;01
  #FF00FF00F700E700E700EF00FF00FF00   ;02
  #FF00FF00E700E700E700E700FF00FF00   ;03
  #FF00FF00C700E700E700E300FF00FF00   ;04
  #FF00FF00C700C700E300E300FF00FF00   ;05
  #FF00FF00C700C300C300E300FF00FF00   ;06
  #FF00FF00C300C300C300C300FF00FF00   ;07
  #FF00FB00C300C300C300C300DF00FF00   ;08
  #FF00F300C300C300C300C300CF00FF00   ;09
  #FF00E300C300C300C300C300C700FF00   ;0A
  #FF00C300C300C300C300C300C300FF00   ;0B
  #FF008300C300C300C300C300C100FF00   ;0C
  #FF0083008300C300C300C100C100FF00   ;0D
  #FF00830083008300C100C100C100FF00   ;0E
  #FF008300830081008100C100C100FF00   ;0F
  #FF0083008100810081008100C100FF00   ;10
  #FF00810081008100810081008100FF00   ;11
  #FD00810081008100810081008100BF00   ;12
  #F9008100810081008100810081009F00   ;13
  #F1008100810081008100810081008F00   ;14
  #E1008100810081008100810081008700   ;15
  #C1008100810081008100810081008300   ;16
  #81008100810081008100810081008100   ;17
  #01008100810081008100810081008000   ;18
  #01000100810081008100810080008000   ;19
  #01000100010081008100800080008000   ;1A
  #01000100010001008000800080008000   ;1B
  #01000100010000000000800080008000   ;1C
  #01000100000000000000000080008000   ;1D
  #01000000000000000000000000008000   ;1E
  #00000000000000000000000000000000   ;1F
]
---------------------------------------------

; The 128 icon records of 4 tilemap words.
; 
; When: DrawInventoryIcon (the equipment and item pages) and code_012390 in lib_shared_012390.
; Sees: the inventory icons.
; Why: every icon is four tiles; a record per icon makes the draw routine one loop.
; In: n/a (data): 8 bytes per record, index = item id and $7F: four words: top-left, top-right, bottom-left, bottom-right (BG2 tilemap entries).
; Out: written to the BG2 page at $7F7800 + the icon's offset (and the next row, +$40).
; Clobbers: n/a (data).

IconTileRecords [
  unk17 < #$0000, #$0001, #$0010, #$0011 >   ;00
  unk17 < #$1802, #$1803, #$1812, #$1813 >   ;01
  unk17 < #$1404, #$1405, #$1414, #$1415 >   ;02
  unk17 < #$1806, #$1807, #$1816, #$1817 >   ;03
  unk17 < #$1808, #$1809, #$1818, #$1819 >   ;04
  unk17 < #$180A, #$180B, #$181A, #$181B >   ;05
  unk17 < #$180C, #$180D, #$181C, #$181D >   ;06
  unk17 < #$180E, #$180F, #$181E, #$181F >   ;07
  unk17 < #$1420, #$1421, #$1430, #$1431 >   ;08
  unk17 < #$1022, #$1023, #$1032, #$1033 >   ;09
  unk17 < #$0C24, #$0C25, #$0C34, #$0C35 >   ;0A
  unk17 < #$0426, #$0427, #$0436, #$0437 >   ;0B
  unk17 < #$1428, #$1429, #$1438, #$1439 >   ;0C
  unk17 < #$142A, #$142B, #$143A, #$143B >   ;0D
  unk17 < #$142C, #$142D, #$143C, #$143D >   ;0E
  unk17 < #$142E, #$142F, #$143E, #$143F >   ;0F
  unk17 < #$0C40, #$0C41, #$0C50, #$0C51 >   ;10
  unk17 < #$0442, #$0443, #$0452, #$0453 >   ;11
  unk17 < #$0444, #$0445, #$0454, #$0455 >   ;12
  unk17 < #$0846, #$0847, #$0856, #$0857 >   ;13
  unk17 < #$0448, #$0449, #$0458, #$0459 >   ;14
  unk17 < #$044A, #$044B, #$045A, #$045B >   ;15
  unk17 < #$084C, #$084D, #$085C, #$085D >   ;16
  unk17 < #$044E, #$044F, #$045E, #$045F >   ;17
  unk17 < #$0460, #$0461, #$0470, #$0471 >   ;18
  unk17 < #$0862, #$0863, #$0872, #$0873 >   ;19
  unk17 < #$1864, #$1865, #$1874, #$1875 >   ;1A
  unk17 < #$1866, #$1867, #$1876, #$1877 >   ;1B
  unk17 < #$1068, #$1069, #$1078, #$1079 >   ;1C
  unk17 < #$086A, #$086B, #$087A, #$087B >   ;1D
  unk17 < #$086C, #$086D, #$087C, #$087D >   ;1E
  unk17 < #$186E, #$186F, #$187E, #$187F >   ;1F
  unk17 < #$0C80, #$0C81, #$0C90, #$0C91 >   ;20
  unk17 < #$1482, #$1483, #$1492, #$1493 >   ;21
  unk17 < #$1884, #$1885, #$1894, #$1895 >   ;22
  unk17 < #$1086, #$1087, #$1096, #$1097 >   ;23
  unk17 < #$1088, #$1089, #$1098, #$1099 >   ;24
  unk17 < #$088A, #$088B, #$089A, #$089B >   ;25
  unk17 < #$088C, #$088D, #$089C, #$089D >   ;26
  unk17 < #$108E, #$108F, #$109E, #$109F >   ;27
  unk17 < #$10A0, #$10A1, #$10B0, #$10B1 >   ;28
  unk17 < #$10A2, #$10A3, #$10B2, #$10B3 >   ;29
  unk17 < #$04A4, #$04A5, #$04B4, #$04B5 >   ;2A
  unk17 < #$10A6, #$10A7, #$10B6, #$10B7 >   ;2B
  unk17 < #$08A8, #$08A9, #$08B8, #$08B9 >   ;2C
  unk17 < #$0CAA, #$0CAB, #$0CBA, #$0CBB >   ;2D
  unk17 < #$18AC, #$18AD, #$18BC, #$18BD >   ;2E
  unk17 < #$10AE, #$10AF, #$10BE, #$10BF >   ;2F
  unk17 < #$0CC0, #$0CC1, #$0CD0, #$0CD1 >   ;30
  unk17 < #$14C2, #$14C3, #$14D2, #$14D3 >   ;31
  unk17 < #$04C4, #$04C5, #$04D4, #$04D5 >   ;32
  unk17 < #$04C6, #$04C7, #$04D6, #$04D7 >   ;33
  unk17 < #$04C8, #$04C9, #$04D8, #$04D9 >   ;34
  unk17 < #$10CA, #$10CB, #$10DA, #$10DB >   ;35
  unk17 < #$0CCA, #$0CCB, #$0CDA, #$0CDB >   ;36
  unk17 < #$14CA, #$14CB, #$14DA, #$14DB >   ;37
  unk17 < #$08E2, #$08E3, #$08F2, #$08F3 >   ;38
  unk17 < #$10CC, #$10CD, #$10DC, #$10DD >   ;39
  unk17 < #$04E0, #$04E1, #$04F0, #$04F1 >   ;3A
  unk17 < #$08E0, #$08E1, #$08F0, #$08F1 >   ;3B
  unk17 < #$0CE0, #$0CE1, #$0CF0, #$0CF1 >   ;3C
  unk17 < #$10E0, #$10E1, #$10F0, #$10F1 >   ;3D
  unk17 < #$14E0, #$14E1, #$14F0, #$14F1 >   ;3E
  unk17 < #$18E0, #$18E1, #$18F0, #$18F1 >   ;3F
  unk17 < #$10CE, #$10CF, #$10DE, #$10DF >   ;40
  unk17 < #$5CEB, #$1CEE, #$5CFB, #$1CFE >   ;41
  unk17 < #$1CEF, #$1CEB, #$1CFF, #$1CFB >   ;42
  unk17 < #$1CED, #$1CEB, #$1CFD, #$1CFB >   ;43
  unk17 < #$5CEB, #$5CED, #$5CFB, #$5CFD >   ;44
  unk17 < #$1CED, #$1CED, #$1CFD, #$1CFD >   ;45
  unk17 < #$5CED, #$5CED, #$5CFD, #$5CFD >   ;46
  unk17 < #$5CE8, #$1CED, #$5CF8, #$1CFD >   ;47
  unk17 < #$5CED, #$1CE8, #$5CFD, #$1CF8 >   ;48
  unk17 < #$1CE9, #$1CEA, #$1CF9, #$1CFA >   ;49
  unk17 < #$5CEA, #$5CE9, #$5CFA, #$5CF9 >   ;4A
  unk17 < #$9CF9, #$9CFA, #$9CE9, #$9CEA >   ;4B
  unk17 < #$DCFA, #$DCF9, #$DCEA, #$DCE9 >   ;4C
  unk17 < #$1CE7, #$1CEC, #$1CF7, #$1CFC >   ;4D
  unk17 < #$1CEC, #$5CE5, #$1CFC, #$5CF5 >   ;4E
  unk17 < #$1CE5, #$1CEC, #$1CF5, #$1CFC >   ;4F
  unk17 < #$1CEC, #$DCF5, #$1CFC, #$DCE5 >   ;50
  unk17 < #$9CF5, #$1CEC, #$9CE5, #$1CFC >   ;51
  unk17 < #$1CE4, #$1CE4, #$1CE4, #$1CE4 >   ;52
  unk17 < #$1CEC, #$1CE6, #$1CFC, #$1CF6 >   ;53
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;54
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;55
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;56
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;57
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;58
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;59
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5A
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5B
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5C
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5D
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5E
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;5F
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;60
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;61
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;62
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;63
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;64
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;65
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;66
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;67
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;68
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;69
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6A
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6B
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6C
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6D
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6E
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;6F
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;70
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;71
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;72
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;73
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;74
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;75
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;76
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;77
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;78
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;79
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7A
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7B
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7C
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7D
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7E
  unk17 < #$0000, #$0000, #$0000, #$0000 >   ;7F
]