;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o while.o while.asm -l while.lst
;gcc -o while.exe while.o
segment .data

segment .bss

segment .text
global _main
_main:

condicion:
    cmp eax,5           ;while(eax <=  5)
    jg salirDelCiclo    ;{

    

    jmp condicion       ;}
salirDelCiclo:
ret