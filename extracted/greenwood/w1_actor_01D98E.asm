?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D98E {
    COP [14] ( #$0062, &code_01D995 ) ; {121230}
    RTL                   ; {121236}
}

code_01D995 {
    COP [15]              ; {121237}
    COP [17] ( &code_01D9BB ) ; {121239}
    COP [07] ( #$0307, &code_01D9A5 ) ; {121243}
    COP [17] ( &code_01D9C0 ) ; {121249}
}

code_01D9A5 {
    COP [07] ( #$0400, &code_01D9AF ) ; {121253}
    COP [17] ( &code_01D9D9 ) ; {121259}
}

code_01D9AF {
    COP [91]              ; {121263}
    COP [18] ( #1F, &code_01D9BA ) ; {121265}
    COP [09] ( #$8907 )   ; {121270}
}

code_01D9BA {
    RTL                   ; {121274}
}

code_01D9BB {
    COP [01] ( &asciistring_01D9DE ) ; {121275}
    RTL                   ; {121279}
}

code_01D9C0 {
    COP [01] ( &asciistring_01DA4D ) ; {121280}
    COP [17] ( &code_01D9D4 ) ; {121284}
    COP [14] ( #$005C, &code_01D9CF ) ; {121288}
    RTL                   ; {121294}
}

code_01D9CF {
    COP [09] ( #$8400 )   ; {121295}
    RTL                   ; {121299}
}

code_01D9D4 {
    COP [01] ( &asciistring_01DB09 ) ; {121300}
    RTL                   ; {121304}
}

code_01D9D9 {
    COP [01] ( &asciistring_01DB0D ) ; {121305}
    RTL                   ; {121309}
}

asciistring_01D9DE |[10]I am always digging in[N]the ground, sometimes [N]I dig up strange [N]things- [FIN]I just dug up some dog[N]bones to #- [FIN]I got scared and re+ [N]buried them- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DA4D |[10]What? Did a female [N]mole come by here? [FIN]No, I am living down [N]here alone- [FIN]Oh, I think I have [N]heard this story----- [FIN]There once was a cute [N]female mole living [N]around here- [FIN]But she was taken away[N]by evil creatures- [FIN][::]I am scared----- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01DB09 |[10][JMP:&asciistring_01DA4D+M]|

asciistring_01DB0D |[10]I became so scared I [N]dug a tunnel to the [N]house next door- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|