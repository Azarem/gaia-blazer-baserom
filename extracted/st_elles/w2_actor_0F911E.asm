?BANK 1F

?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326
!return_active                  03FB

---------------------------------------------

code_0F911E {
    COP [14] ( #$00B6, &code_0F9125 )
    RTL 
}

code_0F9125 {
    COP [30] ( #$00B6, &code_0F922E, #1F )
    COP [9F] ( #$0008 )
    COP [07] ( #$9F02, &code_0F913F )
    COP [15]
    COP [17] ( &code_0F9215 )
    COP [91]
    RTL 
}

code_0F913F {
    COP [11] ( #0D, #00, #C9 )
    COP [11] ( #1A, #00, #C9 )
    LDA #$FF80
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F9416 )
    COP [AC] ( @code_0F91AA, #$0200, #$0100, #$0050 )
    COP [05] ( #$0000 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F953B )
    COP [03] ( #79 )
    COP [04]
    COP [AC] ( @code_0F91E2, #$0200, #$0100, #$0050 )
    COP [05] ( #$0001 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F95CE )
    COP [03] ( #79 )
    COP [04]
    LDA #$0020
    STA $03B4
    COP [10] ( #$0104, #01, #$0120, #$02E0 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F91AA {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #06 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8000 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F91E2 {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #05 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F9215 {
    COP [07] ( #$9B02, &code_0F9229 )
    COP [01] ( &asciistring_0F9252 )
    BRK #$5E
    COP [0A] ( #3C )
    COP [09] ( #$9B02 )
    RTL 
}

code_0F9229 {
    COP [01] ( &asciistring_0F938C )
    RTL 
}

code_0F922E {
    LDA #$FFFF
    STA $return_active
    COP [14] ( #$00BD, &code_0F9242 )
    COP [14] ( #$0092, &code_0F9242 )
    BRA loc_0F9246
}

code_0F9242 {
    COP [01] ( &asciistring_0F9390 )

  loc_0F9246:
    COP [01] ( &asciistring_0F939F )
    COP [37]
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_0F9252 |[10]I have heard about you[N]from Lue- [FIN]You are the one who [N]saved me- [FIN]Everything started [N]when I saw the jewel [N]that Lue had- [FIN]One glance at the Blue[N]Stone caused desire [N]and hatred to [N]overwhelm me- [FIN]Right after that the [N]creatures disappeared [N]and the monsters took [N]over- [FIN]Maybe because we let [N]bad feeling dominate [N]us we created the [N]monsters ourselves- [FIN]I will give you [03:24]the [N]Blue Stone- [FIN][03:20][::]Please travel to other[N]regions and release [N]all creatures- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F938C |[10][JMP:&asciistring_0F9252+M]|

asciistring_0F9390 |[10][0E:1E]Queen! [0E:3C][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F939F |[10][0E:3C]A beautiful voice came[N]from inside the [N]palace- [FIN]I am the Mermaid [N]Queen- [FIN]I know not who you [N]are, but thank you for[N]releasing me- [FIN]Please return to the [N]palace- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F9416 |[10][0F][02:2], [N]thank you very much! [N][0E:3C]Peace has returned [N]here, to St-Elles- [N][0E:5A]The dolphin, Lue, used[N]to live with Dr-Leo- [N][0E:5A]It s strange, whenever[N]he tells me about Dr- [N]Leo and his daughter [N]Lisa- [N][0E:2D]I miss them and [N]sometimes find myself [N]crying- [N][0E:5A]Now Dr-Leo is gone, [N][0E:1E]Lisa must be very [N]lonely- [N][0E:5A]Oh, here comes Lue- He[N]must have heard your [N]voice- [N][0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F953B |[10][0F]Phew! [N][0E:5A][02:2], [N]why did you not visit [N]me? [N][0E:5A]I decided to return to[N]my home town along [N]with my friends- [N][0E:5A]To tell you the truth,[N][0E:28]I am to be married- [N][0E:50]Hey Lala, come in [N]here! [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|

asciistring_0F95CE |[10][0F]Don t you think she is[N]beautiful- [N][0E:5A]We will be happy [N]together- [N][0E:5A][02:2], [N]I wish you luck- [0E:78][JMP:&w2_shared_0FA945.asciistring_0FAA44+M]|