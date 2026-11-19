?BANK 04

?INCLUDE 'w4_shared_023F33'

!joy_block_mask                 0326

---------------------------------------------

code_023B0B {
    LDA #$2F80            ; {146187}
    TSB $joy_block_mask   ; {146190}
    COP [03] ( #02 )      ; {146193}
    COP [04]              ; {146196}
    COP [34]              ; {146198}
    COP [03] ( #29 )      ; {146200}
    COP [04]              ; {146203}
    COP [01] ( &asciistring_023B65 ) ; {146205}
    COP [03] ( #15 )      ; {146209}
    COP [04]              ; {146212}
    COP [96]              ; {146214}
    COP [80] ( #23 )      ; {146216}
    COP [82]              ; {146219}
    COP [01] ( &asciistring_023B88 ) ; {146221}
    COP [09] ( #$8000 )   ; {146225}
    COP [05] ( #$0001 )   ; {146229}
    COP [01] ( &asciistring_023C8F ) ; {146233}
    COP [09] ( #$8002 )   ; {146237}
    COP [05] ( #$0003 )   ; {146241}
    COP [80] ( #1F )      ; {146245}
    COP [82]              ; {146248}
    COP [01] ( &asciistring_023D13 ) ; {146250}
    COP [09] ( #$8801 )   ; {146254}
    LDA #$2F80            ; {146258}
    TRB $joy_block_mask   ; {146261}
    COP [3C] ( #04 )      ; {146264}
    COP [10] ( #$020D, #01, #$0090, #$00A0 ) ; {146267}
    RTL                   ; {146276}
}

asciistring_023B65 |[10]Dr-Leo, King Magridd [N]wishes to see you at [N]once! [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023B88 |[10]Are you going to allow[N]him to make a deal [N]with Deathtoll? [FIN]King Magridd knows [N]nothing about the [N]value of human lives! [FIN]No matter how small, [N]all creatures have a [N]right to exist in this[N]world- [FIN]If the trees in this [N]world were cut in [N]half, [FIN]the oxygen would [N]decrease and many of [N]us would die- [FIN][10]We do what King [N]Magridd tells us to [N]do- [FIN]King Magridd makes all[N]of the decisions for [N]us- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023C8F |[10]Dr-Leo, you love your[N]daughter Lisa don t [N]you? [FIN]If you obey, she will [N]remain safe- [FIN]We will be waiting for[N]you outside in the [N]airship- [FIN]Come out when you are [N]ready- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023D13 |[10]Please forgive me! [FIN]The world will go to [N]ruin sooner or later- [FIN]But I can do nothing [N]more- [FIN]Oh, Master! Please [N]help me- [JMP:&w4_shared_023F33.asciistring_023FA3]|