?BANK 00

?INCLUDE 'data_00F9F7'
?INCLUDE 'lib_014516'
?INCLUDE 'lib_014527'
?INCLUDE 'lib_shared_012769'

!player_level_bcd               1B6A
!player_exp                     1B78
!player_exp_next                1B7C
!player_level                   1B86
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

code_002F56 {
    LDA $player_level     ; {12118}
    CMP #$0032            ; {12121}
    BCC loc_002F61        ; {12124}
    BRL loc_003002        ; {12126}

  loc_002F61:
    ASL                   ; {12129}
    ASL                   ; {12130}
    TAY                   ; {12131}
    LDA $&data_00F9F7.word_00FBB8, Y ; {12132}
    STA $1B7E             ; {12135}
    LDA $&data_00F9F7.word_00FBB8+2, Y ; {12138}
    STA $player_exp_next  ; {12141}
    COP [91]              ; {12144}
    LDA $player_exp       ; {12146}
    SEC                   ; {12149}
    SBC $player_exp_next  ; {12150}
    LDA $1B7A             ; {12153}
    SBC $1B7E             ; {12156}
    BCS loc_002F82        ; {12159}
    RTL                   ; {12161}

  loc_002F82:
    LDA $player_max_hp    ; {12162}
    CLC                   ; {12165}
    ADC #$0002            ; {12166}
    CMP #$0065            ; {12169}
    BCC loc_002F91        ; {12172}
    LDA #$0064            ; {12174}

  loc_002F91:
    STA $player_max_hp    ; {12177}
    LDA $player_hp        ; {12180}
    CLC                   ; {12183}
    ADC #$0002            ; {12184}
    CMP #$0065            ; {12187}
    BCC loc_002FA3        ; {12190}
    LDA #$0064            ; {12192}

  loc_002FA3:
    STA $player_hp        ; {12195}
    COP [37]              ; {12198}
    INC $player_level     ; {12200}
    SED                   ; {12203}
    LDA $player_level_bcd ; {12204}
    CLC                   ; {12207}
    ADC #$0001            ; {12208}
    STA $player_level_bcd ; {12211}
    CLD                   ; {12214}
    LSR                   ; {12215}
    BCS loc_002FBF        ; {12216}
    INC $1B72             ; {12218}
    BRA loc_002FC2        ; {12221}

  loc_002FBF:
    INC $1B76             ; {12223}

  loc_002FC2:
    LDA #$001F            ; {12226}
    TSB $0332             ; {12229}
    LDA $player_level     ; {12232}
    ASL                   ; {12235}
    ASL                   ; {12236}
    TAY                   ; {12237}
    LDA $&data_00F9F7.word_00FBB8, Y ; {12238}
    STA $1B7E             ; {12241}
    LDA $&data_00F9F7.word_00FBB8+2, Y ; {12244}
    STA $player_exp_next  ; {12247}
    BRK #$97              ; {12250}
    COP [03] ( #03 )      ; {12252}
    PHX                   ; {12255}
    LDY #$&lib_014516.asciistring_014516 ; {12256}
    JSL $@lib_shared_012769.code_012769 ; {12259}
    PLX                   ; {12263}
    COP [1B] ( &code_002FEE, #$0014 ) ; {12264}
}

code_002FEE {
    PHX                   ; {12270}
    LDY #$&lib_014527.asciistring_014527 ; {12271}
    JSL $@lib_shared_012769.code_012769 ; {12274}
    PLX                   ; {12278}
    COP [1B] ( &code_002FFD, #$000A ) ; {12279}
}

code_002FFD {
    COP [04]              ; {12285}
    BRL code_002F56       ; {12287}

  loc_003002:
    COP [86]              ; {12290}
    RTL                   ; {12292}
}