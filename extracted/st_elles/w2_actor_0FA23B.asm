?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA23B {
    COP [17] ( &code_0FA252 ) ; {1024571}
    COP [15]              ; {1024575}
    COP [91]              ; {1024577}
    COP [0D] ( #00, #04, #29, &code_0FA24B ) ; {1024579}
    RTL                   ; {1024586}
}

code_0FA24B {
    COP [01] ( &asciistring_0FA25B ) ; {1024587}
    COP [91]              ; {1024591}
    RTL                   ; {1024593}
}

code_0FA252 {
    COP [01] ( &asciistring_0FA369 ) ; {1024594}
    COP [09] ( #$8000 )   ; {1024598}
    RTL                   ; {1024602}
}

asciistring_0FA25B |[10][0F]You can hear the [N]conversation of [FIN]a father and son- [FIN][10]Daddy, how many days [N]have passed since the [N]ship sank? [FIN]I am too hungry and [N]cannot travel any [N]farther- [FIN]Are we going to die? [FIN]Servas, my son, some [N]people believe that [N]human life does not [N]end at death- [FIN]They believe that they[N]will be born into a [N]new life- Lives, they [N]feel, are everlasting-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA369 |[10]Oh, I hear some [N]voices----- maybe the [N]Master is calling me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|