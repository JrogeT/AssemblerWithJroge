;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o stack.o stack.asm -l stack.lst
;gcc -o stack.exe stack.o
segment .data
a 	dd	0x12345678
segment .bss

segment .text
global _main
_main:
	push dword[a]
	pop ebx
ret