Wrote 1768 lines to ./docs/audio/spc-disassembly.md
Code range: $400-$f46 (2887 bytes)
Labels: 192 (92 named + 100 auto)
ytes)
; Execution entry: $0400
; Disassembled from spc_0FF14E in chunk_0FAA49.asm


EngineEntry:
0400:  20          CLRP
0401:  cd cf       MOV X, #$cf
0403:  bd          MOV SP, X
0404:  e8 00       MOV A, #$00
0406:  5d          MOV X, A

ZeroFillLoop:
0407:  af          MOV (X)+, A
0408:  c8 f0       CMP X, #$f0
040a:  d0 fb       BNE $0407
040c:  c5 ff 0f    MOV $0fff, A
040f:  bc          INC
0410:  3f a9 09    CALL $09a9
0413:  a2 48       SET1 $48.5
0415:  e8 60       MOV A, #$60
0417:  8d 0c       MOV Y, #$0c
0419:  3f b8 05    CALL $05b8
041c:  8d 1c       MOV Y, #$1c
041e:  3f b8 05    CALL $05b8
0421:  e8 2c       MOV A, #$2c
0423:  8d 5d       MOV Y, #$5d
0425:  3f b8 05    CALL $05b8
0428:  e8 30       MOV A, #$30
042a:  c4 f1       MOV $f1, A
042c:  e8 10       MOV A, #$10
042e:  c4 fa       MOV $fa, A
0430:  c4 53       MOV $53, A
0432:  e8 01       MOV A, #$01
0434:  c4 f1       MOV $f1, A

MainLoop:
0436:  e4 36       MOV A, $36
0438:  48 ff       EOR A, #$ff
043a:  24 4a       AND A, $4a
043c:  c4 38       MOV $38, A
043e:  8d 0a       MOV Y, #$0a

DSPOutputLoop:
0440:  ad 05       CMP Y, #$05
0442:  f0 07       BEQ $044b
0444:  b0 08       BCS $044e
0446:  69 4d 4c    CMP $4c, $4d
0449:  d0 0f       BNE $045a

loc_044b:
044b:  e3 4c 0c    BBS $4c.7, $045a

loc_044e:
044e:  f6 5d 0d    MOV A, $0d5d+Y
0451:  c4 f2       MOV $f2, A
0453:  f6 67 0d    MOV A, $0d67+Y
0456:  5d          MOV X, A
0457:  e6          MOV A, (X)
0458:  c4 f3       MOV $f3, A

loc_045a:
045a:  fe e4       DBNZ Y, $0440
045c:  cb 45       MOV $45, Y
045e:  cb 46       MOV $46, Y

WaitTimer0:
0460:  eb fd       MOV Y, $fd
0462:  f0 fc       BEQ $0460
0464:  6d          PUSH
0465:  e8 40       MOV A, #$40
0467:  cf          MUL
0468:  60          CLRC
0469:  84 43       ADC A, $43
046b:  c4 43       MOV $43, A
046d:  90 0a       BCC $0479
046f:  3f a0 0d    CALL $0da0
0472:  69 4d 4c    CMP $4c, $4d
0475:  f0 02       BEQ $0479
0477:  ab 4c       INC $4c

SequenceTickCheck:
0479:  e4 53       MOV A, $53
047b:  ee          POP
047c:  cf          MUL
047d:  60          CLRC
047e:  84 51       ADC A, $51
0480:  c4 51       MOV $51, A
0482:  90 19       BCC $049d
0484:  3f 83 06    CALL $0683
0487:  e4 30       MOV A, $30
0489:  f0 0a       BEQ $0495
048b:  8b 31       DEC $31
048d:  d0 06       BNE $0495
048f:  8f 00 04    MOV $04, #$00
0492:  3f e8 05    CALL $05e8

PortDataUpdate:
0495:  cd 00       MOV X, #$00
0497:  3f b6 04    CALL $04b6
049a:  5f 36 04    JMP $0436

SFXOnlyProcess:
049d:  e4 04       MOV A, $04
049f:  f0 12       BEQ $04b3
04a1:  cd 00       MOV X, #$00
04a3:  8f 01 47    MOV $47, #$01

loc_04a6:
04a6:  f4 d5       MOV A, $d5+X
04a8:  f0 03       BEQ $04ad
04aa:  3f 34 0c    CALL $0c34

loc_04ad:
04ad:  3d          INC
04ae:  3d          INC
04af:  0b 47       ASL $47
04b1:  d0 f3       BNE $04a6

loc_04b3:
04b3:  5f 36 04    JMP $0436

ReadPortData:
04b6:  f4 04       MOV A, $04+X
04b8:  d4 f4       MOV $f4+X, A

loc_04ba:
04ba:  f4 f4       MOV A, $f4+X
04bc:  74 f4       CMP $f4+X, A
04be:  d0 fa       BNE $04ba
04c0:  d4 00       MOV $00+X, A

loc_04c2:
04c2:  6f          RET

NoteDispatch:
04c3:  ad ca       CMP Y, #$ca
04c5:  90 05       BCC $04cc
04c7:  3f df 07    CALL $07df
04ca:  8d a4       MOV Y, #$a4

loc_04cc:
04cc:  ad c8       CMP Y, #$c8
04ce:  b0 f2       BCS $04c2
04d0:  e4 1a       MOV A, $1a
04d2:  24 47       AND A, $47
04d4:  d0 ec       BNE $04c2
04d6:  dd          MOV A, Y
04d7:  28 7f       AND A, #$7f
04d9:  60          CLRC
04da:  84 50       ADC A, $50
04dc:  60          CLRC
04dd:  95 f0 02    ADC A, $02f0+X
04e0:  d5 7d 03    MOV $037d+X, A
04e3:  f5 a5 03    MOV A, $03a5+X
04e6:  d5 7c 03    MOV $037c+X, A
04e9:  f5 a1 02    MOV A, $02a1+X
04ec:  5c          LSR
04ed:  e8 00       MOV A, #$00
04ef:  7c          ROR
04f0:  d5 8c 02    MOV $028c+X, A
04f3:  e8 00       MOV A, #$00
04f5:  d4 ac       MOV $ac+X, A
04f7:  d5 00 01    MOV $0100+X, A
04fa:  d5 c8 02    MOV $02c8+X, A
04fd:  d4 c0       MOV $c0+X, A
04ff:  09 47 5e    OR $5e, $47
0502:  09 47 45    OR $45, $47
0505:  f5 64 02    MOV A, $0264+X
0508:  d4 98       MOV $98+X, A
050a:  f0 1e       BEQ $052a
050c:  f5 65 02    MOV A, $0265+X
050f:  d4 99       MOV $99+X, A
0511:  f5 78 02    MOV A, $0278+X
0514:  d0 0a       BNE $0520
0516:  f5 7d 03    MOV A, $037d+X
0519:  80          SETC
051a:  b5 79 02    SBC A, $0279+X
051d:  d5 7d 03    MOV $037d+X, A

loc_0520:
0520:  f5 79 02    MOV A, $0279+X
0523:  60          CLRC
0524:  95 7d 03    ADC A, $037d+X
0527:  3f 15 0a    CALL $0a15

loc_052a:
052a:  3f 2d 0a    CALL $0a2d

PitchCalcEntry:
052d:  8d 00       MOV Y, #$00
052f:  e4 11       MOV A, $11
0531:  80          SETC
0532:  a8 34       SBC A, #$34
0534:  b0 09       BCS $053f
0536:  e4 11       MOV A, $11
0538:  80          SETC
0539:  a8 13       SBC A, #$13
053b:  b0 06       BCS $0543
053d:  dc          DEC
053e:  1c          ASL

loc_053f:
053f:  7a 10       ADDW $10+Y, A
0541:  da 10       MOVW $10, YA

loc_0543:
0543:  4d          PUSH
0544:  e4 11       MOV A, $11
0546:  1c          ASL
0547:  8d 00       MOV Y, #$00
0549:  cd 18       MOV X, #$18
054b:  9e          DIV YA
054c:  5d          MOV X, A
054d:  f6 73 0d    MOV A, $0d73+Y
0550:  c4 15       MOV $15, A
0552:  f6 72 0d    MOV A, $0d72+Y
0555:  c4 14       MOV $14, A
0557:  f6 75 0d    MOV A, $0d75+Y
055a:  2d          PUSH
055b:  f6 74 0d    MOV A, $0d74+Y
055e:  ee          POP
055f:  9a 14       SUBW $14+Y, A
0561:  eb 10       MOV Y, $10
0563:  cf          MUL
0564:  dd          MOV A, Y
0565:  8d 00       MOV Y, #$00
0567:  7a 14       ADDW $14+Y, A
0569:  cb 15       MOV $15, Y
056b:  1c          ASL
056c:  2b 15       ROL $15
056e:  c4 14       MOV $14, A
0570:  2f 04       BRA $0576

