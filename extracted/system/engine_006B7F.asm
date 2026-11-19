?BANK 00

?INCLUDE 'data_00F9F7'
?INCLUDE 'lib_0118FC_part2'
?INCLUDE 'lib_01232B'
?INCLUDE 'lib_0143B0'
?INCLUDE 'lib_01440D'
?INCLUDE 'lib_027132'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'lib_shared_02716E'

!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!location_id                    1C6A
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!MPYL                           2134
!MPYM                           2135

---------------------------------------------

code_006B7F {
    LDA $location_id      ; {27519}
    CMP #$10              ; {27522}
    BNE loc_006BA4        ; {27524}
    JSR $&code_006BF1     ; {27526}
    JSR $&code_006BA8     ; {27529}
    LDX $0476             ; {27532}
    STX $046E             ; {27535}
    LDX $0478             ; {27538}
    STX $0470             ; {27541}
    LDX $047A             ; {27544}
    STX $0472             ; {27547}
    LDX $047C             ; {27550}
    STX $0474             ; {27553}

  loc_006BA4:
    RTL                   ; {27556}
}

code_006BA5 {
    JSR $&code_006C50     ; {27557}
}

code_006BA8 {
    LDA $046E             ; {27560}
    STA $M7A              ; {27563}
    LDA $046F             ; {27566}
    STA $M7A              ; {27569}
    LDA $0470             ; {27572}
    STA $M7B              ; {27575}
    LDA $0471             ; {27578}
    STA $M7B              ; {27581}
    LDA $0472             ; {27584}
    STA $M7C              ; {27587}
    LDA $0473             ; {27590}
    STA $M7C              ; {27593}
    LDA $0474             ; {27596}
    STA $M7D              ; {27599}
    LDA $0475             ; {27602}
    STA $M7D              ; {27605}
    LDA $046A             ; {27608}
    STA $M7X              ; {27611}
    LDA $046B             ; {27614}
    STA $M7X              ; {27617}
    LDA $046C             ; {27620}
    STA $M7Y              ; {27623}
    LDA $046D             ; {27626}
    STA $M7Y              ; {27629}
    RTS                   ; {27632}
}

code_006BF1 {
    SEP #$10              ; {27633}
    LDX $047E             ; {27635}
    REP #$10              ; {27638}
    LDY $0480             ; {27640}
    STY $00               ; {27643}
    XBA                   ; {27645}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27646}
    STA $02               ; {27650}
    JSR $&code_006CA0     ; {27652}
    LDY $MPYM             ; {27655}
    STY $0476             ; {27658}
    LDY $0480             ; {27661}
    STY $00               ; {27664}
    XBA                   ; {27666}
    LDA $@data_00F9F7.binary_00FC84, X ; {27667}
    STA $02               ; {27671}
    JSR $&code_006CA0     ; {27673}
    LDY $MPYM             ; {27676}
    STY $0478             ; {27679}
    LDY $0480             ; {27682}
    STY $00               ; {27685}
    XBA                   ; {27687}
    LDA $@data_00F9F7.binary_00FC84, X ; {27688}
    EOR #$FF              ; {27692}
    INC                   ; {27694}
    STA $02               ; {27695}
    JSR $&code_006CA0     ; {27697}
    LDY $MPYM             ; {27700}
    STY $047A             ; {27703}
    LDY $0480             ; {27706}
    STY $00               ; {27709}
    XBA                   ; {27711}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27712}
    STA $02               ; {27716}
    JSR $&code_006CA0     ; {27718}
    LDY $MPYM             ; {27721}
    STY $047C             ; {27724}
    RTS                   ; {27727}
}

