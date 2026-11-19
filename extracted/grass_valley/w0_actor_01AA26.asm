?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01AA26 {
    COP [07] ( #$8905, &code_01AA33 )
    COP [B0] ( @code_01AA4C, #$2000 )
}

code_01AA33 {
    COP [15]
    COP [14] ( #$0009, &code_01AA41 )
    COP [17] ( &code_01AA60 )
    BRA loc_01AA45
}

code_01AA41 {
    COP [17] ( &code_01AA65 )

  loc_01AA45:
    COP [80] ( #1E )
    COP [82]
    BRA loc_01AA45
}

code_01AA4C {
    COP [91]
    COP [0C] ( #00, #02, &code_01AA55 )
    RTL 
}

code_01AA55 {
    COP [01] ( &asciistring_01AAC9 )
    COP [09] ( #$8905 )
    COP [86]
    RTL 
}

code_01AA60 {
    COP [01] ( &asciistring_01AA6A )
    RTL 
}

code_01AA65 {
    COP [01] ( &asciistring_01AAE6 )
    RTL 
}

asciistring_01AA6A |[10][::]There are many [N]creatures being held [N]in the Underground [N]Castle- [FIN]If you can release [N]those creatures, [N]the village will be [N]reconstructed- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01AAC9 |[10][02:2] heard a [N]small voice- [FIN][JMP:&asciistring_01AA6A+M]|

asciistring_01AAE6 |[10]Thank you for saving [N]the villagers- [FIN]They are now taking [N]care of me- [FIN]No creature likes to [N]live alone- We have to[N]help each other- [JMP:&w0_shared_01B988.asciistring_01B988]|