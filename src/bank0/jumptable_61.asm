
section "jmptbl_61_0f9d", ROM0[$0F9D]

; Reads a byte from SRAM and calls different functions based on the value
FUN_0F9D::
  call FUN_2426
  
  ld a,[sB8A0]   ; Get Value

  cp 1           ; Value is 1
  jr z,.is_one   ; 

  cp 3           ; Value is 3
  jr z,.is_three ; 

  cp 0           ; Value is 0
  jr z,.is_zero  ; 

  cp 1           ; Value is 1
  jr z,.unused   ; This path should never be taken

  cp 2           ; Value is 2
  jr z,.is_two   ; 

  ld a, 19       ; Value is > 3
  call FUN_24C4  ; 

  ret

.is_zero:
  ld a, 8
  call FUN_24C7
  ret

.unused:        ; This path should never be taken
  ld a, 11      ; 
  call FUN_24C4 ; 
  ret           ; 

.is_two:
  ld a, 15
  call FUN_24C4

.is_one:
  ld a, $40
  call FUN_24CD
  ret

.is_three:
  ld a, $41
  call FUN_24CD
  ret


section "24c4", ROM0[$24C4]
FUN_24C4::
  call FUN_24CD

section "24c7", ROM0[$24C7]
FUN_24C7::
  call FUN_24CD
  call FUN_24CD

section "24cd", ROM0[$24CD]

; 
FUN_24CD::
  push bc
  push de
  push hl

  ld [wD39E],a
  ld l, a

  ld a, [rRAMB] ; Save RAM bank
  push af       ; 

  ld a, 30      ; Load bank 30
  ld [rROMB0_1], a

  ld h, 0       ; 
  add hl, hl    ; Multiply input A by 2
  add hl, hl    ; 
  
  ld de, $4001  ; 
  add hl, de    ; Add result as offest to the current bank data
  push hl       ; 
  pop de        ; 

  ld a, [de]    ; 
  inc de        ; 
  ld c, a       ; Use the first byte at offset to offset pointer to
  ld b, 0       ; second section of WRAM
  ld hl, $D300  ; 
  add hl, bc    ; 

  ld a, [hl]    ; Grabs byte at WRAM offset and compares it to $FF
  cp $FF        ; If it is, jump
  jr z,.lab_2512; 

  inc hl        ; 
  ld a, [hl-]   ; 
  ld b, $EE     ; 
  and 3         ; 
  jr z,.lab_250b; 

  ld b, $DD
  cp 1
  jr z,.lab_250b

  ld b, $BB
  cp 2
  jr z,.lab_250b

  ld b, $77

.lab_250b:
  ld a, [wD397]
  and B
  ld [wD397], a

.lab_2512:
  xor a
  ld [hl+], a
  ld a, [de]
  inc de

  ld [hl+], a
  ld a, [de]
  inc de

  ld [hl+], a
  ld a, [de]
  inc de

  ld [hl], a
  
  push hl
  inc hl
  inc hl
  inc hl
  inc hl
  inc hl

  ld a, $FF
  ld [hl], a
  pop hl

  ld de, $0014
  add hl, de
  xor a
  ld [hl], a
  pop af

  ld [rROMB0_1], a
  ld a, [wD39E]
  inc a

  pop hl
  pop de
  pop bc
  ret





section "jmptbl_61_3fcd", ROM0[$3FCD]

; 
FUN_3FCD::
  ld a,$22
  jr FUN_3FEF


section "jmptbl_61_3fd1", ROM0[$3FD1]

; 
FUN_3FD1::
  ld a, $2A
  jr FUN_3FEF


section "jmptbl_61_3fd5", ROM0[$3FD5]

; 
FUN_3FD5::
  ld a, $26
  jr FUN_3FEF


section "jmptbl_61_3fd9", ROM0[$3FD9]

; 
FUN_3FD9::
  ld a, $17
  jr FUN_3FEF


section "jmptbl_61_3fdd", ROM0[$3FDD]

; 
FUN_3FDD::
  ld a, 0
  jr FUN_3FEF


section "jmptbl_61_3fe1", ROM0[$3FE1]

; 
FUN_3FE1::
  ld a,4
  jr FUN_3FEF


section "jmptbl_61_3fe5", ROM0[$3FE5]

; 
FUN_3FE5::
  ld a, $54
  jr FUN_3FEF


section "3fe9", ROM0[$3FE9]

; 
FUN_3FE9::
  ld a, $1E
  jr FUN_3FEF


section "3fed", ROM0[$3FED]

; 
FUN_3FED::
  ld a, $1B


section "3fef", ROM0[$3FEF]

; 
FUN_3FEF::
  call FUN_24C4


section "jmptbl_61_3ff2", ROM0[$3FF2]

; Returns
FUN_3FF2::
  ret




