?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A7AC {
    COP [14] ( #$0000, &code_01A7B3 )
    RTL 
}

code_01A7B3 {
    COP [9F] ( #$0008 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01A7DC )
    COP [15]
    COP [2A] ( #$0010, #$0000 )
    COP [05] ( #$0504 )
    COP [16]
    COP [2B] ( #$0010, #$0000 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [86]
    RTL 
}

code_01A7DC {
    COP [01] ( &asciistring_01A7F9 )
    BRK #$5E
    COP [0A] ( #11 )
    COP [01] ( &asciistring_01A913 )
    SEP #$20
    LDA #$01
    STA $1B82
    REP #$20
    COP [09] ( #$8504 )
    BRK #$0E
    RTL 
}

asciistring_01A7F9 |[10]I used to live up [N]in the sky just like [N]you- [FIN]Now, I am living on [N]Earth, away from the [N]Master- [FIN]All the creatures that[N]have been captured by [N]Deathtoll are sealed [N]away in monster lairs-[FIN]Just as you have set [N]me free, you must free[N]everyone- [FIN]Even the release of a [N]small tree or [N]creature, they will [N]aid you in your quest-[FIN]Here, take this- [FIN][02:2] received [N][03:24]the Flame Ball Magic- [03:20][FIN][END]|

asciistring_01A913 |[10]Now I will join you- I[N]am a magician so I can[N]use all types magic- [FIN]I will use my skill to[N]help you- [FIN]Remember this, I need [N]GEMs in order to use [N]magic- [FIN]When you set me free, [N]the monsters left some[N]small spheres of gold-[FIN]This is what a GEM [N]looks like- Alright, [N]let s work together to[N]revive the world! [FIN]We must go to the [N]Grass Valley Shrine- [JMP:&w0_shared_01B988.asciistring_01B988]|