
section "home", rom0[$0061]

FUN_0061::
; Jump table all in BANK0:
;   FUN_0F9D - 1-5
;   FUN_3FCD - 6, 27, 30-31, 34
;   FUN_3FD1 - 7
;   FUN_3FD5 - 8-12
;   FUN_3FD9 - 15
;   FUN_3FDD - 16-17
;   FUN_3FE1 - 18, 28-29, 35
;   FUN_3FE5 - 19-26
;   FUN_3FED - 37
;   FUN_3FF2 - 0, 13-14, 32-33, 36, 40
;   FUN_3FF3 - 38-39, 41
  ld a,[wC0A7]
  or a
  rst $08

dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $0F9D
  db $00 ; FUN_0F9D bank 0
dw $0F9D
  db $00 ; FUN_0F9D bank 0
dw $0F9D
  db $00 ; FUN_0F9D bank 0
dw $0F9D
  db $00 ; FUN_0F9D bank 0
dw $0F9D
  db $00 ; FUN_0F9D bank 0
dw $3FCD
  db $00 ; FUN_3FCD bank 0
dw $3FD1
  db $00 ; FUN_3FD1 bank 0
dw $3FD5
  db $00 ; FUN_3FD5 bank 0
dw $3FD5
  db $00 ; FUN_3FD5 bank 0
dw $3FD5
  db $00 ; FUN_3FD5 bank 0
dw $3FD5
  db $00 ; FUN_3FD5 bank 0
dw $3FD5
  db $00 ; FUN_3FD5 bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FD9
  db $00 ; FUN_3FD9 bank 0
dw $3FDD
  db $00 ; FUN_3FDD bank 0
dw $3FDD
  db $00 ; FUN_3FDD bank 0
dw $3FE1
  db $00 ; FUN_3FE1 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FE5
  db $00 ; FUN_3FE5 bank 0
dw $3FCD
  db $00 ; FUN_3FCD bank 0
dw $3FE1
  db $00 ; FUN_3FE1 bank 0
dw $3FE1
  db $00 ; FUN_3FE1 bank 0
dw $3FCD
  db $00 ; FUN_3FCD bank 0
dw $3FCD
  db $00 ; FUN_3FCD bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FCD
  db $00 ; FUN_3FCD bank 0
dw $3FE1
  db $00 ; FUN_3FE1 bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FED
  db $00 ; FUN_3FED bank 0
dw $3FF3
  db $00 ; FUN_3FF3 bank 0
dw $3FF3
  db $00 ; FUN_3FF3 bank 0
dw $3FF2
  db $00 ; FUN_3FF2 bank 0
dw $3FF3
  db $00 ; FUN_3FF3 bank 0

db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF
