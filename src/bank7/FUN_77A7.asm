
section "77A7", romx[$77A7], bank[7]
FUN_B7_77A7::
  di

  ld a,$FF
  ld [wDD00],a
  ld [wDD01],a

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  ld hl,$7806
  call send_sgb_packet
  call wait_7000

  ld hl,$7975
  call send_sgb_packet
  call wait_7000

  ld hl,$79D5
  ld b,8
.LAB_77CE:
  push hl
  push bc

  call send_sgb_packet
  call wait_7000

  pop bc
  pop hl

  ld de,16
  add hl,de
  
  dec b
  jr nz,.LAB_77CE

  ld hl,$7D8A
  ld a,$13
  ld de,$7965
  call FUN_23E9

  ld hl,$797F
  ld a,$10
  ld de,$7965
  call FUN_23E9

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  ld hl,$7995
  call send_sgb_packet
  call wait_7000

  ret


