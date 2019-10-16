;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o mul.o mul.asm -l mul.lst
;gcc -o mul.exe mul.o
segment .data

segment .bss

segment .text
global _main
_main:
	mov bl,26
	mov al,10
	mul bl
	
	mov bx,4100
	mov ax,260
	mul bx
	
	mov ebx,0x80000000
	mov eax,0x80000000
	mul ebx
ret






