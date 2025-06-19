
;; Definitions
include "includes/hardware.inc"
include "includes/hardware_niya.inc"
include "src/macros.asm"

;; RAM
include "src/ram/sram.asm"
include "src/ram/wram.asm"
include "src/ram/hram.asm"

;; Home
include "src/resets.asm"
include "src/interrupts.asm"
include "src/home.asm"
include "src/bank0/jumptable_61.asm"


section "Entry", rom0[$0100]
EntryPoint::
  nop
  jp Start


section "Header", rom0[$0104]
ds $150 - @, 0 ; Make room for the header


section "Start", rom0[$0150]
Start::
  nop
  nop
  di

; Set SRAM bank to 0
  xor a
  ld [rRAMB],a

; Set ROM bank to 1
  ld a,1
  ld [rROMB0],a

; Set Stack pointer
  ld sp,$DFEF

; Zero out DMA function
  ld hl,hDMA
  ld bc,$007F
  call memclr

; Zero out $DD00->$DDFF
  ld hl,$DD00
  ld bc,$00FF
  call memclr

  call copy_dma

; Set BG palette to 0
  xor a
  ldh [rBGP],a
; Set Object palette 0 to 0
  xor a
  ldh [rOBP0],a
; Set Object palette 1 to 0 
  xor a
  ldh [rOBP1],a

; FUN_2426()
; TODO: 
  call FUN_2426

; Set hFF8D to 2
  ld a,2
  ldh [hFF8D],a

  call vblank_wait

; Zero out Viewport position
  xor a
  ldh [rSCY],a
  ldh [rSCX],a

; Enable Cart SRAM
  ld a,CART_SRAM_ENABLE
  ld [rRAMG],a

; Latch current time?
; Missing the first set to 0
  ld a,1
  ld [rRTCLATCH],a

; Zero out $DD00
; The part that uses this in wait_7000 isn't used
  xor a
  ld [wDD00],a

; Check if SuperGameboy
  call check_if_sgb
  jr nc,.no_sgb

  push hl
  push af

; Calls FUN_77A7() in bank 7
  banked_call 7, FUN_B7_77A7

  pop af
  pop hl

.no_sgb:
  di

.LAB_01AD:
  di

; Zero $FFFF
  xor a
  ldh [$FFFF],a

; Reset stack pointer
  ld sp,$DFEF

; memclr(hDMA,$007F)
  ld hl,hDMA
  ld bc,$007F
  call memclr

; Set $FF8D to 2
  ld a,2
  ldh [$FF8D],a

  call vblank_wait

; Clear Viewport position
  xor a
  ldh [rSCY],a
  ldh [rSCX],a
  
; memclr(_VRAM,$1FFF)
  ld hl,_VRAM
  ld bc,$1FFF
  call memclr

; memclr(_RAM,$1CFF)
  ld hl,_RAM
  ld bc,$1CFF
  call memclr

; copy_dma()
  call copy_dma

; Set SRAM bank to 0
  xor a
  ld [rRAMB],a

; Set $C0A7 to 32
  ld a,32
  ld [wC0A7],a

  call vblank_wait

  push hl
  push af

; Calls FUN_2426() in bank 0
  banked_call 0, FUN_2426

  pop af
  pop hl

.LAB_01F7:
  di
  call vblank_wait

  push hl
  push af

; Calls FUN_2426() in bank 0
  banked_call 0, FUN_2426

  pop af
  pop hl
  push hl
  push af

; Calls FUN_7816() in bank 7
  banked_call 7, FUN_B7_7816

  pop af
  pop hl

; Zero $FF97
  xor a
  ldh [$FF97],a

; FUN_0258()
; TODO:
  call FUN_0258

  push hl
  push af

; Calls FUN_2426() in bank 0
  banked_call 0, FUN_2426

  pop af
  pop hl

; Zero $C0A6
  xor a
  ld [wC0A6],a 
; Zero $FF8D 
  xor a
  ldh [$FF8D],a
; Zero $FF9A
  xor a
  ldh [$FF9A],a
; Zero $C500
  xor a
  ld [wC500],a
; Zero $FF97 
  xor a
  ldh [$FF97],a

  push hl
  push af

; Calls FUN_7949() in bank 7
  banked_call 7, FUN_B7_7949

  pop af
  pop hl

