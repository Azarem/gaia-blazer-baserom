?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D857 {
    COP [14] ( #$0049, &code_01D85E )
    RTL 
}

code_01D85E {
    COP [30] ( #$0049, &code_01D868, #03 )
    COP [91]
    RTL 
}

code_01D868 {
    COP [01] ( &asciistring_01D86F )
    COP [86]
    RTL 
}

asciistring_01D86F |[10][0E:3C]A voice is calling [N][02:2] from [N]the hole- [FIN]I am the creature who [N]brings light to [N]darkness- I will help [N]you upon your return- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|