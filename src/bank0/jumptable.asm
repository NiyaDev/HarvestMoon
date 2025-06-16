section "calc_jumptable", rom0[$2078]
calc_jumptable::
; Triples a, then adds it to the current return address in hl
  ld e,a
  ld d,0
  ld l,a
  ld h,0
  add hl,hl
  add hl,de
  ld e,l
  ld d,h

  pop hl
  add hl,de

; Grabs first two bytes to make the address
; then the last byte for the bank
  ld e,[hl]
  inc hl
  ld d,[hl]
  inc hl
  ld a,[hl]
  ld l,e
  ld h,d

section "set_bank_then_jump", rom0[$208B] 
set_bank_then_jump::
; Grabs current ROM bank and sets it to what's in a
  push bc
  ld b,a
  ld a,[$4000]
  ld c,a
  ld a,b
  ld [rROMB0+$100],a
  ld a,c

  pop bc
  push af

; Calls jump_hl to set the return addr of that function here
  call jump_hl

; Resets ROM bank to what it started with
  pop af
  ld [rROMB0+$100],a

; Return to original call
  ret

section "jump_hl", rom0[$20A0]
jump_hl::
  jp hl
