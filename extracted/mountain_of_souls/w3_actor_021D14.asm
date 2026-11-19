?BANK 04

?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_021D14 {
    LDA #$2F80            ; {138516}
    TSB $joy_block_mask   ; {138519}
    COP [03] ( #02 )      ; {138522}
    COP [04]              ; {138525}
    COP [34]              ; {138527}
    COP [03] ( #3D )      ; {138529}
    COP [04]              ; {138532}
    COP [96]              ; {138534}
    COP [80] ( #02 )      ; {138536}
    COP [82]              ; {138539}
    COP [01] ( &asciistring_021D48 ) ; {138541}
    COP [09] ( #$8707 )   ; {138545}
    LDA #$2F80            ; {138549}
    TRB $joy_block_mask   ; {138552}
    COP [3C] ( #04 )      ; {138555}
    COP [10] ( #$010A, #00, #$0330, #$0370 ) ; {138558}
    RTL                   ; {138567}
}

asciistring_021D48 |[10]I will not leave you [N]and go off to other [N]places I promise- [FIN]As proof of my [N]promise, I buried my [N]belongings in the [N]Aurora Ridge- [FIN]The Magic Armor, [N]50 GEMs, and [N]one Medical Herb- [FIN]I hope someone will [N]find them- [JMP:&w3_shared_02249A.asciistring_02251E]|