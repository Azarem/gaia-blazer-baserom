?BANK 1F

---------------------------------------------

code_0FB0D6 {
    COP [A2] ( #00 )
    COP [A4]
    COP [A5] ( &code_0FB0E5, &code_0FB0ED, &code_0FB0ED, &code_0FB0ED )
}

code_0FB0E5 {
    COP [81] ( #2C, #FF )
    COP [83]
    BRA code_0FB0E5
}

code_0FB0ED {
    COP [81] ( #2D, #FF )
    COP [83]
    BRA code_0FB0ED
}