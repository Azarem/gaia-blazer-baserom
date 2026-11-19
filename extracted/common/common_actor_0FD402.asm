?BANK 1F

---------------------------------------------

code_0FD402 {
    LDA $001A, X          ; {1037314}
    ORA #$0400            ; {1037317}
    STA $001A, X          ; {1037320}

  loc_0FD40B:
    COP [AD] ( #08 )      ; {1037323}
    COP [9C] ( &code_0FD414, &code_0FD41E ) ; {1037326}
}

code_0FD414 {
    COP [9A] ( #$0000, &code_0FD428, &code_0FD440, &code_0FD440 ) ; {1037332}
}

code_0FD41E {
    COP [9B] ( #$0000, &code_0FD458, &code_0FD470, &code_0FD470 ) ; {1037342}
}

code_0FD428 {
    COP [97]              ; {1037352}

  code_0FD42A:
    COP [81] ( #18, #02 ) ; {1037354}
    COP [83]              ; {1037358}
    COP [28] ( &code_0FD436 ) ; {1037360}
    BRA loc_0FD488        ; {1037364}
}

code_0FD436 {
    COP [9A] ( #$0008, &code_0FD42A, &code_0FD41E, &code_0FD440 ) ; {1037366}
}

code_0FD440 {
    COP [97]              ; {1037376}

  code_0FD442:
    COP [81] ( #19, #02 ) ; {1037378}
    COP [83]              ; {1037382}
    COP [28] ( &code_0FD44E ) ; {1037384}
    BRA loc_0FD488        ; {1037388}
}

code_0FD44E {
    COP [9A] ( #$0008, &code_0FD428, &code_0FD41E, &code_0FD442 ) ; {1037390}
}

code_0FD458 {
    COP [97]              ; {1037400}

  code_0FD45A:
    COP [81] ( #17, #02 ) ; {1037402}
    COP [83]              ; {1037406}
    COP [28] ( &code_0FD466 ) ; {1037408}
    BRA loc_0FD488        ; {1037412}
}

code_0FD466 {
    COP [9B] ( #$0008, &code_0FD45A, &code_0FD414, &code_0FD470 ) ; {1037414}
}

code_0FD470 {
    COP [97]              ; {1037424}

  code_0FD472:
    COP [81] ( #16, #02 ) ; {1037426}
    COP [83]              ; {1037430}
    COP [28] ( &code_0FD47E ) ; {1037432}
    BRA loc_0FD488        ; {1037436}
}

code_0FD47E {
    COP [9B] ( #$0008, &code_0FD458, &code_0FD414, &code_0FD472 ) ; {1037438}

  loc_0FD488:
    COP [80] ( #15 )      ; {1037448}
    COP [82]              ; {1037451}

  loc_0FD48D:
    COP [AD] ( #08 )      ; {1037453}
    COP [9C] ( &code_0FD496, &code_0FD4A0 ) ; {1037456}
}

code_0FD496 {
    COP [9A] ( #$0000, &code_0FD4AA, &code_0FD4C0, &code_0FD4C0 ) ; {1037462}
}

code_0FD4A0 {
    COP [9B] ( #$0000, &code_0FD4D6, &code_0FD4EC, &code_0FD4EC ) ; {1037472}
}

code_0FD4AA {
    COP [97]              ; {1037482}
    COP [23] ( &code_0FD4B8 ) ; {1037484}
    COP [81] ( #14, #04 ) ; {1037488}
    COP [83]              ; {1037492}
    BRA loc_0FD48D        ; {1037494}
}

code_0FD4B8 {
    COP [80] ( #11 )      ; {1037496}
    COP [82]              ; {1037499}
    BRL loc_0FD40B        ; {1037501}
}

code_0FD4C0 {
    COP [96]              ; {1037504}
    COP [24] ( &code_0FD4CE ) ; {1037506}
    COP [81] ( #14, #04 ) ; {1037510}
    COP [83]              ; {1037514}
    BRA loc_0FD48D        ; {1037516}
}

code_0FD4CE {
    COP [80] ( #11 )      ; {1037518}
    COP [82]              ; {1037521}
    BRL loc_0FD40B        ; {1037523}
}

code_0FD4D6 {
    COP [97]              ; {1037526}
    COP [21] ( &code_0FD4E4 ) ; {1037528}
    COP [81] ( #13, #04 ) ; {1037532}
    COP [83]              ; {1037536}
    BRA loc_0FD48D        ; {1037538}
}

code_0FD4E4 {
    COP [80] ( #10 )      ; {1037540}
    COP [82]              ; {1037543}
    BRL loc_0FD40B        ; {1037545}
}

code_0FD4EC {
    COP [97]              ; {1037548}
    COP [22] ( &code_0FD4FA ) ; {1037550}
    COP [81] ( #12, #04 ) ; {1037554}
    COP [83]              ; {1037558}
    BRA loc_0FD48D        ; {1037560}
}

code_0FD4FA {
    COP [80] ( #0F )      ; {1037562}
    COP [82]              ; {1037565}
    BRL loc_0FD40B        ; {1037567}
}