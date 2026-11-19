?BANK 04

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!player_x                       0374
!player_y                       0376
!player_actor                   039C

---------------------------------------------

code_027462 {
    STA $00
    LDY $player_actor
    LDA $0016, Y
    BIT #$0C00
    BEQ loc_027471
    CLC 
    RTL 

  loc_027471:
    PHX 
    LDA $player_x
    AND #$000F
    BEQ loc_027485
    LDA $player_y
    AND #$000F
    BEQ loc_0274B0
    BRL loc_02751A

  loc_027485:
    LDA $player_y
    AND #$000F
    BNE loc_0274E8
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BNE loc_0274AD
    BRL loc_02756F

  loc_0274AD:
    PLX 
    CLC 
    RTL 

  loc_0274B0:
    LDA $player_x
    AND #$FFF0
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BNE loc_0274D3
    BRL loc_02756F

  loc_0274D3:
    JSL $@lib_027462_part2.code_02731A
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BNE loc_0274E5
    BRL loc_02756F

  loc_0274E5:
    PLX 
    CLC 
    RTL 

  loc_0274E8:
    LDA $player_x
    STA $16
    LDA $player_y
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ loc_02756F
    JSL $@lib_027462_part2.code_027331
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ loc_02756F
    PLX 
    CLC 
    RTL 

  loc_02751A:
    LDA $player_x
    AND #$FFF0
    STA $16
    LDA $player_y
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ loc_02756F
    PHX 
    JSL $@lib_027462_part2.code_02731A
    LDA $7E8000, X
    AND #$00FF
    PLX 
    CMP $00
    BEQ loc_02756F
    JSL $@lib_027462_part2.code_027331
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ loc_02756F
    JSL $@lib_027462_part2.code_02731A
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ loc_02756F
    PLX 
    CLC 
    RTL 

  loc_02756F:
    PLX 
    SEC 
    RTL 
}