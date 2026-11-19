?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F8E99 {
    COP [14] ( #$00AB, &code_0F8EA0 ) ; {1019545}
    RTL                   ; {1019551}
}

code_0F8EA0 {
    COP [30] ( #$00AB, &code_0F8EE9, #1F ) ; {1019552}
    COP [17] ( &code_0F8EC5 ) ; {1019559}
    COP [91]              ; {1019563}
    COP [0D] ( #00, #1C, #22, &code_0F8EB5 ) ; {1019565}
    RTL                   ; {1019572}
}

code_0F8EB5 {
    COP [11] ( #00, #1C, #24 ) ; {1019573}
    COP [33]              ; {1019578}
    LDA #$AFC0            ; {1019580}
    TRB $joy_block_mask   ; {1019583}
    COP [91]              ; {1019586}
    RTL                   ; {1019588}
}

code_0F8EC5 {
    COP [01] ( &asciistring_0F8EF0 ) ; {1019589}
    COP [07] ( #$8500, &code_0F8EE8 ) ; {1019593}
    LDA #$EF80            ; {1019599}
    TSB $joy_block_mask   ; {1019602}
    LDA #$0020            ; {1019605}
    STA $03B4             ; {1019608}
    COP [09] ( #$8903 )   ; {1019611}
    COP [10] ( #$0107, #02, #$0240, #$02B0 ) ; {1019615}
}

code_0F8EE8 {
    RTL                   ; {1019624}
}

code_0F8EE9 {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 ) ; {1019625}
    COP [86]              ; {1019629}
    RTL                   ; {1019631}
}

asciistring_0F8EF0 |[10]I will open the [N]passage for you- [FIN]Walk downward under [N]the sea and go to the [N]volcanic island, [N]Durean- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|