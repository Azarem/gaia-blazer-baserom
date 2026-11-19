?BANK 1F

---------------------------------------------

code_0FB0D6 {
    COP [A2] ( #00 )      ; {1028310}
    COP [A4]              ; {1028313}
    COP [A5] ( &code_0FB0E5, &code_0FB0ED, &code_0FB0ED, &code_0FB0ED ) ; {1028315}
}

code_0FB0E5 {
    COP [81] ( #2C, #FF ) ; {1028325}
    COP [83]              ; {1028329}
    BRA code_0FB0E5       ; {1028331}
}

code_0FB0ED {
    COP [81] ( #2D, #FF ) ; {1028333}
    COP [83]              ; {1028337}
    BRA code_0FB0ED       ; {1028339}
}