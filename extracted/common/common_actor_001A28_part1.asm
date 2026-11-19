?BANK 00

?INCLUDE 'common_actor_001A28_part2'
?INCLUDE 'common_actor_001A28_part4'
?INCLUDE 'data_00F9F7'
?INCLUDE 'engine_000000'
?INCLUDE 'engine_routines_001D3B'
?INCLUDE 'lib_010000'
?INCLUDE 'lib_0161CE'
?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_anim                 0380
!player_actor                   039C
!return_active                  03FB
!actor_list_tail                06A6
!player_level_bcd               1B6A
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

code_001512 {
    LDA $0464             ; {5394}
    BEQ loc_00151A        ; {5397}
    STZ $joy_pressed      ; {5399}

  loc_00151A:
    LDA $0439             ; {5402}
    BNE loc_001524        ; {5405}
    LDA $1B5E             ; {5407}
    BNE loc_00152F        ; {5410}

  loc_001524:
    LDY $player_actor     ; {5412}
    LDA #$C000            ; {5415}
    TRB $joy_pressed      ; {5418}
    BRA loc_00155F        ; {5421}

  loc_00152F:
    JSR $&code_0018A1     ; {5423}
    PHX                   ; {5426}
    DEC                   ; {5427}
    ASL                   ; {5428}
    TAX                   ; {5429}
    LDA $@lib_0161CE.word_0161CE, X ; {5430}
    CMP $player_level_bcd ; {5434}
    BEQ loc_001547        ; {5437}
    BCC loc_001547        ; {5439}
    LDA #$8000            ; {5441}
    TRB $joy_pressed      ; {5444}

  loc_001547:
    PLX                   ; {5447}
    LDY $player_actor     ; {5448}
    LDA $001E, Y          ; {5451}
    SEC                   ; {5454}
    SBC #$0014            ; {5455}
    CMP #$0010            ; {5458}
    BCC loc_001577        ; {5461}
    LDA $joy_pressed      ; {5463}
    AND #$8000            ; {5466}
    BNE loc_001578        ; {5469}

  loc_00155F:
    LDA $0016, Y          ; {5471}
    BIT #$0400            ; {5474}
    BNE loc_00157F        ; {5477}
    PHX                   ; {5479}
    LDA $001E, Y          ; {5480}
    ASL                   ; {5483}
    TAX                   ; {5484}
    LDA $@word_001588, X  ; {5485}
    PLX                   ; {5489}
    AND $joy_pressed      ; {5490}
    BEQ loc_001578        ; {5493}

  loc_001577:
    RTL                   ; {5495}

  loc_001578:
    LDA #$&loc_001A65     ; {5496}
    STA $0018, Y          ; {5499}
    RTL                   ; {5502}

  loc_00157F:
    LDA #$&loc_001A65     ; {5503}
    STA $0018, Y          ; {5506}
    COP [91]              ; {5509}
    RTL                   ; {5511}
}
---------------------------------------------

word_001588 [
  #$0400   ;00
  #$0800   ;01
  #$0200   ;02
  #$0100   ;03
  #$0400   ;04
  #$0800   ;05
  #$0800   ;06
  #$0400   ;07
  #$0200   ;08
  #$0100   ;09
  #$0100   ;0A
  #$0200   ;0B
  #$0100   ;0C
  #$0200   ;0D
  #$0200   ;0E
  #$0100   ;0F
  #$0400   ;10
  #$0800   ;11
  #$0800   ;12
  #$0400   ;13
  #$0000   ;14
  #$0000   ;15
  #$0000   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0100   ;24
  #$0100   ;25
  #$0200   ;26
  #$0200   ;27
  #$0400   ;28
  #$0400   ;29
  #$0800   ;2A
  #$0800   ;2B
]
---------------------------------------------

code_0015E0 {
    LDA $0016, X          ; {5600}
    ORA #$0010            ; {5603}
    STA $0016, X          ; {5606}
    COP [91]              ; {5609}
    PHX                   ; {5611}
    LDX $player_actor     ; {5612}
    JSR $&code_00169C     ; {5615}
    BCC loc_001630        ; {5618}
    LDA $0004, X          ; {5620}
    PHA                   ; {5623}
    LDA $0006, X          ; {5624}
    PHA                   ; {5627}
    LDA $03D4             ; {5628}
    STA $0004, X          ; {5631}
    LDA $03D6             ; {5634}
    STA $0006, X          ; {5637}
    JSL $@engine_000000.code_000F28 ; {5640}
    LDA $0004, X          ; {5644}
    STA $03D4             ; {5647}
    CLC                   ; {5650}
    ADC $0000, X          ; {5651}
    STA $0000, X          ; {5654}
    LDA $0006, X          ; {5657}
    STA $03D6             ; {5660}
    CLC                   ; {5663}
    ADC $0002, X          ; {5664}
    STA $0002, X          ; {5667}
    PLA                   ; {5670}
    STA $0006, X          ; {5671}
    PLA                   ; {5674}
    STA $0004, X          ; {5675}
    BRA loc_001633        ; {5678}

  loc_001630:
    JSR $&code_001733     ; {5680}

  loc_001633:
    LDA $joy_block_mask   ; {5683}
    BIT #$0F00            ; {5686}
    BNE loc_001657        ; {5689}
    LDA $03D4             ; {5691}
    BNE loc_001649        ; {5694}
    LDA $0000, X          ; {5696}
    AND #$FFFE            ; {5699}
    STA $0000, X          ; {5702}

  loc_001649:
    LDA $03D6             ; {5705}
    BNE loc_001657        ; {5708}
    LDA $0002, X          ; {5710}
    AND #$FFFE            ; {5713}
    STA $0002, X          ; {5716}

  loc_001657:
    STZ $03D4             ; {5719}
    STZ $03D6             ; {5722}
    LDA $0000, X          ; {5725}
    STA $player_x         ; {5728}
    LSR                   ; {5731}
    LSR                   ; {5732}
    LSR                   ; {5733}
    LSR                   ; {5734}
    STA $player_tile_x    ; {5735}
    LDA $0002, X          ; {5738}
    STA $player_y         ; {5741}
    LSR                   ; {5744}
    LSR                   ; {5745}
    LSR                   ; {5746}
    LSR                   ; {5747}
    DEC                   ; {5748}
    STA $player_tile_y    ; {5749}
    LDY $039E             ; {5752}
    LDA $0000, X          ; {5755}
    STA $0000, Y          ; {5758}
    LDA $0002, X          ; {5761}
    STA $0002, Y          ; {5764}
    LDA $001E, X          ; {5767}
    ASL                   ; {5770}
    TAX                   ; {5771}
    LDA $&data_00F9F7.word_00FAD7, X ; {5772}
    CLC                   ; {5775}
    ADC $0002, Y          ; {5776}
    STA $0002, Y          ; {5779}
    JSL $@lib_010000.code_010000 ; {5782}
    PLX                   ; {5786}
    RTL                   ; {5787}
}

code_00169C {
    LDA $0000, X          ; {5788}
    STA $player_x         ; {5791}
    LSR                   ; {5794}
    LSR                   ; {5795}
    LSR                   ; {5796}
    LSR                   ; {5797}
    STA $player_tile_x    ; {5798}
    LDA $0002, X          ; {5801}
    STA $player_y         ; {5804}
    LSR                   ; {5807}
    LSR                   ; {5808}
    LSR                   ; {5809}
    LSR                   ; {5810}
    DEC                   ; {5811}
    STA $player_tile_y    ; {5812}
    CLC                   ; {5815}
    LDY $03D8             ; {5816}
    BNE loc_0016BE        ; {5819}
    RTS                   ; {5821}

  loc_0016BE:
    LDA $03A6             ; {5822}
    BEQ loc_0016C4        ; {5825}
    RTS                   ; {5827}

  loc_0016C4:
    LDA $0000, X          ; {5828}
    CLC                   ; {5831}
    ADC #$000F            ; {5832}
    LSR                   ; {5835}
    LSR                   ; {5836}
    LSR                   ; {5837}
    LSR                   ; {5838}
    STA $16               ; {5839}
    LDA $0002, X          ; {5841}
    DEC                   ; {5844}
    LSR                   ; {5845}
    LSR                   ; {5846}
    LSR                   ; {5847}
    LSR                   ; {5848}
    STA $18               ; {5849}
    SEP #$20              ; {5851}
    PHB                   ; {5853}
    LDA $03DA             ; {5854}
    PHA                   ; {5857}
    PLB                   ; {5858}

  loc_0016E3:
    LDA $0000, Y          ; {5859}
    INC                   ; {5862}
    BEQ loc_001725        ; {5863}
    LDA $16               ; {5865}
    CMP $0000, Y          ; {5867}
    BCC loc_001719        ; {5870}
    LDA $player_tile_x    ; {5872}
    CMP $0001, Y          ; {5875}
    BCS loc_001719        ; {5878}
    LDA $18               ; {5880}
    CMP $0002, Y          ; {5882}
    BCC loc_001719        ; {5885}
    LDA $player_tile_y    ; {5887}
    CMP $0003, Y          ; {5890}
    BCS loc_001719        ; {5893}
    REP #$20              ; {5895}
    LDA $0004, Y          ; {5897}
    BEQ loc_001711        ; {5900}
    STA $03D4             ; {5902}

  loc_001711:
    LDA $0006, Y          ; {5905}
    BEQ loc_001719        ; {5908}
    STA $03D6             ; {5910}

  loc_001719:
    REP #$20              ; {5913}
    TYA                   ; {5915}
    CLC                   ; {5916}
    ADC #$0008            ; {5917}
    TAY                   ; {5920}
    SEP #$20              ; {5921}
    BRA loc_0016E3        ; {5923}

  loc_001725:
    REP #$20              ; {5925}
    PLB                   ; {5927}
    SEC                   ; {5928}
    LDA $03D4             ; {5929}
    ORA $03D6             ; {5932}
    BNE loc_001732        ; {5935}
    CLC                   ; {5937}

  loc_001732:
    RTS                   ; {5938}
}