loc_0572:
0572:  4b 15       LSR $15
0574:  7c          ROR
0575:  3d          INC

loc_0576:
0576:  c8 06       CMP X, #$06
0578:  d0 f8       BNE $0572
057a:  c4 14       MOV $14, A
057c:  ce          POP
057d:  f5 28 02    MOV A, $0228+X
0580:  eb 15       MOV Y, $15
0582:  cf          MUL
0583:  da 16       MOVW $16, YA
0585:  f5 28 02    MOV A, $0228+X
0588:  eb 14       MOV Y, $14
058a:  cf          MUL
058b:  6d          PUSH
058c:  f5 29 02    MOV A, $0229+X
058f:  eb 14       MOV Y, $14
0591:  cf          MUL
0592:  7a 16       ADDW $16+Y, A
0594:  da 16       MOVW $16, YA
0596:  f5 29 02    MOV A, $0229+X
0599:  eb 15       MOV Y, $15
059b:  cf          MUL
059c:  fd          MOV
059d:  ae          POP
059e:  7a 16       ADDW $16+Y, A
05a0:  da 16       MOVW $16, YA
05a2:  f5 8c 0d    MOV A, $0d8c+X
05a5:  08 02       OR A, #$02
05a7:  fd          MOV
05a8:  e4 16       MOV A, $16
05aa:  3f b0 05    CALL $05b0
05ad:  fc          INC
05ae:  e4 17       MOV A, $17

WriteDSPGuarded:
05b0:  2d          PUSH
05b1:  e4 47       MOV A, $47
05b3:  24 1a       AND A, $1a
05b5:  ae          POP
05b6:  d0 04       BNE $05bc

WriteDSP:
05b8:  cb f2       MOV $f2, Y
05ba:  c4 f3       MOV $f3, A

loc_05bc:
05bc:  6f          RET

ReadPhraseWord:
05bd:  8d 00       MOV Y, #$00
05bf:  f7 40       MOV A, [$40]+Y
05c1:  3a 40       INCW $40
05c3:  2d          PUSH
05c4:  f7 40       MOV A, [$40]+Y
05c6:  3a 40       INCW $40
05c8:  fd          MOV
05c9:  ae          POP
05ca:  6f          RET

HandleFadeIn:
05cb:  8f ff 30    MOV $30, #$ff
05ce:  8f 7f 31    MOV $31, #$7f
05d1:  c4 04       MOV $04, A
05d3:  6f          RET

InitSampleEndPtr:
05d4:  2d          PUSH
05d5:  e5 fd 0f    MOV A, $0ffd
05d8:  ec fe 0f    MOV Y, $0ffe
05db:  da 3b       MOVW $3b, YA
05dd:  e8 00       MOV A, #$00
05df:  5d          MOV X, A

loc_05e0:
05e0:  c7 3b       MOV [$3b+X], A
05e2:  3a 3b       INCW $3b
05e4:  d0 fa       BNE $05e0
05e6:  ae          POP
05e7:  6f          RET

StopAllChannels:
05e8:  8f ff 46    MOV $46, #$ff
05eb:  8f 00 04    MOV $04, #$00
05ee:  a2 48       SET1 $48.5
05f0:  c2 48       SET1 $48.6
05f2:  e8 00       MOV A, #$00
05f4:  c4 e5       MOV $e5, A
05f6:  c4 e7       MOV $e7, A
05f8:  e8 01       MOV A, #$01
05fa:  3f a9 09    CALL $09a9
05fd:  6f          RET

SetEchoBit6:
05fe:  c2 48       SET1 $48.6
0600:  6f          RET

HandleBootHandshake:
0601:  3f 06 0f    CALL $0f06
0604:  c4 08       MOV $08, A
0606:  c4 04       MOV $04, A
0608:  6f          RET

DispatchCommand:
0609:  68 f0       CMP A, #$f0
060b:  f0 db       BEQ $05e8
060d:  68 f1       CMP A, #$f1
060f:  f0 ba       BEQ $05cb
0611:  68 f2       CMP A, #$f2
0613:  f0 e9       BEQ $05fe
0615:  68 ff       CMP A, #$ff
0617:  f0 e8       BEQ $0601
0619:  6f          RET

PlaySong:
061a:  c4 04       MOV $04, A
061c:  1c          ASL
061d:  f0 26       BEQ $0645
061f:  3f d4 05    CALL $05d4
0622:  5d          MOV X, A
0623:  f5 ff 0f    MOV A, $0fff+X
0626:  fd          MOV
0627:  f5 fe 0f    MOV A, $0ffe+X
062a:  da 40       MOVW $40, YA
062c:  8f 02 0c    MOV $0c, #$02
062f:  e8 00       MOV A, #$00
0631:  c4 30       MOV $30, A
0633:  c4 5f       MOV $5f, A
0635:  c4 39       MOV $39, A
0637:  c4 35       MOV $35, A
0639:  c4 36       MOV $36, A
063b:  c4 e5       MOV $e5, A
063d:  c4 e7       MOV $e7, A
063f:  d2 48       CLR1 $48.6
0641:  e8 ff       MOV A, #$ff
0643:  c4 f7       MOV $f7, A

UpdateEnableMask:
0645:  e4 1a       MOV A, $1a
0647:  48 ff       EOR A, #$ff
0649:  0e 46 00    TSET1 $0046
064c:  6f          RET

ResetAllChannels:
064d:  cd 0e       MOV X, #$0e
064f:  8f 80 47    MOV $47, #$80

loc_0652:
0652:  e8 ff       MOV A, #$ff
0654:  d5 05 03    MOV $0305+X, A
0657:  e8 0a       MOV A, #$0a
0659:  3f 49 08    CALL $0849
065c:  d5 15 02    MOV $0215+X, A
065f:  d5 a5 03    MOV $03a5+X, A
0662:  d5 f0 02    MOV $02f0+X, A
0665:  d5 64 02    MOV $0264+X, A
0668:  d4 ad       MOV $ad+X, A
066a:  d4 c1       MOV $c1+X, A
066c:  1d          DEC
066d:  1d          DEC
066e:  4b 47       LSR $47
0670:  d0 e0       BNE $0652
0672:  c4 5a       MOV $5a, A
0674:  c4 68       MOV $68, A
0676:  c4 54       MOV $54, A
0678:  c4 50       MOV $50, A
067a:  c4 42       MOV $42, A
067c:  8f c0 59    MOV $59, #$c0
067f:  8f 20 53    MOV $53, #$20

loc_0682:
0682:  6f          RET

ProcessSequenceTick:
0683:  eb 08       MOV Y, $08
0685:  e4 00       MOV A, $00
0687:  68 f0       CMP A, #$f0
0689:  90 03       BCC $068e
068b:  5f 09 06    JMP $0609

loc_068e:
068e:  c4 08       MOV $08, A
0690:  7e 00       CMP $00, Y
0692:  d0 86       BNE $061a
0694:  e4 04       MOV A, $04
0696:  f0 ea       BEQ $0682
0698:  d2 48       CLR1 $48.6
069a:  e4 0c       MOV A, $0c
069c:  f0 52       BEQ $06f0
069e:  6e 0c ac    DBNZ $0c, $064d

PhraseListLoop:
06a1:  3f bd 05    CALL $05bd
06a4:  d0 19       BNE $06bf
06a6:  fd          MOV
06a7:  d0 05       BNE $06ae
06a9:  c4 f7       MOV $f7, A
06ab:  5f 1a 06    JMP $061a

loc_06ae:
06ae:  8b 42       DEC $42
06b0:  10 02       BPL $06b4
06b2:  c4 42       MOV $42, A

loc_06b4:
06b4:  3f bd 05    CALL $05bd
06b7:  f8 42       MOV X, $42
06b9:  f0 e6       BEQ $06a1
06bb:  da 40       MOVW $40, YA
06bd:  2f e2       BRA $06a1

LoadPattern:
06bf:  da 16       MOVW $16, YA
06c1:  8d 0f       MOV Y, #$0f

loc_06c3:
06c3:  f7 16       MOV A, [$16]+Y
06c5:  d6 d4 00    MOV $00d4+Y, A
06c8:  dc          DEC
06c9:  10 f8       BPL $06c3
06cb:  cd 00       MOV X, #$00
06cd:  8f 01 47    MOV $47, #$01

loc_06d0:
06d0:  f4 d5       MOV A, $d5+X
06d2:  f0 0a       BEQ $06de
06d4:  f5 15 02    MOV A, $0215+X
06d7:  d0 05       BNE $06de
06d9:  e8 00       MOV A, #$00
06db:  3f df 07    CALL $07df

