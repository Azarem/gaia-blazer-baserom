?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_0143A4'
?INCLUDE 'lib_014F02'
?INCLUDE 'lib_shared_012769'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0
!joy_block_mask                 0326
!map_width_px                   0342
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!vram_upload_flags              03B8
!BG3SC                          2109
!TM                             212C
!coldata_buffer                 7F0200

---------------------------------------------

code_01B33A {
    REP #$20              ; {111418}
    LDA #$0059            ; {111420}
    STA $BG3SC            ; {111423}
    STZ $scroll_bg3_x     ; {111426}
    STZ $scroll_bg3_y     ; {111429}
    LDA #$3FC0            ; {111432}
    TSB $joy_block_mask   ; {111435}
    COP [0D] ( #00, #2F, #29, &code_01B38A ) ; {111438}
    LDA #$0007            ; {111445}
    STA $1B84             ; {111448}
    SEP #$20              ; {111451}
    LDA #$04              ; {111453}
    STA $TM               ; {111455}
    REP #$20              ; {111458}
    COP [03] ( #3D )      ; {111460}
    COP [04]              ; {111463}
    COP [01] ( &asciistring_01B52D ) ; {111465}
    COP [03] ( #79 )      ; {111469}
    COP [04]              ; {111472}
    STZ $0419             ; {111474}
    LDA #$0020            ; {111477}
    STA $03B4             ; {111480}
    COP [3C] ( #04 )      ; {111483}
    COP [10] ( #$0D00, #02, #$02F0, #$0290 ) ; {111486}
    COP [91]              ; {111495}
    RTL                   ; {111497}
}

code_01B38A {
    COP [91]              ; {111498}
    COP [34]              ; {111500}
    LDA #$0005            ; {111502}
    STA $1B84             ; {111505}
    COP [03] ( #3D )      ; {111508}
    COP [04]              ; {111511}
    COP [01] ( &asciistring_01B67F ) ; {111513}
    COP [03] ( #79 )      ; {111517}
    COP [04]              ; {111520}
    COP [AC] ( @engine_0026F3.code_00299D, #$02F0, #$02A0, #$0040 ) ; {111522}
    BRK #$96              ; {111533}
    COP [33]              ; {111535}
    LDA #$3FC0            ; {111537}
    TSB $joy_block_mask   ; {111540}
    COP [03] ( #1F )      ; {111543}
    COP [04]              ; {111546}
    COP [03] ( #02 )      ; {111548}
    LDA #$0003            ; {111551}
    LDY $player_actor     ; {111554}
    STA $001E, Y          ; {111557}
    COP [1B] ( &code_01B3CE, #$0010 ) ; {111560}
}

code_01B3CE {
    LDA #$0002            ; {111566}
    LDY $player_actor     ; {111569}
    STA $001E, Y          ; {111572}
    COP [1B] ( &code_01B3DD, #$0010 ) ; {111575}
}

code_01B3DD {
    COP [04]              ; {111581}
    COP [03] ( #5B )      ; {111583}
    COP [04]              ; {111586}
    COP [96]              ; {111588}
    COP [80] ( #25 )      ; {111590}
    COP [82]              ; {111593}
    COP [03] ( #3D )      ; {111595}
    COP [04]              ; {111598}
    COP [32] ( #11 )      ; {111600}
    COP [03] ( #3D )      ; {111603}
    COP [04]              ; {111606}
    COP [01] ( &asciistring_01B6C1 ) ; {111608}
    LDA #$0001            ; {111612}
    STA $1B84             ; {111615}
    COP [01] ( &asciistring_01B6C9 ) ; {111618}
    LDA #$0005            ; {111622}
    STA $1B84             ; {111625}
    COP [01] ( &asciistring_01B6D5 ) ; {111628}
    COP [03] ( #5B )      ; {111632}
    COP [04]              ; {111635}
    COP [01] ( &asciistring_01B6FF ) ; {111637}
    LDA #$3FC0            ; {111641}
    TRB $joy_block_mask   ; {111644}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01B438 ) ; {111647}
    LDA #$3FC0            ; {111654}
    TSB $joy_block_mask   ; {111657}
    LDA $L_choice_result  ; {111660}
    BNE code_01B438       ; {111664}
    COP [01] ( &asciistring_01B723 ) ; {111666}
    BRA loc_01B442        ; {111670}
}

code_01B438 {
    LDA #$3FC0            ; {111672}
    TSB $joy_block_mask   ; {111675}
    COP [01] ( &asciistring_01B73B ) ; {111678}

  loc_01B442:
    COP [03] ( #3D )      ; {111682}
    COP [04]              ; {111685}
    COP [01] ( &asciistring_01B880 ) ; {111687}
    COP [97]              ; {111691}
    COP [80] ( #25 )      ; {111693}
    COP [82]              ; {111696}
    COP [03] ( #29 )      ; {111698}
    COP [04]              ; {111701}
    COP [01] ( &asciistring_01B8CA ) ; {111703}
    LDA #$0002            ; {111707}
    STA $1B84             ; {111710}
    COP [01] ( &asciistring_01B8E8 ) ; {111713}
    LDA #$0005            ; {111717}
    STA $1B84             ; {111720}
    COP [96]              ; {111723}
    COP [80] ( #25 )      ; {111725}
    COP [82]              ; {111728}
    COP [03] ( #29 )      ; {111730}
    COP [04]              ; {111733}
    COP [01] ( &asciistring_01B8F8 ) ; {111735}
    LDA #$0380            ; {111739}
    STA $map_width_px     ; {111742}
    COP [81] ( #26, #04 ) ; {111745}
    COP [83]              ; {111749}
    COP [97]              ; {111751}
    COP [80] ( #25 )      ; {111753}
    COP [82]              ; {111756}
    COP [03] ( #1F )      ; {111758}
    COP [04]              ; {111761}
    COP [01] ( &asciistring_01B951 ) ; {111763}
    COP [96]              ; {111767}
    COP [80] ( #25 )      ; {111769}
    COP [82]              ; {111772}
    LDY $player_actor     ; {111774}
    LDA $0016, Y          ; {111777}
    AND #$EFFF            ; {111780}
    STA $0016, Y          ; {111783}
    LDA #$0100            ; {111786}
    STA $0468             ; {111789}
    COP [09] ( #$8000 )   ; {111792}
    COP [80] ( #26 )      ; {111796}
    COP [82]              ; {111799}
    LDA #$0000            ; {111801}
    STA $0468             ; {111804}
    COP [81] ( #26, #02 ) ; {111807}
    COP [83]              ; {111811}
    LDA #$0100            ; {111813}
    STA $0468             ; {111816}
    COP [81] ( #26, #08 ) ; {111819}
    COP [83]              ; {111823}
    COP [1B] ( &code_01B4D7, #$014A ) ; {111825}
}

code_01B4D7 {
    LDA #$0000            ; {111831}
    STA $0468             ; {111834}
    COP [85] ( @code_01B508 ) ; {111837}
    COP [03] ( #BF )      ; {111842}
    COP [04]              ; {111845}
    STZ $0030, X          ; {111847}
    COP [03] ( #20 )      ; {111850}
    SEP #$20              ; {111853}
    LDA $0030, X          ; {111855}
    ORA #$E0              ; {111858}
    STA $coldata_buffer   ; {111860}
    REP #$20              ; {111864}
    INC $0030, X          ; {111866}
    COP [1B] ( &code_01B503, #$0002 ) ; {111869}
}

code_01B503 {
    COP [04]              ; {111875}
    COP [91]              ; {111877}
    RTL                   ; {111879}
}

code_01B508 {
    LDA #$0002            ; {111880}
    TSB $vram_upload_flags ; {111883}
    COP [03] ( #02 )      ; {111886}
    COP [04]              ; {111889}
    LDA #$00FF            ; {111891}
    STA $scroll_bg3_x     ; {111894}
    PHX                   ; {111897}
    LDY #$&lib_0143A4.asciistring_0143A4 ; {111898}
    JSL $@lib_shared_012769.code_012769 ; {111901}
    PLX                   ; {111905}
    COP [03] ( #FF )      ; {111906}
    DEC $scroll_bg3_x     ; {111909}
    COP [04]              ; {111912}
    COP [91]              ; {111914}
    RTL                   ; {111916}
}

asciistring_01B52D |[10]My follower, [N][0E:28]tell me what is on [N]your mind- [N][0E:5A]I do not know what has[N]happened between you [N]and that girl- [N][0E:5A]However, being [N]attracted to a human [N]means that you have [N]not yet established [N]yourself as a heavenly[N]creature- [N][0E:5A]A year has now passed,[N]but your feelings have[N]not changed- [N][0E:5A]Maybe you should try [N]living as a human [N]being- [N]Learning how they [N]live- [N][0E:5A]Be warned though- Once[N]you go down to earth [N]you will lose all [N]memory- [N][0E:78][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B67F |[10]Hey, [0E:28]Turbo,[N][0E:5A]I feel something [N]strange in the air [N]today- [N][0E:3C]What s wrong with me? [N][0E:5A][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B6C1 |[10][02:2]? [0E:5A][END]|

asciistring_01B6C9 |Is that you? [0E:B4][END]|

asciistring_01B6D5 |Oh, my-----![N][0E:5A]I knew you would come [N]back! [N][0E:5A][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B6FF |[10]What is wrong? [N][0E:28]Don t you remember me?[END]|

asciistring_01B723 |No, I can t believe [N]this- [N][0E:78][JMP:&asciistring_01B73B+M]|

asciistring_01B73B |It s okay- [N][0E:28]You don t have to [N]worry-[N][0E:3C]I can tell by the look[N]in your eyes-[N][0E:5A][::]It s me, [N]Lisa----- [0E:28]Daughter of [N]Dr-Leo the inventor! [N][0E:5A]Please! [N][0E:28]Don t you remember me?[N][0E:B4]Well, okay- [N][0E:5A]You have never lied to[N]me- [N][0E:5A]It s just hard to [N]believe you lost all [N]your memory- [N][0E:5A]All right, I won t ask[N]you again- [N][0E:5A]I guess I have to [N]change my way of [N]thinking- [N][0E:5A]We can create many new[N]and wonderful memories[N]together! [N][0E:78][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B880 |[10]Okay, let me introduce[N]myself- [N][0E:5A]I am Lisa, [N][0E:5A]and the goat behind [N]me is Turbo- [N][0E:5A][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B8CA |[10]Come on Turbo, [N][0E:28]say "helloˮ- [N][0E:5A][END]|

asciistring_01B8E8 |[10]BLEEEET! [N][0E:5A][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B8F8 |[10]He looks like a dog I[N]used to have- [N][0E:5A]That is [N]why I call him Turbo- [N][0E:5A]Come, I will show you [N]around- [N][0E:78][JMP:&w0_shared_01B988.asciistring_01B988+M]|

asciistring_01B951 |[10]Hurry up Turbo! [0E:78][JMP:&w0_shared_01B988.asciistring_01B988+M]|