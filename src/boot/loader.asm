bits 16
org 0x7c00

main:
  mov ah, 0x0e
  mov al, 'k'
  mov bh, 0
  int 0x10

halt:
  hlt
  jmp halt

pad: 
  times 510-($-$$) db 0

sig:
  dw 0xaa55