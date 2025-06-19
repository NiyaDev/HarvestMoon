
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

.unused:        ; 
  ld a, 11      ; This path should be unsused?
  call FUN_24C4 ; 
  ret           ; 

.is_two:
  ld a, 15
  call FUN_24C4

.is_one:
  ld a, 64
  call FUN_24CD
  ret

.is_three:
  ld a, 65
  call FUN_24CD
  ret


section "24c4", ROM0[$24C4]

; Call FUN_24CD 4 times
FUN_24C4::
  call FUN_24CD

; Call FUN_24CD 3 times
FUN_24C7::
  call FUN_24CD
  call FUN_24CD

; Takes $4001 + A*4 as a pointer to data in bank 4 and copys the data to WRAM
; [0] offset for WRAM
; [1] interation?
; [2-3] Pointer?
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
  add hl, hl    ; Multiply input A by 4
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

  ;; NOTE: It looks like the value sent is probably the same value rotated right
  inc hl        ; 
  ld a, [hl-]   ; Grabs next byte at offset+1 and ANDs with %00000011
  ld b, %11101110
  and 3         ; If result == 0, lab_250b with $EE
  jr z,.lab_250b; 

  ld b, %11011101
  cp 1          ; If result of AND == 1, lab_250b with $DD
  jr z,.lab_250b; 

  ld b, %10111011
  cp 2          ; If result of AND == 2, lab_250b with $BB
  jr z,.lab_250b; 

  ld b, %01110111; If result of AND == 3, lab_250b with $77

.lab_250b:
  ld a, [wD397] ; 
  and b         ; Get value and AND it with previous result
  ld [wD397], a ; 

.lab_2512:
  xor a         ; 
  ld [hl+], a   ; 
  ld a, [de]    ; 
  inc de        ; 
  ld [hl+], a   ; 
  ld a, [de]    ; Copy three values from DE to HL
  inc de        ; 
  ld [hl+], a   ; 
  ld a, [de]    ; 
  inc de        ; 
  ld [hl], a    ;
  
  push hl       ; 
  inc hl        ; 
  inc hl        ; 
  inc hl        ; 
  inc hl        ; Set offset+5 to $FF
  inc hl        ; 
  ld a, $FF     ; 
  ld [hl], a    ; 
  pop hl        ; 

  ld de, $0014  ; 
  add hl, de    ; Set offset+20 to 0
  xor a         ; 
  ld [hl], a    ; 

  pop af        ; Reset ROM bank
  ld [rROMB0_1], a

  ld a, [wD39E] ; Load value from WRAM and inc it
  inc a         ; 

  pop hl
  pop de
  pop bc
  ret





section "jmptbl_61_3fcd", ROM0[$3FCD]

jt_61::
; 
.lab_3FCD:
  ld a, 34
  jr .call_fun

; 
.lab_3FD1:
  ld a, 42
  jr .call_fun

; 
.lab_3FD5:
  ld a, 38
  jr .call_fun

; 
.lab_3FD9:
  ld a, 23
  jr .call_fun

; 
.lab_3FDD:
  ld a, 0
  jr .call_fun

; 
.lab_3FE1:
  ld a, 4
  jr .call_fun

; 
.lab_3FE5:
  ld a, 84
  jr .call_fun

; 
.lab_3FE9:
  ld a, 30
  jr .call_fun

; 
.lab_3FED:
  ld a, 27

; 
.call_fun:
  call FUN_24C4
.return:
  ret


; 
FUN_3FF3::
  ld a, 8
  call FUN_24C7
  ret



