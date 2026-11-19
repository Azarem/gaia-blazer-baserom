?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_0185B9 {
    COP [14] ( #$0008, &code_0185C0 )
    RTL 
}

code_0185C0 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [91]
    COP [07] ( #$8202, &code_0185D4 )
    COP [17] ( &code_018635 )
    RTL 
}

code_0185D4 {
    COP [17] ( &code_01863E )

  code_0185D8:
    COP [0C] ( #00, #04, &code_01860F )
    COP [07] ( #$8004, &code_0185FD )
    COP [9A] ( #$0000, &code_0185EE, &code_01860F, &code_0185F3 )
}

code_0185EE {
    COP [97]
    BRL loc_0185F5
}

code_0185F3 {
    COP [96]

  loc_0185F5:
    COP [80] ( #02 )
    COP [82]
    BRL loc_018631
}

code_0185FD {
    COP [16]
    COP [9D] ( #04 )
    COP [9E] ( &code_018606 )
}

code_018606 {
    COP [15]
    COP [09] ( #$0004 )
    BRL loc_018631
}

code_01860F {
    COP [07] ( #$8004, &code_01862C )
    COP [16]
    COP [9D] ( #03 )
    COP [9E] ( &code_01861E )
}

code_01861E {
    COP [80] ( #01 )
    COP [82]
    COP [15]
    COP [09] ( #$8004 )
    BRL loc_018631
}

code_01862C {
    COP [80] ( #01 )
    COP [82]

  loc_018631:
    COP [27] ( &code_0185D8 )
}

code_018635 {
    COP [01] ( &asciistring_018643 )
    COP [09] ( #$8202 )
    RTL 
}

code_01863E {
    COP [01] ( &asciistring_018698 )
    RTL 
}

asciistring_018643 |[10]I am the guard of [N]the bridge- [FIN]I guess it is not [N]really necessary to [N]guard such a small [N]bridge, please pass- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018698 |[10]Please pass-[JMP:&w0_shared_01B988.asciistring_01B988]|