;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o for.o for.asm -l for.lst
;gcc -o for.exe for.o
segment .data

segment .bss

segment .text
global _main
_main:
    mov ecx,1       ;//Automatico por el for
condicion:    
    cmp ecx,5       ;for(int ecx=1;ecx<=5ecx++)
    jg salirDelFor  ;{

    inc ecx         ;//Automatico por el for
    jmp condicion   ;}
salirDelFor:
ret