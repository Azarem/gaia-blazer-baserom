?BANK 03

?INCLUDE 'lib_014F5B'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0

---------------------------------------------

code_01E4E9 {
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBEA )
    COP [1A] ( &lib_014F5B.asciistring_014F5B, #02, &code_01E50B )
    LDA $L_choice_result
    BEQ code_01E50B
    COP [01] ( &w1_shared_01EBC2.asciistring_01EC09 )
    INC $042D
    COP [10] ( #$0104, #02, #$02E0, #$01A0 )
    RTL 
}

code_01E50B {
    COP [01] ( &w1_shared_01EBC2.asciistring_01EC1B )
    RTL 
}