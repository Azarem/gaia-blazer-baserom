?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024D59 {
    COP [14] ( #$0172, &code_024D60 )
    RTL 
}

code_024D60 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_024D6E )
    COP [15]
    COP [91]
    RTL 
}

code_024D6E {
    COP [01] ( &asciistring_024D73 )
    RTL 
}

asciistring_024D73 |[10]I have a friend who [N]once disobeyed King [N]Magridd- He wanted to [N]save Dr-Leo- [FIN]He was taken to the [N]torture room in the [N]first basement and [N]never came back- [FIN]"This harp string is a[N]birthday present from [N]my friend- [FIN]I am able to play [N]great music with this [N]string-ˮ [FIN]He always told me I [N]could- [JMP:&w5_shared_02706C.asciistring_0270DF]|