?BANK 04

?INCLUDE 'lib_0133A6_part3'
?INCLUDE 'lib_shared_027260'

---------------------------------------------

code_02719F {
    PHP 
    REP #$20
    LDA #$&graphics_054000+2
    STA $29
    SEP #$20
    LDA #$^graphics_054000
    STA $2B
    REP #$20
    LDA #$4000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_0133A6_part3.code_013272
    PHB 
    LDX #$8000
    LDY #$3000
    LDA #$3FFF
    MVN #$7F, #$7E
    PLB 
    LDA #$&graphics_05C000+2
    STA $29
    SEP #$20
    LDA #$^graphics_05C000
    STA $2B
    REP #$20
    LDA #$2000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_0133A6_part3.code_013272
    PHB 
    LDX #$8000
    LDY #$1000
    LDA #$1FFF
    MVN #$7F, #$7E
    PLB 
    LDA #$&graphics_04D000+2
    STA $29
    SEP #$20
    LDA #$^graphics_04D000
    STA $2B
    REP #$20
    LDA #$2000
    STA $23
    LDX #$8000
    STX $25
    JSL $@lib_0133A6_part3.code_013272
    PHB 
    LDX #$8000
    LDY #$C000
    LDA #$1FFF
    MVN #$7F, #$7E
    PLB 
    JSL $@lib_shared_027260.code_027260
    PLP 
    RTL 
}