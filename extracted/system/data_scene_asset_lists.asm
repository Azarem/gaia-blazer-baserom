; Scene asset lists: 98 records, one per scene, with the load commands of each scene (file offsets 163840-167937, SNES $05:8000-$9001, bank 02; 4098 bytes).
; 
; === MODEL ===
; LoadSceneAssets (lib_scene_asset_loader) calls FindSceneRecord to find the record of area_current and scene_current in this list (dp$2F-$31 points at it) and runs its commands: graphics, palette, tileset, tilemap, asset8 (scene profile or jump), meta4, music and spritemap, each with its operand bytes, ending with a 00 byte. The layout of the commands and the shared segments (65 jumps to 37 labels) are the subject of the block note of lib_scene_asset_loader.
; Counts over the whole list: 47 spritemap, 65 music, 200 asset8, 135 tilemap, 62 tileset, 109 palette and 107 graphics commands, none of meta4. The first record (area $53, scene $59) is a dummy without commands; the other 97 are exactly the 97 scenes of ScenePlacementIndex. The list has no end sentinel (OQ-I011-3).
---------------------------------------------

---------------------------------------------

; The asset list: 98 records of area, scene, commands and a 00 end.
; 
; When: LoadSceneAssets on every scene change, from InitSceneState.
; Sees: after the call the new scene's graphics, palette, tile definitions, maps, music and sprite map are loaded.
; Why: scenes are data, so one list and one handler per command replace a loader routine per scene.
; In: n/a (data): record = byte area, byte scene, the commands (each a one-bit command byte and its operands), 00. The pointers inside are long addresses of compressed assets.
; Out: the commands drive the loaders; the record of scene (0, 1) opens the list after the dummy ($53, $59).
; Clobbers: n/a (data).

