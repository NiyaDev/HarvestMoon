
section "wram", wram0[$C000]

ds $00A2
wC0A2:: db  ; $C0A2
            ; Seems to be a copy of rLCDC
ds 3
wC0A6:: db  ; $C0A6
wC0A7:: db  ; $C0A7

ds $0458

wC500:: db  ; $C500


section "wram1", wramx[$D000]

ds $0397

wD397:: db  ; $D397

ds $0002

wD3A3:: db  ; $D3A3

ds $095C

wDD00:: db  ; $DD00

