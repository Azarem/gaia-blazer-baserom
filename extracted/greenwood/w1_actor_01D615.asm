?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D615 {
    COP [14] ( #$0064, &code_01D61C ) ; {120341}
    RTL                   ; {120347}
}

code_01D61C {
    COP [85] ( @engine_0026F3.code_00299D ) ; {120348}
    COP [17] ( &code_01D635 ) ; {120353}

  loc_01D625:
    COP [80] ( #1D )      ; {120357}
    COP [82]              ; {120360}
    COP [1B] ( &code_01D630, #$0028 ) ; {120362}
}

code_01D630 {
    COP [87]              ; {120368}
    BRL loc_01D625        ; {120370}
}

code_01D635 {
    COP [01] ( &asciistring_01D63A ) ; {120373}
    RTL                   ; {120377}
}

asciistring_01D63A |[10]I heard of the [N]Phoenix s magic when I[N]visited the Soul of [N]the Mountain- [FIN]If you collect the [N]three symbols, you [N]should visit the [N]Mountain King- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|