; FUN_0061()
; TODO: 
  call FUN_0061

  call copy_lcdc

  ei

.LAB_024D:
  ld a,[wC0A6]
  or a
  or a
  jp z,.LAB_024D

  jp .LAB_01F7


section "0258", rom0[$0258] 
FUN_0258::
; Jump table:
;   FUN_4001 bank  1 -  1
;   FUN_5017 bank  2 -  2
;   FUN_4001 bank  3 -  3
;   FUN_4001 bank  4 -  4
;   FUN_4001 bank  5 -  5
;   FUN_4001 bank  6 -  6
;   FUN_4001 bank  9 - 19
;   FUN_46FC bank  9 - 20
;   FUN_4CA5 bank  9 - 21
;   FUN_4DD2 bank  9 - 22
;   FUN_4EDB bank  9 - 23
;   FUN_4001 bank 14 -  8
;   FUN_54EA bank 14 -  9
;   FUN_5AC6 bank 14 - 10
;   FUN_6160 bank 14 - 11
;   FUN_665A bank 14 - 12
;   FUN_638E bank 15 - 15
;   FUN_4001 bank 16 -  7
;   FUN_4F17 bank 16 - 13
;   FUN_4F2D bank 16 - 14
;   FUN_4001 bank 29 - 16
;   FUN_4350 bank 29 - 17
;   FUN_468C bank 29 - 18
;   FUN_6E51 bank 31 -  0
  ld a,[wC0A7]
  or a
  rst $08

dw $6E51
  db $1F ; FUN_6E51 bank 31
dw $4001
  db $01 ; FUN_4001 bank 1
dw $5017
  db $02 ; FUN_5017 bank 2
dw $4001
  db $03 ; FUN_4001 bank 3
dw $4001
  db $04 ; FUN_4001 bank 4
dw $4001
  db $05 ; FUN_4001 bank 5
dw $4001
  db $06 ; FUN_4001 bank 6
dw $4001
  db $10 ; FUN_4001 bank 16
dw $4001
  db $0E ; FUN_4001 bank 14
dw $54EA
  db $0E ; FUN_54EA bank 14
dw $5AC6
  db $0E ; FUN_5AC6 bank 14
dw $6160
  db $0E ; FUN_6160 bank 14
dw $665A
  db $0E ; FUN_665A bank 14
dw $4F17
  db $10 ; FUN_4F17 bank 16
dw $4F2D
  db $10 ; FUN_4F2D bank 16
dw $638E
  db $0F ; FUN_638E bank 15
dw $4001
  db $1D ; FUN_4001 bank 29
dw $4350
  db $1D ; FUN_4350 bank 29
dw $468C
  db $1D ; FUN_468C bank 29
dw $4001
  db $09 ; FUN_4001 bank 9
dw $46FC
  db $09 ; FUN_46FC bank 9
dw $4CA5
  db $09 ; FUN_4CA5 bank 9
dw $4DD2
  db $09 ; FUN_4DD2 bank 9
dw $4EDB
  db $09 ; FUN_4EDB bank 9



section "02E4", rom0[$02E4]
FUN_02E4::
  nop
section "07A9", rom0[$07A9]
FUN_07A9::
  nop
section "07E9", rom0[$07E9]
FUN_07E9::
  nop
section "206C", rom0[$206C]
FUN_206C::
  nop

include "src/bank0/jumptable.asm" ; $2078->$20A0
include "src/bank0/memory.asm"
include "src/bank0/screen.asm"

include "src/bank0/supergameboy.asm" ; $22E8->$23AF

section "23E9", rom0[$23E9]
FUN_23E9::
  push de
  push af
  push hl

  call vblank_wait

  pop hl

; Setting intensity
  ld a,%11100100
  ldh [rBGP],a

  pop af
  ld c,a
  ld de,_VRAM8800
  call FUN_3036

; Zero out viewport
  xor a
  ldh [rSCY],a
  ldh [rSCX],a

; 
  ld hl,_SCRN0
  ld de,12
  ld a,$80
  ld c,$0D
.outer
  ld b,20

.inner
  ld [hl+],a
  inc a
  dec b
  jr nz,.inner

  add hl,de
  dec c
  jr nz,.outer

; Turn on LCD and background
  ld a,LCDCF_ON | LCDCF_BGON
  ldh [rLCDC],a
  call wait_7000

