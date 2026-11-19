?BANK 02

!RDNMI                          4210

---------------------------------------------

code_0131B7 {
    PHP 
    SEP #$20
    PHA 
    LDA $RDNMI

  loc_0131BE:
    LDA $RDNMI
    BPL loc_0131BE
    LDA $RDNMI
    PLA 
    PLP 
    RTL 
}