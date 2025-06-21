
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

  xor a        ; Set SRAM bank to 0
  ld [rRAMB],a ; 

  ld a,1       ; Set ROM bank to 1
  ld [rROMB0],a; 

  ld sp,$DFEF  ; Set Stack pointer

  ld hl,hDMA   ; Zero out DMA function
  ld bc,$007F  ; 
  call memclr  ; 

  ld hl,$DD00  ; Zero out $DD00->$DDFF
  ld bc,$00FF  ; 
  call memclr  ; 

  call copy_dma; 

  xor a        ; 
  ldh [rBGP],a ; Set BG palette to 0
  xor a        ;
  ldh [rOBP0],a; Set Object palette 0 to 0
  xor a        ;
  ldh [rOBP1],a; Set Object palette 1 to 0 

  call FUN_2426; TODO: 

  ld a, 2      ;
  ldh [hFF8D],a; Set hFF8D to 2

  call vblank_wait

  xor a        ; 
  ldh [rSCY],a ; Zero out Viewport position
  ldh [rSCX],a ; 

  ld a,CART_SRAM_ENABLE
  ld [rRAMG],a ; Enable Cart SRAM

  ld a, RTCLATCH_FINISH
  ld [rRTCLATCH],a ; Finish latch?

  xor a        ; 
  ld [wDD00],a ; Zero out $DD00

  call check_if_sgb
  jr nc,.no_sgb; Check if SuperGameboy

  push hl
  push af

  banked_call 7, FUN_B7_77A7

  pop af
  pop hl

.no_sgb:
  di

.LAB_01AD:
  di

  xor a       ; Zero $FFFF
  ldh [$FFFF],a

  ld sp,$DFEF ; Reset stack pointer

  ld hl,hDMA  ; 
  ld bc,$007F ; memclr(hDMA,$007F)
  call memclr ; 

  ld a, 2     ; Set $FF8D to 2
  ldh [$FF8D],a

  call vblank_wait

  xor a       ; 
  ldh [rSCY],a; Clear Viewport position
  ldh [rSCX],a; 
  
  ld hl,_VRAM ; 
  ld bc,$1FFF ; memclr(_VRAM,$1FFF)
  call memclr ; 

  ld hl,_RAM  ; 
  ld bc,$1CFF ; memclr(_RAM,$1CFF)
  call memclr ; 

  call copy_dma; copy_dma()

  xor a       ; Set SRAM bank to 0
  ld [rRAMB],a; 

  ld a,32     ; Set $C0A7 to 32
  ld [wC0A7],a; 

  call vblank_wait

  push hl
  push af

  banked_call 0, FUN_2426

  pop af
  pop hl

.LAB_01F7:
  di
  call vblank_wait

  push hl
  push af

  banked_call 0, FUN_2426

  pop af
  pop hl
  push hl
  push af

  banked_call 7, FUN_B7_7816

  pop af
  pop hl

  xor a      ; Zero $FF97
  ldh [$FF97],a

  call FUN_0258 ; TODO:

  push hl
  push af

  banked_call 0, FUN_2426

  pop af
  pop hl

  xor a         ;
  ld [wC0A6],a  ; Zero $C0A6
  xor a         ; 
  ldh [$FF8D],a ; Zero $FF8D 
  xor a         ; 
  ldh [$FF9A],a ; Zero $FF9A
  xor a         ; 
  ld [wC500],a  ; Zero $C500
  xor a         ; 
  ldh [$FF97],a ; Zero $FF97 

  push hl
  push af

  banked_call 7, FUN_B7_7949

  pop af
  pop hl

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
  ld a,[wC0A7]
  or a
  rst $08

jumptable 31, $6E51
jumptable  1, $4001
jumptable  2, $5017
jumptable  3, $4001
jumptable  4, $4001
jumptable  5, $4001
jumptable  6, $4001
jumptable 16, $4001
jumptable 14, $4001
jumptable 14, $54EA
jumptable 14, $5AC6
jumptable 14, $6160
jumptable 14, $665A
jumptable 16, $4F17
jumptable 16, $4F2D
jumptable 15, $638E
jumptable 29, $4001
jumptable 29, $4350
jumptable 29, $468C
jumptable  9, $4001
jumptable  9, $46FC
jumptable  9, $4CA5
jumptable  9, $4DD2
jumptable  9, $4EDB



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

  ld a,%11100100 ; Setting intensity
  ldh [rBGP],a   ; 

  pop af
  ld c,a
  ld de,_VRAM8800
  call FUN_3036

  xor a        ; 
  ldh [rSCY],a ; Zero out viewport
  ldh [rSCX],a ; 

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

  ld a,LCDCF_ON | LCDCF_BGON
  ldh [rLCDC],a  ; Turn on LCD and background
  call wait_7000 ; 

  pop hl         ; Send packet in hl
  call send_sgb_packet
  call wait_7000 ; 

  ret
  ret



section "2426", rom0[$2426]

; Possibly audio initialization
FUN_2426::
  ld bc,0
  call FUN_2468

  ld a,$80      ; Turn Audio on
  ldh [rNR52],a ; 
  xor a         ; Turn off Audio panning
  ldh [rNR51],a ;
  ld [wD397],a  ; Set to same as rNR52?
  
  ld a,$77      ; Max out volume and turn off VIN
  ldh [rNR50],a ; 

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

  xor a        ; Zero $D3A3
  ld [wD3A3],a ; 
  ret


section "2468", rom0[$2468]

; 
FUN_2468::
  ld a,b       ; Sets three variables to b, c, and 0
  ld [wD3A0],a ; 
  ld a,c       ; 
  ld [wD3A1],a ; 
  xor a        ; 
  ld [wD3A2],a ; 
  ret


section "3036", rom0[$3036]

FUN_3036::
  ld a,[rRAMB] ; Save RAM bank
  push af      ; 

  ld a,c       ; Set ROM bank to c
  ld [rROMB0+$100],a

  ld a,d       ; 
  ldh [$FFB9],a; Set $FFB9 to de
  ld a,e       ; 
  ldh [$FFB8],a; 

  ld a,[hl+]   ; 
  ldh [$FFBA],a; 
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
