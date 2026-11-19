?BANK 04

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!player_x                       0374
!player_y                       0376
!player_actor                   039C

---------------------------------------------

code_027462 {
    STA $00               ; {160866}
    LDY $player_actor     ; {160868}
    LDA $0016, Y          ; {160871}
    BIT #$0C00            ; {160874}
    BEQ loc_027471        ; {160877}
    CLC                   ; {160879}
    RTL                   ; {160880}

  loc_027471:
    PHX                   ; {160881}
    LDA $player_x         ; {160882}
    AND #$000F            ; {160885}
    BEQ loc_027485        ; {160888}
    LDA $player_y         ; {160890}
    AND #$000F            ; {160893}
    BEQ loc_0274B0        ; {160896}
    BRL loc_02751A        ; {160898}

  loc_027485:
    LDA $player_y         ; {160901}
    AND #$000F            ; {160904}
    BNE loc_0274E8        ; {160907}
    LDA $player_x         ; {160909}
    STA $16               ; {160912}
    LDA $player_y         ; {160914}
    SEC                   ; {160917}
    SBC #$0010            ; {160918}
    STA $18               ; {160921}
    JSL $@lib_027462_part1.code_0272B8 ; {160923}
    LDA $7E8000, X        ; {160927}
    AND #$00FF            ; {160931}
    CMP $00               ; {160934}
    BNE loc_0274AD        ; {160936}
    BRL loc_02756F        ; {160938}

  loc_0274AD:
    PLX                   ; {160941}
    CLC                   ; {160942}
    RTL                   ; {160943}

  loc_0274B0:
    LDA $player_x         ; {160944}
    AND #$FFF0            ; {160947}
    STA $16               ; {160950}
    LDA $player_y         ; {160952}
    SEC                   ; {160955}
    SBC #$0010            ; {160956}
    STA $18               ; {160959}
    JSL $@lib_027462_part1.code_0272B8 ; {160961}
    LDA $7E8000, X        ; {160965}
    AND #$00FF            ; {160969}
    CMP $00               ; {160972}
    BNE loc_0274D3        ; {160974}
    BRL loc_02756F        ; {160976}

  loc_0274D3:
    JSL $@lib_027462_part2.code_02731A ; {160979}
    LDA $7E8000, X        ; {160983}
    AND #$00FF            ; {160987}
    CMP $00               ; {160990}
    BNE loc_0274E5        ; {160992}
    BRL loc_02756F        ; {160994}

  loc_0274E5:
    PLX                   ; {160997}
    CLC                   ; {160998}
    RTL                   ; {160999}

  loc_0274E8:
    LDA $player_x         ; {161000}
    STA $16               ; {161003}
    LDA $player_y         ; {161005}
    AND #$FFF0            ; {161008}
    SEC                   ; {161011}
    SBC #$0010            ; {161012}
    STA $18               ; {161015}
    JSL $@lib_027462_part1.code_0272B8 ; {161017}
    LDA $7E8000, X        ; {161021}
    AND #$00FF            ; {161025}
    CMP $00               ; {161028}
    BEQ loc_02756F        ; {161030}
    JSL $@lib_027462_part2.code_027331 ; {161032}
    LDA $7E8000, X        ; {161036}
    AND #$00FF            ; {161040}
    CMP $00               ; {161043}
    BEQ loc_02756F        ; {161045}
    PLX                   ; {161047}
    CLC                   ; {161048}
    RTL                   ; {161049}

  loc_02751A:
    LDA $player_x         ; {161050}
    AND #$FFF0            ; {161053}
    STA $16               ; {161056}
    LDA $player_y         ; {161058}
    AND #$FFF0            ; {161061}
    SEC                   ; {161064}
    SBC #$0010            ; {161065}
    STA $18               ; {161068}
    JSL $@lib_027462_part1.code_0272B8 ; {161070}
    LDA $7E8000, X        ; {161074}
    AND #$00FF            ; {161078}
    CMP $00               ; {161081}
    BEQ loc_02756F        ; {161083}
    PHX                   ; {161085}
    JSL $@lib_027462_part2.code_02731A ; {161086}
    LDA $7E8000, X        ; {161090}
    AND #$00FF            ; {161094}
    PLX                   ; {161097}
    CMP $00               ; {161098}
    BEQ loc_02756F        ; {161100}
    JSL $@lib_027462_part2.code_027331 ; {161102}
    LDA $7E8000, X        ; {161106}
    AND #$00FF            ; {161110}
    CMP $00               ; {161113}
    BEQ loc_02756F        ; {161115}
    JSL $@lib_027462_part2.code_02731A ; {161117}
    LDA $7E8000, X        ; {161121}
    AND #$00FF            ; {161125}
    CMP $00               ; {161128}
    BEQ loc_02756F        ; {161130}
    PLX                   ; {161132}
    CLC                   ; {161133}
    RTL                   ; {161134}

  loc_02756F:
    PLX                   ; {161135}
    SEC                   ; {161136}
    RTL                   ; {161137}
}