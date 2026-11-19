?BANK 04

?INCLUDE 'data_048000'
?INCLUDE 'engine_000000'
?INCLUDE 'lib_0118FC_part8'
?INCLUDE 'lib_01318C'
?INCLUDE 'lib_027781_part3'
?INCLUDE 'lib_shared_0131D1'

!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!scene_active                   032E
!map_width_pages                0343
!map_height_pages               0345
!vram_upload_flags              03B8
!transition_type                03E3
!return_active                  03FB
!S_switch_owner_table           0483
!INIDISP                        2100
!MOSAIC                         2106
!VMADDL                         2116
!VMDATAL                        2118
!cgram_buffer                   7F0000
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_0276EE {
    PHX                   ; {161518}
    PHP                   ; {161519}
    REP #$20              ; {161520}
    LDA #$2000            ; {161522}
    LDX #$0000            ; {161525}

  loc_0276F8:
    STA $bg3_tilemap_buffer, X ; {161528}
    INX                   ; {161532}
    INX                   ; {161533}
    CPX #$1000            ; {161534}
    BNE loc_0276F8        ; {161537}
    PLP                   ; {161539}
    PLX                   ; {161540}
    RTL                   ; {161541}
}

code_027706 {
    LDA $return_active    ; {161542}
    BEQ loc_027722        ; {161545}
    PHB                   ; {161547}
    LDA #$7F              ; {161548}
    PHA                   ; {161550}
    PLB                   ; {161551}
    REP #$20              ; {161552}
    LDX #$0000            ; {161554}

  loc_027715:
    STZ $S_switch_owner_table, X ; {161557}
    INX                   ; {161560}
    INX                   ; {161561}
    CPX #$0400            ; {161562}
    BNE loc_027715        ; {161565}
    SEP #$20              ; {161567}
    PLB                   ; {161569}

  loc_027722:
    RTL                   ; {161570}
}

code_027723 {
    LDA #$02              ; {161571}
    STA $2A               ; {161573}
    LDA $map_width_pages  ; {161575}
    XBA                   ; {161578}
    LDA $map_height_pages ; {161579}
    JSL $@lib_shared_0131D1.code_0131D1 ; {161582}
    XBA                   ; {161586}
    TAY                   ; {161587}
    BEQ loc_02773C        ; {161588}
    LDX #$8000            ; {161590}
    JSR $&code_02773D     ; {161593}

  loc_02773C:
    RTL                   ; {161596}
}

code_02773D {
    PHX                   ; {161597}
    PHY                   ; {161598}
    LDX #$0000            ; {161599}
    TXY                   ; {161602}
    LDA #$00              ; {161603}
    STA $0C               ; {161605}

  loc_027747:
    LDA #$04              ; {161607}
    STA $0E               ; {161609}

  loc_02774B:
    LDA $7E2001, X        ; {161611}
    INX                   ; {161615}
    INX                   ; {161616}
    AND #$02              ; {161617}
    PHA                   ; {161619}
    DEC $0E               ; {161620}
    BNE loc_02774B        ; {161622}
    PLA                   ; {161624}
    ASL                   ; {161625}
    ORA $01, S            ; {161626}
    ASL                   ; {161628}
    ORA $02, S            ; {161629}
    ASL                   ; {161631}
    ORA $03, S            ; {161632}
    LSR                   ; {161634}
    STA $0200, Y          ; {161635}
    INY                   ; {161638}
    PLA                   ; {161639}
    PLA                   ; {161640}
    PLA                   ; {161641}
    DEC $0C               ; {161642}
    BNE loc_027747        ; {161644}
    PLY                   ; {161646}
    PLX                   ; {161647}

  loc_027770:
    LDA $7E0000, X        ; {161648}
    STA $29               ; {161652}
    LDA ($29)             ; {161654}
    STA $cgram_buffer, X  ; {161656}
    INX                   ; {161660}
    DEY                   ; {161661}
    BNE loc_027770        ; {161662}
    RTS                   ; {161664}
}

