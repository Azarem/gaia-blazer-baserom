?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_018353 {
    COP [14] ( #$0006, &code_01835A )
    RTL 
}

code_01835A {
    COP [17] ( &code_018399 )

  code_01835E:
    COP [91]
    COP [20] ( &code_018395 )
    COP [9A] ( #$0000, &code_01836E, &code_018395, &code_018383 )
}

code_01836E {
    COP [23] ( &code_01837B )
    COP [97]
    COP [9D] ( #0B )
    COP [9E] ( &code_01837B )
}

code_01837B {
    COP [80] ( #06 )
    COP [82]
    BRL code_018395
}

code_018383 {
    COP [24] ( &code_018390 )
    COP [96]
    COP [9D] ( #0B )
    COP [9E] ( &code_018390 )
}

code_018390 {
    COP [80] ( #06 )
    COP [82]
}

code_018395 {
    COP [27] ( &code_01835E )
}

code_018399 {
    COP [18] ( #38, &code_0183A3 )
    COP [01] ( &asciistring_018428 )
    RTL 
}

code_0183A3 {
    COP [01] ( &asciistring_0183AD )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

asciistring_0183AD |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [N]Take whatever you need[N]from my store- [FIN]I only have Medical [N]Herbs though- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018428 |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [FIN]Whenever you use your [N]Medical Herb please [N]come back, and I will [N]give you another- [JMP:&w0_shared_01B988.asciistring_01B988]|