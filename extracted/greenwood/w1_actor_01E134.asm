?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E134 {
    COP [14] ( #$0043, &code_01E13B )
    RTL 
}

code_01E13B {
    COP [30] ( #$0043, &code_01E145, #03 )
    COP [91]
    RTL 
}

code_01E145 {
    COP [01] ( &asciistring_01E14C )
    COP [86]
    RTL 
}

asciistring_01E14C |[10][0E:3C]A small voice is [N]coming from a hole- [FIN]Oh, I am starving----[FIN]If someone can bring [N]me something to eat [FIN]I will exchange this [N]powerful sword with [N]them----- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|