SceneAssetLists [
  asset_list < #53, #59, [
  ] >   ;00
  asset_list < #00, #01, [
    asset8 < #00 >   ;00
    palette < #00, #70, #10, %palette_0F37CB >   ;01
    asset8 < #DA >   ;02
    palette < #00, #10, #00, %palette_04FFE0 >   ;03
    graphics < #80, #10, #00, %graphics_02B66C >   ;04
    tileset < #00, #20, #00, #03, %tileset_0E9DDB >   ;05
    tilemap < #01, %tilemap_0F653B >   ;06
    tilemap < #02, %tilemap_0F6BCB >   ;07
    music < #01, #00, %music_0C6897 >   ;08
    music < #01, #01, %music_0AEC48 >   ;09
  ] >   ;01
  asset_list < #01, #01, [
    asset8 < #01 >   ;00
    asset8 < #E6 >   ;01
    tilemap < #01, %tilemap_09DD79 >   ;02
    asset8 < #C1 >   ;03
    graphics < #80, #10, #00, %graphics_02D66C >   ;04
    tileset < #00, #20, #00, #01, %tileset_0E2F8E >   ;05
    palette < #00, #70, #10, %palette_0F38AB >   ;06
    graphics < #00, #10, #10, %graphics_0BE120 >   ;07
    tileset < #00, #20, #00, #02, %tileset_0E8000 >   ;08
    tilemap < #02, %tilemap_0F3308 >   ;09
    graphics < #00, #10, #30, %graphics_094A23 >   ;0A
    palette < #00, #30, #80, %palette_07FF9A >   ;0B
    spritemap < #00, #00, #00, %spritemap_0DA377 >   ;0C
    music < #01, #00, %music_0D6E9C >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0CBCAF >   ;0F
    music < #01, #03, %music_0F6D31 >   ;10
    music < #01, #04, %music_0AEC48 >   ;11
  ] >   ;02
  asset_list < #01, #02, [
    asset8 < #02 >   ;00
    tilemap < #01, %tilemap_0A7F51 >   ;01
    asset8 < #81 >   ;02
  ] >   ;03
  asset_list < #01, #03, [
    asset8 < #03 >   ;00
    tilemap < #01, %tilemap_0F6ACF >   ;01
    asset8 < #81 >   ;02
  ] >   ;04
  asset_list < #01, #04, [
    asset8 < #04 >   ;00
    tilemap < #01, %tilemap_0F693D >   ;01
    asset8 < #81 >   ;02
  ] >   ;05
  asset_list < #02, #01, [
    asset8 < #05 >   ;00
    tilemap < #01, %tilemap_09F448 >   ;01
    asset8 < #C2 >   ;02
    graphics < #00, #10, #30, %graphics_0A436B >   ;03
    palette < #00, #30, #80, %palette_0F6E12 >   ;04
    spritemap < #00, #00, #00, %spritemap_0EA2C0 >   ;05
    asset8 < #D1 >   ;06
    graphics < #00, #10, #00, %graphics_0820E4 >   ;07
    tileset < #00, #20, #00, #01, %tileset_097A0F >   ;08
    palette < #00, #70, #10, %palette_0F398B >   ;09
    graphics < #00, #10, #10, %graphics_0BE120 >   ;0A
    tileset < #00, #20, #00, #02, %tileset_0E8000 >   ;0B
    tilemap < #02, %tilemap_0F2151 >   ;0C
    music < #01, #00, %music_052CC8 >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
  ] >   ;06
  asset_list < #02, #02, [
    asset8 < #06 >   ;00
    tilemap < #01, %tilemap_0D35D6 >   ;01
    asset8 < #82 >   ;02
  ] >   ;07
  asset_list < #02, #03, [
    asset8 < #0E >   ;00
    tilemap < #01, %tilemap_0D35D6 >   ;01
    graphics < #00, #10, #30, %graphics_094A23 >   ;02
    palette < #00, #30, #80, %palette_07FF9A >   ;03
    spritemap < #00, #00, #00, %spritemap_0DA377 >   ;04
    asset8 < #91 >   ;05
  ] >   ;08
  asset_list < #03, #01, [
    asset8 < #07 >   ;00
    tilemap < #01, %tilemap_0F11D8 >   ;01
    asset8 < #C3 >   ;02
    graphics < #00, #10, #30, %graphics_0AC1C4 >   ;03
    palette < #00, #30, #80, %palette_0F6E72 >   ;04
    spritemap < #00, #00, #00, %spritemap_0E8A13 >   ;05
    asset8 < #D2 >   ;06
    graphics < #00, #10, #00, %graphics_0706EF >   ;07
    tileset < #00, #20, #00, #01, %tileset_048200 >   ;08
    palette < #00, #70, #10, %palette_0F3A6B >   ;09
    graphics < #00, #10, #10, %graphics_0BE120 >   ;0A
    tileset < #00, #20, #00, #02, %tileset_0E8000 >   ;0B
    tilemap < #02, %tilemap_0F6614 >   ;0C
    music < #01, #00, %music_0CC66C >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0B52E8 >   ;0F
  ] >   ;09
  asset_list < #03, #02, [
    asset8 < #08 >   ;00
    tilemap < #01, %tilemap_0F0F67 >   ;01
    asset8 < #83 >   ;02
  ] >   ;0A
  asset_list < #03, #03, [
    asset8 < #09 >   ;00
    tilemap < #01, %tilemap_0F18E2 >   ;01
    asset8 < #83 >   ;02
  ] >   ;0B
  asset_list < #03, #04, [
    asset8 < #0A >   ;00
    tilemap < #01, %tilemap_0F6DA2 >   ;01
    graphics < #00, #10, #30, %graphics_094A23 >   ;02
    palette < #00, #30, #80, %palette_07FF9A >   ;03
    spritemap < #00, #00, #00, %spritemap_0DA377 >   ;04
    asset8 < #92 >   ;05
  ] >   ;0C
  asset_list < #03, #05, [
    asset8 < #0B >   ;00
    tilemap < #01, %tilemap_0F1694 >   ;01
    asset8 < #83 >   ;02
  ] >   ;0D
  asset_list < #03, #06, [
    asset8 < #0C >   ;00
    tilemap < #01, %tilemap_0F66DE >   ;01
    graphics < #00, #10, #30, %graphics_08E730 >   ;02
    palette < #00, #30, #80, %palette_0F6ED2 >   ;03
    spritemap < #00, #00, #00, %spritemap_09977A >   ;04
    asset8 < #92 >   ;05
  ] >   ;0E
  asset_list < #00, #08, [
    asset8 < #0D >   ;00
    graphics < #80, #10, #00, %graphics_02B66C >   ;01
    tileset < #00, #20, #00, #03, %tileset_0E9DDB >   ;02
    palette < #00, #70, #10, %palette_0F3B4B >   ;03
    tilemap < #01, %tilemap_0F69C7 >   ;04
    graphics < #00, #10, #30, %graphics_0A436B >   ;05
    palette < #00, #30, #80, %palette_0F6E12 >   ;06
    spritemap < #00, #00, #00, %spritemap_0EA2C0 >   ;07
    music < #01, #00, %music_0D6E9C >   ;08
  ] >   ;0F
  asset_list < #00, #09, [
    asset8 < #0F >   ;00
    graphics < #00, #20, #20, %graphics_029002 >   ;01
    palette < #00, #80, #80, %palette_0C7EE0 >   ;02
    spritemap < #00, #00, #00, %spritemap_0CE36B >   ;03
    graphics < #00, #10, #00, %graphics_072350 >   ;04
    tileset < #00, #20, #00, #01, %tileset_0E40D3 >   ;05
    palette < #00, #70, #10, %palette_0F3C2B >   ;06
    tilemap < #01, %tilemap_0EFC4A >   ;07
    graphics < #00, #10, #10, %graphics_096236 >   ;08
    tileset < #00, #20, #00, #02, %tileset_0EBA96 >   ;09
    tilemap < #02, %tilemap_0F1D48 >   ;0A
    music < #01, #00, %music_02F66C >   ;0B
    music < #01, #01, %music_0F6D31 >   ;0C
  ] >   ;10
  asset_list < #00, #0A, [
    asset8 < #10 >   ;00
    palette < #00, #10, #00, %palette_04FFE0 >   ;01
    graphics < #00, #10, #FF, %graphics_0C8000 >   ;02
    palette < #00, #20, #10, %palette_09FFAD >   ;03
    tilemap < #00, %tilemap_0D75EA >   ;04
    graphics < #00, #10, #30, %graphics_0D0942 >   ;05
    palette < #00, #40, #90, %palette_0F6A4F >   ;06
    spritemap < #00, #00, #00, %spritemap_0D4F46 >   ;07
    spritemap < #01, #00, #00, %spritemap_0F0CEE >   ;08
    music < #01, #00, %music_0BD265 >   ;09
    music < #01, #01, %music_0DB13D >   ;0A
  ] >   ;11
  asset_list < #00, #0B, [
    asset8 < #11 >   ;00
    graphics < #00, #10, #00, %graphics_07D100 >   ;01
    tileset < #00, #20, #00, #03, %tileset_04AC00 >   ;02
    palette < #00, #70, #10, %palette_0F3D0B >   ;03
    tilemap < #01, %tilemap_0F6B4F >   ;04
    tilemap < #02, %tilemap_0F62A9 >   ;05
    graphics < #00, #10, #30, %graphics_0CB2DC >   ;06
    palette < #00, #30, #D0, %palette_0F6F32 >   ;07
    spritemap < #00, #00, #00, %spritemap_0F3595 >   ;08
    palette < #00, #10, #00, %palette_0C7FE0 >   ;09
    graphics < #00, #10, #40, %graphics_0D8729 >   ;0A
    music < #01, #00, %music_0C94E8 >   ;0B
  ] >   ;12
  asset_list < #00, #0C, [
    asset8 < #12 >   ;00
    palette < #00, #10, #00, %palette_0F7947 >   ;01
    graphics < #00, #18, #40, %graphics_0B91B8 >   ;02
  ] >   ;13
  asset_list < #00, #0D, [
    asset8 < #13 >   ;00
    palette < #00, #10, #00, %palette_04FFE0 >   ;01
    graphics < #00, #18, #40, %graphics_0B91B8 >   ;02
    asset8 < #A6 >   ;03
  ] >   ;14
  asset_list < #00, #02, [
    asset8 < #14 >   ;00
    palette < #00, #70, #10, %palette_0F3DEB >   ;01
    asset8 < #9A >   ;02
  ] >   ;15
  asset_list < #04, #01, [
    asset8 < #15 >   ;00
    tilemap < #01, %tilemap_0CD029 >   ;01
    asset8 < #C4 >   ;02
    palette < #00, #70, #10, %palette_0F3ECB >   ;03
    asset8 < #E4 >   ;04
    graphics < #80, #10, #00, %graphics_03070F >   ;05
    tileset < #00, #20, #00, #01, %tileset_0E4C38 >   ;06
    graphics < #00, #10, #10, %graphics_05B2EA >   ;07
    tileset < #00, #20, #00, #02, %tileset_0EC87D >   ;08
    tilemap < #02, %tilemap_0F2D45 >   ;09
    graphics < #00, #10, #30, %graphics_07EC04 >   ;0A
    palette < #00, #30, #80, %palette_0F6F92 >   ;0B
    spritemap < #00, #00, #00, %spritemap_0E6218 >   ;0C
    music < #01, #00, %music_0D6E9C >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0CBCAF >   ;0F
  ] >   ;16
  asset_list < #04, #02, [
    asset8 < #16 >   ;00
    palette < #00, #70, #10, %palette_0F3FAB >   ;01
    tilemap < #01, %tilemap_0F319D >   ;02
    asset8 < #A4 >   ;03
  ] >   ;17
  asset_list < #04, #03, [
    asset8 < #17 >   ;00
    palette < #00, #70, #10, %palette_0F408B >   ;01
    tilemap < #01, %tilemap_0F6CBF >   ;02
    asset8 < #A4 >   ;03
  ] >   ;18
  asset_list < #04, #04, [
    asset8 < #18 >   ;00
    palette < #00, #70, #10, %palette_0F408B >   ;01
    tilemap < #01, %tilemap_0F678A >   ;02
    asset8 < #A4 >   ;03
  ] >   ;19
  asset_list < #04, #05, [
    asset8 < #23 >   ;00
    tilemap < #01, %tilemap_0F319D >   ;01
    asset8 < #84 >   ;02
  ] >   ;1A
  asset_list < #04, #06, [
    asset8 < #24 >   ;00
    tilemap < #01, %tilemap_0CD029 >   ;01
    asset8 < #84 >   ;02
  ] >   ;1B
  asset_list < #05, #01, [
    asset8 < #19 >   ;00
    graphics < #00, #10, #00, %graphics_080600 >   ;01
    tileset < #00, #20, #00, #01, %tileset_0E1841 >   ;02
    palette < #00, #70, #10, %palette_0F416B >   ;03
    tilemap < #01, %tilemap_0CF69D >   ;04
    graphics < #00, #10, #10, %graphics_05B2EA >   ;05
    tileset < #00, #20, #00, #02, %tileset_0EC87D >   ;06
    tilemap < #02, %tilemap_0AFFD1 >   ;07
    graphics < #00, #10, #30, %graphics_088000 >   ;08
    palette < #00, #30, #80, %palette_0F6FF2 >   ;09
    spritemap < #00, #00, #00, %spritemap_0D1245 >   ;0A
    music < #01, #00, %music_0D2D18 >   ;0B
  ] >   ;1C
  asset_list < #05, #02, [
    asset8 < #1A >   ;00
    tilemap < #01, %tilemap_0F0A6D >   ;01
    tilemap < #02, %tilemap_0AFFD1 >   ;02
    asset8 < #C5 >   ;03
    graphics < #00, #10, #00, %graphics_06D475 >   ;04
    tileset < #00, #20, #00, #01, %tileset_0DB80C >   ;05
    palette < #00, #70, #10, %palette_0F424B >   ;06
    graphics < #00, #10, #10, %graphics_05B2EA >   ;07
    tileset < #00, #20, #00, #02, %tileset_0EC87D >   ;08
    graphics < #00, #10, #30, %graphics_088000 >   ;09
    palette < #00, #30, #80, %palette_0F6FF2 >   ;0A
    spritemap < #00, #00, #00, %spritemap_0D1245 >   ;0B
    music < #01, #00, %music_0D46E4 >   ;0C
  ] >   ;1D
  asset_list < #05, #03, [
    asset8 < #1B >   ;00
    tilemap < #01, %tilemap_0EE92D >   ;01
    tilemap < #02, %tilemap_0AFFD1 >   ;02
    asset8 < #85 >   ;03
  ] >   ;1E
  asset_list < #05, #04, [
    asset8 < #1C >   ;00
    tilemap < #01, %tilemap_0DE515 >   ;01
    tilemap < #02, %tilemap_02FFE1 >   ;02
    asset8 < #85 >   ;03
  ] >   ;1F
  asset_list < #05, #05, [
    asset8 < #1D >   ;00
    tilemap < #01, %tilemap_067D9E >   ;01
    asset8 < #C6 >   ;02
    graphics < #00, #10, #00, %graphics_06D475 >   ;03
    tileset < #00, #20, #00, #01, %tileset_0DB80C >   ;04
    palette < #00, #70, #10, %palette_0F432B >   ;05
    graphics < #00, #10, #10, %graphics_05B2EA >   ;06
    tileset < #00, #20, #00, #02, %tileset_0EC87D >   ;07
    tilemap < #02, %tilemap_0F78D0 >   ;08
    graphics < #00, #10, #30, %graphics_03670F >   ;09
    palette < #00, #30, #80, %palette_0F7052 >   ;0A
    spritemap < #00, #00, #00, %spritemap_0EAC5F >   ;0B
    music < #01, #00, %music_0D46E4 >   ;0C
  ] >   ;20
  asset_list < #05, #06, [
    asset8 < #1E >   ;00
    tilemap < #01, %tilemap_0EDE5E >   ;01
    asset8 < #86 >   ;02
  ] >   ;21
  asset_list < #05, #07, [
    asset8 < #1F >   ;00
    tilemap < #01, %tilemap_0E0000 >   ;01
    asset8 < #86 >   ;02
  ] >   ;22
  asset_list < #05, #08, [
    asset8 < #20 >   ;00
    tilemap < #01, %tilemap_0E6CB5 >   ;01
    asset8 < #C7 >   ;02
    graphics < #00, #10, #30, %graphics_03670F >   ;03
    palette < #00, #30, #80, %palette_0F7052 >   ;04
    spritemap < #00, #00, #00, %spritemap_0EAC5F >   ;05
    asset8 < #D3 >   ;06
    graphics < #00, #10, #00, %graphics_06D475 >   ;07
    tileset < #00, #20, #00, #01, %tileset_0DB80C >   ;08
    palette < #00, #70, #10, %palette_0F440B >   ;09
    graphics < #00, #10, #10, %graphics_05B2EA >   ;0A
    tileset < #00, #20, #00, #02, %tileset_0EC87D >   ;0B
    music < #01, #00, %music_0D46E4 >   ;0C
    music < #01, #02, %music_0B52E8 >   ;0D
  ] >   ;23
  asset_list < #05, #09, [
    asset8 < #21 >   ;00
    tilemap < #01, %tilemap_0E5CBE >   ;01
    tilemap < #02, %tilemap_0EF307 >   ;02
    asset8 < #87 >   ;03
  ] >   ;24
  asset_list < #05, #0A, [
    asset8 < #22 >   ;00
    tilemap < #01, %tilemap_057EDC >   ;01
    graphics < #00, #10, #30, %graphics_06B800 >   ;02
    palette < #00, #30, #80, %palette_0F70B2 >   ;03
    spritemap < #00, #00, #00, %spritemap_0C441D >   ;04
    asset8 < #93 >   ;05
  ] >   ;25
  asset_list < #00, #03, [
    asset8 < #28 >   ;00
    palette < #00, #70, #10, %palette_0F44EB >   ;01
    asset8 < #9A >   ;02
  ] >   ;26
  asset_list < #06, #01, [
    asset8 < #29 >   ;00
    tilemap < #01, %tilemap_04DEE3 >   ;01
    asset8 < #E3 >   ;02
    graphics < #80, #10, #00, %graphics_03270F >   ;03
    tileset < #00, #20, #00, #01, %tileset_0E51D3 >   ;04
    palette < #00, #70, #10, %palette_0F45CB >   ;05
    graphics < #00, #10, #10, %graphics_0AD70A >   ;06
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;07
    tilemap < #02, %tilemap_0F055D >   ;08
    graphics < #00, #10, #30, %graphics_0B671A >   ;09
    palette < #00, #30, #80, %palette_0F7112 >   ;0A
    spritemap < #00, #00, #00, %spritemap_0CED08 >   ;0B
    music < #01, #00, %music_0D6E9C >   ;0C
    music < #01, #01, %music_0DB13D >   ;0D
    music < #01, #02, %music_0CBCAF >   ;0E
  ] >   ;27
  asset_list < #07, #01, [
    asset8 < #2A >   ;00
    tilemap < #01, %tilemap_0C0EA7 >   ;01
    asset8 < #C8 >   ;02
    graphics < #00, #10, #30, %graphics_0A9601 >   ;03
    palette < #00, #30, #80, %palette_0F7172 >   ;04
    spritemap < #00, #00, #00, %spritemap_0E1E39 >   ;05
    asset8 < #D4 >   ;06
    graphics < #00, #10, #00, %graphics_05941C >   ;07
    tileset < #00, #20, #00, #01, %tileset_0DF1AB >   ;08
    palette < #00, #70, #10, %palette_0F46AB >   ;09
    graphics < #00, #10, #10, %graphics_0AD70A >   ;0A
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;0B
    tilemap < #02, %tilemap_05BFC5 >   ;0C
    music < #01, #00, %music_0D574E >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
  ] >   ;28
  asset_list < #07, #02, [
    asset8 < #2B >   ;00
    tilemap < #01, %tilemap_0F2EC2 >   ;01
    asset8 < #88 >   ;02
  ] >   ;29
  asset_list < #07, #03, [
    asset8 < #2C >   ;00
    tilemap < #01, %tilemap_053ECF >   ;01
    asset8 < #A3 >   ;02
  ] >   ;2A
  asset_list < #07, #04, [
    asset8 < #2D >   ;00
    tilemap < #01, %tilemap_06F0DC >   ;01
    graphics < #00, #10, #30, %graphics_0B671A >   ;02
    palette < #00, #30, #80, %palette_0F7112 >   ;03
    spritemap < #00, #00, #00, %spritemap_0CED08 >   ;04
    asset8 < #94 >   ;05
  ] >   ;2B
  asset_list < #07, #05, [
    asset8 < #34 >   ;00
    tilemap < #01, %tilemap_06F0DC >   ;01
    asset8 < #88 >   ;02
  ] >   ;2C
  asset_list < #08, #01, [
    asset8 < #2E >   ;00
    tileset < #00, #20, #00, #01, %tileset_0E8513 >   ;01
    palette < #00, #70, #10, %palette_0F478B >   ;02
    tilemap < #01, %tilemap_0C2A0B >   ;03
    asset8 < #CC >   ;04
    tilemap < #02, %tilemap_0B7FDE >   ;05
    asset8 < #CD >   ;06
    graphics < #80, #10, #00, %graphics_03470F >   ;07
    graphics < #00, #10, #10, %graphics_0AD70A >   ;08
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;09
    graphics < #00, #10, #30, %graphics_075BAE >   ;0A
    palette < #00, #30, #80, %palette_0F71D2 >   ;0B
    spritemap < #00, #00, #00, %spritemap_0CD9CD >   ;0C
    music < #01, #00, %music_08703D >   ;0D
  ] >   ;2D
  asset_list < #08, #02, [
    asset8 < #2F >   ;00
    tileset < #00, #20, #00, #01, %tileset_0E8513 >   ;01
    palette < #00, #70, #10, %palette_0F486B >   ;02
    tilemap < #01, %tilemap_0C9F05 >   ;03
    asset8 < #8C >   ;04
  ] >   ;2E
  asset_list < #08, #03, [
    asset8 < #30 >   ;00
    tileset < #00, #20, #00, #01, %tileset_0B7A75 >   ;01
    palette < #00, #70, #10, %palette_0F494B >   ;02
    tilemap < #01, %tilemap_0D1B3F >   ;03
    asset8 < #8C >   ;04
  ] >   ;2F
  asset_list < #08, #04, [
    asset8 < #31 >   ;00
    tileset < #00, #20, #00, #01, %tileset_0B7A75 >   ;01
    palette < #00, #70, #10, %palette_0F4A2B >   ;02
    tilemap < #01, %tilemap_04F3A0 >   ;03
    tilemap < #02, %tilemap_037FD7 >   ;04
    asset8 < #8D >   ;05
  ] >   ;30
  asset_list < #09, #01, [
    asset8 < #32 >   ;00
    graphics < #00, #10, #30, %graphics_098000 >   ;01
    palette < #00, #30, #80, %palette_0F7232 >   ;02
    spritemap < #00, #00, #00, %spritemap_0C8A7D >   ;03
    asset8 < #D5 >   ;04
    graphics < #00, #10, #00, %graphics_062719 >   ;05
    tileset < #00, #20, #00, #01, %tileset_0E98F3 >   ;06
    palette < #00, #70, #10, %palette_0F4B0B >   ;07
    tilemap < #01, %tilemap_0F02BD >   ;08
    graphics < #00, #10, #10, %graphics_0AD70A >   ;09
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;0A
    tilemap < #02, %tilemap_0B7FDE >   ;0B
    music < #01, #00, %music_0D574E >   ;0C
    music < #01, #01, %music_0DB13D >   ;0D
    music < #01, #02, %music_0B52E8 >   ;0E
  ] >   ;31
  asset_list < #09, #02, [
    asset8 < #33 >   ;00
    graphics < #00, #10, #30, %graphics_094A23 >   ;01
    palette < #00, #30, #80, %palette_07FF9A >   ;02
    spritemap < #00, #00, #00, %spritemap_0DA377 >   ;03
    asset8 < #95 >   ;04
  ] >   ;32
  asset_list < #00, #04, [
    asset8 < #3C >   ;00
    palette < #00, #70, #10, %palette_0F4BEB >   ;01
    asset8 < #9A >   ;02
  ] >   ;33
  asset_list < #0A, #01, [
    asset8 < #3D >   ;00
    graphics < #80, #10, #00, %graphics_04566E >   ;01
    tileset < #00, #20, #00, #01, %tileset_0E5761 >   ;02
    palette < #00, #70, #10, %palette_0F4CCB >   ;03
    tilemap < #01, %tilemap_0B0000 >   ;04
    graphics < #00, #10, #30, %graphics_0BA320 >   ;05
    palette < #00, #30, #80, %palette_0F7292 >   ;06
    spritemap < #00, #00, #00, %spritemap_0D8E4F >   ;07
    music < #01, #00, %music_0D6E9C >   ;08
    music < #01, #01, %music_0DB13D >   ;09
    music < #01, #02, %music_0CBCAF >   ;0A
  ] >   ;34
  asset_list < #0B, #01, [
    asset8 < #3E >   ;00
    palette < #00, #70, #10, %palette_0F4DAB >   ;01
    tilemap < #01, %tilemap_0DEB64 >   ;02
    tilemap < #02, %tilemap_0F7832 >   ;03
    graphics < #00, #10, #10, %graphics_090000 >   ;04
    tileset < #00, #20, #00, #02, %tileset_0E7C3B >   ;05
    asset8 < #CA >   ;06
    graphics < #00, #10, #30, %graphics_0899FA >   ;07
    palette < #00, #30, #80, %palette_0F72F2 >   ;08
    spritemap < #00, #00, #00, %spritemap_07A462 >   ;09
    asset8 < #D6 >   ;0A
    graphics < #00, #10, #00, %graphics_073F93 >   ;0B
    tileset < #00, #20, #00, #01, %tileset_0E3B13 >   ;0C
    music < #01, #00, %music_0A6F8A >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
  ] >   ;35
  asset_list < #0B, #02, [
    asset8 < #3F >   ;00
    palette < #00, #70, #10, %palette_0F4E8B >   ;01
    tilemap < #01, %tilemap_0ECCFB >   ;02
    tilemap < #02, %tilemap_0F36D2 >   ;03
    graphics < #00, #10, #10, %graphics_0AD70A >   ;04
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;05
    asset8 < #8A >   ;06
  ] >   ;36
  asset_list < #0B, #03, [
    asset8 < #40 >   ;00
    palette < #00, #70, #10, %palette_0F4E8B >   ;01
    tilemap < #01, %tilemap_0ECCFB >   ;02
    tilemap < #02, %tilemap_0F36D2 >   ;03
    graphics < #00, #10, #30, %graphics_0BA320 >   ;04
    palette < #00, #30, #80, %palette_0F7292 >   ;05
    spritemap < #00, #00, #00, %spritemap_0D8E4F >   ;06
    graphics < #00, #10, #10, %graphics_0AD70A >   ;07
    tileset < #00, #20, #00, #02, %tileset_0EDA28 >   ;08
    asset8 < #96 >   ;09
  ] >   ;37
  asset_list < #0B, #04, [
    asset8 < #41 >   ;00
    tilemap < #01, %tilemap_0DAA6B >   ;01
    tilemap < #02, %tilemap_0F7900 >   ;02
    asset8 < #CB >   ;03
    graphics < #00, #10, #30, %graphics_09AEF1 >   ;04
    palette < #00, #30, #80, %palette_0F7352 >   ;05
    spritemap < #00, #00, #00, %spritemap_0D5F48 >   ;06
    asset8 < #D7 >   ;07
    palette < #00, #70, #10, %palette_0F4F6B >   ;08
    asset8 < #D8 >   ;09
    graphics < #00, #10, #00, %graphics_073F93 >   ;0A
    tileset < #00, #20, #00, #01, %tileset_0E3B13 >   ;0B
    graphics < #00, #10, #10, %graphics_090000 >   ;0C
    tileset < #00, #20, #00, #02, %tileset_0E7C3B >   ;0D
    music < #01, #00, %music_0A6F8A >   ;0E
    music < #01, #01, %music_0DB13D >   ;0F
    music < #01, #02, %music_0B52E8 >   ;10
  ] >   ;38
  asset_list < #0B, #05, [
    asset8 < #42 >   ;00
    tilemap < #01, %tilemap_0D2433 >   ;01
    tilemap < #02, %tilemap_0F7925 >   ;02
    asset8 < #8B >   ;03
  ] >   ;39
  asset_list < #0B, #06, [
    asset8 < #43 >   ;00
    tilemap < #01, %tilemap_0D2433 >   ;01
    tilemap < #02, %tilemap_0F7925 >   ;02
    graphics < #00, #10, #30, %graphics_0BA320 >   ;03
    palette < #00, #30, #80, %palette_0F7292 >   ;04
    spritemap < #00, #00, #00, %spritemap_0D8E4F >   ;05
    asset8 < #97 >   ;06
  ] >   ;3A
  asset_list < #0B, #07, [
    asset8 < #44 >   ;00
    palette < #00, #70, #10, %palette_0F504B >   ;01
    tilemap < #01, %tilemap_0F6461 >   ;02
    tilemap < #02, %tilemap_087FAF >   ;03
    graphics < #00, #10, #30, %graphics_09C63E >   ;04
    palette < #00, #30, #80, %palette_0F73B2 >   ;05
    spritemap < #00, #00, #00, %spritemap_0B8000 >   ;06
    asset8 < #98 >   ;07
  ] >   ;3B
  asset_list < #0C, #01, [
    asset8 < #45 >   ;00
    palette < #00, #70, #10, %palette_0F512B >   ;01
    tilemap < #01, %tilemap_0E123F >   ;02
    graphics < #00, #10, #30, %graphics_0899FA >   ;03
    palette < #00, #30, #80, %palette_0F72F2 >   ;04
    spritemap < #00, #00, #00, %spritemap_07A462 >   ;05
    asset8 < #C9 >   ;06
    graphics < #00, #10, #00, %graphics_05CA61 >   ;07
    tileset < #00, #20, #00, #01, %tileset_0DBEC1 >   ;08
    graphics < #00, #10, #10, %graphics_090000 >   ;09
    tileset < #00, #20, #00, #02, %tileset_0E7C3B >   ;0A
    music < #01, #00, %music_0A6F8A >   ;0B
  ] >   ;3C
  asset_list < #0C, #02, [
    asset8 < #46 >   ;00
    palette < #00, #70, #10, %palette_0F520B >   ;01
    tilemap < #01, %tilemap_0EB5DD >   ;02
    tilemap < #02, %tilemap_0EFF3F >   ;03
    graphics < #00, #10, #30, %graphics_09AEF1 >   ;04
    palette < #00, #30, #80, %palette_0F7352 >   ;05
    spritemap < #00, #00, #00, %spritemap_0D5F48 >   ;06
    asset8 < #89 >   ;07
  ] >   ;3D
  asset_list < #0C, #03, [
    asset8 < #47 >   ;00
    palette < #00, #70, #10, %palette_0F52EB >   ;01
    tilemap < #01, %tilemap_0D8000 >   ;02
    tilemap < #02, %tilemap_0F61CB >   ;03
    graphics < #00, #10, #30, %graphics_09AEF1 >   ;04
    palette < #00, #30, #80, %palette_0F7352 >   ;05
    spritemap < #00, #00, #00, %spritemap_0D5F48 >   ;06
    asset8 < #89 >   ;07
  ] >   ;3E
  asset_list < #00, #05, [
    asset8 < #50 >   ;00
    palette < #00, #70, #10, %palette_0F53CB >   ;01
    asset8 < #9A >   ;02
  ] >   ;3F
  asset_list < #0D, #01, [
    asset8 < #51 >   ;00
    tilemap < #01, %tilemap_0E71E3 >   ;01
    asset8 < #CE >   ;02
    graphics < #00, #10, #30, %graphics_0B1501 >   ;03
    palette < #00, #30, #80, %palette_0F7412 >   ;04
    spritemap < #00, #00, #00, %spritemap_0E4691 >   ;05
    asset8 < #E5 >   ;06
    graphics < #80, #10, #00, %graphics_048C00 >   ;07
    tileset < #00, #20, #00, #01, %tileset_0DDEC4 >   ;08
    palette < #00, #70, #10, %palette_0F54AB >   ;09
    graphics < #00, #10, #10, %graphics_0C5085 >   ;0A
    tileset < #00, #20, #00, #02, %tileset_0EEC85 >   ;0B
    tilemap < #02, %tilemap_0F681B >   ;0C
    music < #01, #00, %music_0D6E9C >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0CBCAF >   ;0F
  ] >   ;40
  asset_list < #0D, #02, [
    asset8 < #52 >   ;00
    tilemap < #01, %tilemap_0ED16B >   ;01
    asset8 < #8E >   ;02
  ] >   ;41
  asset_list < #0D, #03, [
    asset8 < #53 >   ;00
    tilemap < #01, %tilemap_06FFB5 >   ;01
    asset8 < #8E >   ;02
  ] >   ;42
  asset_list < #0D, #04, [
    asset8 < #54 >   ;00
    tilemap < #01, %tilemap_0F6C46 >   ;01
    asset8 < #8E >   ;02
  ] >   ;43
  asset_list < #0D, #05, [
    asset8 < #55 >   ;00
    graphics < #00, #10, #30, %graphics_09195E >   ;01
    palette < #00, #30, #80, %palette_0F7472 >   ;02
    spritemap < #00, #00, #00, %spritemap_0D9C7F >   ;03
    tilemap < #01, %tilemap_0E71E3 >   ;04
    asset8 < #A5 >   ;05
  ] >   ;44
  asset_list < #0E, #01, [
    asset8 < #56 >   ;00
    tilemap < #01, %tilemap_0DF7EC >   ;01
    tilemap < #02, %tilemap_0F6386 >   ;02
    asset8 < #CF >   ;03
    graphics < #00, #10, #30, %graphics_0AABFA >   ;04
    palette < #00, #30, #80, %palette_0F74D2 >   ;05
    spritemap < #00, #00, #00, %spritemap_0DCBAA >   ;06
    asset8 < #D9 >   ;07
    graphics < #00, #10, #00, %graphics_0855ED >   ;08
    tileset < #00, #20, #00, #01, %tileset_0E2403 >   ;09
    palette < #00, #70, #10, %palette_0F558B >   ;0A
    graphics < #00, #10, #10, %graphics_0C5085 >   ;0B
    tileset < #00, #20, #00, #02, %tileset_0EEC85 >   ;0C
    music < #01, #00, %music_0BB3E4 >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0B52E8 >   ;0F
  ] >   ;45
  asset_list < #0E, #02, [
    asset8 < #57 >   ;00
    tilemap < #01, %tilemap_0DD86F >   ;01
    tilemap < #02, %tilemap_0F1F53 >   ;02
    asset8 < #8F >   ;03
  ] >   ;46
  asset_list < #0E, #03, [
    asset8 < #58 >   ;00
    tilemap < #01, %tilemap_0776C9 >   ;01
    tilemap < #02, %tilemap_0F24CC >   ;02
    asset8 < #8F >   ;03
  ] >   ;47
  asset_list < #0E, #04, [
    asset8 < #59 >   ;00
    tilemap < #01, %tilemap_0F230F >   ;01
    graphics < #00, #10, #30, %graphics_0A2D17 >   ;02
    palette < #00, #30, #80, %palette_0F7532 >   ;03
    spritemap < #00, #00, #00, %spritemap_0D0000 >   ;04
    asset8 < #99 >   ;05
  ] >   ;48
  asset_list < #0E, #05, [
    asset8 < #5A >   ;00
    tilemap < #01, %tilemap_0DD86F >   ;01
    tilemap < #02, %tilemap_0F1F53 >   ;02
    graphics < #00, #10, #30, %graphics_0B1501 >   ;03
    palette < #00, #30, #80, %palette_0F7412 >   ;04
    spritemap < #00, #00, #00, %spritemap_0E4691 >   ;05
    asset8 < #99 >   ;06
  ] >   ;49
  asset_list < #0F, #01, [
    asset8 < #5B >   ;00
    tilemap < #01, %tilemap_0D3E60 >   ;01
    tilemap < #02, %tilemap_0D3E60 >   ;02
    asset8 < #D0 >   ;03
    graphics < #00, #10, #00, %graphics_08B3DA >   ;04
    tileset < #00, #20, #00, #03, %tileset_0EA798 >   ;05
    palette < #00, #70, #10, %palette_0F566B >   ;06
    graphics < #00, #10, #30, %graphics_0B3E77 >   ;07
    palette < #00, #30, #80, %palette_0F7592 >   ;08
    spritemap < #00, #00, #00, %spritemap_0DC53A >   ;09
    music < #01, #00, %music_0CC66C >   ;0A
  ] >   ;4A
  asset_list < #0F, #02, [
    asset8 < #5C >   ;00
    tilemap < #01, %tilemap_0CA8FB >   ;01
    tilemap < #02, %tilemap_0CA8FB >   ;02
    asset8 < #90 >   ;03
  ] >   ;4B
  asset_list < #00, #06, [
    asset8 < #64 >   ;00
    palette < #00, #70, #10, %palette_0F574B >   ;01
    asset8 < #9A >   ;02
  ] >   ;4C
  asset_list < #10, #01, [
    asset8 < #65 >   ;00
    graphics < #80, #10, #00, %graphics_050CC8 >   ;01
    tileset < #00, #20, #00, #01, %tileset_0E0C2D >   ;02
    palette < #00, #70, #10, %palette_0F582B >   ;03
    tilemap < #01, %tilemap_0931CA >   ;04
    graphics < #00, #10, #10, %graphics_083B8C >   ;05
    tileset < #00, #20, #00, #02, %tileset_0E8F0E >   ;06
    tilemap < #02, %tilemap_0E9405 >   ;07
    graphics < #00, #10, #30, %graphics_09195E >   ;08
    palette < #00, #30, #80, %palette_0F7472 >   ;09
    spritemap < #00, #00, #00, %spritemap_0D9C7F >   ;0A
    music < #01, #00, %music_0D6E9C >   ;0B
    music < #01, #02, %music_0CBCAF >   ;0C
  ] >   ;4D
  asset_list < #11, #01, [
    asset8 < #66 >   ;00
    tilemap < #01, %tilemap_0E6770 >   ;01
    asset8 < #DB >   ;02
    graphics < #00, #10, #30, %graphics_0A1696 >   ;03
    palette < #00, #30, #80, %palette_0F75F2 >   ;04
    spritemap < #00, #00, #00, %spritemap_0BC325 >   ;05
    asset8 < #DC >   ;06
    graphics < #00, #10, #00, %graphics_056199 >   ;07
    tileset < #00, #20, #00, #01, %tileset_0DD20E >   ;08
    palette < #00, #70, #10, %palette_0F590B >   ;09
    tileset < #00, #20, #00, #02, %tileset_0DD20E >   ;0A
    music < #01, #00, %music_0D46E4 >   ;0B
    music < #01, #01, %music_0DB13D >   ;0C
  ] >   ;4E
  asset_list < #11, #02, [
    asset8 < #67 >   ;00
    tilemap < #01, %tilemap_0EC3E7 >   ;01
    tilemap < #02, %tilemap_0EE22E >   ;02
    asset8 < #9B >   ;03
  ] >   ;4F
  asset_list < #11, #03, [
    asset8 < #68 >   ;00
    tilemap < #01, %tilemap_0D9569 >   ;01
    tilemap < #02, %tilemap_0E3552 >   ;02
    asset8 < #9B >   ;03
  ] >   ;50
  asset_list < #11, #04, [
    asset8 < #69 >   ;00
    tilemap < #01, %tilemap_0D9569 >   ;01
    tilemap < #02, %tilemap_0E3552 >   ;02
    graphics < #00, #10, #30, %graphics_09195E >   ;03
    palette < #00, #30, #80, %palette_0F7472 >   ;04
    spritemap < #00, #00, #00, %spritemap_0D9C7F >   ;05
    asset8 < #9C >   ;06
  ] >   ;51
  asset_list < #12, #01, [
    asset8 < #6A >   ;00
    palette < #00, #70, #10, %palette_0F59EB >   ;01
    tilemap < #01, %tilemap_0F29F6 >   ;02
    asset8 < #DD >   ;03
    graphics < #00, #10, #30, %graphics_0A8000 >   ;04
    palette < #00, #30, #80, %palette_0F7652 >   ;05
    spritemap < #00, #00, #00, %spritemap_0C3797 >   ;06
    asset8 < #DE >   ;07
    graphics < #00, #10, #00, %graphics_064424 >   ;08
    tileset < #00, #20, #00, #01, %tileset_0E0619 >   ;09
    tileset < #00, #20, #00, #02, %tileset_0E0619 >   ;0A
    music < #01, #00, %music_0C73F8 >   ;0B
    music < #01, #01, %music_0DB13D >   ;0C
  ] >   ;52
  asset_list < #12, #02, [
    asset8 < #6B >   ;00
    palette < #00, #70, #10, %palette_0F59EB >   ;01
    tilemap < #01, %tilemap_0F07EB >   ;02
    tilemap < #02, %tilemap_0DFE2A >   ;03
    asset8 < #9D >   ;04
  ] >   ;53
  asset_list < #12, #03, [
    asset8 < #6C >   ;00
    palette < #00, #70, #10, %palette_0F59EB >   ;01
    tilemap < #01, %tilemap_0F0000 >   ;02
    asset8 < #9D >   ;03
  ] >   ;54
  asset_list < #12, #04, [
    asset8 < #6D >   ;00
    palette < #00, #70, #10, %palette_0F5ACB >   ;01
    tilemap < #01, %tilemap_0F2840 >   ;02
    tilemap < #02, %tilemap_0F3030 >   ;03
    asset8 < #9D >   ;04
  ] >   ;55
  asset_list < #12, #05, [
    asset8 < #6E >   ;00
    palette < #00, #70, #10, %palette_0F5ACB >   ;01
    tilemap < #01, %tilemap_0F1B2D >   ;02
    tilemap < #02, %tilemap_0F2BA8 >   ;03
    asset8 < #9D >   ;04
  ] >   ;56
  asset_list < #12, #06, [
    asset8 < #6F >   ;00
    palette < #00, #70, #10, %palette_0F5ACB >   ;01
    tilemap < #01, %tilemap_0F2687 >   ;02
    asset8 < #9D >   ;03
  ] >   ;57
  asset_list < #12, #07, [
    asset8 < #70 >   ;00
    graphics < #00, #10, #00, %graphics_064424 >   ;01
    tileset < #00, #20, #00, #01, %tileset_0E0619 >   ;02
    palette < #00, #70, #10, %palette_0F5BAB >   ;03
    tilemap < #01, %tilemap_0EF620 >   ;04
    graphics < #00, #10, #10, %graphics_090000 >   ;05
    tileset < #00, #20, #00, #02, %tileset_0E7C3B >   ;06
    tilemap < #02, %tilemap_07AFD4 >   ;07
    graphics < #00, #10, #30, %graphics_0A8000 >   ;08
    palette < #00, #30, #80, %palette_0F7652 >   ;09
    spritemap < #00, #00, #00, %spritemap_0C3797 >   ;0A
    music < #01, #00, %music_0C73F8 >   ;0B
  ] >   ;58
  asset_list < #13, #01, [
    asset8 < #71 >   ;00
    palette < #00, #70, #10, %palette_0F5C8B >   ;01
    graphics < #00, #10, #10, %graphics_056199 >   ;02
    tileset < #00, #20, #00, #02, %tileset_0DD20E >   ;03
    tilemap < #02, %tilemap_0F143B >   ;04
    asset8 < #DF >   ;05
    graphics < #00, #10, #30, %graphics_09195E >   ;06
    palette < #00, #30, #80, %palette_0F7472 >   ;07
    spritemap < #00, #00, #00, %spritemap_0D9C7F >   ;08
    asset8 < #E0 >   ;09
    graphics < #00, #10, #00, %graphics_08CD9C >   ;0A
    tileset < #00, #20, #00, #01, %tileset_0D672D >   ;0B
    tilemap < #01, %tilemap_0D7D2C >   ;0C
    music < #01, #00, %music_0C73F8 >   ;0D
    music < #01, #01, %music_0DB13D >   ;0E
    music < #01, #02, %music_0B52E8 >   ;0F
  ] >   ;59
  asset_list < #13, #02, [
    asset8 < #72 >   ;00
    palette < #00, #70, #10, %palette_0F5D6B >   ;01
    graphics < #00, #10, #10, %graphics_0BE120 >   ;02
    tileset < #00, #20, #00, #02, %tileset_0E8000 >   ;03
    tilemap < #02, %tilemap_04766E >   ;04
    graphics < #00, #10, #30, %graphics_0B29CA >   ;05
    palette < #00, #30, #80, %palette_0F76B2 >   ;06
    spritemap < #00, #00, #00, %spritemap_0E29C9 >   ;07
    asset8 < #A0 >   ;08
  ] >   ;5A
  asset_list < #13, #03, [
    asset8 < #73 >   ;00
    palette < #00, #70, #10, %palette_0F5D6B >   ;01
    graphics < #00, #10, #10, %graphics_0BE120 >   ;02
    tileset < #00, #20, #00, #02, %tileset_0E8000 >   ;03
    tilemap < #02, %tilemap_04766E >   ;04
    asset8 < #9F >   ;05
  ] >   ;5B
  asset_list < #00, #07, [
    asset8 < #78 >   ;00
    palette < #00, #70, #10, %palette_0F5E4B >   ;01
    asset8 < #9A >   ;02
  ] >   ;5C
  asset_list < #14, #01, [
    asset8 < #79 >   ;00
    palette < #00, #70, #10, %palette_0F5F2B >   ;01
    tilemap < #01, %tilemap_0EBF41 >   ;02
    tilemap < #02, %tilemap_0EEFC9 >   ;03
    asset8 < #E1 >   ;04
    graphics < #00, #10, #00, %graphics_066108 >   ;05
    tileset < #00, #20, #00, #01, %tileset_0E7710 >   ;06
    graphics < #00, #10, #10, %graphics_0A5987 >   ;07
    tileset < #00, #20, #00, #02, %tileset_0EB120 >   ;08
    graphics < #00, #10, #30, %graphics_05E915 >   ;09
    palette < #00, #30, #80, %palette_0F7712 >   ;0A
    spritemap < #00, #00, #00, %spritemap_0C5CC4 >   ;0B
    music < #01, #00, %music_0BEFCA >   ;0C
  ] >   ;5D
  asset_list < #14, #02, [
    asset8 < #7A >   ;00
    palette < #00, #70, #10, %palette_0F5F2B >   ;01
    tilemap < #01, %tilemap_0EF935 >   ;02
    tilemap < #02, %tilemap_0EEFC9 >   ;03
    asset8 < #A1 >   ;04
  ] >   ;5E
  asset_list < #14, #03, [
    asset8 < #7B >   ;00
    palette < #00, #70, #10, %palette_0F600B >   ;01
    tilemap < #01, %tilemap_0EE5C6 >   ;02
    tilemap < #02, %tilemap_0BFE71 >   ;03
    asset8 < #A1 >   ;04
  ] >   ;5F
  asset_list < #15, #01, [
    asset8 < #7C >   ;00
    tilemap < #01, %tilemap_0F3457 >   ;01
    music < #01, #00, %music_0F6D31 >   ;02
    palette < #00, #30, #80, %palette_0F7772 >   ;03
    asset8 < #E2 >   ;04
    graphics < #00, #10, #00, %graphics_0609F6 >   ;05
    tileset < #00, #20, #00, #01, %tileset_0ED5DB >   ;06
    palette < #00, #70, #10, %palette_0F60EB >   ;07
    graphics < #00, #10, #10, %graphics_0A5987 >   ;08
    tileset < #00, #20, #00, #02, %tileset_0EB120 >   ;09
    tilemap < #02, %tilemap_0F7891 >   ;0A
    graphics < #00, #10, #30, %graphics_0A0000 >   ;0B
    spritemap < #00, #00, #00, %spritemap_0C1C79 >   ;0C
  ] >   ;60
  asset_list < #15, #02, [
    asset8 < #7D >   ;00
    tilemap < #01, %tilemap_0F68AC >   ;01
    palette < #00, #30, #80, %palette_0F77D2 >   ;02
    music < #01, #00, %music_0C0000 >   ;03
    music < #01, #01, %music_0AEC48 >   ;04
    asset8 < #A2 >   ;05
  ] >   ;61
]