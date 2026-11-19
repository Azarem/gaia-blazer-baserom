?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D98E {
    COP [14] ( #$0062, &code_01D995 )
    RTL 
}

code_01D995 {
    COP [15]
    COP [17] ( &code_01D9BB )
    COP [07] ( #$0307, &code_01D9A5 )
    COP [17] ( &code_01D9C0 )
}

code_01D9A5 {
    COP [07] ( #$0400, &code_01D9AF )
    COP [17] ( &code_01D9D9 )
}

code_01D9AF {
    COP [91]
    COP [18] ( #1F, &code_01D9BA )
    COP [09] ( #$8907 )
}

code_01D9BA {
    RTL 
}

code_01D9BB {
    COP [01] ( &asciistring_01D9DE )
    RTL 
}

code_01D9C0 {
    COP [01] ( &asciistring_01DA4D )
    COP [17] ( &code_01D9D4 )
    COP [14] ( #$005C, &code_01D9CF )
    RTL 
}

code_01D9CF {
    COP [09] ( #$8400 )
    RTL 
}

code_01D9D4 {
    COP [01] ( &asciistring_01DB09 )
    RTL 
}

code_01D9D9 {
    COP [01] ( &asciistring_01DB0D )
    RTL 
}

asciistring_01D9DE |[10]I am always digging in[N]the ground, sometimes [N]I dig up strange [N]things- [FIN]I just dug up some dog[N]bones to #- [FIN]I got scared and re+ [N]buried them- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DA4D |[10]What? Did a female [N]mole come by here? [FIN]No, I am living down [N]here alone- [FIN]Oh, I think I have [N]heard this story----- [FIN]There once was a cute [N]female mole living [N]around here- [FIN]But she was taken away[N]by evil creatures- [FIN][::]I am scared----- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DB09 |[10][JMP:&asciistring_01DA4D+M]|

asciistring_01DB0D |[10]I became so scared I [N]dug a tunnel to the [N]house next door- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|