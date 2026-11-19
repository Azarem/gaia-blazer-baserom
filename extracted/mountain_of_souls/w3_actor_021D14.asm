?BANK 04

?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_021D14 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #02 )
    COP [04]
    COP [34]
    COP [03] ( #3D )
    COP [04]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [01] ( &asciistring_021D48 )
    COP [09] ( #$8707 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$010A, #00, #$0330, #$0370 )
    RTL 
}

asciistring_021D48 |[10]I will not leave you [N]and go off to other [N]places I promise- [FIN]As proof of my [N]promise, I buried my [N]belongings in the [N]Aurora Ridge- [FIN]The Magic Armor, [N]50 GEMs, and [N]one Medical Herb- [FIN]I hope someone will [N]find them- [JMP:&w3_shared_02249A.asciistring_02251E]|