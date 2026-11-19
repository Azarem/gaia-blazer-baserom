?BANK 1F

?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326
!return_active                  03FB

---------------------------------------------

code_0F911E {
    COP [14] ( #$00B6, &code_0F9125 ) ; {1020190}
    RTL                   ; {1020196}
}

code_0F9125 {
    COP [30] ( #$00B6, &code_0F922E, #1F ) ; {1020197}
    COP [9F] ( #$0008 )   ; {1020204}
    COP [07] ( #$9F02, &code_0F913F ) ; {1020208}
    COP [15]              ; {1020214}
    COP [17] ( &code_0F9215 ) ; {1020216}
    COP [91]              ; {1020220}
    RTL                   ; {1020222}
}

code_0F913F {
    COP [11] ( #0D, #00, #C9 ) ; {1020223}
    COP [11] ( #1A, #00, #C9 ) ; {1020228}
    LDA #$FF80            ; {1020233}
    TSB $joy_block_mask   ; {1020236}
    COP [03] ( #29 )      ; {1020239}
    COP [04]              ; {1020242}
    COP [01] ( &asciistring_0F9416 ) ; {1020244}
    COP [AC] ( @code_0F91AA, #$0200, #$0100, #$0050 ) ; {1020248}
    COP [05] ( #$0000 )   ; {1020259}
    COP [03] ( #29 )      ; {1020263}
    COP [04]              ; {1020266}
    COP [01] ( &asciistring_0F953B ) ; {1020268}
    COP [03] ( #79 )      ; {1020272}
    COP [04]              ; {1020275}
    COP [AC] ( @code_0F91E2, #$0200, #$0100, #$0050 ) ; {1020277}
    COP [05] ( #$0001 )   ; {1020288}
    COP [03] ( #29 )      ; {1020292}
    COP [04]              ; {1020295}
    COP [01] ( &asciistring_0F95CE ) ; {1020297}
    COP [03] ( #79 )      ; {1020301}
    COP [04]              ; {1020304}
    LDA #$0020            ; {1020306}
    STA $03B4             ; {1020309}
    COP [10] ( #$0104, #01, #$0120, #$02E0 ) ; {1020312}
    LDA #$BFC0            ; {1020321}
    TRB $joy_block_mask   ; {1020324}
    COP [91]              ; {1020327}
    RTL                   ; {1020329}
}

code_0F91AA {
    COP [81] ( #0D, #04 ) ; {1020330}
    COP [83]              ; {1020334}
    COP [9F] ( #$FFF8 )   ; {1020336}
    COP [96]              ; {1020340}
    COP [81] ( #0E, #02 ) ; {1020342}
    COP [83]              ; {1020346}
    COP [9F] ( #$0008 )   ; {1020348}
    COP [97]              ; {1020352}
    COP [81] ( #0D, #06 ) ; {1020354}
    COP [83]              ; {1020358}
    COP [9F] ( #$FFF8 )   ; {1020360}
    COP [80] ( #0E )      ; {1020364}
    COP [82]              ; {1020367}
    COP [80] ( #11 )      ; {1020369}
    COP [82]              ; {1020372}
    COP [09] ( #$8000 )   ; {1020374}
    COP [91]              ; {1020378}
    COP [80] ( #11 )      ; {1020380}
    COP [82]              ; {1020383}
    RTL                   ; {1020385}
}

code_0F91E2 {
    COP [81] ( #0D, #04 ) ; {1020386}
    COP [83]              ; {1020390}
    COP [9F] ( #$FFF8 )   ; {1020392}
    COP [96]              ; {1020396}
    COP [81] ( #0E, #02 ) ; {1020398}
    COP [83]              ; {1020402}
    COP [9F] ( #$0008 )   ; {1020404}
    COP [97]              ; {1020408}
    COP [81] ( #0D, #05 ) ; {1020410}
    COP [83]              ; {1020414}
    COP [9F] ( #$FFF8 )   ; {1020416}
    COP [80] ( #11 )      ; {1020420}
    COP [82]              ; {1020423}
    COP [09] ( #$8001 )   ; {1020425}
    COP [91]              ; {1020429}
    COP [80] ( #11 )      ; {1020431}
    COP [82]              ; {1020434}
    RTL                   ; {1020436}
}

code_0F9215 {
    COP [07] ( #$9B02, &code_0F9229 ) ; {1020437}
    COP [01] ( &asciistring_0F9252 ) ; {1020443}
    BRK #$5E              ; {1020447}
    COP [0A] ( #3C )      ; {1020449}
    COP [09] ( #$9B02 )   ; {1020452}
    RTL                   ; {1020456}
}

code_0F9229 {
    COP [01] ( &asciistring_0F938C ) ; {1020457}
    RTL                   ; {1020461}
}

code_0F922E {
    LDA #$FFFF            ; {1020462}
    STA $return_active    ; {1020465}
    COP [14] ( #$00BD, &code_0F9242 ) ; {1020468}
    COP [14] ( #$0092, &code_0F9242 ) ; {1020474}
    BRA loc_0F9246        ; {1020480}
}

code_0F9242 {
    COP [01] ( &asciistring_0F9390 ) ; {1020482}

  loc_0F9246:
    COP [01] ( &asciistring_0F939F ) ; {1020486}
    COP [37]              ; {1020490}
    STZ $return_active    ; {1020492}
    COP [86]              ; {1020495}
    RTL                   ; {1020497}
}

asciistring_0F9252 |[10]I have heard about you[N]from Lue- [FIN]You are the one who [N]saved me- [FIN]Everything started [N]when I saw the jewel [N]that Lue had- [FIN]One glance at the Blue[N]Stone caused desire [N]and hatred to [N]overwhelm me- [FIN]Right after that the [N]creatures disappeared [N]and the monsters took [N]over- [FIN]Maybe because we let [N]bad feeling dominate [N]us we created the [N]monsters ourselves- [FIN]I will give you [03:24]the [N]Blue Stone- [FIN][03:20][::]Please travel to other[N]regions and release [N]all creatures- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F938C |[10][JMP:&asciistring_0F9252+M]|

asciistring_0F9390 |[10][0E:1E]Queen! [0E:3C][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F939F |[10][0E:3C]A beautiful voice came[N]from inside the [N]palace- [FIN]I am the Mermaid [N]Queen- [FIN]I know not who you [N]are, but thank you for[N]releasing me- [FIN]Please return to the [N]palace- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9416 |[10][0F][02:2], [N]thank you very much! [N][0E:3C]Peace has returned [N]here, to St-Elles- [N][0E:5A]The dolphin, Lue, used[N]to live with Dr-Leo- [N][0E:5A]It s strange, whenever[N]he tells me about Dr- [N]Leo and his daughter [N]Lisa- [N][0E:2D]I miss them and [N]sometimes find myself [N]crying- [N][0E:5A]Now Dr-Leo is gone, [N][0E:1E]Lisa must be very [N]lonely- [N][0E:5A]Oh, here comes Lue- He[N]must have heard your [N]voice- [N][0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F953B |[10][0F]Phew! [N][0E:5A][02:2], [N]why did you not visit [N]me? [N][0E:5A]I decided to return to[N]my home town along [N]with my friends- [N][0E:5A]To tell you the truth,[N][0E:28]I am to be married- [N][0E:50]Hey Lala, come in [N]here! [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F95CE |[10][0F]Don t you think she is[N]beautiful- [N][0E:5A]We will be happy [N]together- [N][0E:5A][02:2], [N]I wish you luck- [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|