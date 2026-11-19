?BANK 03

?INCLUDE 'w0_actor_01A3B0_part2'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A3B0 {
    COP [14] ( #$0022, &code_01A3B7 ) ; {107440}
    RTL                   ; {107446}
}

code_01A3B7 {
    COP [17] ( &code_01A3D5 ) ; {107447}
    COP [15]              ; {107451}

  loc_01A3BD:
    COP [80] ( #1E )      ; {107453}
    COP [82]              ; {107456}
    BRL loc_01A3BD        ; {107458}

  code_01A3C5:
    COP [AC] ( @w0_actor_01A3B0_part2.code_01AD42, #$0070, #$0080, #$0050 ) ; {107461}
    BRK #$1C              ; {107472}
    BRL loc_01A3BD        ; {107474}
}

code_01A3D5 {
    COP [01] ( &asciistring_01A3E6 ) ; {107477}
    COP [17] ( &code_01A3E1 ) ; {107481}
    COP [27] ( &code_01A3C5 ) ; {107485}
}

code_01A3E1 {
    COP [01] ( &asciistring_01A420 ) ; {107489}
    RTL                   ; {107493}
}

asciistring_01A3E6 |[10]In my dreams I can [N]do anything I like-[N]For example---- [FIN]HA! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A420 |[10]Why don t you try and [N]talk to the jewelry? [JMP:&w0_shared_01B988.asciistring_01B988]|