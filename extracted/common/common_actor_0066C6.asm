?BANK 00

?INCLUDE 'common_shared_0FEEA6'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_014176'
?INCLUDE 'lib_02719F'
?INCLUDE 'lib_shared_012769'

!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_0066C6 {
    LDA #$3080
    TSB $joy_block_mask
    STX $player_actor
    PHX 
    LDY #$&lib_014176.asciistring_014176
    JSL $@lib_shared_012769.code_012769
    PLX 
    COP [1B] ( &code_0066DE, #$0001 )
}

code_0066DE {
    SEP #$20
    PHX 
    JSL $@common_shared_0FEEA6.code_0FEFBC
    JSL $@lib_0118FC_part5.code_012463
    JSL $@lib_02719F.code_02719F
    PLX 
    REP #$20
    COP [10] ( #$0A00, #01, #$0000, #$0000 )
    COP [91]
    RTL 
}