; Actor-slot and collision helpers for the COP handlers.
; 
; Actor slots are 0x40 bytes wide from $0800. Actors are in a doubly linked list ($3C = next, $3E = previous; heads $06A6 and $06A8). Free slots are kept on a stack addressed by $4A (word entries; a taken entry is zeroed). The spawn helpers link a new actor after (code_00663A) or before (code_006662) the caller and clone the caller's first $3C bytes into it (code_0066A3).
---------------------------------------------

?BANK 00

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'
?INCLUDE 'lib_shared_0131D1'

!actor_list_tail                06A6
!actor_list_head                06A8
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

; Clear the collision footprint of the actor at X: for every tile under its box (widths $10/$12) the low byte of the entry in the collision buffer $7F8000 is zeroed. Uses lib_027462 to turn the position into a buffer offset. Counterpart of Cop15_BlockOwnTiles, which ORs $F0 into the same entries.

code_0065A7 {
    LDA $0010, X          ; {26023}
    CLC                   ; {26026}
    ADC $0012, X          ; {26027}
    CMP #$0021            ; {26030}
    BCS loc_0065D3        ; {26033}
    PHX                   ; {26035}
    LDA $0000, X          ; {26036}
    STA $16               ; {26039}
    LDA $0002, X          ; {26041}
    SEC                   ; {26044}
    SBC #$0010            ; {26045}
    STA $18               ; {26048}
    JSL $@lib_027462_part1.code_0272B8 ; {26050}
    LDA $tile_type_map, X ; {26054}
    AND #$FF00            ; {26058}
    STA $tile_type_map, X ; {26061}
    PLX                   ; {26065}
    RTS                   ; {26066}

  loc_0065D3:
    TXY                   ; {26067}
    LDA $0012, Y          ; {26068}
    LSR                   ; {26071}
    LSR                   ; {26072}
    LSR                   ; {26073}
    LSR                   ; {26074}
    STA $0C               ; {26075}
    LDA $0000, X          ; {26077}
    STA $16               ; {26080}
    LDA $0002, X          ; {26082}
    SEC                   ; {26085}
    SBC $0012, X          ; {26086}

  loc_0065E9:
    STA $18               ; {26089}
    JSL $@lib_027462_part1.code_0272B8 ; {26091}
    LDA $0010, Y          ; {26095}
    LSR                   ; {26098}
    LSR                   ; {26099}
    LSR                   ; {26100}
    LSR                   ; {26101}
    STA $0E               ; {26102}

  loc_0065F8:
    LDA $tile_type_map, X ; {26104}
    AND #$FF00            ; {26108}
    STA $tile_type_map, X ; {26111}
    JSL $@lib_027462_part2.code_02731A ; {26115}
    DEC $0E               ; {26119}
    BNE loc_0065F8        ; {26121}
    LDA $18               ; {26123}
    CLC                   ; {26125}
    ADC #$0010            ; {26126}
    DEC $0C               ; {26129}
    BNE loc_0065E9        ; {26131}
    TYX                   ; {26133}
    RTS                   ; {26134}
}

---------------------------------------------
; Convert a slot number to a slot address. In: A (8-bit) = slot number. Out: Y = $0800 + number * $40.

code_006617 {
    SEP #$20              ; {26135}
    XBA                   ; {26137}
    LDA #$40              ; {26138}
    JSL $@lib_shared_0131D1.code_0131D1 ; {26140}
    REP #$20              ; {26144}
    CLC                   ; {26146}
    ADC #$0800            ; {26147}
    TAY                   ; {26150}
    RTS                   ; {26151}
}

---------------------------------------------
; Tile number to pixel coordinate: A = A * 16.

code_006628 {
    ASL                   ; {26152}
    ASL                   ; {26153}
    ASL                   ; {26154}
    ASL                   ; {26155}
    RTS                   ; {26156}
}

