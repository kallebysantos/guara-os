%DEFINE ORIGIN_SECTOR 0x7c00
%DEFINE OK_RESULT 0xaa55
; INTs
%DEFINE DisplayStr 0x1301 ; AX INT - Display String and Update Cursor
%DEFINE DisplayReset 0x03 ; AX INT - Set VGA Video Mode
%DEFINE UpdateVideo 0x10 ; Set Video Mode
%DEFINE TextGreen 0x02 ; BX INT

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

    clear_screen:
        mov ax, DisplayReset 
        int UpdateVideo 
    
    print:
        mov ax, DisplayStr 
        mov bx, 0x02
        mov cx, padding - data
        mov bp, data
        int UpdateVideo

    ; Parada de CPU
    halt:
        cli
        hlt
    
    data:
        db "Hello World!"

    ; Padding dos bytes restantes
    padding: 
        times 510-($-$$) db 0

    ; Retorno OK para BIOS
    return:
        dw OK_RESULT 
