?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8446 {
    COP [14] ( #$0099, &code_0F844D )
    RTL 
}

code_0F844D {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [14] ( #$00C2, &code_0F845B )
    BRL loc_0F8474
}

code_0F845B {
    COP [14] ( #$00A5, &code_0F8464 )
    BRL loc_0F8474
}

code_0F8464 {
    COP [14] ( #$008B, &code_0F846D )
    BRL loc_0F8474
}

code_0F846D {
    COP [17] ( &code_0F8493 )
    BRL loc_0F8478

  loc_0F8474:
    COP [17] ( &code_0F848E )

  loc_0F8478:
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F8482 {
    COP [09] ( #$8003 )
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F848E {
    COP [01] ( &asciistring_0F849B )
    RTL 
}

code_0F8493 {
    COP [01] ( &asciistring_0F84F1 )
    COP [27] ( &code_0F8482 )
}

asciistring_0F849B |[10]Mermaids have to be [N]very good at dancing- [FIN]If three of my [N]students return, I [N]will show you our [N]great dance- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F84F1 |[10]Thank you very much- [N]Three of my students [N]came back- [FIN]I was going to show [N]you our dance-I think [N]it will be more fun if[N]you join us- [FIN]I will show you the [N]easiest dance, just [N]move like they do- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|