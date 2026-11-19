?BANK 02

?INCLUDE 'lib_shared_0131B7'

---------------------------------------------

code_0131C9 {
    JSL $@lib_shared_0131B7.code_0131B7
    DEC 
    BNE code_0131C9
    RTL 
}