loc_06de:
06de:  e8 00       MOV A, #$00
06e0:  d5 b8 03    MOV $03b8+X, A
06e3:  d4 84       MOV $84+X, A
06e5:  d4 85       MOV $85+X, A
06e7:  bc          INC
06e8:  d4 70       MOV $70+X, A
06ea:  3d          INC
06eb:  3d          INC
06ec:  0b 47       ASL $47
06ee:  d0 e0       BNE $06d0

ChannelTickLoop:
06f0:  cd 00       MOV X, #$00
06f2:  d8 5e       MOV $5e, X
06f4:  8f 01 47    MOV $47, #$01

loc_06f7:
06f7:  d8 44       MOV $44, X
06f9:  f4 d5       MOV A, $d5+X
06fb:  f0 6c       BEQ $0769
06fd:  9b 70       DEC $70+X
06ff:  d0 62       BNE $0763

ChannelReadByte:
0701:  3f d5 07    CALL $07d5
0704:  d0 1d       BNE $0723
0706:  f5 b8 03    MOV A, $03b8+X
0709:  f0 96       BEQ $06a1
070b:  3f 41 09    CALL $0941
070e:  f5 b8 03    MOV A, $03b8+X
0711:  9c          DEC
0712:  d5 b8 03    MOV $03b8+X, A
0715:  d0 ea       BNE $0701
0717:  f5 3c 02    MOV A, $023c+X
071a:  d4 d4       MOV $d4+X, A
071c:  f5 3d 02    MOV A, $023d+X
071f:  d4 d5       MOV $d5+X, A
0721:  2f de       BRA $0701

HandleNote:
0723:  30 20       BMI $0745
0725:  d5 00 02    MOV $0200+X, A
0728:  3f d5 07    CALL $07d5
072b:  30 18       BMI $0745
072d:  2d          PUSH
072e:  9f          XCN
072f:  28 07       AND A, #$07
0731:  fd          MOV
0732:  f6 00 2f    MOV A, $2f00+Y
0735:  d5 01 02    MOV $0201+X, A
0738:  ae          POP
0739:  28 0f       AND A, #$0f
073b:  fd          MOV
073c:  f6 08 2f    MOV A, $2f08+Y
073f:  d5 14 02    MOV $0214+X, A
0742:  3f d5 07    CALL $07d5

HandleOpcode:
0745:  68 e0       CMP A, #$e0
0747:  90 05       BCC $074e
0749:  3f c3 07    CALL $07c3
074c:  2f b3       BRA $0701

HandleNotePlay:
074e:  3f c3 04    CALL $04c3
0751:  f5 00 02    MOV A, $0200+X
0754:  d4 70       MOV $70+X, A
0756:  fd          MOV
0757:  f5 01 02    MOV A, $0201+X
075a:  cf          MUL
075b:  dd          MOV A, Y
075c:  d0 01       BNE $075f
075e:  bc          INC

loc_075f:
075f:  d4 71       MOV $71+X, A
0761:  2f 03       BRA $0766

HandleGateTimer:
0763:  3f 5c 0b    CALL $0b5c

loc_0766:
0766:  3f f5 09    CALL $09f5

loc_0769:
0769:  3d          INC
076a:  3d          INC
076b:  0b 47       ASL $47
076d:  d0 88       BNE $06f7

PostChannelProcess:
076f:  e4 30       MOV A, $30
0771:  f0 03       BEQ $0776
0773:  8f ff 5e    MOV $5e, #$ff

loc_0776:
0776:  e4 54       MOV A, $54
0778:  f0 0b       BEQ $0785
077a:  ba 56       MOVW YA, $56
077c:  7a 52       ADDW $52+Y, A
077e:  6e 54 02    DBNZ $54, $0783
0781:  ba 54       MOVW YA, $54

loc_0783:
0783:  da 52       MOVW $52, YA

loc_0785:
0785:  e4 68       MOV A, $68
0787:  f0 15       BEQ $079e
0789:  ba 64       MOVW YA, $64
078b:  7a 60       ADDW $60+Y, A
078d:  da 60       MOVW $60, YA
078f:  ba 66       MOVW YA, $66
0791:  7a 62       ADDW $62+Y, A
0793:  6e 68 06    DBNZ $68, $079c
0796:  ba 68       MOVW YA, $68
0798:  da 60       MOVW $60, YA
079a:  eb 6a       MOV Y, $6a

loc_079c:
079c:  da 62       MOVW $62, YA

loc_079e:
079e:  e4 5a       MOV A, $5a
07a0:  f0 0e       BEQ $07b0
07a2:  ba 5c       MOVW YA, $5c
07a4:  7a 58       ADDW $58+Y, A
07a6:  6e 5a 02    DBNZ $5a, $07ab
07a9:  ba 5a       MOVW YA, $5a

loc_07ab:
07ab:  da 58       MOVW $58, YA
07ad:  8f ff 5e    MOV $5e, #$ff

PerChannelEffects:
07b0:  cd 00       MOV X, #$00
07b2:  8f 01 47    MOV $47, #$01

loc_07b5:
07b5:  f4 d5       MOV A, $d5+X
07b7:  f0 03       BEQ $07bc
07b9:  3f a5 0a    CALL $0aa5

loc_07bc:
07bc:  3d          INC
07bd:  3d          INC
07be:  0b 47       ASL $47
07c0:  d0 f3       BNE $07b5
07c2:  6f          RET

OpcodeDispatch:
07c3:  1c          ASL
07c4:  fd          MOV
07c5:  f6 95 09    MOV A, $0995+Y
07c8:  2d          PUSH
07c9:  f6 94 09    MOV A, $0994+Y
07cc:  2d          PUSH
07cd:  dd          MOV A, Y
07ce:  5c          LSR
07cf:  fd          MOV
07d0:  f6 2a 0a    MOV A, $0a2a+Y
07d3:  f0 08       BEQ $07dd

ReadTrackByte:
07d5:  e7 d4       MOV A, [$d4+X]

loc_07d7:
07d7:  bb d4       INC $d4+X
07d9:  d0 02       BNE $07dd
07db:  bb d5       INC $d5+X

loc_07dd:
07dd:  fd          MOV
07de:  6f          RET

Handler_E0_SetInstrument:
07df:  d5 15 02    MOV $0215+X, A
07e2:  eb 34       MOV Y, $34
07e4:  d0 0f       BNE $07f5
07e6:  fd          MOV
07e7:  10 06       BPL $07ef
07e9:  80          SETC
07ea:  a8 ca       SBC A, #$ca
07ec:  60          CLRC
07ed:  84 5f       ADC A, $5f

loc_07ef:
07ef:  60          CLRC
07f0:  85 ff 0f    ADC A, $0fff
07f3:  2f 09       BRA $07fe

loc_07f5:
07f5:  fd          MOV
07f6:  10 06       BPL $07fe
07f8:  80          SETC
07f9:  a8 ca       SBC A, #$ca
07fb:  60          CLRC
07fc:  84 39       ADC A, $39

loc_07fe:
07fe:  8d 06       MOV Y, #$06
0800:  cf          MUL
0801:  da 14       MOVW $14, YA
0803:  60          CLRC
0804:  98 00 14    ADC $14, #$00
0807:  98 2e 15    ADC $15, #$2e
080a:  e4 1a       MOV A, $1a
080c:  24 47       AND A, $47
080e:  d0 38       BNE $0848
0810:  4d          PUSH
0811:  f5 8c 0d    MOV A, $0d8c+X
0814:  08 04       OR A, #$04
0816:  5d          MOV X, A
0817:  8d 00       MOV Y, #$00
0819:  f7 14       MOV A, [$14]+Y
081b:  10 0e       BPL $082b
081d:  28 1f       AND A, #$1f
081f:  38 20 48    AND $48, #$20
0822:  0e 48 00    TSET1 $0048
0825:  09 47 49    OR $49, $47
0828:  dd          MOV A, Y
0829:  2f 07       BRA $0832

loc_082b:
082b:  e4 47       MOV A, $47
082d:  4e 49 00    TCLR1 $0049

loc_0830:
0830:  f7 14       MOV A, [$14]+Y

loc_0832:
0832:  d8 f2       MOV $f2, X
0834:  c4 f3       MOV $f3, A
0836:  3d          INC
0837:  fc          INC
0838:  ad 04       CMP Y, #$04
083a:  d0 f4       BNE $0830
083c:  ce          POP
083d:  f7 14       MOV A, [$14]+Y
083f:  d5 29 02    MOV $0229+X, A
0842:  fc          INC
0843:  f7 14       MOV A, [$14]+Y
0845:  d5 28 02    MOV $0228+X, A

