;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o idiv.o idiv.asm -l idiv.lst
;gcc -o idiv.exe idiv.o
segment .data
myWord	dw 0xFFFD

segment .bss

segment .text
global _main
_main:
    mov ah,0xFF
    mov al,0xF6
    mov bl,0x0A
    idiv bl
    ;ERROR de ejemplo
    ; mov ah,0xF0
    ; mov al,0xF6
    ; mov bl,0x0A
    ; idiv bl

    mov dx,0xFFFF
    mov ax,0xEFFC
    idiv word[myWord]
    ;ERROR de ejemplo
    ; mov dx,0x3FDF
    ; mov ax,0xEFFC
    ; idiv word[myWord]

    mov ax,0xEFFC
    cwd
    idiv word[myWord]

    ; cbw     ;Convertir de Byte a Word
    ; cwd     ;Convertir de Word a Double
    ; cdq     ;Convertir de Double a Quad
ret