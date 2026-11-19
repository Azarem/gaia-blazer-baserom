?BANK 02

!L_WRMPYA                       004202
!L_WRMPYB                       004203
!L_RDMPYL                       004216
!L_RDMPYH                       004217

---------------------------------------------

code_0131D1 {
    STA $L_WRMPYA         ; {78289}
    XBA                   ; {78293}
    STA $L_WRMPYB         ; {78294}
    NOP                   ; {78298}
    NOP                   ; {78299}
    NOP                   ; {78300}
    NOP                   ; {78301}
    LDA $L_RDMPYH         ; {78302}
    XBA                   ; {78306}
    LDA $L_RDMPYL         ; {78307}
    RTL                   ; {78311}
}