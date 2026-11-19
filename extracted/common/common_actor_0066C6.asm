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
    LDA #$3080            ; {26310}
    TSB $joy_block_mask   ; {26313}
    STX $player_actor     ; {26316}
    PHX                   ; {26319}
    LDY #$&lib_014176.asciistring_014176 ; {26320}
    JSL $@lib_shared_012769.code_012769 ; {26323}
    PLX                   ; {26327}
    COP [1B] ( &code_0066DE, #$0001 ) ; {26328}
}

code_0066DE {
    SEP #$20              ; {26334}
    PHX                   ; {26336}
    JSL $@common_shared_0FEEA6.code_0FEFBC ; {26337}
    JSL $@lib_0118FC_part5.code_012463 ; {26341}
    JSL $@lib_02719F.code_02719F ; {26345}
    PLX                   ; {26349}
    REP #$20              ; {26350}
    COP [10] ( #$0A00, #01, #$0000, #$0000 ) ; {26352}
    COP [91]              ; {26361}
    RTL                   ; {26363}
}