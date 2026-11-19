?BANK 1F

?INCLUDE 'common_actor_004659_part1'

!rng_state                      0301

---------------------------------------------

code_0FB9D6 {
    COP [AD] ( #08 )      ; {1030614}
    COP [9B] ( #$0000, &code_0FB9E3, &code_0FBA01, &code_0FBA01 ) ; {1030617}
}

code_0FB9E3 {
    COP [97]              ; {1030627}
    COP [9B] ( #$0018, &code_0FB9EF, &code_0FBA68, &code_0FB9EF ) ; {1030629}
}

code_0FB9EF {
    COP [21] ( &code_0FB9FA ) ; {1030639}
    COP [80] ( #23 )      ; {1030643}
    COP [82]              ; {1030646}
    BRA code_0FB9D6       ; {1030648}
}

code_0FB9FA {
    COP [80] ( #20 )      ; {1030650}
    COP [82]              ; {1030653}
    BRA code_0FB9D6       ; {1030655}
}

code_0FBA01 {
    COP [97]              ; {1030657}
    COP [9B] ( #$0018, &code_0FBA0D, &code_0FBA68, &code_0FBA0D ) ; {1030659}
}

code_0FBA0D {
    COP [22] ( &code_0FBA18 ) ; {1030669}
    COP [80] ( #22 )      ; {1030673}
    COP [82]              ; {1030676}
    BRA code_0FB9D6       ; {1030678}
}

code_0FBA18 {
    COP [80] ( #1F )      ; {1030680}
    COP [82]              ; {1030683}
    BRA code_0FB9D6       ; {1030685}

  loc_0FBA1F:
    COP [AD] ( #08 )      ; {1030687}
    COP [9A] ( #$0000, &code_0FBA2C, &code_0FBA4A, &code_0FBA4A ) ; {1030690}
}

code_0FBA2C {
    COP [9A] ( #$0018, &code_0FBA36, &code_0FBA85, &code_0FBA36 ) ; {1030700}
}

code_0FBA36 {
    COP [97]              ; {1030710}
    COP [23] ( &code_0FBA43 ) ; {1030712}
    COP [80] ( #24 )      ; {1030716}
    COP [82]              ; {1030719}
    BRA loc_0FBA1F        ; {1030721}
}

code_0FBA43 {
    COP [80] ( #21 )      ; {1030723}
    COP [82]              ; {1030726}
    BRA loc_0FBA1F        ; {1030728}
}

code_0FBA4A {
    COP [9A] ( #$0018, &code_0FBA54, &code_0FBA85, &code_0FBA54 ) ; {1030730}
}

code_0FBA54 {
    COP [96]              ; {1030740}
    COP [24] ( &code_0FBA61 ) ; {1030742}
    COP [80] ( #24 )      ; {1030746}
    COP [82]              ; {1030749}
    BRA loc_0FBA1F        ; {1030751}
}

code_0FBA61 {
    COP [80] ( #21 )      ; {1030753}
    COP [82]              ; {1030756}
    BRA loc_0FBA1F        ; {1030758}
}

code_0FBA68 {
    COP [1F]              ; {1030760}
    LDA $rng_state+1      ; {1030762}
    AND #$0003            ; {1030765}
    BNE loc_0FBA1F        ; {1030768}
    COP [80] ( #1F )      ; {1030770}
    COP [82]              ; {1030773}
    COP [B0] ( @code_0FBAA6, #$0200 ) ; {1030775}
    COP [80] ( #1F )      ; {1030782}
    COP [82]              ; {1030785}
    BRA loc_0FBA1F        ; {1030787}
}

code_0FBA85 {
    COP [1F]              ; {1030789}
    LDA $rng_state+1      ; {1030791}
    AND #$0003            ; {1030794}
    BEQ loc_0FBA92        ; {1030797}
    BRL code_0FB9D6       ; {1030799}

  loc_0FBA92:
    COP [80] ( #1F )      ; {1030802}
    COP [82]              ; {1030805}
    COP [B0] ( @code_0FBAA6, #$0200 ) ; {1030807}
    COP [80] ( #1F )      ; {1030814}
    COP [82]              ; {1030817}
    BRL code_0FB9D6       ; {1030819}
}

code_0FBAA6 {
    COP [A3]              ; {1030822}
    COP [A2] ( #30 )      ; {1030824}
    BRK #$64              ; {1030827}
    LDY #$0028            ; {1030829}
    SEP #$20              ; {1030832}
    LDA #$^common_actor_004659_part1.code_002D67 ; {1030834}
    PHA                   ; {1030836}
    REP #$20              ; {1030837}
    LDA #$&common_actor_004659_part1.code_002D67-1 ; {1030839}
    PHA                   ; {1030842}
    RTL                   ; {1030843}
}