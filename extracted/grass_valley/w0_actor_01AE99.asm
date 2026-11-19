?BANK 03

?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322
!player_actor                   039C

---------------------------------------------

code_01AE99 {
    COP [A0] ( #$0002 )

  loc_01AE9D:
    COP [91]
    COP [07] ( #$8404, &code_01AEAD )
    COP [0D] ( #00, #47, #38, &code_01AEFA )
    RTL 
}

code_01AEAD {
    LDY $player_actor
    LDA $0000, Y
    CMP #$04B0
    BCC code_01AEC0
    COP [A0] ( #$FFB0 )
    COP [27] ( &code_01AEDD )

  code_01AEC0:
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AECA )
    RTL 
}

code_01AECA {
    LDA $joy_pressed
    AND #$0800
    BNE loc_01AED3
    RTL 

  loc_01AED3:
    COP [81] ( #2A, #14 )
    COP [83]
    COP [27] ( &code_01AEDD )
}

code_01AEDD {
    COP [91]
    COP [0D] ( #00, #47, #33, &code_01AEE7 )
    RTL 
}

code_01AEE7 {
    LDA $joy_pressed
    AND #$0400
    BNE loc_01AEF0
    RTL 

  loc_01AEF0:
    COP [81] ( #2C, #14 )
    COP [83]
    COP [27] ( &code_01AEC0 )
}

code_01AEFA {
    COP [01] ( &asciistring_01AF0A )
    COP [91]
    COP [0D] ( #00, #47, #38, &code_01AF09 )
    BRA loc_01AE9D
}

code_01AF09 {
    RTL 
}

asciistring_01AF0A |[10]I am an elevator [N]invented by Dr-Leo- [FIN]I cannot move unless [N]the water mill is [N]turning- [JMP:&w0_shared_01B988.asciistring_01B988]|