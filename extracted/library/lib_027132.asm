?BANK 04

?INCLUDE 'lib_shared_02716E'

---------------------------------------------

code_027132 {
    PHP 
    PHB 
    PHX 
    REP #$20
    LDA $03A4
    XBA 
    ASL 
    ASL 
    TAX 
    JSL $@lib_shared_02716E.code_02716E
    LDA $16
    CMP $7003FA, X
    BNE loc_027169
    LDA $18
    CMP $7003FC, X
    BNE loc_027169
    LDY #$0203
    LDA #$01FF
    MVN #$7F, #$70
    LDY #$1A5E
    LDA #$01F9
    MVN #$01, #$70
    PLX 
    PLB 
    PLP 
    CLC 
    RTL 

  loc_027169:
    PLX 
    PLB 
    PLP 
    SEC 
    RTL 
}