?BANK 04

!frame_counter                  0312
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!location_id                    1C6A

---------------------------------------------

code_027223 {
    PHP                   ; {160291}
    REP #$20              ; {160292}
    LDA $location_id      ; {160294}
    SEC                   ; {160297}
    SBC #$000F            ; {160298}
    CMP #$0004            ; {160301}
    BCS loc_027235        ; {160304}
    BRL loc_027256        ; {160306}

  loc_027235:
    LDA $frame_counter    ; {160309}
    AND #$001F            ; {160312}
    XBA                   ; {160315}
    LSR                   ; {160316}
    CLC                   ; {160317}
    ADC #$1000            ; {160318}
    STA $vram_strip_src   ; {160321}
    LDA $frame_counter    ; {160324}
    AND #$0003            ; {160327}
    ASL                   ; {160330}
    TAX                   ; {160331}
    LDA $@word_027258, X  ; {160332}
    STA $vram_strip_dest  ; {160336}
    INC $vram_strip_pending ; {160339}

  loc_027256:
    PLP                   ; {160342}
    RTL                   ; {160343}
}
---------------------------------------------

word_027258 [
  #$2060   ;00
  #$2080   ;01
  #$20A0   ;02
  #$20C0   ;03
]