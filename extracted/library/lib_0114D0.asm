?BANK 02

?INCLUDE 'table_00AC96'

!location_id                    1C6A

---------------------------------------------

code_0114D0 {
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    LDA $&table_00AC96, X
    SEC 
    SBC #$&table_00AC96
    STA $03B2
    SEP #$20
    RTL 
}