code_006C50 {
    REP #$20              ; {27728}
    TXA                   ; {27730}
    XBA                   ; {27731}
    LSR                   ; {27732}
    LSR                   ; {27733}
    CLC                   ; {27734}
    ADC #$0041            ; {27735}
    ASL                   ; {27738}
    PHA                   ; {27739}
    SEP #$20              ; {27740}
    STA $M7A              ; {27742}
    XBA                   ; {27745}
    STA $M7A              ; {27746}
    LDA $@data_00F9F7.binary_00FCC4, X ; {27749}
    STA $M7B              ; {27753}
    STA $M7B              ; {27756}
    REP #$20              ; {27759}
    LDA $MPYM             ; {27761}
    STA $046E             ; {27764}
    STA $0474             ; {27767}
    PLA                   ; {27770}
    SEP #$20              ; {27771}
    STA $M7A              ; {27773}
    XBA                   ; {27776}
    STA $M7A              ; {27777}
    LDA $@data_00F9F7.binary_00FC84, X ; {27780}
    STA $M7B              ; {27784}
    STA $M7B              ; {27787}
    REP #$20              ; {27790}
    LDA $MPYM             ; {27792}
    STA $0470             ; {27795}
    EOR #$FFFF            ; {27798}
    INC                   ; {27801}
    STA $0472             ; {27802}
    SEP #$20              ; {27805}
    RTS                   ; {27807}
}

