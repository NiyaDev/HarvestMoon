
section "home", rom0[$0061]

; Calls function in jumptable by offset A
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

; Does nothing
dw jt_61.return
  db $00

; Writes some data
dw FUN_0F9D
  db $00
dw FUN_0F9D
  db $00
dw FUN_0F9D
  db $00
dw FUN_0F9D
  db $00
dw FUN_0F9D
  db $00

; 
dw jt_61.lab_3FCD
  db $00

; 
dw jt_61.lab_3FD1
  db $00
dw jt_61.lab_3FD5
  db $00
dw jt_61.lab_3FD5
  db $00
dw jt_61.lab_3FD5
  db $00
dw jt_61.lab_3FD5
  db $00
dw jt_61.lab_3FD5
  db $00

; 
dw jt_61.return
  db $00
dw jt_61.return
  db $00

; 
dw $3FD9
  db $00

; 
dw jt_61.lab_3FDD
  db $00
dw jt_61.lab_3FDD
  db $00

; 
dw jt_61.lab_3FE1
  db $00

; 
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00
dw jt_61.lab_3FE5
  db $00

; 
dw jt_61.lab_3FCD
  db $00

; 
dw jt_61.lab_3FE1
  db $00
dw jt_61.lab_3FE1
  db $00

; 
dw jt_61.lab_3FCD
  db $00
dw jt_61.lab_3FCD
  db $00

; 
dw jt_61.return
  db $00
dw jt_61.return
  db $00

; 
dw jt_61.lab_3FCD
  db $00

; 
dw jt_61.lab_3FE1
  db $00

; 
dw jt_61.return
  db $00

; 
dw jt_61.lab_3FED
  db $00

; 
dw FUN_3FF3
  db $00

; 
dw FUN_3FF3
  db $00

; 
dw jt_61.return
  db $00

; 
dw FUN_3FF3
  db $00


db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF
