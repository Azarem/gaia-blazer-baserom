?BANK 02

?INCLUDE 'lib_0118FC_part12'
?INCLUDE 'lib_0275ED'
?INCLUDE 'lib_027614'
?INCLUDE 'lib_shared_012769'

!location_id                    1C6A

---------------------------------------------

code_012659 {
    LDA $location_id
    SEC 
    SBC #$0F
    CMP #$04
    BCS loc_012666
    BRL loc_0126CB

  loc_012666:
    LDA $0330
    BEQ loc_012675
    BPL loc_01267C
    DEC 
    BMI loc_012682
    LDY #$&lib_0118FC_part12.asciistring_01476F
    BRA loc_012678

  loc_012675:
    LDY #$&lib_0118FC_part12.asciistring_014766

  loc_012678:
    JSL $@lib_shared_012769.code_012769

  loc_01267C:
    DEC $0330
    DEC $0330

  loc_012682:
    JSL $@lib_0275ED.code_0275ED
    JSL $@lib_027614.code_027614
    LDA $0332
    BEQ loc_0126CB
    LSR $0332
    BCC loc_01269B
    LDY #$&lib_0118FC_part12.asciistring_01470E
    JSL $@lib_shared_012769.code_012769

  loc_01269B:
    LSR $0332
    BCC loc_0126A7
    LDY #$&lib_0118FC_part12.asciistring_014739
    JSL $@lib_shared_012769.code_012769

  loc_0126A7:
    LSR $0332
    BCC loc_0126B3
    LDY #$&lib_0118FC_part12.asciistring_014744
    JSL $@lib_shared_012769.code_012769

  loc_0126B3:
    LSR $0332
    BCC loc_0126BF
    LDY #$&lib_0118FC_part12.asciistring_014750
    JSL $@lib_shared_012769.code_012769

  loc_0126BF:
    LSR $0332
    BCC loc_0126CB
    LDY #$&lib_0118FC_part12.asciistring_01475B
    JSL $@lib_shared_012769.code_012769

  loc_0126CB:
    STZ $0332
    RTL 
}