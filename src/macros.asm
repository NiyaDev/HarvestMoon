

;
macro banked_call
  ld l,LOW(\2)
  ld h,HIGH(\2)
  ld a,\1
  call set_bank_then_jump
endm

