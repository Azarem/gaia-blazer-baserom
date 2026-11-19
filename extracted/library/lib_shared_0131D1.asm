?BANK 02

!L_WRMPYA                       004202
!L_WRMPYB                       004203
!L_RDMPYL                       004216
!L_RDMPYH                       004217

---------------------------------------------

code_0131D1 {
    STA $L_WRMPYA
    XBA 
    STA $L_WRMPYB
    NOP 
    NOP 
    NOP 
    NOP 
    LDA $L_RDMPYH
    XBA 
    LDA $L_RDMPYL
    RTL 
}