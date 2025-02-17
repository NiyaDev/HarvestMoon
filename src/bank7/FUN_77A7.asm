
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
; Leave if zero
  ld a,[wDD00]
  or a
  ret z

; Clear video
  ld hl,MASK_EN_PACKET_BLANKC
  call send_sgb_packet
  call wait_7000

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

; Clear some VRAM
  ld hl,$9000
  ld bc,16
  call memclr

; Clear SCRN0
  ld hl,_SCRN0
  ld bc,$400
  call memclr

; If wC0A7 == 1, 7, 15, or 37
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

; Sets pointer and sets packet header to PAL_SET
  ld de,wC0AA
  ld a,(PAL_SET * 8) + 1
  ld [de],a
  inc de

; Copies data from pointer to fill packet
  ld b,4
.copy_data
  ld a,[hl+]
  ld [de],a
  inc de
  xor a
  ld [de],a
  inc de
  dec b
  jr nz,.copy_data

; Loads next byte, sets 7th bit
  ld a,[hl+]
  set 7,a
  ld [de],a
  inc de

; Fills the end of the packet with zeroes
  ld b,6
  xor a
.fill_zeroes
  ld [de],a
  inc de
  dec b
  jr nz,.fill_zeroes

; PAL_SET_PACKET
  push hl
  ld hl,wC0AA
  call send_sgb_packet
  call wait_7000
  pop hl

; If wC0A7 == 32
  ld a,[wC0A7]
  cp 32
  jr z,.LAB_7911

; If wCB50 == 32
  ld a,[wCB50]
  cp 32
  jr z,.LAB_7911

; If wDD01 == [hl]
  ld b,[hl]
  ld a,[wDD01]
  cp b
  jp z,.LAB_7948

; wDD01 = [hl]
  ld a,b
  ld [wDD01],a

  push af
  push bc

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

; Clear some VRAM
  ld hl,$9000
  ld bc,16
  call memclr

; Clear SCRN0
  ld hl,_SCRN0
  ld bc,$400
  ld a,$83
  ld [wC0A2],a
  call memclr

  call copy_lcdc
  call wait_7000
  call vblank_wait

  ld hl,$7975
  call send_sgb_packet
  call wait_7000

  pop bc
  pop af

  add a
  add b

; TODO: FUN_07A9($7B69)
  ld hl,$7B69
  call FUN_07A9

; TODO: FUN_07E9($79A5)
  ld de,$79A5
  call FUN_07E9

; (wDD01 * 3) + 1
  ld a,[wDD01]
  ld b,a
  add a
  add b
  inc a
  
; TODO: FUN_07A9($7B69)
  ld hl,$7B69
  call FUN_07A9

; TODO: FUN_07E9($79B5)
  ld de,$79B5
  call FUN_07E9

; (wDD01 * 3) + 2
  ld a,[wDD01]
  ld b,a
  add a
  add b
  inc a
  inc a

; TODO: FUN_07A9($7B69)
  ld hl,$7B69
  call FUN_07A9

; TODO: FUN_07E9($79C5)
  ld de,$79C5
  call FUN_07E9

.LAB_7911
  call vblank_wait

; Clear some VRAM
  ld hl,$9000
  ld bc,16
  call memclr

; Clear SCRN0
  ld hl,_SCRN0
  ld bc,$400
  call memclr

  xor a
  ldh [rBGP],a
  ldh [rOBP0],a
  ldh [rOBP1],a

  call copy_lcdc
  call wait_7000
  call vblank_wait

; Show screen
  ld hl,MASK_EN_PACKET_CANCEL
  call send_sgb_packet
  call wait_7000

; Blank screen with color
  ld hl,MASK_EN_PACKET_BLANKC
  call send_sgb_packet
  call wait_7000

.LAB_7948
  ret


FUN_B7_7949::
  ld a,[wDD00]
  or a
  ret z
  
; Show screen
  ld hl,MASK_EN_PACKET_CANCEL
  call send_sgb_packet
  ret


PAL_TRN_PACKET:: ; Initializes SGB system colors
  db (PAL_TRN * 8) + 1
  ds 15
