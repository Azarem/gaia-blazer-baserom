?BANK 02

?INCLUDE 'lib_0273A2'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_shared_0131D1'
?INCLUDE 'table_00A9DE'

!map_width_pages                0343
!map_height_pages               0345
!location_id                    1C6A

---------------------------------------------

code_0114E4 {
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    LDA $&table_00A9DE, X
    SEC 
    SBC #$&table_00A9DE
    STA $03AE
    SEP #$20
    LDX $03AE

  loc_0114FA:
    LDA $&table_00A9DE, X
    CMP #$FF
    BEQ loc_01157D
    LDA #$00
    XBA 
    LDA $&table_00A9DE+2, X
    AND #$7F
    LDY #$1A7E
    JSL $@lib_0273A2.code_0273A2
    BCC loc_011570
    PHX 
    LDA $&table_00A9DE+2, X
    STA $02
    REP #$20
    LDA $&table_00A9DE, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&table_00A9DE+1, X
    AND #$00FF
    DEC 
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_shared_0131D1.code_0131D1
    STA $01
    XBA 
    STA $00

  loc_011549:
    LDA $7E8000, X
    CMP #$FB
    BNE loc_011561
    LDA #$FC
    STA $7E8000, X
    LDA $02
    BPL loc_011561
    LDA #$FC
    STA $7EC000, X

  loc_011561:
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    CPX #$4000
    SEP #$20
    BCC loc_011549
    PLX 

  loc_011570:
    REP #$20
    TXA 
    CLC 
    ADC #$0006
    TAX 
    SEP #$20
    BRL loc_0114FA

  loc_01157D:
    RTL 
}