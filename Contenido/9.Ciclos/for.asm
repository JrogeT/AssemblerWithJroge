;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o for.o for.asm -l for.lst
;gcc -o for.exe for.o
segment .data

segment .bss

segment .text
global _main
_main:
    mov eax,5

    mov ecx,1       ;//Automatico por el for
condicion:    
    cmp ecx,eax     ;for(int ecx=1;ecx<=eax;ecx++)
    jg salirDelFor  ;{
    add eax,1           ;eax++;
    inc ecx         ;//Automatico por el for
    jmp condicion   ;}
salirDelFor:
ret