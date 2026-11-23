?BANK 03

?INCLUDE 'engine_scheduler_sprites_combat_collision'

!rng_state                      0301
!scene_sprite_attr              0372

---------------------------------------------

code_01B161 {
    COP [A8] ( #$8000, #0E )
    LDA #$0007
    STA $001E, X
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    LDA $scene_sprite_attr
    STA $001C, X
    COP [15]
    RTL 
}
---------------------------------------------

code_01B17C {
    COP [2E] ( #00, #$0018, &code_01B18A )
    COP [80] ( #07 )
    COP [82]
    BRA code_01B17C
}

code_01B18A {
    COP [80] ( #0C )
    COP [82]
    BRA code_01B17C
}
---------------------------------------------

code_01B191 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_01B1A3
    DEC 
    BEQ loc_01B1A8
    COP [01] ( &asciistring_01B1AD )
    RTL 

  loc_01B1A3:
    COP [01] ( &asciistring_01B1C7 )
    RTL 

  loc_01B1A8:
    COP [01] ( &asciistring_01B1E6 )
    RTL 
}

asciistring_01B1AD |[10]Please, someone help [N]me! [JMP:&asciistring_01B988]|

asciistring_01B1C7 |[10]Please release me, [N]someone help me! [JMP:&asciistring_01B988]|

asciistring_01B1E6 |[10]Someone help me! [JMP:&asciistring_01B988]|
---------------------------------------------

asciistring_01B988 |[12][::][08:408][END]|