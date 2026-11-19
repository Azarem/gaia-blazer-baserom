?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D6AB {
    COP [14] ( #$0049, &code_01D6B2 ) ; {120491}
    RTL                   ; {120497}
}

code_01D6B2 {
    COP [85] ( @code_01D803 ) ; {120498}
    COP [17] ( &code_01D6D0 ) ; {120503}
    COP [15]              ; {120507}
    COP [91]              ; {120509}
    COP [07] ( #$8303, &code_01D6C6 ) ; {120511}
    RTL                   ; {120517}
}

code_01D6C6 {
    COP [16]              ; {120518}
    COP [85] ( @engine_0026F3.code_00299D ) ; {120520}
    COP [86]              ; {120525}
    RTL                   ; {120527}
}

code_01D6D0 {
    COP [01] ( &asciistring_01D6F9 ) ; {120528}
    SEP #$20              ; {120532}
    LDA $1B82             ; {120534}
    ORA #$02              ; {120537}
    STA $1B82             ; {120539}
    REP #$20              ; {120542}
    COP [09] ( #$8303 )   ; {120544}
    BRK #$4E              ; {120548}
    COP [14] ( #$004F, &code_01D6EE ) ; {120550}
    BRA loc_01D6F4        ; {120556}
}

code_01D6EE {
    COP [14] ( #$0051, &code_01D6F8 ) ; {120558}

  loc_01D6F4:
    COP [01] ( &asciistring_01D7A2 ) ; {120564}
}

code_01D6F8 {
    RTL                   ; {120568}
}

asciistring_01D6F9 |[10]Even though I [N]don t look like it, [N]I am from the sky [N]just like you- [FIN]I light up the [N]darkness- [N]You cheer up everyone-[FIN]Let s work together to[N]revive the world- [FIN]The creature who [N]lights up darkness [N]joined [02:2]! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D7A2 |[10][0E:3C]By the way why don t [N]we go to the second [N]basement of the Water [N]Shrine? [FIN]You will now be able [N]to see monsters which [N]you could not see [N]without me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01D803 {
    COP [07] ( #$0304, &code_01D80C ) ; {120835}
    COP [86]              ; {120841}
    RTL                   ; {120843}
}

code_01D80C {
    COP [91]              ; {120844}
    COP [0D] ( #00, #19, #19, &code_01D816 ) ; {120846}
    RTL                   ; {120853}
}

code_01D816 {
    COP [01] ( &asciistring_01D826 ) ; {120854}
    BRK #$5E              ; {120858}
    COP [0A] ( #1E )      ; {120860}
    COP [09] ( #$8304 )   ; {120863}
    COP [91]              ; {120867}
    RTL                   ; {120869}
}

asciistring_01D826 |[10][03:24]The leaves of [N]GreenWood [03:20]are found [N]under the dog bones! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|