code_001733 {
    LDA $0016, X          ; {5939}
    BIT #$0004            ; {5942}
    BNE loc_00173C        ; {5945}
    RTS                   ; {5947}

  loc_00173C:
    JSR $&code_001892     ; {5948}
    BCC loc_001742        ; {5951}
    RTS                   ; {5953}

  loc_001742:
    AND #$00FF            ; {5954}
    BEQ loc_001754        ; {5957}
    DEC                   ; {5959}
    BEQ loc_0017A1        ; {5960}
    DEC                   ; {5962}
    BNE loc_001750        ; {5963}
    BRL loc_0017EA        ; {5965}

  loc_001750:
    BRL loc_00183E        ; {5968}

  loc_001753:
    RTS                   ; {5971}

  loc_001754:
    LDA $joy_pressed      ; {5972}
    BIT #$0800            ; {5975}
    BNE loc_00175D        ; {5978}
    RTS                   ; {5980}

  loc_00175D:
    TXY                   ; {5981}
    LDA $0000, X          ; {5982}
    AND #$000F            ; {5985}
    BEQ loc_00178E        ; {5988}
    LDA $0000, X          ; {5990}
    STA $16               ; {5993}
    LDA $0002, X          ; {5995}
    SEC                   ; {5998}
    SBC #$0020            ; {5999}
    STA $18               ; {6002}
    JSL $@lib_027462_part1.code_0272B8 ; {6004}
    LDA $tile_type_map, X ; {6008}
    AND #$00FC            ; {6012}
    BEQ loc_001790        ; {6015}
    JSL $@lib_027462_part2.code_02731A ; {6017}
    LDA $tile_type_map, X ; {6021}
    AND #$00FC            ; {6025}
    BEQ loc_001795        ; {6028}

  loc_00178E:
    TYX                   ; {6030}
    RTS                   ; {6031}

  loc_001790:
    LDA #$FFFE            ; {6032}
    BRA loc_001798        ; {6035}

  loc_001795:
    LDA #$0002            ; {6037}

  loc_001798:
    TYX                   ; {6040}
    CLC                   ; {6041}
    ADC $0000, X          ; {6042}
    STA $0000, X          ; {6045}
    RTS                   ; {6048}

  loc_0017A1:
    LDA $joy_pressed      ; {6049}
    BIT #$0400            ; {6052}
    BNE loc_0017AA        ; {6055}
    RTS                   ; {6057}

  loc_0017AA:
    TXY                   ; {6058}
    LDA $0000, X          ; {6059}
    AND #$000F            ; {6062}
    BEQ loc_0017D7        ; {6065}
    LDA $0000, X          ; {6067}
    STA $16               ; {6070}
    LDA $0002, X          ; {6072}
    STA $18               ; {6075}
    JSL $@lib_027462_part1.code_0272B8 ; {6077}
    LDA $tile_type_map, X ; {6081}
    AND #$00F3            ; {6085}
    BEQ loc_0017D9        ; {6088}
    JSL $@lib_027462_part2.code_02731A ; {6090}
    LDA $tile_type_map, X ; {6094}
    AND #$00F3            ; {6098}
    BEQ loc_0017DE        ; {6101}

  loc_0017D7:
    TYX                   ; {6103}
    RTS                   ; {6104}

  loc_0017D9:
    LDA #$FFFE            ; {6105}
    BRA loc_0017E1        ; {6108}

  loc_0017DE:
    LDA #$0002            ; {6110}

  loc_0017E1:
    TYX                   ; {6113}
    CLC                   ; {6114}
    ADC $0000, X          ; {6115}
    STA $0000, X          ; {6118}
    RTS                   ; {6121}

  loc_0017EA:
    LDA $joy_pressed      ; {6122}
    BIT #$0100            ; {6125}
    BNE loc_0017F3        ; {6128}
    RTS                   ; {6130}

  loc_0017F3:
    TXY                   ; {6131}
    LDA $0002, X          ; {6132}
    AND #$000F            ; {6135}
    BEQ loc_00182B        ; {6138}
    LDA $0000, X          ; {6140}
    CLC                   ; {6143}
    ADC #$0010            ; {6144}
    STA $16               ; {6147}
    LDA $0002, X          ; {6149}
    AND #$FFF0            ; {6152}
    SEC                   ; {6155}
    SBC #$0010            ; {6156}
    STA $18               ; {6159}
    JSL $@lib_027462_part1.code_0272B8 ; {6161}
    LDA $tile_type_map, X ; {6165}
    AND #$00F5            ; {6169}
    BEQ loc_00182D        ; {6172}
    JSL $@lib_027462_part2.code_027331 ; {6174}
    LDA $tile_type_map, X ; {6178}
    AND #$00F5            ; {6182}
    BEQ loc_001832        ; {6185}

  loc_00182B:
    TYX                   ; {6187}
    RTS                   ; {6188}

  loc_00182D:
    LDA #$FFFE            ; {6189}
    BRA loc_001835        ; {6192}

  loc_001832:
    LDA #$0002            ; {6194}

  loc_001835:
    TYX                   ; {6197}
    CLC                   ; {6198}
    ADC $0002, X          ; {6199}
    STA $0002, X          ; {6202}
    RTS                   ; {6205}

  loc_00183E:
    LDA $joy_pressed      ; {6206}
    BIT #$0200            ; {6209}
    BNE loc_001847        ; {6212}
    RTS                   ; {6214}

  loc_001847:
    TXY                   ; {6215}
    LDA $0002, X          ; {6216}
    AND #$000F            ; {6219}
    BEQ loc_00187F        ; {6222}
    LDA $0000, X          ; {6224}
    SEC                   ; {6227}
    SBC #$0010            ; {6228}
    STA $16               ; {6231}
    LDA $0002, X          ; {6233}
    AND #$FFF0            ; {6236}
    SEC                   ; {6239}
    SBC #$0010            ; {6240}
    STA $18               ; {6243}
    JSL $@lib_027462_part1.code_0272B8 ; {6245}
    LDA $tile_type_map, X ; {6249}
    AND #$00FA            ; {6253}
    BEQ loc_001881        ; {6256}
    JSL $@lib_027462_part2.code_027331 ; {6258}
    LDA $tile_type_map, X ; {6262}
    AND #$00FA            ; {6266}
    BEQ loc_001886        ; {6269}

  loc_00187F:
    TYX                   ; {6271}
    RTS                   ; {6272}

  loc_001881:
    LDA #$FFFE            ; {6273}
    BRA loc_001889        ; {6276}

  loc_001886:
    LDA #$0002            ; {6278}

  loc_001889:
    TYX                   ; {6281}
    CLC                   ; {6282}
    ADC $0002, X          ; {6283}
    STA $0002, X          ; {6286}
    RTS                   ; {6289}
}

code_001892 {
    LDY $001E, X          ; {6290}
    CPY #$002C            ; {6293}
    BCS loc_00189F        ; {6296}
    LDA $&data_00F9F7.binary_00FAAB, Y ; {6298}
    CLC                   ; {6301}
    RTS                   ; {6302}

  loc_00189F:
    SEC                   ; {6303}
    RTS                   ; {6304}
}

