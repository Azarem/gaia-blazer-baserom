?BANK 1F

---------------------------------------------

code_0FD11B {
    COP [A3]              ; {1036571}
    COP [1B] ( &code_0FD123, #$0000 ) ; {1036573}
}

code_0FD123 {
    COP [AD] ( #08 )      ; {1036579}
    BRL loc_0FD195        ; {1036582}

  code_0FD129:
    COP [97]              ; {1036585}
    COP [80] ( #29 )      ; {1036587}
    COP [82]              ; {1036590}
    BRA loc_0FD195        ; {1036592}

  code_0FD132:
    COP [96]              ; {1036594}
    COP [80] ( #26 )      ; {1036596}
    COP [82]              ; {1036599}
    BRA loc_0FD1A9        ; {1036601}

  code_0FD13B:
    COP [96]              ; {1036603}
    COP [80] ( #25 )      ; {1036605}
    COP [82]              ; {1036608}
    BRA loc_0FD195        ; {1036610}

  code_0FD144:
    COP [96]              ; {1036612}
    COP [80] ( #2A )      ; {1036614}
    COP [82]              ; {1036617}
    BRA loc_0FD1A9        ; {1036619}

  code_0FD14D:
    COP [96]              ; {1036621}
    COP [80] ( #27 )      ; {1036623}
    COP [82]              ; {1036626}
    BRA loc_0FD1BD        ; {1036628}

  code_0FD156:
    COP [96]              ; {1036630}
    COP [80] ( #24 )      ; {1036632}
    COP [82]              ; {1036635}
    BRA loc_0FD1A9        ; {1036637}

  code_0FD15F:
    COP [97]              ; {1036639}
    COP [80] ( #28 )      ; {1036641}
    COP [82]              ; {1036644}
    BRA loc_0FD1BD        ; {1036646}

  code_0FD168:
    COP [97]              ; {1036648}
    COP [80] ( #24 )      ; {1036650}
    COP [82]              ; {1036653}
    BRA loc_0FD1D1        ; {1036655}

  code_0FD171:
    COP [97]              ; {1036657}
    COP [80] ( #27 )      ; {1036659}
    COP [82]              ; {1036662}
    BRA loc_0FD1BD        ; {1036664}

  code_0FD17A:
    COP [97]              ; {1036666}
    COP [80] ( #2A )      ; {1036668}
    COP [82]              ; {1036671}
    BRA loc_0FD1D1        ; {1036673}

  code_0FD183:
    COP [97]              ; {1036675}
    COP [80] ( #25 )      ; {1036677}
    COP [82]              ; {1036680}
    BRA loc_0FD195        ; {1036682}

  code_0FD18C:
    COP [97]              ; {1036684}
    COP [80] ( #26 )      ; {1036686}
    COP [82]              ; {1036689}
    BRA loc_0FD1D1        ; {1036691}

  loc_0FD195:
    COP [9B] ( #$0000, &code_0FD129, &code_0FD19F, &code_0FD19F ) ; {1036693}
}

code_0FD19F {
    COP [9A] ( #$0000, &code_0FD18C, &code_0FD132, &code_0FD132 ) ; {1036703}

  loc_0FD1A9:
    COP [9A] ( #$0000, &code_0FD1B3, &code_0FD1B3, &code_0FD144 ) ; {1036713}
}

code_0FD1B3 {
    COP [9B] ( #$0000, &code_0FD13B, &code_0FD14D, &code_0FD14D ) ; {1036723}

  loc_0FD1BD:
    COP [9B] ( #$0000, &code_0FD1C7, &code_0FD1C7, &code_0FD15F ) ; {1036733}
}

code_0FD1C7 {
    COP [9A] ( #$0000, &code_0FD168, &code_0FD168, &code_0FD156 ) ; {1036743}

  loc_0FD1D1:
    COP [9A] ( #$0000, &code_0FD17A, &code_0FD1DB, &code_0FD1DB ) ; {1036753}
}

code_0FD1DB {
    COP [9B] ( #$0000, &code_0FD183, &code_0FD183, &code_0FD171 ) ; {1036763}
}