---------------------------------------------
; Register the actor X in the table $7F0483 at index A (word entries). Used by Cop14_JumpIfSwitchSet and Cop3B_JumpIfSwitchSetData. Preserves A and X.

code_00662D {
    PHA                   ; {26157}
    PHX                   ; {26158}
    ASL                   ; {26159}
    TAX                   ; {26160}
    LDA $01, S            ; {26161}
    STA $switch_owner_table, X ; {26163}
    PLX                   ; {26167}
    PLA                   ; {26168}
    RTS                   ; {26169}
}

---------------------------------------------
; Spawn: take a free slot, link it AFTER the actor X, then initialise it (code_0066A3). Out: Y = new slot, carry set when no slot is free.

code_00663A {
    JSL $@code_00668A     ; {26170}
    BCS loc_006661        ; {26174}
    TXA                   ; {26176}
    STA $003E, Y          ; {26177}
    LDA $003C, X          ; {26180}
    STA $003C, Y          ; {26183}
    TYA                   ; {26186}
    STA $003C, X          ; {26187}
    PHX                   ; {26190}
    LDX $003C, Y          ; {26191}
    BNE loc_006659        ; {26194}
    STY $actor_list_tail  ; {26196}
    BRA loc_00665D        ; {26199}

  loc_006659:
    TYA                   ; {26201}
    STA $003E, X          ; {26202}

  loc_00665D:
    PLX                   ; {26205}
    JSR $&code_0066A3     ; {26206}

  loc_006661:
    RTS                   ; {26209}
}

---------------------------------------------
; Spawn: take a free slot, link it BEFORE the actor X, then initialise it (code_0066A3). Out: Y = new slot, carry set when no slot is free.

code_006662 {
    JSL $@code_00668A     ; {26210}
    BCS loc_006689        ; {26214}
    TXA                   ; {26216}
    STA $003C, Y          ; {26217}
    LDA $003E, X          ; {26220}
    STA $003E, Y          ; {26223}
    TYA                   ; {26226}
    STA $003E, X          ; {26227}
    PHX                   ; {26230}
    LDX $003E, Y          ; {26231}
    BEQ loc_006682        ; {26234}
    TYA                   ; {26236}
    STA $003C, X          ; {26237}
    BRA loc_006685        ; {26240}

  loc_006682:
    STY $actor_list_head  ; {26242}

  loc_006685:
    PLX                   ; {26245}
    JSR $&code_0066A3     ; {26246}

  loc_006689:
    RTS                   ; {26249}
}

---------------------------------------------
; Pop a free slot from the stack at $4A. Out: Y = slot, carry clear; or carry set (Y = $06AA, a scratch slot) when the stack is empty.

code_00668A {
    LDA ($4A)             ; {26250}
    BEQ loc_00669E        ; {26252}
    TAY                   ; {26254}
    LDA #$0000            ; {26255}
    STA ($4A)             ; {26258}
    SEP #$20              ; {26260}
    INC $4A               ; {26262}
    INC $4A               ; {26264}
    REP #$20              ; {26266}
    CLC                   ; {26268}
    RTL                   ; {26269}

  loc_00669E:
    SEC                   ; {26270}
    LDY #$06AA            ; {26271}
    RTL                   ; {26274}
}

---------------------------------------------
; Initialise a new actor Y from the caller X: copy $3C bytes (MVN), set $16 bit $2000 and clear bit $0010, zero $1A, $30 and $14.

code_0066A3 {
    PHX                   ; {26275}
    PHY                   ; {26276}
    LDA #$003B            ; {26277}
    MVN #$01, #$01        ; {26280}
    PLY                   ; {26283}
    PLX                   ; {26284}
    LDA $0016, Y          ; {26285}
    ORA #$2000            ; {26288}
    AND #$FFEF            ; {26291}
    STA $0016, Y          ; {26294}
    LDA #$0000            ; {26297}
    STA $001A, Y          ; {26300}
    STA $0030, Y          ; {26303}
    STA $0014, Y          ; {26306}
    RTS                   ; {26309}
}