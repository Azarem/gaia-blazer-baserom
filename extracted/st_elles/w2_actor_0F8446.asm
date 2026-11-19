?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8446 {
    COP [14] ( #$0099, &code_0F844D ) ; {1016902}
    RTL                   ; {1016908}
}

code_0F844D {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1016909}
    COP [14] ( #$00C2, &code_0F845B ) ; {1016914}
    BRL loc_0F8474        ; {1016920}
}

code_0F845B {
    COP [14] ( #$00A5, &code_0F8464 ) ; {1016923}
    BRL loc_0F8474        ; {1016929}
}

code_0F8464 {
    COP [14] ( #$008B, &code_0F846D ) ; {1016932}
    BRL loc_0F8474        ; {1016938}
}

code_0F846D {
    COP [17] ( &code_0F8493 ) ; {1016941}
    BRL loc_0F8478        ; {1016945}

  loc_0F8474:
    COP [17] ( &code_0F848E ) ; {1016948}

  loc_0F8478:
    COP [15]              ; {1016952}
    COP [91]              ; {1016954}
    COP [80] ( #06 )      ; {1016956}
    COP [82]              ; {1016959}
    RTL                   ; {1016961}
}

code_0F8482 {
    COP [09] ( #$8003 )   ; {1016962}
    COP [91]              ; {1016966}
    COP [80] ( #06 )      ; {1016968}
    COP [82]              ; {1016971}
    RTL                   ; {1016973}
}

code_0F848E {
    COP [01] ( &asciistring_0F849B ) ; {1016974}
    RTL                   ; {1016978}
}

code_0F8493 {
    COP [01] ( &asciistring_0F84F1 ) ; {1016979}
    COP [27] ( &code_0F8482 ) ; {1016983}
}

asciistring_0F849B |[10]Mermaids have to be [N]very good at dancing- [FIN]If three of my [N]students return, I [N]will show you our [N]great dance- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F84F1 |[10]Thank you very much- [N]Three of my students [N]came back- [FIN]I was going to show [N]you our dance-I think [N]it will be more fun if[N]you join us- [FIN]I will show you the [N]easiest dance, just [N]move like they do- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|