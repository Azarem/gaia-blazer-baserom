?BANK 00

---------------------------------------------

code_005354 {
    SEP #$20              ; {21332}
    LDA #$00              ; {21334}
    STA $0036, X          ; {21336}
    REP #$20              ; {21339}
    LDA #$2010            ; {21341}
    STA $0016, X          ; {21344}
    INC $0466             ; {21347}
    COP [37]              ; {21350}
    COP [31] ( #00 )      ; {21352}
    COP [03] ( #F1 )      ; {21355}
    COP [04]              ; {21358}
    LDA $0016, X          ; {21360}
    AND #$FFEF            ; {21363}
    STA $0016, X          ; {21366}
    COP [01] ( &asciistring_0053C6 ) ; {21369}
    LDA $1B82             ; {21373}
    AND #$001F            ; {21376}
    DEC                   ; {21379}
    BEQ loc_00538C        ; {21380}
    COP [01] ( &asciistring_00543B ) ; {21382}
    BRA loc_005390        ; {21386}

  loc_00538C:
    COP [01] ( &asciistring_00540B ) ; {21388}

  loc_005390:
    SEP #$20              ; {21392}
    STZ $1B82             ; {21394}
    REP #$20              ; {21397}
    COP [03] ( #3D )      ; {21399}
    COP [04]              ; {21402}
    COP [01] ( &asciistring_005593 ) ; {21404}
    COP [85] ( @code_0055B9 ) ; {21408}
    COP [03] ( #F1 )      ; {21413}
    COP [04]              ; {21416}
    COP [09] ( #$9F02 )   ; {21418}
    LDA #$0006            ; {21422}
    STA $1B84             ; {21425}
    LDA #$0001            ; {21428}
    STA $031E             ; {21431}
    COP [10] ( #$0700, #01, #$0070, #$0060 ) ; {21434}
    COP [91]              ; {21443}
    RTL                   ; {21445}
}

asciistring_0053C6 |[10]Finally, [02:2] [N]defeated Deathtoll! [FIN]Suddenly [02:2][N]heard a small voice- [FIN][END]|

asciistring_00540B |[10][02:2],I decided to [N]stay here and seal the[N]World of Evil- [FIN][JMP:&asciistring_00543B+M]|

asciistring_00543B |[10][02:2], we decided [N]to stay here and seal [N]the World of Evil-----[FIN][::]The World of Evil is [N]a dark world that [N]exists in the back of [N]creatures  minds- [FIN]As long as there are [N]inventions in this [N]world the same thing [N]will happen- [FIN]I will stay and try to[N]stop as much as [N]possible- [FIN]You are still young, [N]you should experience [N]more- [FIN]And if you figure out [N]reasons for, [N]all feelings, [FIN]all connections [FIN]and existences, [N]you will be wise like [N]the Master- [FIN][02:2], get going- [12][08:408][END]|

asciistring_005593 |[10]The World of Evil [N]began to disappear- [12][08:408][END]|

code_0055B9 {
    COP [A8] ( #$8000, #0D ) ; {21945}
    COP [92] ( #4D )      ; {21950}
    COP [94]              ; {21953}
    COP [86]              ; {21955}
    RTL                   ; {21957}
}