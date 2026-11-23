; Menu palettes and the tile group map (file offsets 323584-324511, SNES $09:F000-$F39F, bank 04; 256 + 256 + 256 + 160 bytes).
; 
; === WHAT IS HERE ===
; ItemPagePalette and MenuBgPalette are 256-byte palettes (CGRAM colours 0-127) copied into cgram_buffer for the item page and the rest of the menus. MenuTileGroupMap is a 16 x 16 map of group numbers (x 8 indexes IconTileRecords) used by code_012390 (lib_shared_012390). MenuSpellPalettes holds the palettes 11-15 (160 bytes, cgram_buffer + $160) restored after a menu closes.
---------------------------------------------

---------------------------------------------

; The item page palette: 256 bytes, colours 0-127.
; 
; When: LoadItemPagePalette, every time the item page is shown (DrawItemPage).
; Sees: the item icons and page frame in their own colours.
; Why: the icons need other colours than the equipment page.
; In: n/a (data): 128 BGR555 words.
; Out: copied to cgram_buffer (colours 0-127) with MVN.
; Clobbers: n/a (data).

ItemPagePalette [
  #000000001E5FFF7F4A290000DF22DF73   ;00
  #4A290000E0781C004A2900008448DE6F   ;01
  #0821000016001F009F01DF029F33AD59   ;02
  #D672397F6A00D00097017F023F4FFF7F   ;03
  #08210000A70C2D15D4219C2E6B39D672   ;04
  #A040807D0001A00160024003D043FF7F   ;05
  #082100002A19D035964AFA569F67FF7F   ;06
  #8015402B00280050007CE07DEF7EFF7F   ;07
  #08210000B2009801DF029F3312001F00   ;08
  #00300078C51C8B3D505E357F9A7FFF7F   ;09
  #0821000005400C7C307D737E967FBF56   ;0A
  #12001F0006180C30124818601C72FF7F   ;0B
  #0821000012001F001F323F5B3F035242   ;0C
  #185BFF73841008218C311042F75EFF7F   ;0D
  #E71C25018605080A0B138D1B21480000   ;0E
  #21082314661CA9240E2571211626DC26   ;0F
]
---------------------------------------------

; The menu palette: 256 bytes, colours 0-127.
; 
; When: LoadMenuPalette (OpenEquipmentMenu, RedrawEquipmentPage and lib_01232B).
; Sees: the menu colours on the next NMI upload.
; Why: the CGRAM buffer is uploaded by the NMI, so loading the palette is a copy.
; In: n/a (data): 128 BGR555 words.
; Out: copied to cgram_buffer ($7F:0000).
; Clobbers: n/a (data).

MenuBgPalette [
  #000000001E5FFF7F4A290000DF22DF73   ;00
  #4A290000E0781C004A2900008448DE6F   ;01
  #CE011010BF005F025F23FF7F44508571   ;02
  #C77EEC7F94053B0E2C69DF4300008634   ;03
  #160013305F4CFF65FF7B0F65FC7D0B24   ;04
  #F40D2C15FA6FC07C807E3F1300000450   ;05
  #862A203AC05F4124FF5B15285F380B24   ;06
  #F40D2C15FA6FC07C807E3F1300000450   ;07
  #D129262DEB45B256FE7F1210BF00F014   ;08
  #FF0DFF2A6118C03B7A6F8C1300008423   ;09
  #4A29EB591373FF7FC50C8B01B612111C   ;0A
  #1F317F075902BF7CE041453D0000C428   ;0B
  #4A29AE59B77EFF7FC9189111992A1214   ;0C
  #1F00F708DF051F13E07D607F00000678   ;0D
  #E71C25018605080A0B138D1B21480000   ;0E
  #21082314661CA9240E2571211626DC26   ;0F
]
---------------------------------------------

; A 16 x 16 map of tile group numbers for the icon records.
; 
; When: code_012390 (lib_shared_012390), when it draws a block of icon tiles.
; Sees: a block of icon tiles drawn in one pass.
; Why: the group number selects the icon record (group x 8 into IconTileRecords).
; In: n/a (data): 256 bytes, row-major.
; Out: the group number of each cell.
; Clobbers: n/a (data).

MenuTileGroupMap [
  #4B4C4745454543414244464646484B4C   ;00
  #50515252525252525252525252525051   ;01
  #534D525252525252525252525252534D   ;02
  #534D525252525252525252525252534D   ;03
  #534D525252525252525252525252534D   ;04
  #534D525252525252525252525252534D   ;05
  #4E4F5252525252525252525252524E4F   ;06
  #50515252525252525252525252525051   ;07
  #534D525252525252525252525252534D   ;08
  #534D525252525252525252525252534D   ;09
  #534D525252525252525252525252534D   ;0A
  #534D525252525252525252525252534D   ;0B
  #4E4F5252525252525252525252524E4F   ;0C
  #494A474545454543444646464648494A   ;0D
  #00000000000000000000000000000000   ;0E
  #00000000000000000000000000000000   ;0F
]
---------------------------------------------

; The spell palettes 11-15: 160 bytes.
; 
; When: RestoreSceneBgGfxAndPalette, after a menu or a scene load.
; Sees: the field's spell and effect colours return after the menu.
; Why: the menu overwrites part of the palette, so the field's colours are put back.
; In: n/a (data): 80 BGR555 words.
; Out: copied to cgram_buffer + $160.
; Clobbers: n/a (data).

MenuSpellPalettes [
  #0821FF7FFF7FFF7FFF7FFF7FFF7FFF7F   ;00
  #FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F   ;01
  #0821000094015A02FF5B5F1B14001F00   ;02
  #1F024630004800702076D27BDB7BFF7F   ;03
  #8C3100004A00120018001E000C017001   ;04
  #BE0286304C61905A56734E2156425E63   ;05
  #8C31000010735477987BDC7F10421863   ;06
  #FF7FEC4FF67386304C619029984A5E63   ;07
  #0821FF7FFF7FFF7FFF7FFF7FFF7FFF7F   ;08
  #FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F   ;09
]