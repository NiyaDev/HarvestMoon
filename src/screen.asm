
section "vblank_wait", rom0[$2166] 

vblank_wait::
; Return if LCD disabled
  ld hl,rLCDC
  bit 7,[hl]
  ret z

; Grabs IE
  ldh a,[$FFFF]
  push af

; Disables VBlank interrupt
  res 0,a
  ldh [$FFFF],a
.wait:
  ldh a,[rLY]
  cp 145
  jr nz,.wait

; Turn off LCD
  res 7,[hl]

; Resets interrupts back
  pop af
  ldh [$FFFF],a

  ret



section "copy_lcdc", rom0[$217F]

copy_lcdc::
; Copies LCDC from mem to register
  ld a,[wC0A2]
  ldh [rLCDC],a
  ret