ATTR_TRN_PACKET:: ; Initialize Attribute files in SNES RAM
  db (ATTR_TRN * 8) + 1
  ds 15
MASK_EN_PACKET_BLANKC:: ; Makes screen blank with color 0
  db (MASK_EN * 8) + 1
  db MASK_EN_BLANKC
  ds 14
MASK_EN_PACKET_BLANKB:: ; Makes screen black
  db (MASK_EN * 8) + 1
  db MASK_EN_BLANKB
  ds 14
MASK_EN_PACKET_CANCEL:: ; Turn on display
  db (MASK_EN * 8) + 1
  db MASK_EN_CANCEL
  ds 14
CHR_TRN_PACKET_0:: ; Transfer bg tile data from $00-$7F in VRAM to SNES VRAM
  db (CHR_TRN * 8) + 1
  db 0
  ds 14
CHR_TRN_PACKET_1:: ; Transfer bg tile data from $80-$FF in VRAM to SNES VRAM
  db (CHR_TRN * 8) + 1
  db 1
  ds 14
PCT_TRN_PACKET:: ; Transfer tile map data and palette data SNES BG map memory for border
  db (PCT_TRN * 8) + 1
  ds 15


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


COMP_PACKET::
A_00::  ds 6
        db $00, $00, $00, $00, $00, $01 
A_02::  db $44, $44, $44, $44, $01, $01 
A_03::  db $48, $48, $48, $48, $02, $01 
A_04::  db $4C, $4C, $4C, $4C, $03, $01 
A_05::  db $50, $50, $50, $50, $04, $01 
A_06::  db $00, $00, $00, $00, $00, $01 
        db $00, $00, $00, $00, $00, $01 
A_08::  db $54, $54, $54, $54, $11, $01 
A_09::  db $54, $54, $54, $54, $11, $01 
A_10::  db $54, $54, $54, $54, $11, $01 
A_11::  db $54, $54, $54, $54, $11, $01 
A_12::  db $54, $54, $54, $54, $11, $01 
A_13::  db $58, $59, $5A, $5B, $12, $01 
A_14::  db $58, $59, $5A, $5B, $12, $01 
        db $00, $00, $00, $00, $00, $01 
A_16::  db $04, $04, $04, $04, $05, $01 
A_17::  db $08, $09, $0A, $0B, $06, $01 
A_18::  db $08, $09, $0A, $0B, $06, $01 
A_19::  db $30, $30, $30, $30, $00, $01 
A_20::  db $10, $11, $12, $13, $09, $01 
A_21::  db $14, $15, $16, $17, $0A, $01 
A_22::  db $18, $19, $1A, $1B, $0B, $01 
A_23::  db $1C, $1D, $1E, $1F, $0C, $01 
A_24::  db $20, $21, $22, $23, $0D, $01 
A_25::  db $24, $25, $26, $27, $0E, $01 
A_26::  db $0C, $0D, $0E, $0F, $08, $01 
A_27::  db $00, $00, $00, $00, $00, $01 
A_28::  db $00, $00, $00, $00, $00, $01 
A_29::  db $00, $00, $00, $00, $00, $01 
A_30::  db $00, $00, $00, $00, $00, $01 
A_31::  db $00, $00, $00, $00, $00, $01 
A_32::  db $28, $29, $2A, $2B, $0F, $01 
A_33::  db $2C, $2D, $2E, $2F, $10, $01 
A_34::  db $00, $00, $00, $00, $00, $01 
A_35::  db $00, $00, $00, $00, $00, $01 
A_36::  db $58, $58, $58, $58, $00, $01 
        db $00, $00, $00, $00, $00, $01 
A_38::  db $34, $34, $34, $34, $00, $01 
A_39::  db $48, $48, $48, $48, $02, $01 
A_40::  db $34, $34, $34, $34, $00, $01 
A_41::  db $4C, $4C, $4C, $4C, $03, $01 

B_0::   db $34, $34, $34, $34, $00, $01 
B_1::   db $38, $38, $38, $38, $00, $01 
B_2::   db $3C, $3C, $3C, $3C, $00, $01 
B_3::   db $40, $40, $40, $40, $00, $01 