code_0018A1 {
    PHX                   ; {6305}
    PHA                   ; {6306}
    LDY $player_actor     ; {6307}
    LDA $001E, Y          ; {6310}
    CMP #$0004            ; {6313}
    BCS loc_0018E8        ; {6316}
    STA $00               ; {6318}
    LDA $0000, Y          ; {6320}
    CLC                   ; {6323}
    ADC #$0008            ; {6324}
    STA $16               ; {6327}
    LDA $0002, Y          ; {6329}
    CLC                   ; {6332}
    ADC #$0008            ; {6333}
    STA $18               ; {6336}
    LDA $actor_list_tail  ; {6338}
    BRA loc_0018CA        ; {6341}

  loc_0018C7:
    LDA $003E, X          ; {6343}

  loc_0018CA:
    TAX                   ; {6346}
    BEQ loc_0018E8        ; {6347}
    LDA $0016, X          ; {6349}
    BMI loc_0018C7        ; {6352}
    BIT #$4000            ; {6354}
    BEQ loc_0018C7        ; {6357}
    LDA $001E, X          ; {6359}
    SEC                   ; {6362}
    SBC #$0004            ; {6363}
    CMP #$0003            ; {6366}
    BCS loc_0018C7        ; {6369}
    JSR $&code_0018EB     ; {6371}
    BRA loc_0018C7        ; {6374}

  loc_0018E8:
    PLA                   ; {6376}
    PLX                   ; {6377}
    RTS                   ; {6378}
}

code_0018EB {
    LDA $00               ; {6379}
    BEQ loc_001923        ; {6381}
    DEC                   ; {6383}
    BEQ loc_0018F8        ; {6384}
    DEC                   ; {6386}
    BEQ loc_00194E        ; {6387}
    BRL loc_001979        ; {6389}

  loc_0018F8:
    LDA $0002, X          ; {6392}
    CMP $18               ; {6395}
    BCC loc_001900        ; {6397}
    RTS                   ; {6399}

  loc_001900:
    LDA $16               ; {6400}
    SEC                   ; {6402}
    SBC $0000, X          ; {6403}
    CMP #$0011            ; {6406}
    BCC loc_00190C        ; {6409}
    RTS                   ; {6411}

  loc_00190C:
    LDA $001E, X          ; {6412}
    CMP #$0006            ; {6415}
    BEQ loc_00191F        ; {6418}
    CMP #$0005            ; {6420}
    BEQ loc_00191C        ; {6423}
    INC $0002, X          ; {6425}

  loc_00191C:
    INC $0002, X          ; {6428}

  loc_00191F:
    INC $0002, X          ; {6431}
    RTS                   ; {6434}

  loc_001923:
    LDA $0002, X          ; {6435}
    CMP $18               ; {6438}
    BCS loc_00192B        ; {6440}
    RTS                   ; {6442}

  loc_00192B:
    LDA $16               ; {6443}
    SEC                   ; {6445}
    SBC $0000, X          ; {6446}
    CMP #$0011            ; {6449}
    BCC loc_001937        ; {6452}
    RTS                   ; {6454}

  loc_001937:
    LDA $001E, X          ; {6455}
    CMP #$0006            ; {6458}
    BEQ loc_00194A        ; {6461}
    CMP #$0005            ; {6463}
    BEQ loc_001947        ; {6466}
    DEC $0002, X          ; {6468}

  loc_001947:
    DEC $0002, X          ; {6471}

  loc_00194A:
    DEC $0002, X          ; {6474}
    RTS                   ; {6477}

  loc_00194E:
    LDA $0000, X          ; {6478}
    CMP $16               ; {6481}
    BCC loc_001956        ; {6483}
    RTS                   ; {6485}

  loc_001956:
    LDA $18               ; {6486}
    SEC                   ; {6488}
    SBC $0002, X          ; {6489}
    CMP #$0011            ; {6492}
    BCC loc_001962        ; {6495}
    RTS                   ; {6497}

  loc_001962:
    LDA $001E, X          ; {6498}
    CMP #$0006            ; {6501}
    BEQ loc_001975        ; {6504}
    CMP #$0005            ; {6506}
    BEQ loc_001972        ; {6509}
    INC $0000, X          ; {6511}

  loc_001972:
    INC $0000, X          ; {6514}

  loc_001975:
    INC $0000, X          ; {6517}
    RTS                   ; {6520}

  loc_001979:
    LDA $0000, X          ; {6521}
    CMP $16               ; {6524}
    BCS loc_001981        ; {6526}
    RTS                   ; {6528}

  loc_001981:
    LDA $18               ; {6529}
    SEC                   ; {6531}
    SBC $0002, X          ; {6532}
    CMP #$0011            ; {6535}
    BCC loc_00198D        ; {6538}
    RTS                   ; {6540}

  loc_00198D:
    LDA $001E, X          ; {6541}
    CMP #$0006            ; {6544}
    BEQ loc_0019A0        ; {6547}
    CMP #$0005            ; {6549}
    BEQ loc_00199D        ; {6552}
    DEC $0000, X          ; {6554}

  loc_00199D:
    DEC $0000, X          ; {6557}

  loc_0019A0:
    DEC $0000, X          ; {6560}
    RTS                   ; {6563}
}

