?BANK 03

?INCLUDE 'w0_actor_01A3B0_part2'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A3B0 {
    COP [14] ( #$0022, &code_01A3B7 )
    RTL 
}

code_01A3B7 {
    COP [17] ( &code_01A3D5 )
    COP [15]

  loc_01A3BD:
    COP [80] ( #1E )
    COP [82]
    BRL loc_01A3BD

  code_01A3C5:
    COP [AC] ( @w0_actor_01A3B0_part2.code_01AD42, #$0070, #$0080, #$0050 )
    BRK #$1C
    BRL loc_01A3BD
}

code_01A3D5 {
    COP [01] ( &asciistring_01A3E6 )
    COP [17] ( &code_01A3E1 )
    COP [27] ( &code_01A3C5 )
}

code_01A3E1 {
    COP [01] ( &asciistring_01A420 )
    RTL 
}

asciistring_01A3E6 |[10]In my dreams I can [N]do anything I like-[N]For example---- [FIN]HA! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A420 |[10]Why don t you try and [N]talk to the jewelry? [JMP:&w0_shared_01B988.asciistring_01B988]|