
section "home", rom0[$0061]

; Calls function in jumptable by offset A
FUN_0061::
  ld a,[wC0A7]
  or a
  rst $08

jumptable 0, jt_61.return
jumptable 0, FUN_0F9D
jumptable 0, FUN_0F9D
jumptable 0, FUN_0F9D
jumptable 0, FUN_0F9D
jumptable 0, FUN_0F9D
jumptable 0, jt_61.val_34
jumptable 0, jt_61.val_42
jumptable 0, jt_61.val_38
jumptable 0, jt_61.val_38
jumptable 0, jt_61.val_38
jumptable 0, jt_61.val_38
jumptable 0, jt_61.val_38
jumptable 0, jt_61.return
jumptable 0, jt_61.return
jumptable 0, jt_61.val_23
jumptable 0, jt_61.val_0
jumptable 0, jt_61.val_0
jumptable 0, jt_61.val_4
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_84
jumptable 0, jt_61.val_34
jumptable 0, jt_61.val_4
jumptable 0, jt_61.val_4
jumptable 0, jt_61.val_34
jumptable 0, jt_61.val_34
jumptable 0, jt_61.return
jumptable 0, jt_61.return
jumptable 0, jt_61.val_34
jumptable 0, jt_61.val_4
jumptable 0, jt_61.return
jumptable 0, jt_61.val_27
jumptable 0, FUN_3FF3
jumptable 0, FUN_3FF3
jumptable 0, jt_61.return
jumptable 0, FUN_3FF3


db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF, $FF, $FF
db $FF, $FF, $FF
