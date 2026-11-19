?BANK 04

?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'

!player_actor                   039C
!location_id                    1C6A

---------------------------------------------

code_0273F9 {
    PHP                   ; {160761}
    PHX                   ; {160762}
    SEP #$20              ; {160763}
    LDA $location_id      ; {160765}
    SEC                   ; {160768}
    SBC #$0F              ; {160769}
    CMP #$04              ; {160771}
    BCS loc_02740A        ; {160773}
    BRL loc_02745F        ; {160775}

  loc_02740A:
    LDA $0439             ; {160778}
    BNE loc_027414        ; {160781}
    LDA $1B5E             ; {160783}
    BNE loc_027440        ; {160786}

  loc_027414:
    LDX $player_actor     ; {160788}
    LDA #$0A              ; {160791}
    STA $0024, X          ; {160793}
    LDY $001E, X          ; {160796}
    LDA $&data_00F9F7.binary_00FA7F, Y ; {160799}
    EOR #$01              ; {160802}
    STA $001E, X          ; {160804}
    REP #$20              ; {160807}
    STZ $0020, X          ; {160809}
    JSL $@engine_000000.code_0008F3 ; {160812}
    LDX $039E             ; {160816}
    LDA $0016, X          ; {160819}
    ORA #$2000            ; {160822}
    STA $0016, X          ; {160825}
    SEP #$20              ; {160828}
    BRA loc_02745F        ; {160830}

  loc_027440:
    LDX $player_actor     ; {160832}
    LDA #$0B              ; {160835}
    STA $0024, X          ; {160837}
    REP #$20              ; {160840}
    STZ $0020, X          ; {160842}
    JSL $@engine_000000.code_0008F3 ; {160845}
    LDX $039E             ; {160849}
    LDA $0016, X          ; {160852}
    AND #$DFFF            ; {160855}
    STA $0016, X          ; {160858}
    SEP #$20              ; {160861}

  loc_02745F:
    PLX                   ; {160863}
    PLP                   ; {160864}
    RTL                   ; {160865}
}