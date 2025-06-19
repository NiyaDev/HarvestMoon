

section "calc_jumptable", rom0[$2078]

; Calculates the target of the jumptable
calc_jumptable::
  ld e,a    ; 
  ld d,0    ; 
  ld l,a    ; 
  ld h,0    ; Triples a, then adds it to current return address in hl
  add hl,hl ; 
  add hl,de ; 
  ld e,l    ; 
  ld d,h    ; 

  pop hl
  add hl,de

  ld e,[hl] ; 
  inc hl    ; 
  ld d,[hl] ; 
  inc hl    ; Grabs first two bytes to make the address then the last byte for bank
  ld a,[hl] ; 
  ld l,e    ; 
  ld h,d    ; 


; Sets the bank and then jumps
set_bank_then_jump::
  push bc       ; 
  ld b,a        ; 
  ld a,[$4000]  ; Grabs current ROM bank and sets it to a
  ld c,a        ; 
  ld a,b        ; 
  ld [rROMB0+$100],a
  ld a,c        ; 
  pop bc        ;

  push af       ; 
  call jump_hl  ; Calls jump_hl to set the return addr of that function here

  pop af        ; Resets ROM bank to what it started with
  ld [rROMB0+$100],a

  ret           ; Return to original call

; Jump to hl
jump_hl::
  jp hl