code_027781 {
    LDA $scene_next       ; {161665}
    BEQ loc_0277D4        ; {161668}
    LDA $scene_active     ; {161670}
    BEQ loc_027798        ; {161673}
    LDA #$1E              ; {161675}
    STA $03E5             ; {161677}
    LDA #$FF              ; {161680}
    STA $03E7             ; {161682}
    JSR $&code_0277D5     ; {161685}

  loc_027798:
    STZ $scene_active     ; {161688}
    STZ $42               ; {161691}
    JSL $@lib_01318C.code_01318C ; {161693}
    LDA $scene_next       ; {161697}
    STA $scene_current    ; {161700}
    LDA $area_next        ; {161703}
    STA $area_current     ; {161706}
    STZ $scene_next       ; {161709}
    JSL $@lib_027781_part3.code_0279B5 ; {161712}
    JSL $@engine_000000.code_000127 ; {161716}
    JSL $@lib_0118FC_part8.code_0131A2 ; {161720}
    STZ $03E5             ; {161724}
    LDA #$01              ; {161727}
    STA $03E7             ; {161729}
    JSR $&code_027827     ; {161732}
    INC $scene_active     ; {161735}
    STZ $transition_type  ; {161738}
    STZ $0462             ; {161741}
    JSL $@engine_000000.code_000127 ; {161744}

  loc_0277D4:
    RTL                   ; {161748}
}

code_0277D5 {
    LDA $transition_type  ; {161749}
    BPL loc_0277DD        ; {161752}
    BRL loc_02787C        ; {161754}

  loc_0277DD:
    BEQ loc_0277F4        ; {161757}
    DEC                   ; {161759}
    BEQ loc_0277F4        ; {161760}
    DEC                   ; {161762}
    BEQ loc_027801        ; {161763}
    DEC                   ; {161765}
    BEQ loc_027801        ; {161766}
    DEC                   ; {161768}
    BEQ loc_027809        ; {161769}
    DEC                   ; {161771}
    BEQ loc_027809        ; {161772}
    DEC                   ; {161774}
    BEQ loc_027801        ; {161775}
    DEC                   ; {161777}
    BEQ loc_027801        ; {161778}

  loc_0277F4:
    LDA #$0F              ; {161780}

  loc_0277F6:
    JSL $@engine_000000.code_000127 ; {161782}
    STA $INIDISP          ; {161786}
    DEC                   ; {161789}
    BPL loc_0277F6        ; {161790}
    RTS                   ; {161792}

  loc_027801:
    JSL $@engine_000000.code_000127 ; {161793}
    STZ $INIDISP          ; {161797}
    RTS                   ; {161800}

  loc_027809:
    LDA #$0F              ; {161801}

  loc_02780B:
    JSL $@engine_000000.code_000127 ; {161803}
    JSL $@engine_000000.code_000127 ; {161807}
    STA $INIDISP          ; {161811}
    PHA                   ; {161814}
    EOR #$0F              ; {161815}
    ASL                   ; {161817}
    ASL                   ; {161818}
    ASL                   ; {161819}
    ASL                   ; {161820}
    ORA #$03              ; {161821}
    STA $MOSAIC           ; {161823}
    PLA                   ; {161826}
    DEC                   ; {161827}
    BPL loc_02780B        ; {161828}
    RTS                   ; {161830}
}

