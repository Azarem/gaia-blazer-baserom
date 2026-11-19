?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D615 {
    COP [14] ( #$0064, &code_01D61C )
    RTL 
}

code_01D61C {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01D635 )

  loc_01D625:
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01D630, #$0028 )
}

code_01D630 {
    COP [87]
    BRL loc_01D625
}

code_01D635 {
    COP [01] ( &asciistring_01D63A )
    RTL 
}

asciistring_01D63A |[10]I heard of the [N]Phoenix s magic when I[N]visited the Soul of [N]the Mountain- [FIN]If you collect the [N]three symbols, you [N]should visit the [N]Mountain King- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|