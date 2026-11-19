?BANK 00

---------------------------------------------

code_005354 {
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    LDA #$2010
    STA $0016, X
    INC $0466
    COP [37]
    COP [31] ( #00 )
    COP [03] ( #F1 )
    COP [04]
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0053C6 )
    LDA $1B82
    AND #$001F
    DEC 
    BEQ loc_00538C
    COP [01] ( &asciistring_00543B )
    BRA loc_005390

  loc_00538C:
    COP [01] ( &asciistring_00540B )

  loc_005390:
    SEP #$20
    STZ $1B82
    REP #$20
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_005593 )
    COP [85] ( @code_0055B9 )
    COP [03] ( #F1 )
    COP [04]
    COP [09] ( #$9F02 )
    LDA #$0006
    STA $1B84
    LDA #$0001
    STA $031E
    COP [10] ( #$0700, #01, #$0070, #$0060 )
    COP [91]
    RTL 
}

asciistring_0053C6 |[10]Finally, [02:2] [N]defeated Deathtoll! [FIN]Suddenly [02:2][N]heard a small voice- [FIN][END]|

asciistring_00540B |[10][02:2],I decided to [N]stay here and seal the[N]World of Evil- [FIN][JMP:&asciistring_00543B+M]|

asciistring_00543B |[10][02:2], we decided [N]to stay here and seal [N]the World of Evil-----[FIN][::]The World of Evil is [N]a dark world that [N]exists in the back of [N]creatures  minds- [FIN]As long as there are [N]inventions in this [N]world the same thing [N]will happen- [FIN]I will stay and try to[N]stop as much as [N]possible- [FIN]You are still young, [N]you should experience [N]more- [FIN]And if you figure out [N]reasons for, [N]all feelings, [FIN]all connections [FIN]and existences, [N]you will be wise like [N]the Master- [FIN][02:2], get going- [12][08:408][END]|

asciistring_005593 |[10]The World of Evil [N]began to disappear- [12][08:408][END]|

code_0055B9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4D )
    COP [94]
    COP [86]
    RTL 
}