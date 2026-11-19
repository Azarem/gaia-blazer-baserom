?BANK 02

?INCLUDE 'lib_shared_0131B7'

---------------------------------------------

code_0131C9 {
    JSL $@lib_shared_0131B7.code_0131B7 ; {78281}
    DEC                   ; {78285}
    BNE code_0131C9       ; {78286}
    RTL                   ; {78288}
}