loc_0848:
0848:  6f          RET

Handler_E1_Pan:
0849:  d5 69 03    MOV $0369+X, A
084c:  28 1f       AND A, #$1f
084e:  d5 41 03    MOV $0341+X, A
0851:  e8 00       MOV A, #$00
0853:  d5 40 03    MOV $0340+X, A
0856:  6f          RET

Handler_E2_PanFade:
0857:  d4 85       MOV $85+X, A
0859:  2d          PUSH
085a:  3f d5 07    CALL $07d5
085d:  d5 68 03    MOV $0368+X, A
0860:  80          SETC
0861:  b5 41 03    SBC A, $0341+X
0864:  ce          POP
0865:  3f 38 0a    CALL $0a38
0868:  d5 54 03    MOV $0354+X, A
086b:  dd          MOV A, Y
086c:  d5 55 03    MOV $0355+X, A
086f:  6f          RET

Handler_E3_Vibrato:
0870:  d5 a0 02    MOV $02a0+X, A
0873:  3f d5 07    CALL $07d5
0876:  d5 8d 02    MOV $028d+X, A
0879:  3f d5 07    CALL $07d5

Handler_E4_VibratoOff:
087c:  d4 ad       MOV $ad+X, A
087e:  d5 b5 02    MOV $02b5+X, A
0881:  e8 00       MOV A, #$00
0883:  d5 a1 02    MOV $02a1+X, A
0886:  6f          RET

Handler_F0_AmplMod:
0887:  d5 a1 02    MOV $02a1+X, A
088a:  2d          PUSH
088b:  8d 00       MOV Y, #$00
088d:  f4 ad       MOV A, $ad+X
088f:  ce          POP
0890:  9e          DIV YA
0891:  f8 44       MOV X, $44
0893:  d5 b4 02    MOV $02b4+X, A
0896:  6f          RET

Handler_E5_MainVolume:
0897:  dd          MOV A, Y
0898:  80          SETC
0899:  a8 00       SBC A, #$00
089b:  fd          MOV
089c:  e8 00       MOV A, #$00
089e:  da 58       MOVW $58, YA
08a0:  6f          RET

Handler_E6_VolumeFade:
08a1:  c4 5a       MOV $5a, A
08a3:  3f d5 07    CALL $07d5
08a6:  c4 5b       MOV $5b, A
08a8:  80          SETC
08a9:  a4 59       SBC A, $59
08ab:  f8 5a       MOV X, $5a
08ad:  3f 38 0a    CALL $0a38
08b0:  da 5c       MOVW $5c, YA
08b2:  6f          RET

Handler_E7_Tempo:
08b3:  e4 34       MOV A, $34
08b5:  d0 04       BNE $08bb
08b7:  e8 00       MOV A, #$00
08b9:  da 52       MOVW $52, YA
08bb:  6f          RET

Handler_E8_TempoFade:
08bc:  c4 54       MOV $54, A
08be:  3f d5 07    CALL $07d5
08c1:  c4 55       MOV $55, A
08c3:  80          SETC
08c4:  a4 53       SBC A, $53
08c6:  f8 54       MOV X, $54
08c8:  3f 38 0a    CALL $0a38
08cb:  da 56       MOVW $56, YA
08cd:  6f          RET

Handler_E9_GlobalTranspose:
08ce:  c4 50       MOV $50, A
08d0:  6f          RET

Handler_EA_PerVoiceTranspose:
08d1:  d5 f0 02    MOV $02f0+X, A
08d4:  6f          RET

Handler_EB_Tremolo:
08d5:  d5 dc 02    MOV $02dc+X, A
08d8:  3f d5 07    CALL $07d5
08db:  d5 c9 02    MOV $02c9+X, A
08de:  3f d5 07    CALL $07d5

Handler_EC_ADSRAttack:
08e1:  d4 c1       MOV $c1+X, A
08e3:  6f          RET

Handler_F1_ADSROverride:
08e4:  e8 01       MOV A, #$01
08e6:  2f 02       BRA $08ea

Handler_F2_PitchEnvelope:
08e8:  e8 00       MOV A, #$00
08ea:  d5 78 02    MOV $0278+X, A
08ed:  dd          MOV A, Y
08ee:  d5 65 02    MOV $0265+X, A
08f1:  3f d5 07    CALL $07d5
08f4:  d5 64 02    MOV $0264+X, A
08f7:  3f d5 07    CALL $07d5
08fa:  d5 79 02    MOV $0279+X, A
08fd:  6f          RET

Handler_F3_PitchEnvOff:
08fe:  d5 64 02    MOV $0264+X, A
0901:  6f          RET

Handler_ED_ChannelVolume:
0902:  d5 05 03    MOV $0305+X, A
0905:  e8 00       MOV A, #$00
0907:  d5 04 03    MOV $0304+X, A
090a:  6f          RET

Handler_EE_ChannelVolFade:
090b:  d4 84       MOV $84+X, A
090d:  2d          PUSH
090e:  3f d5 07    CALL $07d5
0911:  d5 2c 03    MOV $032c+X, A
0914:  80          SETC
0915:  b5 05 03    SBC A, $0305+X
0918:  ce          POP
0919:  3f 38 0a    CALL $0a38
091c:  d5 18 03    MOV $0318+X, A
091f:  dd          MOV A, Y
0920:  d5 19 03    MOV $0319+X, A
0923:  6f          RET

Handler_F4_Tuning:
0924:  d5 a5 03    MOV $03a5+X, A
0927:  6f          RET

Handler_EF_Subcommand:
0928:  d5 50 02    MOV $0250+X, A
092b:  3f d5 07    CALL $07d5
092e:  d5 51 02    MOV $0251+X, A
0931:  3f d5 07    CALL $07d5
0934:  d5 b8 03    MOV $03b8+X, A
0937:  f4 d4       MOV A, $d4+X
0939:  d5 3c 02    MOV $023c+X, A
093c:  f4 d5       MOV A, $d5+X
093e:  d5 3d 02    MOV $023d+X, A

loc_0941:
0941:  f5 50 02    MOV A, $0250+X
0944:  d4 d4       MOV $d4+X, A
0946:  f5 51 02    MOV A, $0251+X
0949:  d4 d5       MOV $d5+X, A
094b:  6f          RET

Handler_F5_EchoOn:
094c:  c4 4a       MOV $4a, A
094e:  3f d5 07    CALL $07d5
0951:  e8 00       MOV A, #$00
0953:  da 60       MOVW $60, YA
0955:  3f d5 07    CALL $07d5
0958:  e8 00       MOV A, #$00
095a:  da 62       MOVW $62, YA
095c:  b2 48       CLR1 $48.5
095e:  6f          RET

Handler_F8_SubroutineCall:
095f:  c4 68       MOV $68, A
0961:  3f d5 07    CALL $07d5
0964:  c4 69       MOV $69, A
0966:  80          SETC
0967:  a4 61       SBC A, $61
0969:  f8 68       MOV X, $68
096b:  3f 38 0a    CALL $0a38
096e:  da 64       MOVW $64, YA
0970:  3f d5 07    CALL $07d5
0973:  c4 6a       MOV $6a, A
0975:  80          SETC
0976:  a4 63       SBC A, $63
0978:  f8 68       MOV X, $68
097a:  3f 38 0a    CALL $0a38
097d:  da 66       MOVW $66, YA
097f:  6f          RET

Handler_F6_EchoOff:
0980:  da 60       MOVW $60, YA
0982:  da 62       MOVW $62, YA
0984:  a2 48       SET1 $48.5
0986:  6f          RET

Handler_F7_EchoFIR:
0987:  3f a9 09    CALL $09a9
098a:  3f d5 07    CALL $07d5
098d:  c4 4e       MOV $4e, A
098f:  3f d5 07    CALL $07d5
0992:  8d 08       MOV Y, #$08
0994:  cf          MUL
0995:  5d          MOV X, A
0996:  8d 0f       MOV Y, #$0f
0998:  f5 3e 0d    MOV A, $0d3e+X
099b:  3f b8 05    CALL $05b8
099e:  3d          INC
099f:  dd          MOV A, Y
09a0:  60          CLRC
09a1:  88 10       ADC A, #$10
09a3:  fd          MOV
09a4:  10 f2       BPL $0998
09a6:  f8 44       MOV X, $44
09a8:  6f          RET

