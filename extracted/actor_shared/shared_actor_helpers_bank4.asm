; The shared fairy-gem idle loop, the captive's second plea set and the Mountain of Souls gem texts of bank 04 (file offsets 139913-140041 and 140442-140578, SNES $04:A289-$A309 and $04:A49A-$A522; bank 04).
; 
; === WHAT RUNS HERE ===
; - cm_npc_fairy_gem_idle_022289: the same idle loop as shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C (animation 7, animation $0C when the hero is inside the box widened by $18 pixels). The Mountain of Souls gems start it by a pushed RTL address after the bank 03 setup.
; - cm_npc_captive_plea_02229E: the second plea of a captive, chosen at random by the low 2 bits of rng_state+1 (0 'I want to return to my real form-', 1 'Ow----', 2 and 3 'Ouch---- it hurts! Somebody please help me!').
; - asciistring_02249A and its neighbours: the two fairy gems of the Mountain of Souls ($3E and $3F, ms_multi_area_actors): 'I am watching the world- Here, take this- <name> received EXP!', the question 'Would you like to return to the location of the Mountain of Souls?', the answers 'Good luck then-' and 'Return to me when you are ready-'.
; - asciistring_02251E: the common tail ([12] key, [08:408] erase window) that many texts of the Mountain of Souls areas jump to ([JMP]), among them the dungeon and the Soul of the Mountain house.
; 
; === OPEN ===
; The wording of the gem texts is OQ-I037-14; which creatures use the plea set is not traced.
---------------------------------------------

?BANK 04

!rng_state                      0301

---------------------------------------------

; The idle loop of a fairy gem, the bank 04 copy.
; 
; When: the loop the gems run after the bank 03 setup (reached by a pushed RTL address).
; Sees: animation 7 while the hero is away; animation $0C once when he is inside the box widened by $18 pixels.
; Why: the same behaviour, instruction for instruction, as cm_npc_fairy_gem_idle_01B17C.
; In: X = own slot.
; Out: loops forever (COP 82 yields).
; Clobbers: A, Y.

cm_npc_fairy_gem_idle_022289 {
    COP [2E] ( #00, #$0018, &cm_npc_fairy_gem_idle_near_022297 ) ; the hero inside the gem's box widened by $18 pixels?
    COP [80] ( #07 )
    COP [82]
    BRA cm_npc_fairy_gem_idle_022289
}

---------------------------------------------
; The near branch: animation $0C plays once (COP 80, COP 82), then the loop restarts.

cm_npc_fairy_gem_idle_near_022297 {
    COP [80] ( #0C )
    COP [82]
    BRA cm_npc_fairy_gem_idle_022289
}

---------------------------------------------
; A captive's second random plea.
; 
; When: the talk handler of a captive creature runs it (COP 01 with a text chosen at random).
; Sees: 'I want to return to my real form-', 'Ow----' or 'Ouch---- it hurts! Somebody please help me!' (the last twice as likely).
; Why: the same trick as cm_npc_captive_plea_01B191 with other words.
; In: X = own slot.
; Out: COP 1F steps rng_state; its second byte AND 3 picks the text: 0 real form, 1 Ow, 2 and 3 the long one. RTL after the text.
; Clobbers: A.

cm_npc_captive_plea_02229E {
    COP [1F]
    LDA $rng_state+1      ; COP 1F stepped the generator: the low 2 bits pick the text (0 real form, 1 Ow, 2 and 3 the long one)
    AND #$0003
    BEQ cm_npc_captive_plea_real_form_0222B0
    DEC 
    BEQ cm_npc_captive_plea_ow_0222B5
    COP [01] ( &asciistring_0222BA )
    RTL 

; Branch 0: 'I want to return to my real form-', then RTL.

  cm_npc_captive_plea_real_form_0222B0:
    COP [01] ( &asciistring_0222E2 )
    RTL 

; Branch 1: 'Ow----', then RTL.

  cm_npc_captive_plea_ow_0222B5:
    COP [01] ( &asciistring_0222FF )
    RTL 
}

asciistring_0222BA |[10]Ouch---- it hurts! [N]Somebody please help [N]me! [JMP:&asciistring_02251E]|

asciistring_0222E2 |[10]I want to return to my[N]real form- [JMP:&asciistring_02251E]|

asciistring_0222FF |[10]Ow---- [JMP:&asciistring_02251E]|
---------------------------------------------

; The gem texts of the Mountain of Souls and the common tail (file offsets 140442-140578).
; 
; When: asciistring_02249A is the gift text of both gems (the first talk, before the EXP is given), asciistring_0224C2 the question, asciistring_0224F4 the answer of Go back and asciistring_022507 the answer of Stay (ms_multi_area_actors).
; Sees: 'I am watching the world- Here, take this- <name> received EXP!', 'Would you like to return to the location of the Mountain of Souls?', 'Good luck then-' and 'Return to me when you are ready-'.
; Why: both gems share the texts; the EXP and the flags are in the gems' scripts.
; In: n/a (data). Out: n/a.
; Clobbers: n/a.

asciistring_02249A |[10]I am watching the [N]world- Here, take [N]this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0224C2 |[10]Would you like to [N]return to the location[N]of the Mountain of [N]Souls? [END]|

asciistring_0224F4 |Good luck then- [JMP:&asciistring_02251E]|

asciistring_022507 |Return to me when you [N]are ready- [JMP:&asciistring_02251E]|

---------------------------------------------
; The common tail of the texts of the Mountain of Souls: the box waits for a key ([12]) and is erased ([08:408]); many strings of the dungeon and of the Soul of the Mountain house end by a [JMP] to it.

asciistring_02251E |[12][::][08:408][END]|