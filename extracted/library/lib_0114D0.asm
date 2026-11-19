?BANK 02

?INCLUDE 'table_00AC96'

!location_id                    1C6A

---------------------------------------------

code_0114D0 {
    REP #$20              ; {70864}
    LDA $location_id      ; {70866}
    ASL                   ; {70869}
    TAX                   ; {70870}
    LDA $&table_00AC96, X ; {70871}
    SEC                   ; {70874}
    SBC #$&table_00AC96   ; {70875}
    STA $03B2             ; {70878}
    SEP #$20              ; {70881}
    RTL                   ; {70883}
}