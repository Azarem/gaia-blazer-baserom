; The text dictionary: 128 words of 12 bytes (file offsets 524288-525823, SNES $10:8000-$85FF, bank 08; 1536 bytes).
; 
; === MODEL ===
; A string byte of $80 or more is a dictionary word: the text renderers (ExpandDictionaryWord in the menu text, ExpandDialogueWord in dialogue, through ReadTextByte and ReadDialogueByte) print entry (byte and $7F) and a blank. Each entry is 12 bytes, the word padded with zero bytes. The 128 entries are common words (all, and, back, because, ...) and a few names: $0A King, $0B Leo, $0C Liesa, $0D Magridd, $06 Deathtole, $10 Stone. Entries $00-$15 are capitalised, $16-$7F lower case (so $01 is 'A' and $17 'a'); the fragments '-ll', 's', 'm' and 't' ($3F, $57, $46, $65) complete contractions.
; ROM spelling against the walkthrough: entry $06 reads 'Deathtole' (OQ-I010-2) and the walkthrough writes 'Deathtoll'; entry $0C reads 'Liesa' and the walkthrough writes 'Lisa' (OQ-I033-7).
---------------------------------------------

---------------------------------------------

; The dictionary of 128 common words, 12 bytes each.
; 
; When: every string byte of $80 or more in dialogue, menus and item names.
; Sees: the word typed out followed by a blank.
; Why: dialogue and menu text repeat common words, so each is stored once and referenced by one byte.
; In: n/a (data): entry = byte and $7F; 12 bytes: the characters, then zero padding.
; Out: up to 12 characters of the entry are drawn.
; Clobbers: n/a (data).

Dictionary [
  |All|(12)   ;00
  |A|(12)   ;01
  |And|(12)   ;02
  |But|(12)   ;03
  |Come|(12)   ;04
  |Dream|(12)   ;05
  |Deathtole|(12)   ;06
  |Green|(12)   ;07
  |I|(12)   ;08
  |If|(12)   ;09
  |King|(12)   ;0A
  |Leo|(12)   ;0B
  |Liesa|(12)   ;0C
  |Magridd|(12)   ;0D
  |Necessary|(12)   ;0E
  |Please|(12)   ;0F
  |Stone|(12)   ;10
  |The|(12)   ;11
  |This|(12)   ;12
  |There|(12)   ;13
  |Thank|(12)   ;14
  |You|(12)   ;15
  |and|(12)   ;16
  |a|(12)   ;17
  |are|(12)   ;18
  |about|(12)   ;19
  |all|(12)   ;1A
  |around|(12)   ;1B
  |an|(12)   ;1C
  |am|(12)   ;1D
  |after|(12)   ;1E
  |always|(12)   ;1F
  |back|(12)   ;20
  |be|(12)   ;21
  |but|(12)   ;22
  |because|(12)   ;23
  |basement|(12)   ;24
  |believe|(12)   ;25
  |come|(12)   ;26
  |can|(12)   ;27
  |called|(12)   ;28
  |came|(12)   ;29
  |creatures|(12)   ;2A
  |could|(12)   ;2B
  |everything|(12)   ;2C
  |from|(12)   ;2D
  |for|(12)   ;2E
  |found|(12)   ;2F
  |give|(12)   ;30
  |going|(12)   ;31
  |good|(12)   ;32
  |go|(12)   ;33
  |get|(12)   ;34
  |have|(12)   ;35
  |has|(12)   ;36
  |help|(12)   ;37
  |human|(12)   ;38
  |here|(12)   ;39
  |is|(12)   ;3A
  |in|(12)   ;3B
  |just|(12)   ;3C
  |know|(12)   ;3D
  |like|(12)   ;3E
  |ll|(12)   ;3F
  |live|(12)   ;40
  |lives|(12)   ;41
  |my|(12)   ;42
  |me|(12)   ;43
  |monsters|(12)   ;44
  |medical|(12)   ;45
  |m|(12)   ;46
  |many|(12)   ;47
  |made|(12)   ;48
  |machine|(12)   ;49
  |not|(12)   ;4A
  |of|(12)   ;4B
  |one|(12)   ;4C
  |on|(12)   ;4D
  |over|(12)   ;4E
  |people|(12)   ;4F
  |put|(12)   ;50
  |person|(12)   ;51
  |please|(12)   ;52
  |queen|(12)   ;53
  |received|(12)   ;54
  |really|(12)   ;55
  |released|(12)   ;56
  |s|(12)   ;57
  |something|(12)   ;58
  |started|(12)   ;59
  |strange|(12)   ;5A
  |see|(12)   ;5B
  |should|(12)   ;5C
  |soul|(12)   ;5D
  |snail|(12)   ;5E
  |scared|(12)   ;5F
  |somewhere|(12)   ;60
  |the|(12)   ;61
  |to|(12)   ;62
  |that|(12)   ;63
  |this|(12)   ;64
  |t|(12)   ;65
  |take|(12)   ;66
  |tell|(12)   ;67
  |think|(12)   ;68
  |there|(12)   ;69
  |talk|(12)   ;6A
  |though|(12)   ;6B
  |used|(12)   ;6C
  |use|(12)   ;6D
  |very|(12)   ;6E
  |village|(12)   ;6F
  |voice|(12)   ;70
  |will|(12)   ;71
  |with|(12)   ;72
  |was|(12)   ;73
  |when|(12)   ;74
  |what|(12)   ;75
  |world|(12)   ;76
  |watching|(12)   ;77
  |want|(12)   ;78
  |walk|(12)   ;79
  |whenever|(12)   ;7A
  |who|(12)   ;7B
  |watch|(12)   ;7C
  |were|(12)   ;7D
  |you|(12)   ;7E
  |your|(12)   ;7F
]