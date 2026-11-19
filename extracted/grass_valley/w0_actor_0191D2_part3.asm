?BANK 03

?INCLUDE 'w0_shared_01B988'

!rng_state                      0301

---------------------------------------------

code_01B191 {
    COP [1F]              ; {110993}
    LDA $rng_state+1      ; {110995}
    AND #$0003            ; {110998}
    BEQ loc_01B1A3        ; {111001}
    DEC                   ; {111003}
    BEQ loc_01B1A8        ; {111004}
    COP [01] ( &asciistring_01B1AD ) ; {111006}
    RTL                   ; {111010}

  loc_01B1A3:
    COP [01] ( &asciistring_01B1C7 ) ; {111011}
    RTL                   ; {111015}

  loc_01B1A8:
    COP [01] ( &asciistring_01B1E6 ) ; {111016}
    RTL                   ; {111020}
}

asciistring_01B1AD |[10]Please, someone help [N]me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01B1C7 |[10]Please release me, [N]someone help me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01B1E6 |[10]Someone help me! [JMP:&w0_shared_01B988.asciistring_01B988]|