VolumeControlUpdate:
09a9:  c4 4d       MOV $4d, A
09ab:  8d 7d       MOV Y, #$7d
09ad:  cb f2       MOV $f2, Y
09af:  e4 f3       MOV A, $f3
09b1:  64 4d       CMP A, $4d
09b3:  f0 29       BEQ $09de
09b5:  28 0f       AND A, #$0f
09b7:  48 ff       EOR A, #$ff
09b9:  f3 4c 03    BBC $4c.7, $09bf
09bc:  60          CLRC
09bd:  84 4c       ADC A, $4c

loc_09bf:
09bf:  c4 4c       MOV $4c, A
09c1:  8d 04       MOV Y, #$04

loc_09c3:
09c3:  f6 5d 0d    MOV A, $0d5d+Y
09c6:  c4 f2       MOV $f2, A
09c8:  e8 00       MOV A, #$00
09ca:  c4 f3       MOV $f3, A
09cc:  fe f5       DBNZ Y, $09c3
09ce:  e4 48       MOV A, $48
09d0:  08 20       OR A, #$20
09d2:  8d 6c       MOV Y, #$6c
09d4:  3f b8 05    CALL $05b8
09d7:  e4 4d       MOV A, $4d
09d9:  8d 7d       MOV Y, #$7d
09db:  3f b8 05    CALL $05b8

loc_09de:
09de:  1c          ASL
09df:  1c          ASL
09e0:  1c          ASL
09e1:  48 ff       EOR A, #$ff
09e3:  80          SETC
09e4:  88 ff       ADC A, #$ff
09e6:  8d 6d       MOV Y, #$6d
09e8:  5f b8 05    JMP $05b8

Handler_FA_Conditional:
09eb:  eb 34       MOV Y, $34
09ed:  d0 03       BNE $09f2
09ef:  c4 5f       MOV $5f, A
09f1:  6f          RET
09f2:  c4 39       MOV $39, A
09f4:  6f          RET

PitchSlideProcess:
09f5:  f4 98       MOV A, $98+X
09f7:  d0 33       BNE $0a2c
09f9:  e7 d4       MOV A, [$d4+X]
09fb:  68 f9       CMP A, #$f9
09fd:  d0 2d       BNE $0a2c
09ff:  3f d7 07    CALL $07d7
0a02:  3f d5 07    CALL $07d5

Handler_F9_LoopReturn:
0a05:  d4 99       MOV $99+X, A
0a07:  3f d5 07    CALL $07d5
0a0a:  d4 98       MOV $98+X, A
0a0c:  3f d5 07    CALL $07d5
0a0f:  60          CLRC
0a10:  84 50       ADC A, $50
0a12:  95 f0 02    ADC A, $02f0+X

loc_0a15:
0a15:  28 7f       AND A, #$7f
0a17:  d5 a4 03    MOV $03a4+X, A
0a1a:  80          SETC
0a1b:  b5 7d 03    SBC A, $037d+X
0a1e:  fb 98       MOV Y, $98+X
0a20:  6d          PUSH
0a21:  ce          POP
0a22:  3f 38 0a    CALL $0a38
0a25:  d5 90 03    MOV $0390+X, A
0a28:  dd          MOV A, Y
0a29:  d5 91 03    MOV $0391+X, A

loc_0a2c:
0a2c:  6f          RET

CopyCurrentPitch:
0a2d:  f5 7d 03    MOV A, $037d+X
0a30:  c4 11       MOV $11, A
0a32:  f5 7c 03    MOV A, $037c+X
0a35:  c4 10       MOV $10, A
0a37:  6f          RET

SignedDivide16:
0a38:  ed          NOTC
0a39:  6b 12       ROR $12
0a3b:  10 03       BPL $0a40
0a3d:  48 ff       EOR A, #$ff
0a3f:  bc          INC

loc_0a40:
0a40:  8d 00       MOV Y, #$00
0a42:  9e          DIV YA
0a43:  2d          PUSH
0a44:  e8 00       MOV A, #$00
0a46:  9e          DIV YA
0a47:  ee          POP
0a48:  f8 44       MOV X, $44

SignedMultiplyApply:
0a4a:  f3 12 06    BBC $12.7, $0a53
0a4d:  da 14       MOVW $14, YA
0a4f:  ba 0e       MOVW YA, $0e
0a51:  9a 14       SUBW $14+Y, A

loc_0a53:
0a53:  6f          RET

; ═══════════════════════════════════════════════════════════
; HandlerAddrTable: N-SPC opcode handler addresses (27 valid entries × u16 = 54 bytes, $E0–$FA; $FB–$FF overlap with ParamCountTable)
; ═══════════════════════════════════════════════════════════
0a54:  .dw $07df        ; $E0:SetInstrument
0a56:  .dw $0849        ; $E1:Pan
0a58:  .dw $0857        ; $E2:PanFade
0a5a:  .dw $0870        ; $E3:Vibrato
0a5c:  .dw $087c        ; $E4:VibratoOff
0a5e:  .dw $0897        ; $E5:MainVolume
0a60:  .dw $08a1        ; $E6:VolumeFade
0a62:  .dw $08b3        ; $E7:Tempo
0a64:  .dw $08bc        ; $E8:TempoFade
0a66:  .dw $08ce        ; $E9:GlobalTranspose
0a68:  .dw $08d1        ; $EA:PerVoiceTransp
0a6a:  .dw $08d5        ; $EB:Tremolo
0a6c:  .dw $08e1        ; $EC:ADSRAttack
0a6e:  .dw $0902        ; $ED:ChannelVol
0a70:  .dw $090b        ; $EE:ChanVolFade
0a72:  .dw $0928        ; $EF:Subcommand
0a74:  .dw $0887        ; $F0:AmplMod
0a76:  .dw $08e4        ; $F1:ADSROverride
0a78:  .dw $08e8        ; $F2:PitchEnv
0a7a:  .dw $08fe        ; $F3:PitchEnvOff
0a7c:  .dw $0924        ; $F4:Tuning
0a7e:  .dw $094c        ; $F5:EchoOn
0a80:  .dw $0980        ; $F6:EchoOff
0a82:  .dw $0987        ; $F7:EchoFIR
0a84:  .dw $095f        ; $F8:SubroutineCall
0a86:  .dw $0a05        ; $F9:LoopReturn
0a88:  .dw $09eb        ; $FA:Conditional

; ═══════════════════════════════════════════════════════════
; ParamCountTable: N-SPC opcode param counts (32 bytes, for opcodes $E0–$FF; first 10 bytes overlap HandlerAddrTable entries $FB–$FF)
; ═══════════════════════════════════════════════════════════
0a8a:  .db 01 01 02 03 00 01 02 01 02 01 01 03 00 01 02 03
0a9a:  .db 01 03 03 00 01 03 00 03 03 03 01 f4 84 f0 09 e8
0aaa:  04 8d       OR A, $8d
0aac:  03 9b 84    BBS $9b.0, $0a33
0aaf:  3f 38 0b    CALL $0b38
0ab2:  fb c1       MOV Y, $c1+X
0ab4:  f0 23       BEQ $0ad9
0ab6:  f5 dc 02    MOV A, $02dc+X
0ab9:  de c0 1b    CBNE $c0+X, $0ad7
0abc:  09 47 5e    OR $5e, $47
0abf:  f5 c8 02    MOV A, $02c8+X
0ac2:  10 07       BPL $0acb
0ac4:  fc          INC
0ac5:  d0 04       BNE $0acb
0ac7:  e8 80       MOV A, #$80
0ac9:  2f 04       BRA $0acf
0acb:  60          CLRC
0acc:  95 c9 02    ADC A, $02c9+X
0acf:  d5 c8 02    MOV $02c8+X, A
0ad2:  3f c0 0c    CALL $0cc0
0ad5:  2f 07       BRA $0ade
0ad7:  bb c0       INC $c0+X
0ad9:  e8 ff       MOV A, #$ff
0adb:  3f cb 0c    CALL $0ccb
0ade:  f4 85       MOV A, $85+X
0ae0:  f0 09       BEQ $0aeb
0ae2:  e8 40       MOV A, #$40
0ae4:  8d 03       MOV Y, #$03
0ae6:  9b 85       DEC $85+X
0ae8:  3f 38 0b    CALL $0b38
0aeb:  e4 47       MOV A, $47
0aed:  24 5e       AND A, $5e
0aef:  f0 46       BEQ $0b37
0af1:  f5 41 03    MOV A, $0341+X
0af4:  fd          MOV
0af5:  f5 40 03    MOV A, $0340+X
0af8:  da 10       MOVW $10, YA

VibratoTremoloUpdate:
0afa:  f5 8c 0d    MOV A, $0d8c+X
0afd:  c4 12       MOV $12, A

