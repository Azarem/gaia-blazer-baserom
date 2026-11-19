?BANK 03

?INCLUDE 'w0_shared_01B988'

!rng_state                      0301

---------------------------------------------

code_01B191 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_01B1A3
    DEC 
    BEQ loc_01B1A8
    COP [01] ( &asciistring_01B1AD )
    RTL 

  loc_01B1A3:
    COP [01] ( &asciistring_01B1C7 )
    RTL 

  loc_01B1A8:
    COP [01] ( &asciistring_01B1E6 )
    RTL 
}

asciistring_01B1AD |[10]Please, someone help [N]me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01B1C7 |[10]Please release me, [N]someone help me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01B1E6 |[10]Someone help me! [JMP:&w0_shared_01B988.asciistring_01B988]|