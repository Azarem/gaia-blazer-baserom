?BANK 1F

---------------------------------------------

code_0FBD12 {
    COP [A5] ( &code_0FBD1C, &code_0FBD23, &code_0FBD2A, &code_0FBD33 ) ; {1031442}
}

code_0FBD1C {
    COP [80] ( #08 )      ; {1031452}
    COP [82]              ; {1031455}
    BRA loc_0FBD38        ; {1031457}
}

code_0FBD23 {
    COP [80] ( #0A )      ; {1031459}
    COP [82]              ; {1031462}
    BRA loc_0FBD38        ; {1031464}
}

code_0FBD2A {
    COP [96]              ; {1031466}
    COP [80] ( #0A )      ; {1031468}
    COP [82]              ; {1031471}
    BRA loc_0FBD38        ; {1031473}
}

code_0FBD33 {
    COP [80] ( #09 )      ; {1031475}
    COP [82]              ; {1031478}

  loc_0FBD38:
    COP [AD] ( #08 )      ; {1031480}
    COP [9C] ( &code_0FBD41, &code_0FBDC2 ) ; {1031483}
}

code_0FBD41 {
    COP [9A] ( #$0000, &code_0FBD4B, &code_0FBD86, &code_0FBD86 ) ; {1031489}
}

code_0FBD4B {
    COP [97]              ; {1031499}
    COP [80] ( #0A )      ; {1031501}
    COP [82]              ; {1031504}

  code_0FBD52:
    COP [80] ( #0D )      ; {1031506}
    COP [82]              ; {1031509}
    COP [9A] ( #$0000, &code_0FBD52, &code_0FBD61, &code_0FBD61 ) ; {1031511}
}

code_0FBD61 {
    LDA $0016, X          ; {1031521}
    ORA #$0200            ; {1031524}
    STA $0016, X          ; {1031527}
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 ) ; {1031530}
    LDA $0016, X          ; {1031541}
    AND #$FDFF            ; {1031544}
    STA $0016, X          ; {1031547}
    COP [81] ( #0A, #02 ) ; {1031550}
    COP [83]              ; {1031554}
    BRA loc_0FBD38        ; {1031556}
}

code_0FBD86 {
    COP [96]              ; {1031558}
    COP [80] ( #0A )      ; {1031560}
    COP [82]              ; {1031563}

  code_0FBD8D:
    COP [80] ( #0D )      ; {1031565}
    COP [82]              ; {1031568}
    COP [9A] ( #$0000, &code_0FBD9C, &code_0FBD9C, &code_0FBD8D ) ; {1031570}
}

code_0FBD9C {
    LDA $0016, X          ; {1031580}
    ORA #$0200            ; {1031583}
    STA $0016, X          ; {1031586}
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 ) ; {1031589}
    LDA $0016, X          ; {1031600}
    AND #$FDFF            ; {1031603}
    STA $0016, X          ; {1031606}
    COP [81] ( #0A, #02 ) ; {1031609}
    COP [83]              ; {1031613}
    BRL loc_0FBD38        ; {1031615}
}

code_0FBDC2 {
    COP [9B] ( #$0000, &code_0FBDCC, &code_0FBE08, &code_0FBE08 ) ; {1031618}
}

code_0FBDCC {
    COP [97]              ; {1031628}
    COP [80] ( #09 )      ; {1031630}
    COP [82]              ; {1031633}

  code_0FBDD3:
    COP [80] ( #0C )      ; {1031635}
    COP [82]              ; {1031638}
    COP [9B] ( #$0000, &code_0FBDD3, &code_0FBDE2, &code_0FBDE2 ) ; {1031640}
}

code_0FBDE2 {
    LDA $0016, X          ; {1031650}
    ORA #$0200            ; {1031653}
    STA $0016, X          ; {1031656}
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 ) ; {1031659}
    LDA $0016, X          ; {1031670}
    AND #$FDFF            ; {1031673}
    STA $0016, X          ; {1031676}
    COP [81] ( #09, #02 ) ; {1031679}
    COP [83]              ; {1031683}
    BRL loc_0FBD38        ; {1031685}
}

code_0FBE08 {
    COP [97]              ; {1031688}
    COP [80] ( #08 )      ; {1031690}
    COP [82]              ; {1031693}

  code_0FBE0F:
    COP [80] ( #0B )      ; {1031695}
    COP [82]              ; {1031698}
    COP [9B] ( #$0000, &code_0FBE1E, &code_0FBE1E, &code_0FBE0F ) ; {1031700}
}

code_0FBE1E {
    LDA $0016, X          ; {1031710}
    ORA #$0200            ; {1031713}
    STA $0016, X          ; {1031716}
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 ) ; {1031719}
    LDA $0016, X          ; {1031730}
    AND #$FDFF            ; {1031733}
    STA $0016, X          ; {1031736}
    COP [81] ( #08, #02 ) ; {1031739}
    COP [83]              ; {1031743}
    BRL loc_0FBD38        ; {1031745}
}

code_0FBE44 {
    COP [A3]              ; {1031748}
    COP [97]              ; {1031750}
    COP [99]              ; {1031752}
    COP [81] ( #10, #08 ) ; {1031754}
    COP [83]              ; {1031758}
    BRK #$4B              ; {1031760}
    COP [9C] ( &code_0FBE58, &code_0FBE62 ) ; {1031762}
}

code_0FBE58 {
    COP [9A] ( #$0000, &code_0FBE78, &code_0FBE76, &code_0FBE76 ) ; {1031768}
}

code_0FBE62 {
    COP [9B] ( #$0000, &code_0FBE6C, &code_0FBE6E, &code_0FBE6E ) ; {1031778}
}

code_0FBE6C {
    COP [98]              ; {1031788}
}

code_0FBE6E {
    COP [81] ( #0E, #20 ) ; {1031790}
    COP [83]              ; {1031794}
    BRA loc_0FBE7E        ; {1031796}
}

code_0FBE76 {
    COP [96]              ; {1031798}
}

code_0FBE78 {
    COP [81] ( #0F, #20 ) ; {1031800}
    COP [83]              ; {1031804}

  loc_0FBE7E:
    COP [86]              ; {1031806}
    RTL                   ; {1031808}
}