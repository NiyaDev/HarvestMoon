
section "send_sgb_packet", rom0[$22E8]

send_sgb_packet::
; Check number of packets
  ld a,[hl]
  and 7
  ret z

; Store number in b
  ld b,a
  ld c,0
.loop::
  push bc

; Send Reset signal
  ld a,SGB_RES
  ldh [c],a
; Send End signal
  ld a,$30
  ldh [c],a

; Packet length
  ld b,16
.next_byte::
  ld e,8
; Get next bit in packet
  ld a,[hl+]
  ld d,a

.next_bit::
  bit 0,d
; If bit is not zero send Low
  ld a,SGB_LOW
  jr nz,.next

; If bit is zero send High
  ld a,SGB_HIG
.next::
  ldh [c],a
; Send end after every pulse
  ld a,SGB_END
  ldh [c],a

; Get next bit
  rr d
  dec e
  jr nz,.next_bit

; Get next Byte
  dec b
  jr nz,.next_byte

; Send Stop signal
  ld a,SGB_HIG
  ldh [c],a
  ld a,SGB_END
  ldh [c],a

; Break if no more packets
  pop bc
  dec b
  ret z

; Wait 1 frame
  call wait_7000
  jr .loop



section "wait_7000", rom0[$231E]

; Way out of wait function
  ld a,[wDD00]
  or a
  ret z

wait_7000::
; Loops 7000 times
; or 10 * 7000 = 70,000 cycles
; or ~0.02 seconds
; or ~1 frame
  ld de,7000
.loop
  nop
  nop
  nop

  dec de
  ld a,d
  or e
  jr nz,.loop

  ret



section "check_if_sgb", rom0[$232F]

check_if_sgb::
; Checks if currently running in a SGB by requesting multiple controllers

; Sends MLT2 packet
  ld hl,MLT2_PACKET
  call send_sgb_packet
  call wait_7000

; Check if player number is not 4 or 
  ldh a,[rP1]
  and 3
  cp 3
  jr nz,.ret_true

; Send High signal
  ld a,SGB_HIG
  ldh [rP1],a
  ldh a,[rP1]
  ldh a,[rP1]
  call wait_7000

; Send End signal
  ld a,SGB_END
  ldh [rP1],a
  call wait_7000

; Send Low signal
  ld a,SGB_LOW
  ldh [rP1],a
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  call wait_7000

; Send End signal
  ld a,SGB_END
  ldh [rP1],a
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  call wait_7000
  ldh a,[rP1]
  and 3
  cp 3
  jr nz,.ret_true

; Sends MLT1 packet
  ld hl,MLT1_PACKET
  call send_sgb_packet
  call wait_7000
  sub a
  ret

.ret_true::
; Sends MLT1 packet 
  ld hl,MLT1_PACKET
  call send_sgb_packet
  call wait_7000

; Return true
  scf
  ret

MLT1_PACKET::
  db MLT_REQ * 8 + 1
  db 0
  ds 14
MLT2_PACKET::
  db MLT_REQ * 8 + 1
  db 1
  ds 14

