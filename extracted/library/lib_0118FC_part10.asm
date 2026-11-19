?BANK 02

---------------------------------------------

code_013215 {
    STZ $0000, X
    STZ $0001, X

  loc_01321B:
    CMP #$64
    BCC loc_013227
    SEC 
    SBC #$64
    INC $0001, X
    BRA loc_01321B

  loc_013227:
    CMP #$0A
    BCC loc_013233
    SEC 
    SBC #$0A
    INC $0000, X
    BRA loc_013227

  loc_013233:
    ASL $0000, X
    ASL $0000, X
    ASL $0000, X
    ASL $0000, X
    ORA $0000, X
    STA $0000, X
    RTL 
}