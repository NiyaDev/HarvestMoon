
section "copy_dma", rom0[$214E] 
copy_dma::
; Copy dma function to HRAM
  ld c,$80
  ld b,10
  ld hl,DMADATA

.loop:
  ld a,[hl+]
  ldh [c],a
  inc c
  dec b
  jr nz,.loop

  ret

DMADATA::
db $3E, $C0, $E0, $46
db $3E, $28, $3D, $20
db $FD, $C9



section "memclr", rom0[$218E]

memclr::
; Clears BC bytes at HL
  xor a
  ld [hl+],a
  dec bc
  ld a,c
  or b
  jr nz,memclr
  ret


