?BANK 00

?INCLUDE 'cop_handler_006473'

!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380

---------------------------------------------

Cop10_SetNextScene {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    XBA 
    STA $scene_next
    LDA [$38]
    INC $38
    AND #$00FF
    STA $warp_dest_anim
    LDA [$38]
    INC $38
    INC $38
    STA $warp_dest_x
    LDA [$38]
    INC $38
    INC $38
    STA $warp_dest_y
    BRL cop_handler_006473.loc_0064BF
}