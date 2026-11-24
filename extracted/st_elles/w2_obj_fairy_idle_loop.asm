; Scripts and texts shared by the world 2 actors (file offsets 1026373-1026633, SNES $1F:A945-$AA48): the idle loop of the fairies, the plea of the captive creatures and the common dialogue strings (the EXP gift of a fairy, the return prompt, the end of a dialogue). Included by the actor files of the Seabed Sanctuary, the seabed and the coast.
; 
; === ROSTER ===
; - w2_obj_fairy_idle_loop_0FA945: the fairies look at the hero: when he is inside the box widened by $18 (COP 2E) animation $0C, else $07.
; - w2_npc_caged_plea_0FA95A: the talk handler of a creature that is still held by its lair: one of three pleas chosen by the random generator ('Please somebody help me.', 'I want to return to myself!', 'Help! Somebody please.').
; - asciistring_0FA9C5 ('I am watching over the world. Here, take this. [the hero] received EXP!'), asciistring_0FA9F0 ('Would you like to return to the Seabed Palace?'), asciistring_0FAA15 ('Allright, good luck.'), asciistring_0FAA29 ('Visit me again when you are ready.') and asciistring_0FAA44 (the common end of a dialogue, an engine control string).
; 
; === OPEN ===
; 'I want to return to myself!' (the captives are creatures that the evil changed; the walkthrough does not quote it).
---------------------------------------------

?BANK 1F

!rng_state                      0301

---------------------------------------------

; The idle loop of a fairy gem.
; 
; When: entered by the fairies' root scripts through a pushed return address (RTL); loops every frame.
; Sees: COP 2E: hero inside the actor's box widened by $18: code_0FA953 (animation $0C, 'looking up'); otherwise animation $07; each pass waits for the animation step (COP 82).
; In: X = D = slot.
; Out: yields; never returns.
; Clobbers: A.

w2_obj_fairy_idle_loop_0FA945 {
    COP [2E] ( #00, #$0018, &code_0FA953 ) ; the hero inside the box widened by $18 makes the fairy look at him (animation $0C)
    COP [80] ( #07 )
    COP [82]
    BRA w2_obj_fairy_idle_loop_0FA945
}

code_0FA953 {
    COP [80] ( #0C )
    COP [82]
    BRA w2_obj_fairy_idle_loop_0FA945
}

---------------------------------------------
; The plea of a captive creature (the talk handler of every COP 3B root of the world 2 actors).
; 
; When: the hero talks to a creature whose lair is not released yet.
; Sees: COP 1F advances the random generator and rng_state+1 AND 3 picks the text: 0 'I want to return to myself!', 1 'Help! Somebody please.', 2 or 3 'Please somebody help me.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

w2_npc_caged_plea_0FA95A {
    COP [1F]
    LDA $rng_state+1
    AND #$0003            ; 0: 'I want to return to myself!', 1: 'Help! Somebody please.', 2 and 3: 'Please somebody help me.'
    BEQ loc_0FA96C
    DEC 
    BEQ loc_0FA971
    COP [01] ( &asciistring_0FA976 )
    RTL 

  loc_0FA96C:
    COP [01] ( &asciistring_0FA98C )
    RTL 

  loc_0FA971:
    COP [01] ( &asciistring_0FA9A4 )
    RTL 
}

asciistring_0FA976 |[10]Please somebody help [N]me--- [JMP:&asciistring_0FAA44]|

asciistring_0FA98C |[10]I want to return to [N]myself! [JMP:&asciistring_0FAA44]|

asciistring_0FA9A4 |[10]Help! Somebody [N]please------ [JMP:&asciistring_0FAA44]|

asciistring_0FA9C5 |[10]I am watching over the[N]world- [N]Here, take this- [FIN][02:2] received [N]EXP! [FIN][END]|

asciistring_0FA9F0 |[10]Would you like to [N]return to the Seabed [N]Palace? [END]|

asciistring_0FAA15 |Allright, good luck- [JMP:&asciistring_0FAA44]|

asciistring_0FAA29 |Visit me again when [N]you are ready- [JMP:&asciistring_0FAA44]|

asciistring_0FAA44 |[12][::][08:408][END]|