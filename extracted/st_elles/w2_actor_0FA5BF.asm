?BANK 1F

?INCLUDE 'lib_027462'

---------------------------------------------

code_0FA5BF {
    COP [07] ( #$8503, &code_0FA5D3 )
    LDA #$0047
    JSL $@lib_027462.code_027462
    BCS loc_0FA5CF
    RTL 

  loc_0FA5CF:
    COP [39] ( #04 )
    RTL 
}

code_0FA5D3 {
    COP [86]
    RTL 
}