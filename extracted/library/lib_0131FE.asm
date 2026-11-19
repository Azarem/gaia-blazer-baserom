?BANK 02

---------------------------------------------

code_0131FE {
    PHP 
    SEP #$20
    XBA 
    LDA #$00
    XBA 
    CMP #$80
    BCC loc_01320C
    XBA 
    DEC 
    XBA 

  loc_01320C:
    PLP 
    RTL 
}