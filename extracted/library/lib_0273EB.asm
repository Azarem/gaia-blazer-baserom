?BANK 04

---------------------------------------------

code_0273EB {
    PHP 
    REP #$20
    LDA $001C, X
    EOR #$4000
    STA $001C, X
    PLP 
    RTL 
}