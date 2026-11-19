?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019A2C {
    COP [14] ( #$001D, &code_019A33 )
    RTL 
}

code_019A33 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [07] ( #$0102, &code_019A46 )
    COP [11] ( #15, #32, #2A )
    BRL loc_019AD6
}

code_019A46 {
    COP [17] ( &code_019AE4 )
    COP [15]
    COP [91]
    RTL 
}

code_019A4F {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [81] ( #1B, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #03 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #02 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [80] ( #18 )
    COP [82]
    COP [17] ( &code_019AEC )
    COP [15]
    COP [91]
    RTL 
}

code_019A8D {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [81] ( #1A, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #03 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [80] ( #1A )
    COP [82]
    COP [17] ( &code_019AF4 )
    COP [15]
    COP [91]
    RTL 
}

code_019AB5 {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [87]
    COP [9F] ( #$0008 )
    COP [81] ( #1B, #04 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #19, #0A )
    COP [83]
    COP [80] ( #18 )
    COP [82]

  loc_019AD6:
    COP [15]
    COP [17] ( &code_019AFC )
    COP [91]
    COP [80] ( #24 )
    COP [82]
    RTL 
}

code_019AE4 {
    COP [01] ( &asciistring_019B0A )
    COP [27] ( &code_019A4F )
}

code_019AEC {
    COP [01] ( &asciistring_019B52 )
    COP [27] ( &code_019A8D )
}

code_019AF4 {
    COP [01] ( &asciistring_019BF2 )
    COP [27] ( &code_019AB5 )
}

code_019AFC {
    COP [01] ( &asciistring_019C56 )
    COP [09] ( #$8102 )
    RTL 
}

code_019B05 {
    COP [01] ( &asciistring_019CC1 )
    RTL 
}

asciistring_019B0A |[10]You are the one who [N]set me free, right? [FIN]Come, I shall show you[N]around- Please follow [N]me- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019B52 |[10]This is the home of [N]Dr-Leo the inventor [N]and his daughter, [N]Lisa- [FIN]Dr-Leo was a great [N]painter as well as an [N]inventor- [FIN]One day, many soldiers[N]came and took Dr-Leo [N]away- Lisa has not [N]been the same since- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019BF2 |[10]The house at the top [N]of this cliff contains[N]a painting by Dr-Leo-[FIN]I think the title of [N]the painting is [N]something like [N]"The World of Evil-ˮ [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019C56 |[10]This is a house people[N]constructed for the [N]goats- I am not [N]terribly fond of it- [FIN]I did see something on[N]the ground near the [N]corner of the fence- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019CC1 |[10]This is all I will [N]tell you- Please [N]follow me- [JMP:&w0_shared_01B988.asciistring_01B988]|