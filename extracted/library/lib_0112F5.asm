?BANK 02

?INCLUDE 'data_00BA0D'
?INCLUDE 'lib_shared_01112A'

!location_id                    1C6A

---------------------------------------------

code_0112F5 {
    LDX #$0000            ; {70389}
    TXY                   ; {70392}

  loc_0112F9:
    LDA $1A9E, Y          ; {70393}
    INY                   ; {70396}
    STA $04               ; {70397}
    LDA #$08              ; {70399}
    STA $0C               ; {70401}

  loc_011303:
    LDA $&data_00BA0D, X  ; {70403}
    BPL loc_01130B        ; {70406}
    BRL loc_011394        ; {70408}

  loc_01130B:
    LSR $04               ; {70411}
    BCC loc_011380        ; {70413}
    CMP $location_id      ; {70415}
    BNE loc_011380        ; {70418}
    LDA $&data_00BA0D+6, X ; {70420}
    ORA $&data_00BA0D+7, X ; {70423}
    BEQ loc_011380        ; {70426}
    PHX                   ; {70428}
    PHY                   ; {70429}
    LDA $&data_00BA0D+E, X ; {70430}
    ORA $&data_00BA0D+F, X ; {70433}
    BEQ loc_011363        ; {70436}
    REP #$20              ; {70438}
    LDA $&data_00BA0D+E, X ; {70440}
    AND #$00FF            ; {70443}
    ASL                   ; {70446}
    ASL                   ; {70447}
    ASL                   ; {70448}
    ASL                   ; {70449}
    STA $16               ; {70450}
    LDA $&data_00BA0D+F, X ; {70452}
    AND #$00FF            ; {70455}
    ASL                   ; {70458}
    ASL                   ; {70459}
    ASL                   ; {70460}
    ASL                   ; {70461}
    STA $18               ; {70462}
    LDA $&data_00BA0D+8, X ; {70464}
    LSR                   ; {70467}
    PHP                   ; {70468}
    TXA                   ; {70469}
    CLC                   ; {70470}
    ADC #$&data_00BA0D    ; {70471}
    TAX                   ; {70474}
    LDY #$1C6D            ; {70475}
    LDA #$0007            ; {70478}
    MVN #$01, #$^data_00BA0D ; {70481}
    PLP                   ; {70484}
    SEP #$20              ; {70485}
    BCS loc_01135E        ; {70487}
    JSR $&lib_shared_01112A.code_0111CB ; {70489}
    BRA loc_01137E        ; {70492}

  loc_01135E:
    JSR $&lib_shared_01112A.code_01125E ; {70494}
    BRA loc_01137E        ; {70497}

  loc_011363:
    REP #$20              ; {70499}
    TXA                   ; {70501}
    CLC                   ; {70502}
    ADC #$&data_00BA0D    ; {70503}
    TAX                   ; {70506}
    LDY #$1C6D            ; {70507}
    LDA #$0007            ; {70510}
    MVN #$01, #$^data_00BA0D ; {70513}
    SEP #$20              ; {70516}
    LDA #$03              ; {70518}
    STA $1C6E             ; {70520}
    JSR $&lib_shared_01112A.code_01112A ; {70523}

  loc_01137E:
    PLY                   ; {70526}
    PLX                   ; {70527}

  loc_011380:
    REP #$20              ; {70528}
    TXA                   ; {70530}
    CLC                   ; {70531}
    ADC #$0020            ; {70532}
    TAX                   ; {70535}
    SEP #$20              ; {70536}
    DEC $0C               ; {70538}
    BEQ loc_011391        ; {70540}
    BRL loc_011303        ; {70542}

  loc_011391:
    BRL loc_0112F9        ; {70545}

  loc_011394:
    RTL                   ; {70548}
}