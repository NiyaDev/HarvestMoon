
;; Definitions
include "includes/hardware.inc"

;; RAM
include "src/ram/wram.asm"


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
  ld hl,_RUNDMA
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

; Set $FF8D to 2
  ld a,2
  ldh [$FF8D],a

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
  xor a
  ld [wDD00],a

; bool FUN_232F()
; TODO:
  call FUN_232F
  jr nc,.LAB_01AC

  push hl
  push af

; FUN_208B($A7,$77,7)
; TODO:
  ld l,$A7
  ld h,$77
  ld a,7
  call FUN_208B

  pop af
  pop hl

.LAB_01AC:
  di

.LAB_01AD:
  di

; Zero $FFFF
  xor a
  ldh [$FFFF],a

; Reset stack pointer
  ld sp,$DFEF

; memclr(_RUNDMA,$007F)
  ld hl,_RUNDMA
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

; Set $C0A7 to $20
  ld a,$20
  ld [wC0A7],a

  call vblank_wait

  push hl
  push af

; FUN_208B($26,$24,0)
; TODO:
  ld l,$26
  ld h,$24
  ld a,0
  call FUN_208B

  pop af
  pop hl

.LAB_01F7:
  di
  call vblank_wait

  push hl
  push af

; FUN_208B($26,$24,0)
; TODO:
  ld l,$26
  ld h,$24
  ld a,0
  call FUN_208B

  pop af
  pop hl
  push hl
  push af

; FUN_208B($26,$24,0)
; TODO:
  ld l,$16
  ld h,$78
  ld a,7
  call FUN_208B

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

; FUN_208B($26,$24,0)
; TODO:
  ld l,$26
  ld h,$24
  ld a,0
  call FUN_208B

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

; FUN_208B($49,$79,7)
; TODO:
  ld l,$49
  ld h,$79
  ld a,7
  call FUN_208B

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


section "0061", rom0[$0061]
FUN_0061::
  nop 
section "0258", rom0[$0258] 
FUN_0258::
  nop 
section "208B", rom0[$208B] 
FUN_208B::
  nop 

include "src/memory.asm"
include "src/screen.asm"

section "232F", rom0[$232F] 
FUN_232F::
  nop

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


section "end", romx[$7FFF], bank[31]
