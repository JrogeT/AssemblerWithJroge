;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o add-sub.o add-sub.asm -l add-sub.lst
;gcc -o add-sub.exe add-sub.o
segment .data
;Variables inicializadas

segment .bss
;Variables NO inicializadas

segment .text
global _main
_main:
    mov eax,1
    add eax,10 ; eax = eax + 10

    mov ah,0xff
    add ah,1

    sub al,ah
    sub al,1

    sub ah,1

    adc al,1

    mov ah,0
    sub ah,1

    sbb al,1
ret