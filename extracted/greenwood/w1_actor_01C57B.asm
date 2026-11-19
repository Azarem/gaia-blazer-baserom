?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0
!joy_block_mask                 0326

---------------------------------------------

code_01C57B {
    COP [14] ( #$003C, &code_01C582 ) ; {116091}
    RTL                   ; {116097}
}

code_01C582 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {116098}
    COP [AC] ( @code_01C826, #$02B0, #$0200, #$2040 ) ; {116103}
    COP [17] ( &code_01C60A ) ; {116114}
    COP [15]              ; {116118}
    COP [91]              ; {116120}
    RTL                   ; {116122}
}

code_01C59B {
    COP [16]              ; {116123}
    COP [81] ( #11, #06 ) ; {116125}
    COP [83]              ; {116129}
    COP [9F] ( #$0008 )   ; {116131}
    COP [81] ( #0F, #04 ) ; {116135}
    COP [83]              ; {116139}
    COP [9F] ( #$FFF8 )   ; {116141}
    COP [80] ( #0E )      ; {116145}
    COP [82]              ; {116148}
    COP [17] ( &code_01C631 ) ; {116150}
    COP [15]              ; {116154}
    COP [91]              ; {116156}
    RTL                   ; {116158}
}

code_01C5BF {
    COP [16]              ; {116159}
    COP [17] ( &code_01C62C ) ; {116161}
    COP [81] ( #10, #07 ) ; {116165}
    COP [83]              ; {116169}
    COP [17] ( &code_01C639 ) ; {116171}
    COP [15]              ; {116175}
    COP [91]              ; {116177}
    RTL                   ; {116179}
}

code_01C5D4 {
    COP [17] ( #$0000 )   ; {116180}
    LDA #$2F80            ; {116184}
    TSB $joy_block_mask   ; {116187}
    COP [1B] ( &code_01C5E4, #$003C ) ; {116190}
}

code_01C5E4 {
    COP [01] ( &asciistring_01C782 ) ; {116196}
    COP [80] ( #0C )      ; {116200}
    COP [82]              ; {116203}
    COP [1B] ( &code_01C5F3, #$001E ) ; {116205}
}

code_01C5F3 {
    COP [81] ( #24, #04 ) ; {116211}
    COP [83]              ; {116215}
    COP [01] ( &asciistring_01C7DF ) ; {116217}
    LDA #$2F80            ; {116221}
    TRB $joy_block_mask   ; {116224}
    COP [17] ( &code_01C62C ) ; {116227}
    COP [91]              ; {116231}
    RTL                   ; {116233}
}

code_01C60A {
    COP [01] ( &asciistring_01C64D ) ; {116234}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01C627 ) ; {116238}
    LDA $L_choice_result  ; {116245}
    BNE code_01C627       ; {116249}
    COP [01] ( &asciistring_01C661 ) ; {116251}
    COP [17] ( &code_01C62C ) ; {116255}
    COP [27] ( &code_01C59B ) ; {116259}
}

code_01C627 {
    COP [01] ( &asciistring_01C675 ) ; {116263}
    RTL                   ; {116267}
}

code_01C62C {
    COP [01] ( &asciistring_01C683 ) ; {116268}
    RTL                   ; {116272}
}

code_01C631 {
    COP [01] ( &asciistring_01C6B6 ) ; {116273}
    COP [27] ( &code_01C5BF ) ; {116277}
}

code_01C639 {
    COP [14] ( #$004A, &code_01C645 ) ; {116281}
    COP [01] ( &asciistring_01C738 ) ; {116287}
    BRA loc_01C649        ; {116291}
}

code_01C645 {
    COP [01] ( &asciistring_01C6F6 ) ; {116293}

  loc_01C649:
    COP [27] ( &code_01C5D4 ) ; {116297}
}

asciistring_01C64D |[10]Please, come [N]take a walk with me- [END]|

asciistring_01C661 |All right, let s go! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C675 |Why not!? [N][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C683 |[10]I have as much fun [N]walking people as they[N]do walking me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C6B6 |[10]The island over there [N]is a graveyard- [N]My twin brother is the[N]island guard- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C6F6 |[10]This is Green Theater-[N]A group called the [N]"Woodstin+Trioˮ is a [N]local favorite here- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C738 |[10]This place used to be [N]the Green Theater- [FIN]A group called the [N]"Woodstin+Trioˮ used [N]to be a very popular [N]band- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C782 |[10]Thank you for walking [N]with me- [N]Oh, one more thing--- [FIN]We animals communicate[N]not only with our [N]voices but also--- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01C7DF |[10]If I step like this [N]and wag my tail, it [N]means "thank youˮ- [FIN]Did you already know [N]that? [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C826 {
    COP [17] ( &code_01C832 ) ; {116774}
    COP [91]              ; {116778}
    COP [80] ( #23 )      ; {116780}
    COP [82]              ; {116783}
    RTL                   ; {116785}
}

code_01C832 {
    COP [01] ( &asciistring_01C837 ) ; {116786}
    RTL                   ; {116790}
}

asciistring_01C837 |[10][0A]If█you█find█a[N]particular█mole,█you[N]will█be█able█to[N]see█in█the█dark-[FIN]Make█sure█you█talk█to[N]all█the█moles-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|