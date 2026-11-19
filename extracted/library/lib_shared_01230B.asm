?BANK 02

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_01230B {
    LDA $03C6             ; {74507}
    AND #$1F              ; {74510}
    CMP #$18              ; {74512}
    BCC loc_012318        ; {74514}
    LDA #$20              ; {74516}
    BRA loc_01231A        ; {74518}

  loc_012318:
    LDA #$2B              ; {74520}

  loc_01231A:
    STA $7F6FC0, X        ; {74522}
    STA $bg3_tilemap_buffer, X ; {74526}
    INC $03C6             ; {74530}
    LDA #$01              ; {74533}
    TSB $vram_upload_flags ; {74535}
    RTS                   ; {74538}
}