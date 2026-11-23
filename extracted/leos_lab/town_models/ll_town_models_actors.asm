?BANK 04

?INCLUDE 'll_laboratory_dungeon_actors'
?INCLUDE 'll_watching_over_world_return_prompt_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

!scene_sprite_attr              0372

---------------------------------------------

code_023E27 {
    COP [14] ( #$0147, &code_023E2E )
    RTL 
}

code_023E2E {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_023E42 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.code_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.code_022289-1
    PHA 
    RTL 
}

code_023E42 {
    COP [07] ( #$9D02, &ll_laboratory_dungeon_actors.code_023E00 )
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D02 )
    BRL ll_laboratory_dungeon_actors.code_023E00
}
---------------------------------------------

code_023E87 {
    COP [14] ( #$0143, &code_023E8E )
    RTL 
}

code_023E8E {
    COP [07] ( #$9B07, &code_023EF0 )
    COP [09] ( #$9B07 )
    COP [B2] ( @code_023EF3, #$0000, #$0000, #$4000 )
    COP [B2] ( @code_023EF3, #$0020, #$0000, #$4000 )
    COP [B2] ( @code_023EF3, #$0040, #$0000, #$4000 )
    COP [B2] ( @code_023EF3, #$0060, #$0000, #$4000 )
    COP [B2] ( @code_023EF3, #$0000, #$0040, #$4000 )
    COP [B2] ( @code_023EF3, #$0020, #$0040, #$4000 )
    COP [B2] ( @code_023EF3, #$0040, #$0040, #$4000 )
    COP [B2] ( @code_023EF3, #$0060, #$0040, #$4000 )
}

code_023EF0 {
    COP [86]
    RTL 
}

code_023EF3 {
    COP [A8] ( #$8000, #0E )
    LDA $0005
    STA $001E, X
    STZ $0020, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #3C )
    COP [83]
    COP [86]
    RTL 
}