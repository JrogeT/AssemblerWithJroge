;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o skel.o skel.asm -l skel.lst
;gcc -o skel.exe skel.o
segment .data
;Variables inicializadas

segment .bss
;Variables NO inicializadas

segment .text
global _main
_main:
;Codigo
	mov eax,1
	mov ebx,1
ret
