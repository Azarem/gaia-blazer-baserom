?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop0D_JumpIfActorAtTile {
    TYX                   ; {22797}
    LDA [$38]             ; {22798}
    INC $38               ; {22800}
    AND #$00FF            ; {22802}
    JSR $&engine_0065A7.code_006617 ; {22805}
    LDA [$38]             ; {22808}
    INC $38               ; {22810}
    AND #$00FF            ; {22812}
    JSR $&engine_0065A7.code_006628 ; {22815}
    CMP $0000, Y          ; {22818}
    BEQ loc_00592A        ; {22821}
    BRL cop_handler_006473.loc_0064B9 ; {22823}

  loc_00592A:
    LDA [$38]             ; {22826}
    INC $38               ; {22828}
    AND #$00FF            ; {22830}
    INC                   ; {22833}
    JSR $&engine_0065A7.code_006628 ; {22834}
    CMP $0002, Y          ; {22837}
    BEQ loc_00593D        ; {22840}
    BRL cop_handler_006473.loc_0064BB ; {22842}

  loc_00593D:
    LDA [$38]             ; {22845}
    INC $38               ; {22847}
    INC $38               ; {22849}
    BRL cop_handler_006473.loc_0064C1 ; {22851}
}