?BANK 02

!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

code_01230B {
    LDA $03C6
    AND #$1F
    CMP #$18
    BCC loc_012318
    LDA #$20
    BRA loc_01231A

  loc_012318:
    LDA #$2B

  loc_01231A:
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    INC $03C6
    LDA #$01
    TSB $vram_upload_flags
    RTS 
}