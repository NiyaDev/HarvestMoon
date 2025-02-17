
section "wram", wram0[$C000]

ds $00A2
wC0A2:: db  ; $C0A2
            ; Seems to be a copy of rLCDC
ds 3
wC0A6:: db  ; $C0A6
wC0A7:: db  ; $C0A7
            ; Seems to be jump table offset
ds 2

wC0AA:: ds 16 ; $C0AA
              ; A SGB command packet is "decompressed" here

ds $0446

wC500:: db  ; $C500

ds $0650

wCB50:: db


section "wram1", wramx[$D000]

ds $0397

wD397:: db  ; $D397

ds $0002

; These could be Audio values
wD3A0:: db  ; $D3A0
wD3A1:: db  ; $D3A1
wD3A2:: db  ; $D3A2
wD3A3:: db  ; $D3A3

ds $0962

wDD00:: db  ; $DD00
wDD01:: db  ; $DD01