code_027827 {
    LDA $transition_type  ; {161831}
    BMI loc_02787C        ; {161834}
    BEQ loc_027843        ; {161836}
    DEC                   ; {161838}
    BEQ loc_027852        ; {161839}
    DEC                   ; {161841}
    BEQ loc_027843        ; {161842}
    DEC                   ; {161844}
    BEQ loc_027852        ; {161845}
    DEC                   ; {161847}
    BEQ loc_02785C        ; {161848}
    DEC                   ; {161850}
    BEQ loc_027852        ; {161851}
    DEC                   ; {161853}
    BEQ loc_02785C        ; {161854}
    DEC                   ; {161856}
    BEQ loc_027852        ; {161857}

  loc_027843:
    LDA #$00              ; {161859}

  loc_027845:
    JSL $@engine_000000.code_000127 ; {161861}
    STA $INIDISP          ; {161865}
    INC                   ; {161868}
    CMP #$10              ; {161869}
    BCC loc_027845        ; {161871}
    RTS                   ; {161873}

  loc_027852:
    JSL $@engine_000000.code_000127 ; {161874}
    LDA #$0F              ; {161878}
    STA $INIDISP          ; {161880}
    RTS                   ; {161883}

  loc_02785C:
    LDA #$00              ; {161884}

  loc_02785E:
    JSL $@engine_000000.code_000127 ; {161886}
    JSL $@engine_000000.code_000127 ; {161890}
    STA $INIDISP          ; {161894}
    PHA                   ; {161897}
    EOR #$0F              ; {161898}
    ASL                   ; {161900}
    ASL                   ; {161901}
    ASL                   ; {161902}
    ASL                   ; {161903}
    ORA #$03              ; {161904}
    STA $MOSAIC           ; {161906}
    PLA                   ; {161909}
    INC                   ; {161910}
    CMP #$10              ; {161911}
    BCC loc_02785E        ; {161913}
    RTS                   ; {161915}

  loc_02787C:
    LDA $03E7             ; {161916}
    BPL loc_02788F        ; {161919}
    INC $0462             ; {161921}
    JSL $@code_0276EE     ; {161924}
    LDA #$01              ; {161928}
    TSB $vram_upload_flags ; {161930}
    BRA loc_027894        ; {161933}

  loc_02788F:
    LDA #$0F              ; {161935}
    STA $INIDISP          ; {161937}

  loc_027894:
    JSL $@engine_000000.code_000127 ; {161940}
    JSL $@engine_000000.code_000127 ; {161944}
    LDA $03E5             ; {161948}
    ASL                   ; {161951}
    ASL                   ; {161952}
    ASL                   ; {161953}
    ASL                   ; {161954}
    XBA                   ; {161955}
    LDA $transition_type  ; {161956}
    ADC $transition_type  ; {161959}
    XBA                   ; {161962}
    TAX                   ; {161963}
    REP #$20              ; {161964}
    LDA #$4000            ; {161966}
    STA $VMADDL           ; {161969}
    LDA $@data_048000.binary_048000, X ; {161972}
    STA $VMDATAL          ; {161976}
    LDA $@data_048000.binary_048000+2, X ; {161979}
    STA $VMDATAL          ; {161983}
    LDA $@data_048000.binary_048000+4, X ; {161986}
    STA $VMDATAL          ; {161990}
    LDA $@data_048000.binary_048000+6, X ; {161993}
    STA $VMDATAL          ; {161997}
    LDA $@data_048000.binary_048000+8, X ; {162000}
    STA $VMDATAL          ; {162004}
    LDA $@data_048000.binary_048000+A, X ; {162007}
    STA $VMDATAL          ; {162011}
    LDA $@data_048000.binary_048000+C, X ; {162014}
    STA $VMDATAL          ; {162018}
    LDA $@data_048000.binary_048000+E, X ; {162021}
    STA $VMDATAL          ; {162025}
    SEP #$20              ; {162028}
    LDA $03E7             ; {162030}
    BPL loc_027900        ; {162033}
    LDA $03E5             ; {162035}
    CLC                   ; {162038}
    ADC $03E7             ; {162039}
    STA $03E5             ; {162042}
    BPL loc_027894        ; {162045}
    RTS                   ; {162047}

  loc_027900:
    LDA $03E5             ; {162048}
    CLC                   ; {162051}
    ADC $03E7             ; {162052}
    STA $03E5             ; {162055}
    CMP #$20              ; {162058}
    BEQ loc_027911        ; {162060}
    BRL loc_027894        ; {162062}

  loc_027911:
    RTS                   ; {162065}
}