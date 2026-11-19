?BANK 1F

?INCLUDE 'common_actor_004659_part1'

---------------------------------------------

code_0FB561 {
    COP [AD] ( #10 )
    COP [81] ( #14, #02 )
    COP [83]
    COP [B2] ( @code_0FB57F, #$0008, #$FFFC, #$0000 )

  loc_0FB575:
    COP [AD] ( #08 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FB575
}

code_0FB57F {
    COP [A3]
    COP [81] ( #15, #02 )
    COP [83]

  loc_0FB587:
    COP [85] ( @common_actor_004659_part1.code_002D96 )
    CPY #$06AA
    BEQ loc_0FB599
    COP [81] ( #15, #02 )
    COP [83]
    BRA loc_0FB587

  loc_0FB599:
    COP [86]
    RTL 
}