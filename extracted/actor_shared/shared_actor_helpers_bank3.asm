; The shared fairy-gem and captive helpers of bank 03 (file offsets 110945-111094 and 113032-113036, SNES $03:B161-$B1F6 and $03:B988-$B98C; bank 03).
; 
; === WHAT RUNS HERE ===
; - cm_npc_fairy_gem_setup_01B161: the JSL that every fairy gem runs once (12 actor files of Grass Valley, GreenWood, St. Elles, Magridd's Castle, Leo's Lab and the Mountain of Souls call it): it selects the effect animation table $0E:8000, sets animation 7 step 0, draws the first frame, copies the sprite attributes of the scene and blocks the tiles under the gem (COP 15).
; - cm_npc_fairy_gem_idle_01B17C: the gem's idle loop: animation 7 until the hero is inside the box widened by $18 pixels, then animation $0C once. Bank 04 holds the same code (cm_npc_fairy_gem_idle_022289) and St. Elles holds a third copy (w2_obj_fairy_idle_loop_0FA945): the three do the same, so the copy a script uses follows the file it was extracted from, not its behaviour.
; - cm_npc_captive_plea_01B191: a random plea of a captive creature, shown by COP 01 with a random choice of three texts (COP 1F; the low 2 bits of rng_state+1: 0 'Please release me, someone help me!', 1 'Someone help me!', 2 and 3 'Please, someone help me!'). Bank 04 holds a second set with other words.
; - asciistring_01B988: the common tail of the three pleas ([12] waits for a key, [08:408] erases the dialogue window).
; 
; === OPEN ===
; Which creatures use each plea set is not traced (the callers name them in their own files). The gems of the Mountain of Souls give EXP and offer a ride back: ms_multi_area_actors.
---------------------------------------------

?BANK 03

?INCLUDE 'engine_scheduler_sprites_combat_collision'

!rng_state                      0301
!scene_sprite_attr              0372

---------------------------------------------

; The one-time setup of a fairy gem.
; 
; When: called with JSL by the root of every fairy gem, before its idle loop.
; Sees: the gem sprite (animation 7, step 0) drawn at once.
; Why: the setup is the same in every world, so it lives here.
; In: JSL from the gem's script, X = D = the gem's slot.
; Out: COP A8 selects the effect animation table $0E:8000; $1E = 7, $20 = 0, SetActorAnimFrame draws the frame; $1C = scene_sprite_attr; COP 15 marks the tiles under the gem solid; RTL.
; Clobbers: A, Y.

cm_npc_fairy_gem_setup_01B161 {
    COP [A8] ( #$8000, #0E ) ; the effect animation table: animation 7 is the gem, $0C the gem when the hero is near
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

; The idle loop of a fairy gem: it looks at the hero.
; 
; When: the loop the gem runs after its setup (reached by a pushed RTL address).
; Sees: animation 7 while the hero is away; when he comes inside the box widened by $18 pixels, animation $0C once.
; Why: the gem reacts to the hero before it is spoken to.
; In: X = own slot.
; Out: loops forever (COP 82 yields).
; Clobbers: A, Y.

cm_npc_fairy_gem_idle_01B17C {
    COP [2E] ( #00, #$0018, &cm_npc_fairy_gem_idle_near_01B18A ) ; the hero inside the gem's box widened by $18 pixels?
    COP [80] ( #07 )
    COP [82]
    BRA cm_npc_fairy_gem_idle_01B17C
}

---------------------------------------------
; The near branch: animation $0C plays once (COP 80, COP 82), then the loop restarts.

cm_npc_fairy_gem_idle_near_01B18A {
    COP [80] ( #0C )
    COP [82]
    BRA cm_npc_fairy_gem_idle_01B17C
}
---------------------------------------------

; A captive's random plea.
; 
; When: the talk handler of a captive creature runs it (COP 01 with a text chosen at random).
; Sees: one of three texts: 'Please release me, someone help me!', 'Someone help me!' or 'Please, someone help me!' (the last twice as likely).
; Why: the variety keeps the repeated talks from always sounding the same.
; In: X = own slot.
; Out: COP 1F steps rng_state; its second byte AND 3 picks the text: 0 release, 1 short, 2 and 3 the plain one. RTL after the text.
; Clobbers: A.

cm_npc_captive_plea_01B191 {
    COP [1F]
    LDA $rng_state+1      ; COP 1F stepped the generator: the low 2 bits pick the text (0 release, 1 short, 2 and 3 the plain one)
    AND #$0003
    BEQ cm_npc_captive_plea_release_01B1A3
    DEC 
    BEQ cm_npc_captive_plea_short_01B1A8
    COP [01] ( &asciistring_01B1AD )
    RTL 

; Branch 0: 'Please release me, someone help me!', then RTL.

  cm_npc_captive_plea_release_01B1A3:
    COP [01] ( &asciistring_01B1C7 )
    RTL 

; Branch 1: 'Someone help me!', then RTL.

  cm_npc_captive_plea_short_01B1A8:
    COP [01] ( &asciistring_01B1E6 )
    RTL 
}

asciistring_01B1AD |[10]Please, someone help [N]me! [JMP:&asciistring_01B988]|

asciistring_01B1C7 |[10]Please release me, [N]someone help me! [JMP:&asciistring_01B988]|

asciistring_01B1E6 |[10]Someone help me! [JMP:&asciistring_01B988]|
---------------------------------------------

; The common tail of the three pleas.
; 
; When: jumped to by [JMP] from asciistring_01B1AD, asciistring_01B1C7 and asciistring_01B1E6, and from the texts of other files that end the same way.
; Sees: the box waits for a key ([12]) and is erased ([08:408]).
; Why: one tail for all of them.
; In: n/a (data). Out: n/a.
; Clobbers: n/a.

asciistring_01B988 |[12][::][08:408][END]|