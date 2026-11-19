?BANK 00

?INCLUDE 'engine_007A52'
?INCLUDE 'lib_014F02'
?INCLUDE 'lib_014F23'
?INCLUDE 'lib_014F43'
?INCLUDE 'lib_0270E4'

!L_choice_result                0003D0
!scene_next                     0318
!joy_block_mask                 0326
!warp_dest_x                    037C
!warp_dest_y                    037E

---------------------------------------------

code_00766C {
    COP [37]              ; {30316}

  code_00766E:
    COP [91]              ; {30318}
    COP [0D] ( #00, #07, #04, &code_00767F ) ; {30320}
    COP [0D] ( #00, #07, #06, &code_007765 ) ; {30327}
    RTL                   ; {30334}
}

code_00767F {
    COP [01] ( &asciistring_0077B0 ) ; {30335}
    COP [07] ( #$9B00, &code_00769C ) ; {30339}
    COP [1A] ( &lib_014F43.asciistring_014F43, #02, &code_007754 ) ; {30345}
    LDA $L_choice_result  ; {30352}
    BNE loc_007699        ; {30356}
    BRL code_0076EF       ; {30358}

  loc_007699:
    BRL code_007754       ; {30361}
}

code_00769C {
    COP [1A] ( &lib_014F23.asciistring_014F23, #03, &code_007754 ) ; {30364}
    LDA $L_choice_result  ; {30371}
    BNE loc_0076AC        ; {30375}
    BRL code_0076EF       ; {30377}

  loc_0076AC:
    DEC                   ; {30380}
    BEQ loc_0076B2        ; {30381}
    BRL code_007754       ; {30383}

  loc_0076B2:
    COP [01] ( &asciistring_007866 ) ; {30386}
    PHX                   ; {30390}
    LDA #$0009            ; {30391}
    STA $scene_next       ; {30394}
    LDA $03BA             ; {30397}
    ASL                   ; {30400}
    ASL                   ; {30401}
    TAX                   ; {30402}
    LDA $@data_0076D3, X  ; {30403}
    STA $warp_dest_x      ; {30407}
    LDA $@data_0076D3+2, X ; {30410}
    STA $warp_dest_y      ; {30414}
    PLX                   ; {30417}
    RTL                   ; {30418}
}
---------------------------------------------

data_0076D3 [
  unk4 < #$0070, #$00A0 >   ;00
  unk4 < #$0030, #$0160 >   ;01
  unk4 < #$00F0, #$0160 >   ;02
  unk4 < #$00F0, #$0060 >   ;03
  unk4 < #$01B0, #$0140 >   ;04
  unk4 < #$0170, #$0060 >   ;05
  unk4 < #$00F0, #$0020 >   ;06
]
---------------------------------------------

code_0076EF {
    COP [01] ( &asciistring_0077D4 ) ; {30447}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_007754 ) ; {30451}
    LDA $L_choice_result  ; {30458}
    DEC                   ; {30462}
    BEQ code_007754       ; {30463}
    BRK #$66              ; {30465}
    PHX                   ; {30467}
    JSL $@lib_0270E4.code_0270E4 ; {30468}
    PLX                   ; {30472}
    LDA #$7FC0            ; {30473}
    TSB $joy_block_mask   ; {30476}
    COP [03] ( #3D )      ; {30479}
    COP [04]              ; {30482}
    LDA #$7FC0            ; {30484}
    TRB $joy_block_mask   ; {30487}
    COP [01] ( &asciistring_0077FA ) ; {30490}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_007754 ) ; {30494}
    LDA $L_choice_result  ; {30501}
    BEQ code_007754       ; {30505}
    COP [01] ( &asciistring_007825 ) ; {30507}
    LDA #$7F80            ; {30511}
    TSB $joy_block_mask   ; {30514}
    COP [03] ( #1F )      ; {30517}
    COP [04]              ; {30520}
    BRK #$8E              ; {30522}
    COP [AC] ( @code_007798, #$0070, #$0050, #$0050 ) ; {30524}
    COP [34]              ; {30535}
    COP [03] ( #3D )      ; {30537}
    COP [04]              ; {30540}
    COP [31] ( #13 )      ; {30542}
    COP [91]              ; {30545}
    RTL                   ; {30547}
}

code_007754 {
    COP [01] ( &asciistring_007848 ) ; {30548}
    COP [91]              ; {30552}
    COP [0D] ( #00, #07, #04, &code_007764 ) ; {30554}
    BRL code_00766E       ; {30561}
}

code_007764 {
    RTL                   ; {30564}
}

code_007765 {
    LDA $043F             ; {30565}
    BEQ loc_00777B        ; {30568}
    STZ $043F             ; {30570}
    COP [1B] ( &code_007773, #$0002 ) ; {30573}
}

code_007773 {
    COP [01] ( &asciistring_00786A ) ; {30579}
    COP [27] ( &code_00766E ) ; {30583}

  loc_00777B:
    COP [07] ( #$8602, &code_007794 ) ; {30587}
    COP [07] ( #$1B00, &code_007794 ) ; {30593}
    COP [03] ( #03 )      ; {30599}
    COP [04]              ; {30602}
    COP [09] ( #$8602 )   ; {30604}
    COP [01] ( &asciistring_0078BB ) ; {30608}
}

code_007794 {
    COP [27] ( &code_00766E ) ; {30612}
}

code_007798 {
    COP [A8] ( #$8000, #0E ) ; {30616}
    LDA $0372             ; {30621}
    STA $001C, X          ; {30624}
    COP [A3]              ; {30627}
    COP [A2] ( #30 )      ; {30629}
    COP [80] ( #02 )      ; {30632}
    COP [82]              ; {30635}
    COP [86]              ; {30637}
    RTL                   ; {30639}
}

asciistring_0077B0 |[10]A voice came from [N]above- [FIN][JMP:&asciistring_0077C1+M]|

asciistring_0077C1 |[10][::][02:2], [N]how can I help you? [END]|

asciistring_0077D4 |I will record all [N]you have accomplished-[N]Is this okay? [END]|

asciistring_0077FA |Finished recording- [FIN]Do you wish to [N]continue? [END]|

asciistring_007825 |Rest well, there is [N]still much to be done-[JMP:&engine_007A52.asciistring_007A52]|

asciistring_007848 |[02:2][N]you are doing well- [N]Do not give up- [JMP:&engine_007A52.asciistring_007A52]|

asciistring_007866 |[08:448][END]|

asciistring_00786A |[10]A voice came from [N]above- [FIN]"Do not rush, but be [N]patient- You must [N]continue making steady[N]progress-ˮ [JMP:&engine_007A52.asciistring_007A52]|

asciistring_0078BB |[10]A voice came from [N]above- [FIN]"The Brown Stone you [N]received is one of 6 [N]stones in this world- [FIN]When all six of these [N]stones are gathered, [FIN]the gate leading to [N]the World of Evil [N]shall be opened- [FIN]Now, you must go to [N]GreenWood where the [N]next stone awaits [N]you-ˮ [JMP:&engine_007A52.asciistring_007A52]|