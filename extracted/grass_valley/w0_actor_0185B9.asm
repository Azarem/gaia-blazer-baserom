?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_0185B9 {
    COP [14] ( #$0008, &code_0185C0 ) ; {99769}
    RTL                   ; {99775}
}

code_0185C0 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {99776}
    COP [15]              ; {99781}
    COP [91]              ; {99783}
    COP [07] ( #$8202, &code_0185D4 ) ; {99785}
    COP [17] ( &code_018635 ) ; {99791}
    RTL                   ; {99795}
}

code_0185D4 {
    COP [17] ( &code_01863E ) ; {99796}

  code_0185D8:
    COP [0C] ( #00, #04, &code_01860F ) ; {99800}
    COP [07] ( #$8004, &code_0185FD ) ; {99806}
    COP [9A] ( #$0000, &code_0185EE, &code_01860F, &code_0185F3 ) ; {99812}
}

code_0185EE {
    COP [97]              ; {99822}
    BRL loc_0185F5        ; {99824}
}

code_0185F3 {
    COP [96]              ; {99827}

  loc_0185F5:
    COP [80] ( #02 )      ; {99829}
    COP [82]              ; {99832}
    BRL loc_018631        ; {99834}
}

code_0185FD {
    COP [16]              ; {99837}
    COP [9D] ( #04 )      ; {99839}
    COP [9E] ( &code_018606 ) ; {99842}
}

code_018606 {
    COP [15]              ; {99846}
    COP [09] ( #$0004 )   ; {99848}
    BRL loc_018631        ; {99852}
}

code_01860F {
    COP [07] ( #$8004, &code_01862C ) ; {99855}
    COP [16]              ; {99861}
    COP [9D] ( #03 )      ; {99863}
    COP [9E] ( &code_01861E ) ; {99866}
}

code_01861E {
    COP [80] ( #01 )      ; {99870}
    COP [82]              ; {99873}
    COP [15]              ; {99875}
    COP [09] ( #$8004 )   ; {99877}
    BRL loc_018631        ; {99881}
}

code_01862C {
    COP [80] ( #01 )      ; {99884}
    COP [82]              ; {99887}

  loc_018631:
    COP [27] ( &code_0185D8 ) ; {99889}
}

code_018635 {
    COP [01] ( &asciistring_018643 ) ; {99893}
    COP [09] ( #$8202 )   ; {99897}
    RTL                   ; {99901}
}

code_01863E {
    COP [01] ( &asciistring_018698 ) ; {99902}
    RTL                   ; {99906}
}

asciistring_018643 |[10]I am the guard of [N]the bridge- [FIN]I guess it is not [N]really necessary to [N]guard such a small [N]bridge, please pass- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018698 |[10]Please pass-[JMP:&w0_shared_01B988.asciistring_01B988]|