loc_0aff:
0aff:  eb 11       MOV Y, $11
0b01:  f6 ea 0c    MOV A, $0cea+Y
0b04:  80          SETC
0b05:  b6 e9 0c    SBC A, $0ce9+Y
0b08:  eb 10       MOV Y, $10
0b0a:  cf          MUL
0b0b:  dd          MOV A, Y
0b0c:  eb 11       MOV Y, $11
0b0e:  60          CLRC
0b0f:  96 e9 0c    ADC A, $0ce9+Y
0b12:  fd          MOV
0b13:  f5 2d 03    MOV A, $032d+X
0b16:  cf          MUL
0b17:  f5 69 03    MOV A, $0369+X
0b1a:  1c          ASL
0b1b:  13 12 01    BBC $12.0, $0b1f
0b1e:  1c          ASL

loc_0b1f:
0b1f:  dd          MOV A, Y
0b20:  90 03       BCC $0b25
0b22:  48 ff       EOR A, #$ff
0b24:  bc          INC

loc_0b25:
0b25:  eb 12       MOV Y, $12
0b27:  3f b0 05    CALL $05b0
0b2a:  8d 14       MOV Y, #$14
0b2c:  e8 00       MOV A, #$00
0b2e:  9a 10       SUBW $10+Y, A
0b30:  da 10       MOVW $10, YA
0b32:  ab 12       INC $12
0b34:  33 12 c8    BBC $12.1, $0aff
0b37:  6f          RET

EnvelopeApply:
0b38:  09 47 5e    OR $5e, $47

loc_0b3b:
0b3b:  da 14       MOVW $14, YA
0b3d:  da 16       MOVW $16, YA
0b3f:  4d          PUSH
0b40:  ee          POP
0b41:  60          CLRC
0b42:  d0 0a       BNE $0b4e
0b44:  98 27 16    ADC $16, #$27
0b47:  e8 00       MOV A, #$00
0b49:  d7 14       MOV [$14]+Y, A
0b4b:  fc          INC
0b4c:  2f 09       BRA $0b57

loc_0b4e:
0b4e:  98 14 16    ADC $16, #$14
0b51:  3f 55 0b    CALL $0b55
0b54:  fc          INC

loc_0b55:
0b55:  f7 14       MOV A, [$14]+Y

loc_0b57:
0b57:  97 16       ADC A, [$16]+Y
0b59:  d7 14       MOV [$14]+Y, A
0b5b:  6f          RET

GateTimerProcess:
0b5c:  f4 71       MOV A, $71+X
0b5e:  f0 64       BEQ $0bc4
0b60:  9b 71       DEC $71+X
0b62:  f0 05       BEQ $0b69
0b64:  e8 02       MOV A, #$02
0b66:  de 70 5b    CBNE $70+X, $0bc4

ScanAheadSetup:
0b69:  f5 b8 03    MOV A, $03b8+X
0b6c:  c4 17       MOV $17, A
0b6e:  f4 d4       MOV A, $d4+X
0b70:  fb d5       MOV Y, $d5+X

loc_0b72:
0b72:  da 14       MOVW $14, YA
0b74:  8d 00       MOV Y, #$00

ScanAheadLoop:
0b76:  f7 14       MOV A, [$14]+Y
0b78:  f0 1c       BEQ $0b96
0b7a:  30 05       BMI $0b81

loc_0b7c:
0b7c:  fc          INC
0b7d:  f7 14       MOV A, [$14]+Y
0b7f:  10 fb       BPL $0b7c

loc_0b81:
0b81:  68 c8       CMP A, #$c8
0b83:  f0 3f       BEQ $0bc4
0b85:  68 ef       CMP A, #$ef
0b87:  f0 29       BEQ $0bb2
0b89:  68 e0       CMP A, #$e0
0b8b:  90 30       BCC $0bbd
0b8d:  6d          PUSH
0b8e:  fd          MOV
0b8f:  ae          POP
0b90:  96 aa 09    ADC A, $09aa+Y
0b93:  fd          MOV
0b94:  2f e0       BRA $0b76

loc_0b96:
0b96:  e4 17       MOV A, $17
0b98:  f0 23       BEQ $0bbd
0b9a:  8b 17       DEC $17
0b9c:  d0 0a       BNE $0ba8
0b9e:  f5 3d 02    MOV A, $023d+X
0ba1:  2d          PUSH
0ba2:  f5 3c 02    MOV A, $023c+X
0ba5:  ee          POP
0ba6:  2f ca       BRA $0b72

loc_0ba8:
0ba8:  f5 51 02    MOV A, $0251+X
0bab:  2d          PUSH
0bac:  f5 50 02    MOV A, $0250+X
0baf:  ee          POP
0bb0:  2f c0       BRA $0b72

loc_0bb2:
0bb2:  fc          INC
0bb3:  f7 14       MOV A, [$14]+Y
0bb5:  2d          PUSH
0bb6:  fc          INC
0bb7:  f7 14       MOV A, [$14]+Y
0bb9:  fd          MOV
0bba:  ae          POP
0bbb:  2f b5       BRA $0b72

loc_0bbd:
0bbd:  e4 47       MOV A, $47
0bbf:  8d 5c       MOV Y, #$5c
0bc1:  3f b0 05    CALL $05b0

PitchBendProcess:
0bc4:  f2 13       CLR1 $13.7
0bc6:  f4 98       MOV A, $98+X
0bc8:  f0 13       BEQ $0bdd
0bca:  f4 99       MOV A, $99+X
0bcc:  f0 04       BEQ $0bd2
0bce:  9b 99       DEC $99+X
0bd0:  2f 0b       BRA $0bdd

loc_0bd2:
0bd2:  e2 13       SET1 $13.7
0bd4:  e8 7c       MOV A, #$7c
0bd6:  8d 03       MOV Y, #$03
0bd8:  9b 98       DEC $98+X
0bda:  3f 3b 0b    CALL $0b3b

PitchUpdateAndVolume:
0bdd:  3f 2d 0a    CALL $0a2d
0be0:  f4 ad       MOV A, $ad+X
0be2:  f0 4c       BEQ $0c30
0be4:  f5 a0 02    MOV A, $02a0+X
0be7:  de ac 44    CBNE $ac+X, $0c2e
0bea:  f5 00 01    MOV A, $0100+X
0bed:  75 a1 02    CMP A, $02a1+X
0bf0:  d0 05       BNE $0bf7
0bf2:  f5 b5 02    MOV A, $02b5+X
0bf5:  2f 0d       BRA $0c04

loc_0bf7:
0bf7:  40          SETP
0bf8:  bb 00       INC $00+X
0bfa:  20          CLRP
0bfb:  fd          MOV
0bfc:  f0 02       BEQ $0c00
0bfe:  f4 ad       MOV A, $ad+X

loc_0c00:
0c00:  60          CLRC
0c01:  95 b4 02    ADC A, $02b4+X

loc_0c04:
0c04:  d4 ad       MOV $ad+X, A
0c06:  f5 8c 02    MOV A, $028c+X
0c09:  60          CLRC
0c0a:  95 8d 02    ADC A, $028d+X
0c0d:  d5 8c 02    MOV $028c+X, A

VolumeCalcCore:
0c10:  c4 12       MOV $12, A
0c12:  1c          ASL
0c13:  1c          ASL
0c14:  90 02       BCC $0c18
0c16:  48 ff       EOR A, #$ff

loc_0c18:
0c18:  fd          MOV
0c19:  f4 ad       MOV A, $ad+X
0c1b:  68 f1       CMP A, #$f1
0c1d:  90 05       BCC $0c24
0c1f:  28 0f       AND A, #$0f
0c21:  cf          MUL
0c22:  2f 04       BRA $0c28

loc_0c24:
0c24:  cf          MUL
0c25:  dd          MOV A, Y
0c26:  8d 00       MOV Y, #$00

loc_0c28:
0c28:  3f ab 0c    CALL $0cab

loc_0c2b:
0c2b:  5f 2d 05    JMP $052d

loc_0c2e:
0c2e:  bb ac       INC $ac+X

loc_0c30:
0c30:  e3 13 f8    BBS $13.7, $0c2b
0c33:  6f          RET

SFXChannelProcess:
0c34:  f2 13       CLR1 $13.7
0c36:  f4 c1       MOV A, $c1+X
0c38:  f0 09       BEQ $0c43
0c3a:  f5 dc 02    MOV A, $02dc+X
0c3d:  de c0 03    CBNE $c0+X, $0c43
0c40:  3f b3 0c    CALL $0cb3

