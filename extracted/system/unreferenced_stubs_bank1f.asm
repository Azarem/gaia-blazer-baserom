; Two kill-self stubs in bank 1F (file offsets 1040320-1040322 and 1042281-1042283, SNES $1F:DFC0 and $1F:E769).
; 
; === MODEL ===
; Each stub is COP 86 (Cop86_KillSelf) and RTL: an actor script that ends the actor at once. No reference to either label exists in the extraction, so no 2-byte reference pins them; they stay in bank 1F because they started there and nothing moves across banks. 'Unreferenced' is a static statement (OQ-I020-4).
---------------------------------------------

?BANK 1F

---------------------------------------------

; Actor script that kills its actor at once (first stub of bank 1F).
; 
; When: no reference in the extraction (OQ-I020-4).
; Sees: n/a.
; Why: a placeholder script (inferred).
; In: actor entry, X = actor slot.
; Out: COP 86 (Cop86_KillSelf), RTL.
; Clobbers: A, Y.

KillSelfStubA {
    COP [86]
    RTL 
}
---------------------------------------------

; Actor script that kills its actor at once (second stub of bank 1F).
; 
; When: no reference in the extraction (OQ-I020-4).
; Sees: n/a.
; Why: a placeholder script (inferred).
; In: actor entry, X = actor slot.
; Out: COP 86 (Cop86_KillSelf), RTL.
; Clobbers: A, Y.

KillSelfStubB {
    COP [86]
    RTL 
}