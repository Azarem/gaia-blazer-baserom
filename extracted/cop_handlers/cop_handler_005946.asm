?BANK 00

?INCLUDE 'cop_handler_006473'

!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380

---------------------------------------------

Cop10_SetNextScene {
    TYX                   ; {22854}
    LDA [$38]             ; {22855}
    INC $38               ; {22857}
    INC $38               ; {22859}
    XBA                   ; {22861}
    STA $scene_next       ; {22862}
    LDA [$38]             ; {22865}
    INC $38               ; {22867}
    AND #$00FF            ; {22869}
    STA $warp_dest_anim   ; {22872}
    LDA [$38]             ; {22875}
    INC $38               ; {22877}
    INC $38               ; {22879}
    STA $warp_dest_x      ; {22881}
    LDA [$38]             ; {22884}
    INC $38               ; {22886}
    INC $38               ; {22888}
    STA $warp_dest_y      ; {22890}
    BRL cop_handler_006473.loc_0064BF ; {22893}
}