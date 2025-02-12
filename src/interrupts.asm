
section "interrupts", rom0[$0040]

intr_vblank::
  call FUN_02E4
  reti
db $FF, $FF, $FF, $FF

intr_stat::
  jp FUN_3317
db $FF, $FF, $FF, $FF, $FF

intr_timer::
  jp FUN_33FF
db $FF, $FF, $FF, $FF, $FF

intr_serial::
  jp FUN_340E
db $FF, $FF, $ff, $FF, $FF

intr_joypad::
  reti

