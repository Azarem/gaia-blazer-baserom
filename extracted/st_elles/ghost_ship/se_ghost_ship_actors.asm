; The two people of Servas's dream (file offsets 1024571-1025088, SNES $1F:A23B-$A43F): the father and the son (Servas) on the sinking ghost ship, in the dream scene A09S02 that the Dream Rod opens at the napping dolphin (se_npc_dolphin_servas_dream_0F8000). Both are plain placement scripts without a lair switch: they stand there for the dream.
; 
; === ROSTER ===
; - se_npc_servas_father_0FA23B: walking onto tile ($04,$29) replays the overheard talk ('You can hear the conversation of a father and son. Daddy, how many days have passed since the ship sank? I am too hungry and cannot travel any farther. Are we going to die? Servas, my son, some people believe that human life does not end at death. They believe that they will be born into a new life. Lives, they feel, are everlasting.'); talking to him: 'Oh, I hear some voices ... maybe the Master is calling me.' and flag $0000 is set.
; - se_npc_servas_son_0FA3A5: Servas. Before the father has spoken (flag $0000 clear) only '--------'. After: 'Someone is calling me. What is that? I just put one GEM in a treasure chest. I hope someone will find it. --------', then COP 10 to A06S01 at pixel ($C0,$40) (the dream ends at the doorstep of the dolphin's house) and flag $0704 is set (the dolphin of the first half then only says that he always has the same dream).
; 
; === EVENT FLAGS ===
; $0000 the father has spoken, $0704 the dream was lived to the end.
; 
; === OPEN ===
; The walkthrough (Boss Preparation) says Servas 'will note a 1-Gem treasure he placed'; the ROM text says he put one GEM in a treasure chest; the chest itself is not in this block.
---------------------------------------------

?BANK 1F

?INCLUDE 'w2_obj_fairy_idle_loop'

---------------------------------------------

; The father in Servas's dream.
; 
; When: placement script of the dream scene; runs every frame (SetEntryHere).
; Sees: tiles blocked (COP 15); the hero on tile ($04,$29) triggers code_0FA24B each frame he stands there; talk handler code_0FA252.
; Why: the overheard talk is the story of the ghost ship (walkthrough: 'Servas and his father, prior to their reincarnation').
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_servas_father_0FA23B {
    COP [17] ( &code_0FA252 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #04, #29, &code_0FA24B ) ; the hero on tile ($04,$29) replays the overheard conversation
    RTL 
}

---------------------------------------------
; The overheard conversation: shows the long text 'You can hear the conversation of a father and son ...' and re-enters (COP 91) so that it plays again the next time the hero steps on the tile.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0FA24B {
    COP [01] ( &asciistring_0FA25B )
    COP [91]
    RTL 
}

---------------------------------------------
; Talk handler of the father: 'Oh, I hear some voices maybe the Master is calling me.' and flag $0000 is set.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0FA252 {
    COP [01] ( &asciistring_0FA369 )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_0FA25B |[10][0F]You can hear the [N]conversation of [FIN]a father and son- [FIN][10]Daddy, how many days [N]have passed since the [N]ship sank? [FIN]I am too hungry and [N]cannot travel any [N]farther- [FIN]Are we going to die? [FIN]Servas, my son, some [N]people believe that [N]human life does not [N]end at death- [FIN]They believe that they[N]will be born into a [N]new life- Lives, they [N]feel, are everlasting-[JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0FA369 |[10]Oh, I hear some [N]voices----- maybe the [N]Master is calling me- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; Servas, the son, in the dream.
; 
; When: placement script of the dream scene.
; Sees: tiles blocked, talk handler code_0FA3AE.
; Why: the end of the dream: the talk with the son takes the hero out of it and records the dream (flag $0704).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_servas_son_0FA3A5 {
    COP [17] ( &code_0FA3AE )
    COP [15]
    COP [91]
    RTL 
}

---------------------------------------------
; Talk handler of Servas in the dream.
; 
; When: the hero talks to the son.
; Sees: flag $0000 clear (the father has not spoken): '--------' only (code_0FA3C9). Set: 'Someone is calling me. What is that? I just put one GEM in a treasure chest. I hope someone will find it.', transition type 4, COP 10 to A06S01 at pixel ($C0,$40) and flag $0704 set.
; In: X = D = slot.
; Out: RTL (the scene changes).
; Clobbers: A.

code_0FA3AE {
    COP [07] ( #$0000, &code_0FA3C9 ) ; flag $0000 is set by the father's talk; clear, the son only answers with dashes
    COP [01] ( &asciistring_0FA3DB )
    COP [3C] ( #04 )
    COP [10] ( #$0106, #03, #$00C0, #$0040 ) ; A06S01 at pixel ($C0,$40): out of the dream
    COP [09] ( #$8704 )   ; flag $0704: Servas's dream is done (read by the dolphin se_npc_dolphin_servas_dream_0F8000)
    RTL 
}

code_0FA3C9 {
    COP [01] ( &asciistring_0FA3CE )
    RTL 
}

asciistring_0FA3CE |[10]-------- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0FA3DB |[10]Someone is calling me-[N]What is that? [FIN]I just put one GEM in [N]a treasure chest- [FIN]I hope someone will [N]find it- [FIN]-------- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|