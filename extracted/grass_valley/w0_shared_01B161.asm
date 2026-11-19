?BANK 03

?INCLUDE 'engine_000000'

---------------------------------------------

code_01B161 {
    COP [A8] ( #$8000, #0E )
    LDA #$0007
    STA $001E, X
    STZ $0020, X
    JSL $@engine_000000.code_0008F3
    LDA $0372
    STA $001C, X
    COP [15]
    RTL 
}
---------------------------------------------

code_01B17C {
    COP [2E] ( #00, #$0018, &code_01B18A )
    COP [80] ( #07 )
    COP [82]
    BRA code_01B17C
}

code_01B18A {
    COP [80] ( #0C )
    COP [82]
    BRA code_01B17C
}