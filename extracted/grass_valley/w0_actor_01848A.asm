?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01848A {
    COP [14] ( #$0007, &code_018491 ) ; {99466}
    RTL                   ; {99472}
}

code_018491 {
    COP [30] ( #$0007, &code_0184B9, #03 ) ; {99473}
    COP [85] ( @engine_0026F3.code_00299D ) ; {99480}
    COP [17] ( &code_0184AA ) ; {99485}
    COP [15]              ; {99489}

  loc_0184A3:
    COP [80] ( #1E )      ; {99491}
    COP [82]              ; {99494}
    BRA loc_0184A3        ; {99496}
}

code_0184AA {
    COP [14] ( #$0009, &code_0184B5 ) ; {99498}
    COP [01] ( &asciistring_0184BE ) ; {99504}
    RTL                   ; {99508}
}

code_0184B5 {
    COP [01] ( &asciistring_018552 ) ; {99509}
}

code_0184B9 {
    COP [01] ( &asciistring_01852E ) ; {99513}
    RTL                   ; {99517}
}

asciistring_0184BE |[10][::]There once was [N]a water mill here [N]before the village was[N]destroyed- [FIN]I hear there is a man [N]in the mill who runs [N]the elevator in the [N]Underground Castle- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01852E |[10][0E:3C][02:2] began [N]to hear a small voice-[FIN][JMP:&asciistring_0184BE+M]|

asciistring_018552 |[10]The village Chief [N]speaks with me every [N]morning- [FIN]Even though I cannot [N]speak, I communicate [N]with him through our [N]thoughts- [JMP:&w0_shared_01B988.asciistring_01B988]|