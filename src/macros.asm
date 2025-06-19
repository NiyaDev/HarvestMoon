

;
macro banked_call
  ld l,LOW(\2)
  ld h,HIGH(\2)
  ld a,\1
  call set_bank_then_jump
endm

;
macro jumptable
  dw \2
  db \1
endm

;
macro unk_struc_1
  if \1 != 1
    db $32, 0
    dw \2
    db $4B, 1
    dw \3
    db $64, 2
    dw \4
    if \1 > 3
      db $7D, 3
      dw \5
    endc
  else
    db $00, 0
    dw \2
  endc
endm

