%DEFINE ORIGIN_SECTOR 0x7c00
%DEFINE OK_RESULT 0xaa55

; Display INTs
%DEFINE DisplayChar 0x0e ; AH INT - Display a char 
%DEFINE DisplayStr 0x1301 ; AX INT - Display String and Update Cursor
%DEFINE DisplayReset 0x03 ; AX INT - Set VGA Video Mode
%DEFINE UpdateVideo 0x10 ; Set Video Mode
%DEFINE TextGreen 0x02 ; BX INT

; Timer INTs
%DEFINE WaitTime 0x8600 ; AH INT - Wait
%DEFINE SecondUnitCX 0x0f ; CX INT - 1 second
%DEFINE SecondUnitDX 0x4240 ; DX INT - 1 second
%DEFINE Time 0x15 ; Set Timer

; Keyboad INTs
%DEFINE ReadKey 0x0000 ; AX INT - Read Key
%DEFINE Keyboard 0x16 ; Keyboard services

; Keyboard Utils
% KeyENTER 0x0d ; ASCII CR

bits 16
org ORIGIN_SECTOR 

main:
    clean_up:
        xor ax, ax
        mov ds, ax
        mov es, ax

    init_stack:
        mov ss, ax
        mov sp, ORIGIN_SECTOR
    
    waiting:
        mov ax, WaitTime
        mov cx, SecondUnitCX
        mov dx, SecondUnitDX
        INT Time
        
        mov cx, 0 ; Limpa o CX
        mov dx, 0 ; Limpa DX

    clear_screen:
       mov ax, DisplayReset 
       INT UpdateVideo 
   
    ask_for_name:
        mov ax, DisplayStr 
        mov bx, TextGreen
        mov cx, padding - data
        mov bp, data
        INT UpdateVideo

    read_name:
        mov ax, ReadKey
        INT Keyboard
        
        ; Para de ler caso pressione ENTER
        cmp al, KeyENTER
        je halt
        
        ; Exibe o char digitado na tela
        mov ah, DisplayChar
        INT UpdateVideo
        jmp read_name

    ; Parada de CPU
    halt:
        cli
        hlt

    data:
        db "Digite seu nome: ", 0

    ; Padding dos bytes restantes
    padding: 
        times 510-($-$$) db 0

    ; Retorno OK para BIOS
    return:
        dw OK_RESULT 
