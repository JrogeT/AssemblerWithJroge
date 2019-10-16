;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o loop.o loop.asm -l loop.lst
;gcc -o loop.exe loop.o
segment .data

segment .bss

segment .text
global _main
_main:
    mov eax,1
    mov ecx,5
ciclo:
    ;Esto se repetirá ecx veces
    inc eax
    
    loop ciclo
ret