; Send packet in hl
  pop hl
  call send_sgb_packet
  call wait_7000

  ret

  ret



section "2426", rom0[$2426] 
FUN_2426::
; Possibly audio initialization

; FUN_2468(0,0)
  ld bc,0
  call FUN_2468

; Turn Audio on
  ld a,$80
  ldh [rNR52],a
; Turn off Audio panning
  xor a
  ldh [rNR51],a
  ld [wD397],a ;Set to same as rNR52?
  
; Max out volume and turn off VIN
  ld a,$77
  ldh [rNR50],a

; $FF, $00, $00, $00, $00
; $00, $00, $00, $00, $00
; $00, $00, $00, $00, $00
; $00, $00, $00, $00, $00
; $00, $00, $00, $02
; x6
  ld hl,$D300
  ld b,6
  ld a,$FF
.LAB_2441:
  ld [hl],a
  ld de,$0017
  add hl,de
  ld [hl],2
  add hl,de
  dec b
  jr nz,.LAB_2441

; Zero $D3A3
  xor a
  ld [wD3A3],a
  ret

section "2468", rom0[$2468] 
FUN_2468::
; Sets three variables to b, c, and 0
  ld a,b
  ld [wD3A0],a
  ld a,c
  ld [wD3A1],a
  xor a
  ld [wD3A2],a
  ret

section "3036", rom0[$3036]
FUN_3036::
  ld a,[rRAMB]
  push af

  ld a,c
  ld [$2100],a
  ld a,d
  ldh [$FFB9],a
  ld a,e
  ldh [$FFB8],a
  ld a,[hl+]
  ldh [$FFBA],a
  add e
  ldh [$FFBC],a
  ld a,[hl+]
  ldh [$FFBB],a
  adc d
  ldh [$FFBD],a
  ld c,0

.LAB_3052
  ld a,c
  and a
  jr nz,.LAB_305A

  ld a,[hl+]
  ld b,a
  ld c,8

.LAB_305A
  dec c
  srl b
  push bc
  jr nc,.LAB_3065

  ld a,[hl+]
  ld [de],a
  inc de
  jr .LAB_30BA


.LAB_3065
  ld a,[hl+]
  ld c,a
  and $0f
  inc a
  inc a
  inc a
  ldh [$FFBE],a
  ld a,[hl+]
  ld b,a
  push hl
  srl b
  rr c
  srl b
  rr c
  srl b
  rr c
  srl b
  rr c
  ld a,e
  sub c
  ld c,a
  ld a,d
  sbc b
  ld b,a
  ldh a,[$FFB9]
  cp b
  jr c,.LAB_30AE

  jr nz,.LAB_3095

  ldh a,[$FFB8]
  cp c
  jr c,.LAB_30AE
  jr z,.LAB_30AE

.LAB_3095
  ld a,c
  xor $FF
  inc a
  ld b,a
  ldh a,[$FFBE]
  ld c,a
  xor a

.LAB_309E
  ld [de],a
  inc de
  dec c
  jr z,.LAB_30B9

  dec b
  jr nz,.LAB_309E

  ld hl,$FFB8
  ld a,[hl+]
  ld h,[hl]
  ld l,a
  jr .LAB_30B3


.LAB_30AE
  ld h,b
  ld l,c
  ldh a,[$FFBE]
  ld c,a

.LAB_30B3
  ld a,[hl+]
  ld [de],a
  inc de
  dec c
  jr c,.LAB_30B3

.LAB_30B9
  pop hl

.LAB_30BA
  ldh a,[$FFBD]
  ld b,a
  ld a,d
  cp b
  jr c,.LAB_30CA
  jr nz,.LAB_30CD

  ld c,a
  ld a,e
  cp c
  jr c,.LAB_30CD

.LAB_30CA
  pop bc
  jr .LAB_3052


.LAB_30CD
  pop bc
  pop af
  ld [$2100],a
  ret



section "3317", rom0[$3317]
FUN_3317::
  nop
section "33FF", rom0[$33FF]
FUN_33FF::
  nop
section "340E", rom0[$340E]
FUN_340E::
  nop

include "src/bank7/FUN_77A7.asm"
include "src/bank30/data.asm"

section "end", romx[$7FFF], bank[31]
