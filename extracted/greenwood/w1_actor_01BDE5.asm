?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01BDE5 {
    COP [14] ( #$0037, &code_01BDEC )
    RTL 
}

code_01BDEC {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01BEE5, #$0030, #$0110, #$2040 )
    COP [15]

  loc_01BDFE:
    COP [0C] ( #00, #04, &code_01BE0C )

  code_01BE04:
    COP [80] ( #18 )
    COP [82]
    BRL loc_01BDFE
}

code_01BE0C {
    COP [9B] ( #$0010, &code_01BE04, &code_01BE16, &code_01BE16 )
}

code_01BE16 {
    COP [17] ( #$0000 )
    COP [16]
    COP [A3]
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #05 )
    COP [83]
    COP [80] ( #20 )
    COP [82]
    COP [87]
    COP [A6]
    COP [15]
    COP [17] ( &code_01BE3B )
    BRL loc_01BDFE
}

code_01BE3B {
    COP [18] ( #18, &code_01BE42 )
    BRA loc_01BE47
}

code_01BE42 {
    COP [18] ( #32, &code_01BE4C )

  loc_01BE47:
    COP [01] ( &asciistring_01BED2 )
    RTL 
}

code_01BE4C {
    COP [01] ( &asciistring_01BE56 )
    BRK #$5E
    COP [0A] ( #32 )
    RTL 
}

asciistring_01BE56 |[10]AHHHH! [N]You scared me! Please [N]don t sneak up behind [N]me- [FIN]Well, I guess it s [N]okay- I have something[N]special for you- [FIN][02:2] received [N][03:24]the Red+Hot Mirror- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01BED2 |[10]AHHHH! [N]You scared me! [N][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01BEE5 {
    COP [17] ( &code_01BEF1 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01BEF1 {
    COP [01] ( &asciistring_01BEF6 )
    RTL 
}

asciistring_01BEF6 |[10][0A]For█shy█birds,[N]you█better█approach[N]quietly█from█behind-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|