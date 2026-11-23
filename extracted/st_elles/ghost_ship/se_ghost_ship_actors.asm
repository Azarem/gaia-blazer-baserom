?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA23B {
    COP [17] ( &code_0FA252 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #04, #29, &code_0FA24B )
    RTL 
}

code_0FA24B {
    COP [01] ( &asciistring_0FA25B )
    COP [91]
    RTL 
}

code_0FA252 {
    COP [01] ( &asciistring_0FA369 )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_0FA25B |[10][0F]You can hear the [N]conversation of [FIN]a father and son- [FIN][10]Daddy, how many days [N]have passed since the [N]ship sank? [FIN]I am too hungry and [N]cannot travel any [N]farther- [FIN]Are we going to die? [FIN]Servas, my son, some [N]people believe that [N]human life does not [N]end at death- [FIN]They believe that they[N]will be born into a [N]new life- Lives, they [N]feel, are everlasting-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA369 |[10]Oh, I hear some [N]voices----- maybe the [N]Master is calling me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

code_0FA3A5 {
    COP [17] ( &code_0FA3AE )
    COP [15]
    COP [91]
    RTL 
}

code_0FA3AE {
    COP [07] ( #$0000, &code_0FA3C9 )
    COP [01] ( &asciistring_0FA3DB )
    COP [3C] ( #04 )
    COP [10] ( #$0106, #03, #$00C0, #$0040 )
    COP [09] ( #$8704 )
    RTL 
}

code_0FA3C9 {
    COP [01] ( &asciistring_0FA3CE )
    RTL 
}

asciistring_0FA3CE |[10]-------- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA3DB |[10]Someone is calling me-[N]What is that? [FIN]I just put one GEM in [N]a treasure chest- [FIN]I hope someone will [N]find it- [FIN]-------- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|