loc_0c43:
0c43:  f5 41 03    MOV A, $0341+X
0c46:  fd          MOV
0c47:  f5 40 03    MOV A, $0340+X
0c4a:  da 10       MOVW $10, YA
0c4c:  f4 85       MOV A, $85+X
0c4e:  f0 0a       BEQ $0c5a
0c50:  f5 55 03    MOV A, $0355+X
0c53:  fd          MOV
0c54:  f5 54 03    MOV A, $0354+X
0c57:  3f 95 0c    CALL $0c95

loc_0c5a:
0c5a:  f3 13 03    BBC $13.7, $0c60
0c5d:  3f fa 0a    CALL $0afa

loc_0c60:
0c60:  f2 13       CLR1 $13.7
0c62:  f5 7d 03    MOV A, $037d+X
0c65:  fd          MOV
0c66:  f5 7c 03    MOV A, $037c+X
0c69:  da 10       MOVW $10, YA
0c6b:  f4 98       MOV A, $98+X
0c6d:  f0 0e       BEQ $0c7d
0c6f:  f4 99       MOV A, $99+X
0c71:  d0 0a       BNE $0c7d
0c73:  f5 91 03    MOV A, $0391+X
0c76:  fd          MOV
0c77:  f5 90 03    MOV A, $0390+X
0c7a:  3f 95 0c    CALL $0c95

loc_0c7d:
0c7d:  f4 ad       MOV A, $ad+X
0c7f:  f0 af       BEQ $0c30
0c81:  f5 a0 02    MOV A, $02a0+X
0c84:  de ac a9    CBNE $ac+X, $0c30
0c87:  eb 51       MOV Y, $51
0c89:  f5 8d 02    MOV A, $028d+X
0c8c:  cf          MUL
0c8d:  dd          MOV A, Y
0c8e:  60          CLRC
0c8f:  95 8c 02    ADC A, $028c+X
0c92:  5f 10 0c    JMP $0c10

PitchBendApply:
0c95:  e2 13       SET1 $13.7
0c97:  cb 12       MOV $12, Y
0c99:  3f 4a 0a    CALL $0a4a
0c9c:  6d          PUSH
0c9d:  eb 51       MOV Y, $51
0c9f:  cf          MUL
0ca0:  cb 14       MOV $14, Y
0ca2:  8f 00 15    MOV $15, #$00
0ca5:  eb 51       MOV Y, $51
0ca7:  ae          POP
0ca8:  cf          MUL
0ca9:  7a 14       ADDW $14+Y, A

FinalPitchWrite:
0cab:  3f 4a 0a    CALL $0a4a
0cae:  7a 10       ADDW $10+Y, A
0cb0:  da 10       MOVW $10, YA
0cb2:  6f          RET

TremoloVolumeCalc:
0cb3:  e2 13       SET1 $13.7
0cb5:  eb 51       MOV Y, $51
0cb7:  f5 c9 02    MOV A, $02c9+X
0cba:  cf          MUL
0cbb:  dd          MOV A, Y
0cbc:  60          CLRC
0cbd:  95 c8 02    ADC A, $02c8+X

TremoloMultiply:
0cc0:  1c          ASL
0cc1:  90 02       BCC $0cc5
0cc3:  48 ff       EOR A, #$ff

loc_0cc5:
0cc5:  fb c1       MOV Y, $c1+X
0cc7:  cf          MUL
0cc8:  dd          MOV A, Y
0cc9:  48 ff       EOR A, #$ff

VolumeOutputPipeline:
0ccb:  eb 34       MOV Y, $34
0ccd:  d0 03       BNE $0cd2
0ccf:  eb 59       MOV Y, $59
0cd1:  cf          MUL

loc_0cd2:
0cd2:  f5 14 02    MOV A, $0214+X
0cd5:  cf          MUL
0cd6:  f5 05 03    MOV A, $0305+X
0cd9:  cf          MUL
0cda:  e4 30       MOV A, $30
0cdc:  f0 04       BEQ $0ce2
0cde:  e4 31       MOV A, $31
0ce0:  1c          ASL
0ce1:  cf          MUL

loc_0ce2:
0ce2:  dd          MOV A, Y
0ce3:  cf          MUL
0ce4:  dd          MOV A, Y
0ce5:  d5 2d 03    MOV $032d+X, A
0ce8:  6f          RET

; ═══════════════════════════════════════════════════════════
; PitchInterpolation: Pitch interpolation curve (18 bytes, quarter-sine shape)
; ═══════════════════════════════════════════════════════════
0ce9:  .db 00 01 03 07 0d 15 1e 29 34 42 51 5e 67 6e 73 77
0cf9:  .db 7a 7c

; ═══════════════════════════════════════════════════════════
; VibratoSineTable: Vibrato/tremolo sine wave LUT (67 bytes — unique to Soul Blazer, not in IoG)
; ═══════════════════════════════════════════════════════════
0cfb:  .db 7d 7e 7f 0a 0b 0c 0d 0e 0f 10 11 11 12 12 13 13
0d0b:  .db 13 14 14 14 14 14 13 13 13 12 12 11 11 10 0f 0e
0d1b:  .db 0d 0c 0b 0a 09 08 07 06 05 04 03 03 02 02 01 01
0d2b:  .db 01 00 00 00 00 00 01 01 01 02 02 03 03 04 05 06
0d3b:  .db 07 08 09

; ═══════════════════════════════════════════════════════════
; EnvelopeCurve: ADSR envelope curve table (24 bytes)
; ═══════════════════════════════════════════════════════════
0d3e:  .db 7f 00 00 00 00 00 00 00 58 bf db f0 fe 07 0c 0c
0d4e:  .db 0c 21 2b 2b 13 fe f3 f9

; ═══════════════════════════════════════════════════════════
; EnvelopeConfig: Envelope config / FIR coefficients (22 bytes)
; ═══════════════════════════════════════════════════════════
0d56:  .db 34 33 00 d9 e5 01 fc eb 2c 3c 0d 4d 6c 4c 5c 3d
0d66:  .db 2d 5c 61 63 4e 38

; ═══════════════════════════════════════════════════════════
; DSPRegTable: DSP register number table for channel output (6 bytes)
; ═══════════════════════════════════════════════════════════
0d6c:  .db 48 45 0e 49 4b 46

; ═══════════════════════════════════════════════════════════
; FreqTable: Frequency table (13 × u16 = 26 bytes, C through C+)
; ═══════════════════════════════════════════════════════════
0d72:  .dw $085f        ; C   = 2143
0d74:  .dw $08de        ; C#  = 2270
0d76:  .dw $0965        ; D   = 2405
0d78:  .dw $09f4        ; D#  = 2548
0d7a:  .dw $0a8c        ; E   = 2700
0d7c:  .dw $0b2c        ; F   = 2860
0d7e:  .dw $0bd6        ; F#  = 3030
0d80:  .dw $0c8b        ; G   = 3211
0d82:  .dw $0d4a        ; G#  = 3402
0d84:  .dw $0e14        ; A   = 3604
0d86:  .dw $0eea        ; A#  = 3818
0d88:  .dw $0fcd        ; B   = 4045
0d8a:  .dw $10be        ; C+  = 4286

; ═══════════════════════════════════════════════════════════
; OctaveShiftTable: Octave shift lookup (16 bytes)
; ═══════════════════════════════════════════════════════════
0d8c:  .db 00 00 10 00 20 00 30 00 40 00 50 00 60 00 70 00

; ═══════════════════════════════════════════════════════════
; SFXInitData: SFX init data / padding (4 bytes)
; ═══════════════════════════════════════════════════════════
0d9c:  .db 60 00 70 00

SFXHandler:
0da0:  fa 1a 37    MOV $37, $1a
0da3:  38 3f 1a    AND $1a, #$3f
0da6:  8f ff 34    MOV $34, #$ff
0da9:  8f 00 5e    MOV $5e, #$00
0dac:  8f 40 47    MOV $47, #$40
0daf:  cd 10       MOV X, #$10
0db1:  e4 f6       MOV A, $f6
0db3:  f0 39       BEQ $0dee
0db5:  30 04       BMI $0dbb
0db7:  eb 35       MOV Y, $35
0db9:  d0 33       BNE $0dee

loc_0dbb:
0dbb:  2d          PUSH
0dbc:  0d          PUSH
0dbd:  09 47 46    OR $46, $47
0dc0:  09 47 37    OR $37, $47
0dc3:  09 47 36    OR $36, $47
0dc6:  3f 14 0e    CALL $0e14
0dc9:  8e          POP
0dca:  10 21       BPL $0ded
0dcc:  3f 79 0e    CALL $0e79
0dcf:  8f ff 35    MOV $35, #$ff
0dd2:  8f 00 3f    MOV $3f, #$00
0dd5:  8f 80 47    MOV $47, #$80
0dd8:  cd 12       MOV X, #$12
0dda:  ae          POP
0ddb:  09 47 46    OR $46, $47
0dde:  09 47 37    OR $37, $47
0de1:  09 47 36    OR $36, $47
0de4:  3f 14 0e    CALL $0e14
0de7:  e8 03       MOV A, #$03
0de9:  d4 70       MOV $70+X, A
0deb:  2f 1d       BRA $0e0a

