;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o variables.o variables.asm -l variables.lst
;gcc -o variables.exe variables.o
segment .data
;Variables inicializadas int x = 10;
x	db	10

segment .bss
;Variables NO inicializadas int y;
y	resb	1

segment .text
global _main
_main:
;Codigo
	mov eax,1
	mov ebx,1
ret