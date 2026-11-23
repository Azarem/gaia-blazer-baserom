?BANK 03

?INCLUDE 'gv_underground_castle_actors'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'

!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384

---------------------------------------------

code_01A3B0 {
    COP [14] ( #$0022, &code_01A3B7 )
    RTL 
}

code_01A3B7 {
    COP [17] ( &code_01A3D5 )
    COP [15]

  loc_01A3BD:
    COP [80] ( #1E )
    COP [82]
    BRL loc_01A3BD

  code_01A3C5:
    COP [AC] ( @code_01AD42, #$0070, #$0080, #$0050 )
    BRK #$1C
    BRL loc_01A3BD
}

code_01A3D5 {
    COP [01] ( &asciistring_01A3E6 )
    COP [17] ( &code_01A3E1 )
    COP [27] ( &code_01A3C5 )
}

code_01A3E1 {
    COP [01] ( &asciistring_01A420 )
    RTL 
}

asciistring_01A3E6 |[10]In my dreams I can [N]do anything I like-[N]For example---- [FIN]HA! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A420 |[10]Why don t you try and [N]talk to the jewelry? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01AD42 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01AD56 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01AD56 {
    COP [01] ( &asciistring_01AD5D )
    BRL gv_underground_castle_actors.code_01AD1B
}

asciistring_01AD5D |[10]The monsters running [N]all over in Dr-Leo s [N]paintings [FIN]cannot be defeated [N]unless you have a [N]special sword- [FIN]You must find the [N]special sword that can[N]destroy metal- [FIN]Return here once you [N]have found the sword- [FIN][END]|
---------------------------------------------

code_01B21A {
    LDA $0000, X
    SEC 
    SBC #$0008
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    SEC 
    SBC #$0008
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}
---------------------------------------------

code_01B273 {
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^binary_01B284
    LDY #$&binary_01B284
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

binary_01B284 #07F20CF10CF00CEF0CEE0CED0CEC0CEB0CEA0CE90CE80CE70CE60CE50CE40CE30CE20CE10CE000