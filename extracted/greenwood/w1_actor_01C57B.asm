?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0
!joy_block_mask                 0326

---------------------------------------------

code_01C57B {
    COP [14] ( #$003C, &code_01C582 )
    RTL 
}

code_01C582 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01C826, #$02B0, #$0200, #$2040 )
    COP [17] ( &code_01C60A )
    COP [15]
    COP [91]
    RTL 
}

code_01C59B {
    COP [16]
    COP [81] ( #11, #06 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_01C631 )
    COP [15]
    COP [91]
    RTL 
}

code_01C5BF {
    COP [16]
    COP [17] ( &code_01C62C )
    COP [81] ( #10, #07 )
    COP [83]
    COP [17] ( &code_01C639 )
    COP [15]
    COP [91]
    RTL 
}

code_01C5D4 {
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [1B] ( &code_01C5E4, #$003C )
}

code_01C5E4 {
    COP [01] ( &asciistring_01C782 )
    COP [80] ( #0C )
    COP [82]
    COP [1B] ( &code_01C5F3, #$001E )
}

code_01C5F3 {
    COP [81] ( #24, #04 )
    COP [83]
    COP [01] ( &asciistring_01C7DF )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_01C62C )
    COP [91]
    RTL 
}

code_01C60A {
    COP [01] ( &asciistring_01C64D )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01C627 )
    LDA $L_choice_result
    BNE code_01C627
    COP [01] ( &asciistring_01C661 )
    COP [17] ( &code_01C62C )
    COP [27] ( &code_01C59B )
}

code_01C627 {
    COP [01] ( &asciistring_01C675 )
    RTL 
}

code_01C62C {
    COP [01] ( &asciistring_01C683 )
    RTL 
}

code_01C631 {
    COP [01] ( &asciistring_01C6B6 )
    COP [27] ( &code_01C5BF )
}

code_01C639 {
    COP [14] ( #$004A, &code_01C645 )
    COP [01] ( &asciistring_01C738 )
    BRA loc_01C649
}

code_01C645 {
    COP [01] ( &asciistring_01C6F6 )

  loc_01C649:
    COP [27] ( &code_01C5D4 )
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
    COP [17] ( &code_01C832 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C832 {
    COP [01] ( &asciistring_01C837 )
    RTL 
}

asciistring_01C837 |[10][0A]If█you█find█a[N]particular█mole,█you[N]will█be█able█to[N]see█in█the█dark-[FIN]Make█sure█you█talk█to[N]all█the█moles-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|