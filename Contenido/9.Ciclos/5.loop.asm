;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o loop.o loop.asm -l loop.lst
;gcc -o loop.exe loop.o
segment .data

segment .bss

segment .text
global _main
_main:
    mov ecx,5   ;OJO: siempre tiene que ser el registro ECX
ciclo:
    
    loop ciclo  ;internamente:  dec ecx
                ;               jnz ciclo
ret