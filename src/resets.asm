
section "resets", rom0[$0000]

; TODO
RST00::
  jp FUN_206C
db $FF, $FF, $FF, $FF, $FF

; Calculates jumptable offset, calls function, then returns
RST08::
  jp calc_jumptable
  ret
db $FF, $FF, $FF, $FF

; Empty
RST10::
  ret
db $FF, $FF, $FF, $FF, $FF, $FF, $FF
RST18::
  ret
db $FF, $FF, $FF, $FF, $FF, $FF, $FF
RST20::
  ret
db $FF, $FF, $FF, $FF, $FF, $FF, $FF
RST28::
  ret
db $FF, $FF, $FF, $FF, $FF, $FF, $FF
RST30::
  ret
db $FF, $FF, $FF, $FF, $FF, $FF, $FF

; Offsets HL by A
RST38::
  add l
  ld l,a
  ld a,0
  adc h
  ld h,a
  ret

; Calls RST38
FUN_003F::
  rst $38
