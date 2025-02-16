
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

; Set SGB colors
  ld hl,PAL01_PACKET
  call send_sgb_packet
  call wait_7000

; Make screen blank
  ld hl,MASK_EN_PACKET_BLANKC
  call send_sgb_packet
  call wait_7000

  ld hl,DATA_SND_PACKETS
  ld b,8
.send_data:
  push hl
  push bc

; Send packets in reverse
  call send_sgb_packet
  call wait_7000

  pop bc
  pop hl

; Increment
  ld de,16
  add hl,de
  
  dec b
  jr nz,.send_data

;
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

; Cancel mask
  ld hl,MASK_EN_PACKET_CANCEL
  call send_sgb_packet
  call wait_7000

  ret


PAL01_PACKET::
; Sets Pal 0 colors
  db PAL_01 << 3 | $01
  db $FF, $7F
  db $FF, $7F
  db $FF, $7F
  db $FF, $7F
  db $00, $00
  db $00, $00
  db $00, $00
  ds 1


section "7816", romx[$7816], bank[7]

FUN_B7_7816::
  ld a,[wDD00]
  or a
  ret z

  ld hl,$7975
  call send_sgb_packet
  call wait_7000

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  ld hl,$9000
  ld bc, 16
  call memclr

  ld hl,$9800
  ld bc,$400
  call memclr

  ld hl,$7A55
  ld a,[wC0A7]
  cp 1
  jr z,.LAB_7853

  cp 7
  jr z,.LAB_7853

  cp 15
  jr z,.LAB_7853

  cp 37
  jr nz,.LAB_7859

.LAB_7853
  ld hl,$7B51
  ld a,[wB884]

.LAB_7859
  ld c,l
  ld b,h
  ld l,a
  ld h,0
  add hl,hl
  ld d,h
  ld e,l
  add hl,hl
  add hl,de
  add hl,bc
  ld de,$C0AA
  ld a,$51
  ld [de],a
  inc de
  ld b,4

.LAB_786D
  ld a,[hl+]
  ld [de],a
  inc de
  xor a
  ld [de],a
  inc de
  dec b
  jr nz,.LAB_786D

  ld a,[hl+]
  set 7,a
  ld [de],a
  inc de
  ld b,6
  xor a

.LAB_787E
  ld [de],a
  inc de
  dec b
  jr nz,.LAB_787E

  push hl
  ld hl,$C0AA
  call send_sgb_packet
  call wait_7000
  pop hl

  ld a,[wC0A7]
  cp $20
  jr z,.LAB_7911

  ld a,[wCB50]
  cp $20
  jr z,.LAB_7911

  ld b,[hl]
  ld a,[wDD01]
  cp b
  jr z,.LAB_7948

  ld a,b
  ld [wDD01],a

  push af
  push bc

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  ld hl,$9000
  ld bc,16
  call memclr

  ld hl,$9800
  ld bc,$400
  call memclr

  call copy_lcdc
  call wait_7000
  call vblank_wait

  ld hl,$7B69
  call FUN_07A9

  ld de,$79A5
  call FUN_07E9

  ld a,[wDD01]
  ld b,a
  add a
  add b
  inc a
  
  ld hl,$7B69
  call FUN_07A9
  
  ld de,$79B5
  call FUN_07E9

  ld a,[wDD01]
  ld b,a
  add a
  add b
  inc a
  inc a

  ld hl,$7B69
  call FUN_07A9

  ld de,$79C5
  call FUN_07E9

.LAB_7911
  call vblank_wait

  ld hl,$9000
  ld bc,16
  call memclr

  ld hl,$9800
  ld bc,$400
  call memclr

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  call copy_lcdc
  call wait_7000
  call vblank_wait

  ld hl,$7995
  call send_sgb_packet
  call wait_7000

  ld hl,$7975
  call send_sgb_packet
  call wait_7000

.LAB_7948
  ret



section "temp_mask_packet", romx[$7975], bank[7]
MASK_EN_PACKET_BLANKC::
; Makes screen blank
  db (MASK_EN * 8) + 1
  db MASK_EN_BLANKC
  ds 14
MASK_EN_PACKET_BLANKB::
  db (MASK_EN * 8) + 1
  db MASK_EN_BLANKB
  ds 14
MASK_EN_PACKET_CANCEL::
  db (MASK_EN * 8) + 1
  db MASK_EN_CANCEL
  ds 14


section "temp_data_snd_packet", romx[$79D5], bank[7]
DATA_SND_PACKETS::
DATA_SND_PACKET_0::
  db (DATA_SND * 8) + 1
  dw $081B  ; Address
  db 0      ; Bank #
  db 11     ; # of bytes
  db $EA, $EA, $EA, $EA, $EA
  db $A9, $01, $CD, $4F, $0C
  db $D0    ; Data
DATA_SND_PACKET_1::
  db (DATA_SND * 8) + 1
  dw $0826  ; Address
  db 0      ; Bank # 
  db 11     ; # of bytes
  db $39, $CD, $48, $0C, $D0
  db $34, $A5, $C9, $C9, $80
  db $D0    ; Data
DATA_SND_PACKET_2::
  db (DATA_SND * 8) + 1
  dw $0831  ; Address
  db 0      ; Bank # 
  db 11     ; # of bytes
  db $0C, $A5, $CA, $C9, $7E
  db $D0, $06, $A5, $CB, $C9
  db $7E    ; Data
DATA_SND_PACKET_3::
  db (DATA_SND * 8) + 1
  dw $083C  ; Address 
  db 0      ; Bank # 
  db 11     ; # of bytes 
  db $F0, $12, $A5, $C9, $C9
  db $C8, $D0, $1C, $A5, $CA
  db $C9    ; Data
DATA_SND_PACKET_4::
  db (DATA_SND * 8) + 1
  dw $0847  ; Address 
  db 0      ; Bank # 
  db 11     ; # of bytes 
  db $C4, $D0, $16, $A5, $CB
  db $C9, $05, $D0, $10, $A2
  db $28    ; Data
DATA_SND_PACKET_5::
  db (DATA_SND * 8) + 1
  dw $0852  ; Address 
  db 0      ; Bank # 
  db 11     ; # of bytes 
  db $A9, $E7, $9F, $01, $C0
  db $7E, $E8, $E8, $E8, $E8
  db $E0    ; Data
DATA_SND_PACKET_6::
  db (DATA_SND * 8) + 1
  dw $085D  ; Address 
  db 0      ; Bank # 
  db 4      ; # of bytes 
  db $8C, $D0, $F4, $60
  ds 7      ; Data
DATA_SND_PACKET_7::
  db (DATA_SND * 8) + 1
  dw $0810  ; Address 
  db 0      ; Bank # 
  db 11     ; # of bytes 
  db $4C, $20, $08, $EA, $EA
  db $EA, $EA, $EA, $60, $EA
  db $EA    ; Data

