
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

ds $0300

wD300:: db
wD301:: db
wD302:: db
wD303:: db
wD304:: db
wD305:: db
wD306:: db
wD307:: db
wD308:: db
wD309:: db
wD30A:: db
wD30B:: db
wD30C:: db
wD30D:: db
wD30E:: db
wD30F:: db

wD310:: db
wD311:: db
wD312:: db
wD313:: db
wD314:: db
wD315:: db
wD316:: db
wD317:: db
wD318:: db
wD319:: db
wD31A:: db
wD31B:: db
wD31C:: db
wD31D:: db
wD31E:: db
wD31F:: db

wD320:: db
wD321:: db
wD322:: db
wD323:: db
wD324:: db
wD325:: db
wD326:: db
wD327:: db
wD328:: db
wD329:: db
wD32A:: db
wD32B:: db
wD32C:: db
wD32D:: db
wD32E:: db
wD32F:: db

wD330:: db
wD331:: db

; Used in 24CD
wD332:: db ; 00
wD333:: db ; variable
wD334:: dw ; ptr?
wD336:: db
wD337:: db
wD338:: db
wD339:: db
wD33A:: db ; FF
wD33B:: db
wD33C:: db
wD33D:: db
wD33E:: db
wD33F:: db
wD340:: db
wD341:: db
wD342:: db
wD343:: db
wD344:: db
wD345:: db
wD346:: db
wD347:: db
wD348:: db
wD349:: db ; 00
wD34A:: db

; Used in 24CD
wD34B:: db ; 00
wD34C:: db ; variable
wD34D:: dw ; ptr?
wD34F:: db
wD350:: db
wD351:: db
wD352:: db
wD353:: db ; FF
wD354:: db
wD355:: db
wD356:: db
wD357:: db
wD358:: db
wD359:: db
wD35A:: db
wD35B:: db
wD35C:: db
wD35D:: db
wD35E:: db
wD35F:: db
wD360:: db
wD361:: db
wD362:: db ; 00
wD363:: db

; Used in 24CD
wD364:: db ; 00
wD365:: db ; variable
wD366:: dw ; ptr?
wD368:: db
wD369:: db
wD36A:: db
wD36B:: db
wD36C:: db ; FF
wD36D:: db
wD36E:: db
wD36F:: db
wD370:: db
wD371:: db
wD372:: db
wD373:: db
wD374:: db
wD375:: db
wD376:: db
wD377:: db
wD378:: db
wD379:: db
wD37A:: db
wD37B:: db ; 00
wD37C:: db

wD37D:: db ; 00
wD37E:: db ; variable
wD37F:: db ; ptr?
wD380:: db
wD381:: db
wD382:: db
wD383:: db
wD384:: db ; FF
wD385:: db
wD386:: db
wD387:: db
wD388:: db
wD389:: db
wD38A:: db
wD38B:: db
wD38C:: db
wD38D:: db
wD38E:: db
wD38F:: db
wD390:: db
wD391:: db
wD392:: db
wD393:: db ; 00
wD394:: db

wD395:: db
wD396:: db
wD397:: db
wD398:: db
wD399:: db
wD39A:: db
wD39B:: db
wD39C:: db
wD39D:: db
wD39E:: db
wD39F:: db


; These could be Audio values
wD3A0:: db  ; $D3A0
wD3A1:: db  ; $D3A1
wD3A2:: db  ; $D3A2
wD3A3:: db  ; $D3A3

ds $0962

wDD00:: db  ; $DD00
wDD01:: db  ; $DD01