code_0019A4 {
    COP [91]              ; {6564}
    LDA $warp_dest_anim   ; {6566}
    BEQ loc_0019AC        ; {6569}
    RTL                   ; {6571}

  loc_0019AC:
    PHX                   ; {6572}
    LDA $0405             ; {6573}
    ASL                   ; {6576}
    TAX                   ; {6577}
    LDA $switch_owner_table, X ; {6578}
    PLX                   ; {6582}
    TAY                   ; {6583}
    BNE loc_0019BB        ; {6584}
    RTL                   ; {6586}

  loc_0019BB:
    LDA $0000, X          ; {6587}
    SEC                   ; {6590}
    SBC $0000, Y          ; {6591}
    BMI loc_0019E3        ; {6594}
    STA $16               ; {6596}
    LDA $0002, X          ; {6598}
    SEC                   ; {6601}
    SBC $0002, Y          ; {6602}
    BMI loc_0019D7        ; {6605}
    STA $18               ; {6607}
    CMP $16               ; {6609}
    BCS loc_001A10        ; {6611}
    BRA loc_001A0B        ; {6613}

  loc_0019D7:
    EOR #$FFFF            ; {6615}
    INC                   ; {6618}
    STA $18               ; {6619}
    CMP $16               ; {6621}
    BCS loc_001A06        ; {6623}
    BRA loc_001A0B        ; {6625}

  loc_0019E3:
    EOR #$FFFF            ; {6627}
    INC                   ; {6630}
    STA $16               ; {6631}
    LDA $0002, X          ; {6633}
    SEC                   ; {6636}
    SBC $0002, Y          ; {6637}
    BMI loc_0019FA        ; {6640}
    STA $18               ; {6642}
    CMP $16               ; {6644}
    BCS loc_001A10        ; {6646}
    BRA loc_001A15        ; {6648}

  loc_0019FA:
    EOR #$FFFF            ; {6650}
    INC                   ; {6653}
    STA $18               ; {6654}
    CMP $16               ; {6656}
    BCS loc_001A06        ; {6658}
    BRA loc_001A15        ; {6660}

  loc_001A06:
    LDA #$0000            ; {6662}
    BRA loc_001A18        ; {6665}

  loc_001A0B:
    LDA #$0002            ; {6667}
    BRA loc_001A18        ; {6670}

  loc_001A10:
    LDA #$0001            ; {6672}
    BRA loc_001A18        ; {6675}

  loc_001A15:
    LDA #$0003            ; {6677}

  loc_001A18:
    STA $001E, X          ; {6680}
    STZ $0020, X          ; {6683}
    JSL $@engine_000000.code_0008F3 ; {6686}
    STZ $0014, X          ; {6690}
    COP [91]              ; {6693}
    RTL                   ; {6695}
}

