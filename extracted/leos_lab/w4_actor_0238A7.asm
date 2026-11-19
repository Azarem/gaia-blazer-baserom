?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0238A7 {
    COP [14] ( #$013C, &code_0238AE )
    RTL 
}

code_0238AE {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0238D3 )
    COP [15]

  loc_0238B9:
    COP [0C] ( #00, #04, &code_0238C6 )
    COP [80] ( #0C )
    COP [82]
    BRA loc_0238B9
}

code_0238C6 {
    COP [80] ( #1E )
    COP [82]
    COP [0C] ( #00, #04, &code_0238C6 )
    BRA loc_0238B9
}

code_0238D3 {
    COP [07] ( #$0605, &code_0238DF )
    COP [07] ( #$8606, &code_0238E4 )
}

code_0238DF {
    COP [01] ( &asciistring_0238F8 )
    RTL 
}

code_0238E4 {
    COP [18] ( #15, &code_0238EE )
    COP [01] ( &asciistring_023976 )
    RTL 
}

code_0238EE {
    COP [01] ( &asciistring_023921 )
    BRK #$5E
    COP [0A] ( #15 )
    RTL 
}

asciistring_0238F8 |[10]We cannot walk [N]around outside because[N]of the cats- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023921 |[10]Thank you for getting [N]rid of the cats- [FIN]Take this magic, the [N]Magic of Spark Bomb- [FIN][02:2] received [N][03:24]Spark Bomb- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023976 |[10]It is not easy to hit [N]the enemies with Spark[N]Bomb, but if you do, [N]it works very well- [JMP:&w4_shared_023F33.asciistring_023FA3]|