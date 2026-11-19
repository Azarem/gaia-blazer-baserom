?BANK 02

?INCLUDE 'lib_017504'
?INCLUDE 'lib_0272E6'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!vram_write_queue               1C7B
!tile_type_map                  7F8000

---------------------------------------------

code_0108BB {
    PHX                   ; {67771}
    ASL                   ; {67772}
    ASL                   ; {67773}
    ASL                   ; {67774}
    TAX                   ; {67775}
    TXY                   ; {67776}
    LDA $@lib_017504.unk14_017504+4, X ; {67777}
    STA $16               ; {67781}
    LDA $@lib_017504.unk14_017504+6, X ; {67783}
    STA $18               ; {67787}
    JSL $@lib_027462_part1.code_0272B8 ; {67789}
    PHX                   ; {67793}
    TYX                   ; {67794}
    LDA $@lib_017504.unk14_017504, X ; {67795}
    AND #$00FF            ; {67799}
    ASL                   ; {67802}
    ASL                   ; {67803}
    ASL                   ; {67804}
    ASL                   ; {67805}
    STA $00               ; {67806}
    LDA $@lib_017504.unk14_017504+1, X ; {67808}
    AND #$00FF            ; {67812}
    ASL                   ; {67815}
    ASL                   ; {67816}
    ASL                   ; {67817}
    ASL                   ; {67818}
    STA $18               ; {67819}
    LDA $@lib_017504.unk14_017504+2, X ; {67821}
    AND #$00FF            ; {67825}
    STA $02               ; {67828}
    LDA $@lib_017504.unk14_017504+3, X ; {67830}
    AND #$00FF            ; {67834}
    STA $0E               ; {67837}
    LDY #$0000            ; {67839}
    PLX                   ; {67842}

  loc_010903:
    PHX                   ; {67843}
    LDA $02               ; {67844}
    STA $0C               ; {67846}
    LDA $00               ; {67848}
    STA $16               ; {67850}

  loc_01090C:
    PHX                   ; {67852}
    SEP #$20              ; {67853}
    LDA $7E8000, X        ; {67855}
    PHA                   ; {67859}
    LDA $tile_type_map, X ; {67860}
    PHA                   ; {67864}
    REP #$20              ; {67865}
    JSL $@lib_027462_part1.code_0272B8 ; {67867}
    SEP #$20              ; {67871}
    PLA                   ; {67873}
    STA $tile_type_map, X ; {67874}
    PLA                   ; {67878}
    STA $7E8000, X        ; {67879}
    REP #$20              ; {67883}
    LDA $16               ; {67885}
    CLC                   ; {67887}
    ADC #$0010            ; {67888}
    SEC                   ; {67891}
    SBC $scroll_bg1_x     ; {67892}
    CMP #$0111            ; {67895}
    BCS loc_0109A6        ; {67898}
    LDA $18               ; {67900}
    CLC                   ; {67902}
    ADC #$0010            ; {67903}
    SEC                   ; {67906}
    SBC $scroll_bg1_y     ; {67907}
    CMP #$0111            ; {67910}
    BCS loc_0109A6        ; {67913}
    LDA $7E8000, X        ; {67915}
    AND #$00FF            ; {67919}
    ASL                   ; {67922}
    ASL                   ; {67923}
    ASL                   ; {67924}
    TAX                   ; {67925}
    LDA $7E2000, X        ; {67926}
    AND $035C             ; {67930}
    ORA $036A             ; {67933}
    STA $1C7D, Y          ; {67936}
    LDA $7E2002, X        ; {67939}
    AND $035C             ; {67943}
    ORA $036A             ; {67946}
    STA $1C81, Y          ; {67949}
    LDA $7E2004, X        ; {67952}
    AND $035C             ; {67956}
    ORA $036A             ; {67959}
    STA $1C85, Y          ; {67962}
    LDA $7E2006, X        ; {67965}
    AND $035C             ; {67969}
    ORA $036A             ; {67972}
    STA $1C89, Y          ; {67975}
    JSL $@lib_0272E6.code_0272E6 ; {67978}
    STA $vram_write_queue, Y ; {67982}
    INC                   ; {67985}
    STA $1C7F, Y          ; {67986}
    CLC                   ; {67989}
    ADC #$001F            ; {67990}
    STA $1C83, Y          ; {67993}
    INC                   ; {67996}
    STA $1C87, Y          ; {67997}
    TYA                   ; {68000}
    CLC                   ; {68001}
    ADC #$0010            ; {68002}
    TAY                   ; {68005}

  loc_0109A6:
    PLX                   ; {68006}
    JSL $@lib_027462_part2.code_02731A ; {68007}
    LDA $16               ; {68011}
    CLC                   ; {68013}
    ADC #$0010            ; {68014}
    STA $16               ; {68017}
    DEC $0C               ; {68019}
    BEQ loc_0109BA        ; {68021}
    BRL loc_01090C        ; {68023}

  loc_0109BA:
    PLX                   ; {68026}
    JSL $@lib_027462_part2.code_027331 ; {68027}
    LDA $18               ; {68031}
    CLC                   ; {68033}
    ADC #$0010            ; {68034}
    STA $18               ; {68037}
    DEC $0E               ; {68039}
    BEQ loc_0109CE        ; {68041}
    BRL loc_010903        ; {68043}

  loc_0109CE:
    LDA #$0000            ; {68046}
    STA $vram_write_queue, Y ; {68049}
    PLX                   ; {68052}
    RTL                   ; {68053}
}