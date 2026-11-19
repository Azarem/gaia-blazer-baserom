?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01BDE5 {
    COP [14] ( #$0037, &code_01BDEC ) ; {114149}
    RTL                   ; {114155}
}

code_01BDEC {
    COP [85] ( @engine_0026F3.code_00299D ) ; {114156}
    COP [AC] ( @code_01BEE5, #$0030, #$0110, #$2040 ) ; {114161}
    COP [15]              ; {114172}

  loc_01BDFE:
    COP [0C] ( #00, #04, &code_01BE0C ) ; {114174}

  code_01BE04:
    COP [80] ( #18 )      ; {114180}
    COP [82]              ; {114183}
    BRL loc_01BDFE        ; {114185}
}

code_01BE0C {
    COP [9B] ( #$0010, &code_01BE04, &code_01BE16, &code_01BE16 ) ; {114188}
}

code_01BE16 {
    COP [17] ( #$0000 )   ; {114198}
    COP [16]              ; {114202}
    COP [A3]              ; {114204}
    COP [80] ( #1E )      ; {114206}
    COP [82]              ; {114209}
    COP [81] ( #1F, #05 ) ; {114211}
    COP [83]              ; {114215}
    COP [80] ( #20 )      ; {114217}
    COP [82]              ; {114220}
    COP [87]              ; {114222}
    COP [A6]              ; {114224}
    COP [15]              ; {114226}
    COP [17] ( &code_01BE3B ) ; {114228}
    BRL loc_01BDFE        ; {114232}
}

code_01BE3B {
    COP [18] ( #18, &code_01BE42 ) ; {114235}
    BRA loc_01BE47        ; {114240}
}

code_01BE42 {
    COP [18] ( #32, &code_01BE4C ) ; {114242}

  loc_01BE47:
    COP [01] ( &asciistring_01BED2 ) ; {114247}
    RTL                   ; {114251}
}

code_01BE4C {
    COP [01] ( &asciistring_01BE56 ) ; {114252}
    BRK #$5E              ; {114256}
    COP [0A] ( #32 )      ; {114258}
    RTL                   ; {114261}
}

asciistring_01BE56 |[10]AHHHH! [N]You scared me! Please [N]don t sneak up behind [N]me- [FIN]Well, I guess it s [N]okay- I have something[N]special for you- [FIN][02:2] received [N][03:24]the Red+Hot Mirror- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01BED2 |[10]AHHHH! [N]You scared me! [N][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01BEE5 {
    COP [17] ( &code_01BEF1 ) ; {114405}
    COP [91]              ; {114409}
    COP [80] ( #23 )      ; {114411}
    COP [82]              ; {114414}
    RTL                   ; {114416}
}

code_01BEF1 {
    COP [01] ( &asciistring_01BEF6 ) ; {114417}
    RTL                   ; {114421}
}

asciistring_01BEF6 |[10][0A]For█shy█birds,[N]you█better█approach[N]quietly█from█behind-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|