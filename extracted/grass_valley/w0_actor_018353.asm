?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_018353 {
    COP [14] ( #$0006, &code_01835A ) ; {99155}
    RTL                   ; {99161}
}

code_01835A {
    COP [17] ( &code_018399 ) ; {99162}

  code_01835E:
    COP [91]              ; {99166}
    COP [20] ( &code_018395 ) ; {99168}
    COP [9A] ( #$0000, &code_01836E, &code_018395, &code_018383 ) ; {99172}
}

code_01836E {
    COP [23] ( &code_01837B ) ; {99182}
    COP [97]              ; {99186}
    COP [9D] ( #0B )      ; {99188}
    COP [9E] ( &code_01837B ) ; {99191}
}

code_01837B {
    COP [80] ( #06 )      ; {99195}
    COP [82]              ; {99198}
    BRL code_018395       ; {99200}
}

code_018383 {
    COP [24] ( &code_018390 ) ; {99203}
    COP [96]              ; {99207}
    COP [9D] ( #0B )      ; {99209}
    COP [9E] ( &code_018390 ) ; {99212}
}

code_018390 {
    COP [80] ( #06 )      ; {99216}
    COP [82]              ; {99219}
}

code_018395 {
    COP [27] ( &code_01835E ) ; {99221}
}

code_018399 {
    COP [18] ( #38, &code_0183A3 ) ; {99225}
    COP [01] ( &asciistring_018428 ) ; {99230}
    RTL                   ; {99234}
}

code_0183A3 {
    COP [01] ( &asciistring_0183AD ) ; {99235}
    BRK #$5E              ; {99239}
    COP [0A] ( #38 )      ; {99241}
    RTL                   ; {99244}
}

asciistring_0183AD |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [N]Take whatever you need[N]from my store- [FIN]I only have Medical [N]Herbs though- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018428 |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [FIN]Whenever you use your [N]Medical Herb please [N]come back, and I will [N]give you another- [JMP:&w0_shared_01B988.asciistring_01B988]|