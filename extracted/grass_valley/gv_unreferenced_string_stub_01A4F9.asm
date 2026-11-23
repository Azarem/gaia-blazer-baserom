; An unreferenced string 'I am dreaming.' next to the Lisa dream texts (file offsets 107769-107786, bank 03). No label, pointer or script refers to asciistring_01A4F9; it sits between gv_underground_castle_actors.code_01A4E4 and asciistring_01A50A ('Daddy, where are you?!'). It is probably a leftover line for Lisa or the dream (OQ-I034-13).
; 
; === NOTES ===
; - The string ends with the shared text tail asciistring_01B988 like the other dream texts.
---------------------------------------------

?BANK 03

?INCLUDE 'shared_actor_helpers_bank3'

---------------------------------------------

; 'I am dreaming.' (unused).
; 
; When: never; nothing refers to it.
; Sees: nothing.
; Why: a leftover of the dream scene (OQ-I034-13).
; In: n/a (data).
; Out: n/a. Ends with [N] and [JMP] to asciistring_01B988.
; Clobbers: n/a.

asciistring_01A4F9 |[10]I am dreaming- [N][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|