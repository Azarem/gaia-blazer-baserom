?BANK 04

!frame_counter                  0312
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!location_id                    1C6A

---------------------------------------------

code_027223 {
    PHP 
    REP #$20
    LDA $location_id
    SEC 
    SBC #$000F
    CMP #$0004
    BCS loc_027235
    BRL loc_027256

  loc_027235:
    LDA $frame_counter
    AND #$001F
    XBA 
    LSR 
    CLC 
    ADC #$1000
    STA $vram_strip_src
    LDA $frame_counter
    AND #$0003
    ASL 
    TAX 
    LDA $@word_027258, X
    STA $vram_strip_dest
    INC $vram_strip_pending

  loc_027256:
    PLP 
    RTL 
}
---------------------------------------------

word_027258 [
  #$2060   ;00
  #$2080   ;01
  #$20A0   ;02
  #$20C0   ;03
]