
section "resets", rom0[$0000]

RST00::
  jp FUN_206C
db $FF, $FF, $FF, $FF, $FF

RST08::
  jp calc_jumptable
  ret
db $FF, $FF, $FF, $FF

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

RST38::
  add l
  ld l,a
  ld a,0
  adc h
  ld h,a
  ret

FUN_003F::
  rst $38
