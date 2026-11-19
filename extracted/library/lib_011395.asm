?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_01112A'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'table_00B69A'

!map_width_pages                0343
!map_height_pages               0345
!player_tile_x                  0378
!player_tile_y                  037A
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

code_011395 {
    LDX #$01FF            ; {70549}

  loc_011398:
    LDA $7F0203, X        ; {70552}
    BPL loc_0113A1        ; {70556}
    ASL                   ; {70558}
    BMI loc_0113A5        ; {70559}

  loc_0113A1:
    DEX                   ; {70561}
    BPL loc_011398        ; {70562}
    RTL                   ; {70564}

  loc_0113A5:
    REP #$20              ; {70565}
    PHX                   ; {70567}
    TXA                   ; {70568}
    ASL                   ; {70569}
    ASL                   ; {70570}
    ASL                   ; {70571}
    ASL                   ; {70572}
    ASL                   ; {70573}
    TAX                   ; {70574}
    TAY                   ; {70575}
    SEP #$20              ; {70576}
    LDA $&data_00BA0D, X  ; {70578}
    CMP $location_id      ; {70581}
    BEQ loc_0113BD        ; {70584}
    BRL loc_011441        ; {70586}

  loc_0113BD:
    LDY $&data_00BA0D+1E, X ; {70589}
    BEQ loc_0113D2        ; {70592}
    LDA $&data_00BA0D+1F, X ; {70594}
    XBA                   ; {70597}
    LDA $&data_00BA0D+1E, X ; {70598}
    LDY #$1ADE            ; {70601}
    JSL $@lib_0273A2.code_0273A2 ; {70604}
    BCC loc_011441        ; {70608}

  loc_0113D2:
    TXY                   ; {70610}
    REP #$20              ; {70611}
    LDA $&data_00BA0D+2, X ; {70613}
    AND #$00FF            ; {70616}
    ASL                   ; {70619}
    ASL                   ; {70620}
    ASL                   ; {70621}
    ASL                   ; {70622}
    STA $16               ; {70623}
    LDA $&data_00BA0D+3, X ; {70625}
    AND #$00FF            ; {70628}
    ASL                   ; {70631}
    ASL                   ; {70632}
    ASL                   ; {70633}
    ASL                   ; {70634}
    STA $18               ; {70635}
    JSL $@lib_027462_part1.code_0272B8 ; {70637}
    SEP #$20              ; {70641}
    LDA $&data_00BA0D+6, Y ; {70643}
    ORA $&data_00BA0D+7, Y ; {70646}
    BNE loc_01143B        ; {70649}
    LDA $map_width_pages  ; {70651}
    XBA                   ; {70654}
    LDA $map_height_pages ; {70655}
    JSL $@lib_shared_0131D1.code_0131D1 ; {70658}
    STA $01               ; {70662}
    STZ $00               ; {70664}
    XBA                   ; {70666}
    LDA $&data_00BA0D+1, Y ; {70667}
    BEQ loc_011421        ; {70670}
    JSL $@lib_shared_0131D1.code_0131D1 ; {70672}
    REP #$20              ; {70676}
    PHX                   ; {70678}
    XBA                   ; {70679}
    CLC                   ; {70680}
    ADC $01, S            ; {70681}
    TAX                   ; {70683}
    PLA                   ; {70684}
    SEP #$20              ; {70685}
    BRA loc_01143B        ; {70687}

  loc_011421:
    LDY #$0003            ; {70689}

  loc_011424:
    LDA #$01              ; {70692}
    STA $tile_type_map, X ; {70694}
    REP #$20              ; {70698}
    TXA                   ; {70700}
    CLC                   ; {70701}
    ADC $00               ; {70702}
    TAX                   ; {70704}
    SEP #$20              ; {70705}
    CPX #$4000            ; {70707}
    BCS loc_011441        ; {70710}
    DEY                   ; {70712}
    BNE loc_011424        ; {70713}

  loc_01143B:
    LDA #$01              ; {70715}
    STA $tile_type_map, X ; {70717}

  loc_011441:
    PLX                   ; {70721}
    BRL loc_0113A1        ; {70722}

  code_011445:
    LDX #$0000            ; {70725}
    STZ $03A8             ; {70728}
    REP #$20              ; {70731}
    LDA $location_id      ; {70733}
    ASL                   ; {70736}
    ASL                   ; {70737}
    TAX                   ; {70738}
    STX $03AA             ; {70739}
    LDA $&table_00B69A, X ; {70742}
    SEC                   ; {70745}
    SBC #$&table_00B69A   ; {70746}
    STA $03AC             ; {70749}
    TAX                   ; {70752}
    SEP #$20              ; {70753}

  loc_011463:
    LDA $&table_00B69A, X ; {70755}
    CMP #$FF              ; {70758}
    BEQ loc_01148E        ; {70760}
    CMP $player_tile_x    ; {70762}
    BNE loc_011487        ; {70765}
    LDA $&table_00B69A+1, X ; {70767}
    CMP $player_tile_y    ; {70770}
    BNE loc_011487        ; {70773}
    LDA $&table_00B69A+3, X ; {70775}
    XBA                   ; {70778}
    LDA $&table_00B69A+2, X ; {70779}
    LDY #$1A9E            ; {70782}
    JSL $@lib_0273A2.code_0273A2 ; {70785}
    BCS loc_01148F        ; {70789}

  loc_011487:
    INX                   ; {70791}
    INX                   ; {70792}
    INX                   ; {70793}
    INX                   ; {70794}
    BRL loc_011463        ; {70795}

  loc_01148E:
    RTL                   ; {70798}

  loc_01148F:
    REP #$20              ; {70799}
    LDA $&table_00B69A+2, X ; {70801}
    ASL                   ; {70804}
    ASL                   ; {70805}
    ASL                   ; {70806}
    ASL                   ; {70807}
    ASL                   ; {70808}
    CLC                   ; {70809}
    ADC #$&data_00BA0D    ; {70810}
    TAX                   ; {70813}
    LDY #$1C6D            ; {70814}
    LDA #$0007            ; {70817}
    MVN #$01, #$^data_00BA0D ; {70820}
    SEP #$20              ; {70823}
    LDA #$02              ; {70825}
    STA $1C6E             ; {70827}
    JSR $&lib_shared_01112A.code_01112A ; {70830}
    REP #$20              ; {70833}
    LDX $03AA             ; {70835}
    LDA $03A8             ; {70838}
    EOR #$0001            ; {70841}
    STA $03A8             ; {70844}
    BEQ loc_0114C3        ; {70847}
    INX                   ; {70849}
    INX                   ; {70850}

  loc_0114C3:
    LDA $&table_00B69A, X ; {70851}
    SEC                   ; {70854}
    SBC #$&table_00B69A   ; {70855}
    STA $03AC             ; {70858}
    SEP #$20              ; {70861}
    RTL                   ; {70863}
}