code_006CA0 {
    PHP                   ; {27808}
    SEP #$20              ; {27809}
    LDA $00               ; {27811}
    STA $M7A              ; {27813}
    LDA $01               ; {27816}
    STA $M7A              ; {27818}
    LDA $02               ; {27821}
    STA $M7B              ; {27823}
    STA $M7B              ; {27826}
    LDA $MPYL             ; {27829}
    STA $00               ; {27832}
    LDA $MPYM             ; {27834}
    STA $01               ; {27837}
    PLP                   ; {27839}
    RTS                   ; {27840}

  loc_006CC1:
    PHX                   ; {27841}
    JSL $@lib_01232B.code_01232B ; {27842}
    JSR $&code_006D4E     ; {27846}
    PLX                   ; {27849}
    COP [1B] ( &code_006CD0, #$0001 ) ; {27850}
}

code_006CD0 {
    PHX                   ; {27856}
    LDA $701FFE           ; {27857}
    CMP #$0004            ; {27861}
    BCC loc_006CDD        ; {27864}
    LDA #$0000            ; {27866}

  loc_006CDD:
    XBA                   ; {27869}
    CLC                   ; {27870}
    ADC #$0005            ; {27871}
    BRA loc_006CE7        ; {27874}

  loc_006CE4:
    LDA #$0005            ; {27876}

  loc_006CE7:
    JSL $@lib_0118FC_part2.code_0121E8 ; {27879}
    BCS loc_006CE4        ; {27883}
    AND #$00FF            ; {27885}
    CMP #$0004            ; {27888}
    BNE loc_006D20        ; {27891}
    LDA #$03FF            ; {27893}
    STA $7F0006           ; {27896}
    LDA #$0004            ; {27900}
    JSL $@lib_0118FC_part2.code_0121E8 ; {27903}
    BCS loc_006D14        ; {27907}
    AND #$00FF            ; {27909}
    XBA                   ; {27912}
    ASL                   ; {27913}
    ASL                   ; {27914}
    TAX                   ; {27915}
    STA $700000, X        ; {27916}
    STA $701000, X        ; {27920}

  loc_006D14:
    LDA #$7FFF            ; {27924}
    STA $7F0006           ; {27927}
    JSR $&code_006D4E     ; {27931}
    BRA loc_006CE4        ; {27934}

  loc_006D20:
    STA $03A4             ; {27936}
    JSL $@lib_027132.code_027132 ; {27939}
    PLX                   ; {27943}
    LDA #$0001            ; {27944}
    BCS loc_006D30        ; {27947}
    LDA $1B90             ; {27949}

  loc_006D30:
    STA $scene_next       ; {27952}
    LDA #$0001            ; {27955}
    STA $warp_dest_anim   ; {27958}
    LDA #$0070            ; {27961}
    STA $warp_dest_x      ; {27964}
    LDA #$0060            ; {27967}
    STA $warp_dest_y      ; {27970}
    STZ $0445             ; {27973}
    INC $0454             ; {27976}
    COP [91]              ; {27979}
    RTL                   ; {27981}
}

code_006D4E {
    LDY #$&lib_0143B0.asciistring_0143B0 ; {27982}
    JSL $@lib_shared_012769.code_012769 ; {27985}
    STZ $03A4             ; {27989}
    LDX #$0000            ; {27992}
    LDY #$&lib_01440D.binary_01440D ; {27995}
    LDA #$0000            ; {27998}
    PHA                   ; {28001}

  loc_006D62:
    JSL $@lib_shared_02716E.code_02716E ; {28002}
    LDA $16               ; {28006}
    CMP $7003FA, X        ; {28008}
    BNE loc_006D8B        ; {28012}
    LDA $18               ; {28014}
    CMP $7003FC, X        ; {28016}
    BNE loc_006D8B        ; {28020}
    PHX                   ; {28022}
    PHY                   ; {28023}
    PHB                   ; {28024}
    TXY                   ; {28025}
    TYA                   ; {28026}
    CLC                   ; {28027}
    ADC #$1000            ; {28028}
    TAY                   ; {28031}
    LDA #$03FD            ; {28032}
    MVN #$70, #$70        ; {28035}
    PLB                   ; {28038}
    PLY                   ; {28039}
    PLX                   ; {28040}
    BRA loc_006DB2        ; {28041}

  loc_006D8B:
    PHX                   ; {28043}
    PHY                   ; {28044}
    PHB                   ; {28045}
    TXY                   ; {28046}
    TXA                   ; {28047}
    CLC                   ; {28048}
    ADC #$1000            ; {28049}
    TAX                   ; {28052}
    LDA #$03FD            ; {28053}
    MVN #$70, #$70        ; {28056}
    PLB                   ; {28059}
    PLY                   ; {28060}
    PLX                   ; {28061}
    JSL $@lib_shared_02716E.code_02716E ; {28062}
    LDA $16               ; {28066}
    CMP $7003FA, X        ; {28068}
    BNE loc_006E06        ; {28072}
    LDA $18               ; {28074}
    CMP $7003FC, X        ; {28076}
    BNE loc_006E06        ; {28080}

  loc_006DB2:
    PHY                   ; {28082}
    PHX                   ; {28083}
    TXA                   ; {28084}
    SEC                   ; {28085}
    SBC #$1A5E            ; {28086}
    PHA                   ; {28089}
    CLC                   ; {28090}
    ADC #$1B92            ; {28091}
    TAX                   ; {28094}
    LDA $700200, X        ; {28095}
    STA $0447             ; {28099}
    LDA $700202, X        ; {28102}
    STA $0449             ; {28106}
    LDA $700204, X        ; {28109}
    STA $044B             ; {28113}
    LDA $700206, X        ; {28116}
    STA $044D             ; {28120}
    LDA $700207, X        ; {28123}
    STA $044E             ; {28127}
    LDA $01, S            ; {28130}
    CLC                   ; {28132}
    ADC #$1B6A            ; {28133}
    TAX                   ; {28136}
    LDA $700200, X        ; {28137}
    STA $0450             ; {28141}
    PLA                   ; {28144}
    CLC                   ; {28145}
    ADC #$1B90            ; {28146}
    TAX                   ; {28149}
    LDA $700200, X        ; {28150}
    STA $0452             ; {28154}
    JSL $@lib_shared_012769.code_012769 ; {28157}
    PLX                   ; {28161}
    PLY                   ; {28162}
    PLA                   ; {28163}
    INC                   ; {28164}
    PHA                   ; {28165}

  loc_006E06:
    INC $03A4             ; {28166}
    TXA                   ; {28169}
    CLC                   ; {28170}
    ADC #$0400            ; {28171}
    TAX                   ; {28174}
    TYA                   ; {28175}
    CLC                   ; {28176}
    ADC #$0014            ; {28177}
    TAY                   ; {28180}
    CPX #$1000            ; {28181}
    BEQ loc_006E1D        ; {28184}
    BRL loc_006D62        ; {28186}

  loc_006E1D:
    STZ $03A4             ; {28189}
    PLA                   ; {28192}
    BNE loc_006E27        ; {28193}
    STA $701FFE           ; {28195}

  loc_006E27:
    RTS                   ; {28199}
}