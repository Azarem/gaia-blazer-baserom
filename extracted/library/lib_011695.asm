?BANK 02

?INCLUDE 'lib_01186E'

!location_id                    1C6A

---------------------------------------------

code_011695 {
    LDA $location_id
    SEC 
    SBC #$10
    CMP #$03
    BCS loc_0116A0
    RTL 

  loc_0116A0:
    LDA #$12
    XBA 
    LDA #$^binary_0116AD
    LDY #$&binary_0116AD
    JSL $@lib_01186E.code_01188A
    RTL 
}
---------------------------------------------

binary_0116AD #14FCFF0C00000C040001030001020001010001000000