loc_0ded:
0ded:  ae          POP

loc_0dee:
0dee:  3f 79 0e    CALL $0e79
0df1:  8f 80 47    MOV $47, #$80
0df4:  cd 12       MOV X, #$12
0df6:  e4 35       MOV A, $35
0df8:  d0 10       BNE $0e0a
0dfa:  e4 f7       MOV A, $f7
0dfc:  f0 0c       BEQ $0e0a
0dfe:  09 47 46    OR $46, $47
0e01:  09 47 37    OR $37, $47
0e04:  09 47 36    OR $36, $47
0e07:  3f 14 0e    CALL $0e14

SFXProcessChannel8:
0e0a:  3f 79 0e    CALL $0e79
0e0d:  8f 00 34    MOV $34, #$00
0e10:  fa 37 1a    MOV $1a, $37
0e13:  6f          RET

SFXInitChannel:
0e14:  1c          ASL
0e15:  4d          PUSH
0e16:  5d          MOV X, A
0e17:  f5 01 24    MOV A, $2401+X
0e1a:  fd          MOV
0e1b:  f5 00 24    MOV A, $2400+X
0e1e:  ce          POP
0e1f:  d4 d4       MOV $d4+X, A
0e21:  db d5       MOV $d5+X, Y
0e23:  e8 dc       MOV A, #$dc
0e25:  d5 05 03    MOV $0305+X, A
0e28:  e8 0a       MOV A, #$0a
0e2a:  3f 49 08    CALL $0849
0e2d:  e8 00       MOV A, #$00
0e2f:  d5 15 02    MOV $0215+X, A
0e32:  d5 a5 03    MOV $03a5+X, A
0e35:  d5 f0 02    MOV $02f0+X, A
0e38:  d5 64 02    MOV $0264+X, A
0e3b:  d4 ad       MOV $ad+X, A
0e3d:  d4 c1       MOV $c1+X, A
0e3f:  d5 b8 03    MOV $03b8+X, A
0e42:  d4 84       MOV $84+X, A
0e44:  d4 85       MOV $85+X, A
0e46:  e8 02       MOV A, #$02
0e48:  d4 70       MOV $70+X, A
0e4a:  6f          RET

SFXStopChannel:
0e4b:  e4 47       MOV A, $47
0e4d:  48 ff       EOR A, #$ff
0e4f:  fd          MOV
0e50:  24 37       AND A, $37
0e52:  c4 37       MOV $37, A
0e54:  dd          MOV A, Y
0e55:  24 36       AND A, $36
0e57:  c4 36       MOV $36, A
0e59:  09 47 5e    OR $5e, $47
0e5c:  fa 47 5c    MOV $5c, $47
0e5f:  8f 00 34    MOV $34, #$00
0e62:  4d          PUSH
0e63:  7d          MOV A, X
0e64:  80          SETC
0e65:  a8 04       SBC A, #$04
0e67:  5d          MOV X, A
0e68:  f5 15 02    MOV A, $0215+X
0e6b:  3f df 07    CALL $07df
0e6e:  ce          POP
0e6f:  8f ff 34    MOV $34, #$ff
0e72:  e8 00       MOV A, #$00
0e74:  d4 d5       MOV $d5+X, A
0e76:  c4 35       MOV $35, A
0e78:  6f          RET

SFXChannelTick:
0e79:  f4 d5       MOV A, $d5+X
0e7b:  d0 01       BNE $0e7e
0e7d:  6f          RET

loc_0e7e:
0e7e:  e4 35       MOV A, $35
0e80:  f0 28       BEQ $0eaa
0e82:  09 47 5e    OR $5e, $47
0e85:  c8 12       CMP X, #$12
0e87:  d0 12       BNE $0e9b
0e89:  e4 3f       MOV A, $3f
0e8b:  ab 3f       INC $3f
0e8d:  5c          LSR
0e8e:  28 3f       AND A, #$3f
0e90:  fd          MOV
0e91:  f6 fe 0c    MOV A, $0cfe+Y
0e94:  08 c0       OR A, #$c0
0e96:  3f 49 08    CALL $0849
0e99:  2f 0f       BRA $0eaa

loc_0e9b:
0e9b:  e4 3f       MOV A, $3f
0e9d:  48 ff       EOR A, #$ff
0e9f:  bc          INC
0ea0:  5c          LSR
0ea1:  28 3f       AND A, #$3f
0ea3:  fd          MOV
0ea4:  f6 fe 0c    MOV A, $0cfe+Y
0ea7:  3f 49 08    CALL $0849

SFXPlaybackLoop:
0eaa:  d8 44       MOV $44, X
0eac:  9b 70       DEC $70+X
0eae:  d0 45       BNE $0ef5

SFXReadByte:
0eb0:  3f d5 07    CALL $07d5
0eb3:  f0 96       BEQ $0e4b
0eb5:  30 20       BMI $0ed7
0eb7:  d5 00 02    MOV $0200+X, A
0eba:  3f d5 07    CALL $07d5
0ebd:  30 18       BMI $0ed7
0ebf:  2d          PUSH
0ec0:  9f          XCN
0ec1:  28 07       AND A, #$07
0ec3:  fd          MOV
0ec4:  f6 00 2f    MOV A, $2f00+Y
0ec7:  d5 01 02    MOV $0201+X, A
0eca:  ae          POP
0ecb:  28 0f       AND A, #$0f
0ecd:  fd          MOV
0ece:  f6 08 2f    MOV A, $2f08+Y
0ed1:  d5 14 02    MOV $0214+X, A
0ed4:  3f d5 07    CALL $07d5

loc_0ed7:
0ed7:  68 e0       CMP A, #$e0
0ed9:  90 05       BCC $0ee0
0edb:  3f c3 07    CALL $07c3
0ede:  2f d0       BRA $0eb0

loc_0ee0:
0ee0:  3f c3 04    CALL $04c3
0ee3:  f5 00 02    MOV A, $0200+X
0ee6:  d4 70       MOV $70+X, A
0ee8:  fd          MOV
0ee9:  f5 01 02    MOV A, $0201+X
0eec:  cf          MUL
0eed:  dd          MOV A, Y
0eee:  d0 01       BNE $0ef1
0ef0:  bc          INC

loc_0ef1:
0ef1:  d4 71       MOV $71+X, A
0ef3:  2f 03       BRA $0ef8

loc_0ef5:
0ef5:  3f 5c 0b    CALL $0b5c

loc_0ef8:
0ef8:  3f f5 09    CALL $09f5
0efb:  e4 30       MOV A, $30
0efd:  f0 03       BEQ $0f02
0eff:  09 47 5e    OR $5e, $47

loc_0f02:
0f02:  3f a5 0a    CALL $0aa5
0f05:  6f          RET

BootHandshake:
0f06:  8d bb       MOV Y, #$bb
0f08:  e8 aa       MOV A, #$aa
0f0a:  da f4       MOVW $f4, YA

loc_0f0c:
0f0c:  e4 f4       MOV A, $f4
0f0e:  68 cc       CMP A, #$cc
0f10:  d0 fa       BNE $0f0c
0f12:  2f 1e       BRA $0f32

loc_0f14:
0f14:  eb f4       MOV Y, $f4
0f16:  d0 fc       BNE $0f14

loc_0f18:
0f18:  7e f4       CMP $f4, Y
0f1a:  d0 10       BNE $0f2c
0f1c:  cb f4       MOV $f4, Y
0f1e:  e4 f5       MOV A, $f5
0f20:  d6 00 00    MOV $0000+Y, A
0f23:  fc          INC
0f24:  d0 f2       BNE $0f18
0f26:  ac 22 0f    INC $0f22
0f29:  5f 18 0f    JMP $0f18

loc_0f2c:
0f2c:  10 ea       BPL $0f18
0f2e:  7e f4       CMP $f4, Y
0f30:  10 e6       BPL $0f18

BootLoadData:
0f32:  ba f6       MOVW YA, $f6
0f34:  c5 21 0f    MOV $0f21, A
0f37:  cc 22 0f    MOV $0f22, Y

; ═══════════════════════════════════════════════════════════
; DSPRegInitAndBoot: DSP register init values and boot tail (13 bytes)
; ═══════════════════════════════════════════════════════════
0f3a:  .db eb f4 e4 f5 cb f4 d0 d2 cd 31 d8 f1 6f
```