code_001A28 {
    STX $player_actor     ; {6696}
    COP [A9] ( #$3000, #7F ) ; {6699}
    COP [84] ( @common_actor_001A28_part4.code_002F56 ) ; {6704}
    LDA $return_active    ; {6709}
    BEQ loc_001A3D        ; {6712}
    BRL code_0019A4       ; {6714}

  loc_001A3D:
    COP [84] ( @common_actor_001A28_part2.code_001FE0 ) ; {6717}
    LDA $0016, Y          ; {6722}
    AND #$CF7F            ; {6725}
    ORA #$0310            ; {6728}
    STA $0016, Y          ; {6731}
    STY $03A0             ; {6734}
    COP [84] ( @code_001512 ) ; {6737}
    COP [85] ( @code_0015E0 ) ; {6742}
    COP [85] ( @common_actor_001A28_part2.code_001FCF ) ; {6747}
    STY $039E             ; {6752}
    COP [91]              ; {6755}

  loc_001A65:
    LDA $0016, X          ; {6757}
    BIT #$0400            ; {6760}
    BEQ loc_001A70        ; {6763}
    BRL engine_routines_001D3B.loc_001ED3 ; {6765}

  loc_001A70:
    LDA $0439             ; {6768}
    BNE loc_001A7A        ; {6771}
    LDA $1B5E             ; {6773}
    BNE loc_001ACD        ; {6776}

  loc_001A7A:
    LDA $joy_pressed      ; {6778}
    BIT #$0030            ; {6781}
    BNE loc_001A9E        ; {6784}
    EOR #$FFFF            ; {6786}
    XBA                   ; {6789}
    LSR                   ; {6790}
    BCS loc_001A8C        ; {6791}
    BRL engine_routines_001D3B.code_001E0D ; {6793}

  loc_001A8C:
    LSR                   ; {6796}
    BCS loc_001A92        ; {6797}
    BRL engine_routines_001D3B.code_001DEF ; {6799}

  loc_001A92:
    LSR                   ; {6802}
    BCS loc_001A98        ; {6803}
    BRL engine_routines_001D3B.code_001DD1 ; {6805}

  loc_001A98:
    LSR                   ; {6808}
    BCS loc_001A9E        ; {6809}
    BRL engine_routines_001D3B.code_001DB3 ; {6811}

  loc_001A9E:
    PHX                   ; {6814}
    LDA $001E, X          ; {6815}
    ASL                   ; {6818}
    CLC                   ; {6819}
    ADC $001E, X          ; {6820}
    ASL                   ; {6823}
    ASL                   ; {6824}
    TAX                   ; {6825}
    LDA $joy_pressed      ; {6826}
    INX                   ; {6829}
    INX                   ; {6830}
    XBA                   ; {6831}
    LSR                   ; {6832}
    BCS loc_001AC4        ; {6833}
    INX                   ; {6835}
    INX                   ; {6836}
    LSR                   ; {6837}
    BCS loc_001AC4        ; {6838}
    INX                   ; {6840}
    INX                   ; {6841}
    LSR                   ; {6842}
    BCS loc_001AC4        ; {6843}
    INX                   ; {6845}
    INX                   ; {6846}
    LSR                   ; {6847}
    BCS loc_001AC4        ; {6848}
    INX                   ; {6850}
    INX                   ; {6851}

  loc_001AC4:
    LDA $@code_list_001B2B, X ; {6852}
    PLX                   ; {6856}
    DEC                   ; {6857}
    PHA                   ; {6858}
    CLC                   ; {6859}
    RTS                   ; {6860}

  loc_001ACD:
    LDA $joy_pressed      ; {6861}
    BIT #$8030            ; {6864}
    BNE loc_001AEE        ; {6867}
    XBA                   ; {6869}
    LSR                   ; {6870}
    BCC loc_001ADC        ; {6871}
    BRL engine_routines_001D3B.code_001E0D ; {6873}

  loc_001ADC:
    LSR                   ; {6876}
    BCC loc_001AE2        ; {6877}
    BRL engine_routines_001D3B.code_001DEF ; {6879}

  loc_001AE2:
    LSR                   ; {6882}
    BCC loc_001AE8        ; {6883}
    BRL engine_routines_001D3B.code_001DD1 ; {6885}

  loc_001AE8:
    LSR                   ; {6888}
    BCC loc_001AEE        ; {6889}
    BRL engine_routines_001D3B.code_001DB3 ; {6891}

  loc_001AEE:
    PHX                   ; {6894}
    LDA $001E, X          ; {6895}
    ASL                   ; {6898}
    CLC                   ; {6899}
    ADC $001E, X          ; {6900}
    ASL                   ; {6903}
    ASL                   ; {6904}
    TAX                   ; {6905}
    LDA $joy_pressed      ; {6906}
    BIT #$8000            ; {6909}
    BNE loc_001B19        ; {6912}
    INX                   ; {6914}
    INX                   ; {6915}
    XBA                   ; {6916}
    LSR                   ; {6917}
    BCS loc_001B19        ; {6918}
    INX                   ; {6920}
    INX                   ; {6921}
    LSR                   ; {6922}
    BCS loc_001B19        ; {6923}
    INX                   ; {6925}
    INX                   ; {6926}
    LSR                   ; {6927}
    BCS loc_001B19        ; {6928}
    INX                   ; {6930}
    INX                   ; {6931}
    LSR                   ; {6932}
    BCS loc_001B19        ; {6933}
    INX                   ; {6935}
    INX                   ; {6936}

  loc_001B19:
    CLC                   ; {6937}
    LDA $joy_pressed      ; {6938}
    BIT #$0030            ; {6941}
    BNE loc_001B23        ; {6944}
    SEC                   ; {6946}

  loc_001B23:
    LDA $@code_list_001B2B, X ; {6947}
    PLX                   ; {6951}
    DEC                   ; {6952}
    PHA                   ; {6953}
    RTS                   ; {6954}
}
---------------------------------------------

code_list_001B2B [
  &engine_routines_001D3B.code_001F1B   ;00
  &engine_routines_001D3B.code_001EB7   ;01
  &engine_routines_001D3B.code_001E8D   ;02
  &engine_routines_001D3B.code_001DD1   ;03
  &engine_routines_001D3B.code_001E2B   ;04
  &engine_routines_001D3B.code_001D59   ;05
  &engine_routines_001D3B.code_001EFB   ;06
  &engine_routines_001D3B.code_001EA9   ;07
  &engine_routines_001D3B.code_001E7F   ;08
  &engine_routines_001D3B.code_001E55   ;09
  &engine_routines_001D3B.code_001DB3   ;0A
  &engine_routines_001D3B.code_001D3B   ;0B
  &engine_routines_001D3B.code_001F3B   ;0C
  &engine_routines_001D3B.code_001EC5   ;0D
  &engine_routines_001D3B.code_001DEF   ;0E
  &engine_routines_001D3B.code_001E63   ;0F
  &engine_routines_001D3B.code_001E39   ;10
  &engine_routines_001D3B.code_001D77   ;11
  &engine_routines_001D3B.code_001F5B   ;12
  &engine_routines_001D3B.code_001E0D   ;13
  &engine_routines_001D3B.code_001E9B   ;14
  &engine_routines_001D3B.code_001E71   ;15
  &engine_routines_001D3B.code_001E47   ;16
  &engine_routines_001D3B.code_001D95   ;17
  &engine_routines_001D3B.code_001F1B   ;18
  &engine_routines_001D3B.code_001EB7   ;19
  &engine_routines_001D3B.code_001E8D   ;1A
  &engine_routines_001D3B.code_001DD1   ;1B
  &engine_routines_001D3B.code_001E2B   ;1C
  &engine_routines_001D3B.code_001D59   ;1D
  &engine_routines_001D3B.code_001F1B   ;1E
  &engine_routines_001D3B.code_001EB7   ;1F
  &engine_routines_001D3B.code_001E8D   ;20
  &engine_routines_001D3B.code_001DD1   ;21
  &engine_routines_001D3B.code_001E2B   ;22
  &engine_routines_001D3B.code_001D59   ;23
  &engine_routines_001D3B.code_001EFB   ;24
  &engine_routines_001D3B.code_001EA9   ;25
  &engine_routines_001D3B.code_001E7F   ;26
  &engine_routines_001D3B.code_001E55   ;27
  &engine_routines_001D3B.code_001DB3   ;28
  &engine_routines_001D3B.code_001D3B   ;29
  &engine_routines_001D3B.code_001EFB   ;2A
  &engine_routines_001D3B.code_001EA9   ;2B
  &engine_routines_001D3B.code_001E7F   ;2C
  &engine_routines_001D3B.code_001E55   ;2D
  &engine_routines_001D3B.code_001DB3   ;2E
  &engine_routines_001D3B.code_001D3B   ;2F
  &engine_routines_001D3B.code_001F3B   ;30
  &engine_routines_001D3B.code_001EC5   ;31
  &engine_routines_001D3B.code_001DEF   ;32
  &engine_routines_001D3B.code_001E63   ;33
  &engine_routines_001D3B.code_001E39   ;34
  &engine_routines_001D3B.code_001D77   ;35
  &engine_routines_001D3B.code_001F3B   ;36
  &engine_routines_001D3B.code_001EC5   ;37
  &engine_routines_001D3B.code_001DEF   ;38
  &engine_routines_001D3B.code_001E63   ;39
  &engine_routines_001D3B.code_001E39   ;3A
  &engine_routines_001D3B.code_001D77   ;3B
  &engine_routines_001D3B.code_001F5B   ;3C
  &engine_routines_001D3B.code_001E0D   ;3D
  &engine_routines_001D3B.code_001E9B   ;3E
  &engine_routines_001D3B.code_001E71   ;3F
  &engine_routines_001D3B.code_001E47   ;40
  &engine_routines_001D3B.code_001D95   ;41
  &engine_routines_001D3B.code_001F5B   ;42
  &engine_routines_001D3B.code_001E0D   ;43
  &engine_routines_001D3B.code_001E9B   ;44
  &engine_routines_001D3B.code_001E71   ;45
  &engine_routines_001D3B.code_001E47   ;46
  &engine_routines_001D3B.code_001D95   ;47
  &engine_routines_001D3B.code_001F1B   ;48
  &engine_routines_001D3B.code_001EB7   ;49
  &engine_routines_001D3B.code_001E8D   ;4A
  &engine_routines_001D3B.code_001DD1   ;4B
  &engine_routines_001D3B.code_001E2B   ;4C
  &engine_routines_001D3B.code_001D59   ;4D
  &engine_routines_001D3B.code_001F1B   ;4E
  &engine_routines_001D3B.code_001EB7   ;4F
  &engine_routines_001D3B.code_001E8D   ;50
  &engine_routines_001D3B.code_001DD1   ;51
  &engine_routines_001D3B.code_001E2B   ;52
  &engine_routines_001D3B.code_001D59   ;53
  &engine_routines_001D3B.code_001EFB   ;54
  &engine_routines_001D3B.code_001EA9   ;55
  &engine_routines_001D3B.code_001E7F   ;56
  &engine_routines_001D3B.code_001E55   ;57
  &engine_routines_001D3B.code_001DB3   ;58
  &engine_routines_001D3B.code_001D3B   ;59
  &engine_routines_001D3B.code_001EFB   ;5A
  &engine_routines_001D3B.code_001EA9   ;5B
  &engine_routines_001D3B.code_001E7F   ;5C
  &engine_routines_001D3B.code_001E55   ;5D
  &engine_routines_001D3B.code_001DB3   ;5E
  &engine_routines_001D3B.code_001D3B   ;5F
  &engine_routines_001D3B.code_001F3B   ;60
  &engine_routines_001D3B.code_001EC5   ;61
  &engine_routines_001D3B.code_001DEF   ;62
  &engine_routines_001D3B.code_001E63   ;63
  &engine_routines_001D3B.code_001E39   ;64
  &engine_routines_001D3B.code_001D77   ;65
  &engine_routines_001D3B.code_001F3B   ;66
  &engine_routines_001D3B.code_001EC5   ;67
  &engine_routines_001D3B.code_001DEF   ;68
  &engine_routines_001D3B.code_001E63   ;69
  &engine_routines_001D3B.code_001E39   ;6A
  &engine_routines_001D3B.code_001D77   ;6B
  &engine_routines_001D3B.code_001F5B   ;6C
  &engine_routines_001D3B.code_001E0D   ;6D
  &engine_routines_001D3B.code_001E9B   ;6E
  &engine_routines_001D3B.code_001E71   ;6F
  &engine_routines_001D3B.code_001E47   ;70
  &engine_routines_001D3B.code_001D95   ;71
  &engine_routines_001D3B.code_001F5B   ;72
  &engine_routines_001D3B.code_001E0D   ;73
  &engine_routines_001D3B.code_001E9B   ;74
  &engine_routines_001D3B.code_001E71   ;75
  &engine_routines_001D3B.code_001E47   ;76
  &engine_routines_001D3B.code_001D95   ;77
  &engine_routines_001D3B.code_001D3B   ;78
  &engine_routines_001D3B.code_001D3B   ;79
  &engine_routines_001D3B.code_001D3B   ;7A
  &engine_routines_001D3B.code_001D3B   ;7B
  &engine_routines_001D3B.code_001D3B   ;7C
  &engine_routines_001D3B.code_001D3B   ;7D
  &engine_routines_001D3B.code_001D3B   ;7E
  &engine_routines_001D3B.code_001D3B   ;7F
  &engine_routines_001D3B.code_001D3B   ;80
  &engine_routines_001D3B.code_001D3B   ;81
  &engine_routines_001D3B.code_001D3B   ;82
  &engine_routines_001D3B.code_001D3B   ;83
  &engine_routines_001D3B.code_001D3B   ;84
  &engine_routines_001D3B.code_001D3B   ;85
  &engine_routines_001D3B.code_001D3B   ;86
  &engine_routines_001D3B.code_001D3B   ;87
  &engine_routines_001D3B.code_001D3B   ;88
  &engine_routines_001D3B.code_001D3B   ;89
  &engine_routines_001D3B.code_001D3B   ;8A
  &engine_routines_001D3B.code_001D3B   ;8B
  &engine_routines_001D3B.code_001D3B   ;8C
  &engine_routines_001D3B.code_001D3B   ;8D
  &engine_routines_001D3B.code_001D3B   ;8E
  &engine_routines_001D3B.code_001D3B   ;8F
  &engine_routines_001D3B.code_001D3B   ;90
  &engine_routines_001D3B.code_001D3B   ;91
  &engine_routines_001D3B.code_001D3B   ;92
  &engine_routines_001D3B.code_001D3B   ;93
  &engine_routines_001D3B.code_001D3B   ;94
  &engine_routines_001D3B.code_001D3B   ;95
  &engine_routines_001D3B.code_001D3B   ;96
  &engine_routines_001D3B.code_001D3B   ;97
  &engine_routines_001D3B.code_001D3B   ;98
  &engine_routines_001D3B.code_001D3B   ;99
  &engine_routines_001D3B.code_001D3B   ;9A
  &engine_routines_001D3B.code_001D3B   ;9B
  &engine_routines_001D3B.code_001D3B   ;9C
  &engine_routines_001D3B.code_001D3B   ;9D
  &engine_routines_001D3B.code_001D3B   ;9E
  &engine_routines_001D3B.code_001D3B   ;9F
  &engine_routines_001D3B.code_001D3B   ;A0
  &engine_routines_001D3B.code_001D3B   ;A1
  &engine_routines_001D3B.code_001D3B   ;A2
  &engine_routines_001D3B.code_001D3B   ;A3
  &engine_routines_001D3B.code_001D3B   ;A4
  &engine_routines_001D3B.code_001D3B   ;A5
  &engine_routines_001D3B.code_001D3B   ;A6
  &engine_routines_001D3B.code_001D3B   ;A7
  &engine_routines_001D3B.code_001D3B   ;A8
  &engine_routines_001D3B.code_001D3B   ;A9
  &engine_routines_001D3B.code_001D3B   ;AA
  &engine_routines_001D3B.code_001D3B   ;AB
  &engine_routines_001D3B.code_001D3B   ;AC
  &engine_routines_001D3B.code_001D3B   ;AD
  &engine_routines_001D3B.code_001D3B   ;AE
  &engine_routines_001D3B.code_001D3B   ;AF
  &engine_routines_001D3B.code_001D3B   ;B0
  &engine_routines_001D3B.code_001D3B   ;B1
  &engine_routines_001D3B.code_001D3B   ;B2
  &engine_routines_001D3B.code_001D3B   ;B3
  &engine_routines_001D3B.code_001D3B   ;B4
  &engine_routines_001D3B.code_001D3B   ;B5
  &engine_routines_001D3B.code_001D3B   ;B6
  &engine_routines_001D3B.code_001D3B   ;B7
  &engine_routines_001D3B.code_001D3B   ;B8
  &engine_routines_001D3B.code_001D3B   ;B9
  &engine_routines_001D3B.code_001D3B   ;BA
  &engine_routines_001D3B.code_001D3B   ;BB
  &engine_routines_001D3B.code_001D3B   ;BC
  &engine_routines_001D3B.code_001D3B   ;BD
  &engine_routines_001D3B.code_001D3B   ;BE
  &engine_routines_001D3B.code_001D3B   ;BF
  &engine_routines_001D3B.code_001F1B   ;C0
  &engine_routines_001D3B.code_001EB7   ;C1
  &engine_routines_001D3B.code_001E8D   ;C2
  &engine_routines_001D3B.code_001DD1   ;C3
  &engine_routines_001D3B.code_001E2B   ;C4
  &engine_routines_001D3B.code_001D59   ;C5
  &engine_routines_001D3B.code_001EFB   ;C6
  &engine_routines_001D3B.code_001EA9   ;C7
  &engine_routines_001D3B.code_001E7F   ;C8
  &engine_routines_001D3B.code_001E55   ;C9
  &engine_routines_001D3B.code_001DB3   ;CA
  &engine_routines_001D3B.code_001D3B   ;CB
  &engine_routines_001D3B.code_001F3B   ;CC
  &engine_routines_001D3B.code_001EC5   ;CD
  &engine_routines_001D3B.code_001DEF   ;CE
  &engine_routines_001D3B.code_001E63   ;CF
  &engine_routines_001D3B.code_001E39   ;D0
  &engine_routines_001D3B.code_001D77   ;D1
  &engine_routines_001D3B.code_001F5B   ;D2
  &engine_routines_001D3B.code_001E0D   ;D3
  &engine_routines_001D3B.code_001E9B   ;D4
  &engine_routines_001D3B.code_001E71   ;D5
  &engine_routines_001D3B.code_001E47   ;D6
  &engine_routines_001D3B.code_001D95   ;D7
  &engine_routines_001D3B.code_001F5B   ;D8
  &engine_routines_001D3B.code_001E0D   ;D9
  &engine_routines_001D3B.code_001E9B   ;DA
  &engine_routines_001D3B.code_001E71   ;DB
  &engine_routines_001D3B.code_001E47   ;DC
  &engine_routines_001D3B.code_001D95   ;DD
  &engine_routines_001D3B.code_001F5B   ;DE
  &engine_routines_001D3B.code_001E0D   ;DF
  &engine_routines_001D3B.code_001E9B   ;E0
  &engine_routines_001D3B.code_001E71   ;E1
  &engine_routines_001D3B.code_001E47   ;E2
  &engine_routines_001D3B.code_001D95   ;E3
  &engine_routines_001D3B.code_001F3B   ;E4
  &engine_routines_001D3B.code_001EC5   ;E5
  &engine_routines_001D3B.code_001DEF   ;E6
  &engine_routines_001D3B.code_001E63   ;E7
  &engine_routines_001D3B.code_001E39   ;E8
  &engine_routines_001D3B.code_001D77   ;E9
  &engine_routines_001D3B.code_001F3B   ;EA
  &engine_routines_001D3B.code_001EC5   ;EB
  &engine_routines_001D3B.code_001DEF   ;EC
  &engine_routines_001D3B.code_001E63   ;ED
  &engine_routines_001D3B.code_001E39   ;EE
  &engine_routines_001D3B.code_001D77   ;EF
  &engine_routines_001D3B.code_001F1B   ;F0
  &engine_routines_001D3B.code_001EB7   ;F1
  &engine_routines_001D3B.code_001E8D   ;F2
  &engine_routines_001D3B.code_001DD1   ;F3
  &engine_routines_001D3B.code_001E2B   ;F4
  &engine_routines_001D3B.code_001D59   ;F5
  &engine_routines_001D3B.code_001F1B   ;F6
  &engine_routines_001D3B.code_001EB7   ;F7
  &engine_routines_001D3B.code_001E8D   ;F8
  &engine_routines_001D3B.code_001DD1   ;F9
  &engine_routines_001D3B.code_001E2B   ;FA
  &engine_routines_001D3B.code_001D59   ;FB
  &engine_routines_001D3B.code_001EFB   ;FC
  &engine_routines_001D3B.code_001EA9   ;FD
  &engine_routines_001D3B.code_001E7F   ;FE
  &engine_routines_001D3B.code_001E55   ;FF
  &engine_routines_001D3B.code_001DB3   ;100
  &engine_routines_001D3B.code_001D3B   ;101
  &engine_routines_001D3B.code_001EFB   ;102
  &engine_routines_001D3B.code_001EA9   ;103
  &engine_routines_001D3B.code_001E7F   ;104
  &engine_routines_001D3B.code_001E55   ;105
  &engine_routines_001D3B.code_001DB3   ;106
  &engine_routines_001D3B.code_001D3B   ;107
]