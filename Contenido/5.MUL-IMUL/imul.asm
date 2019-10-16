;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o imul.o imul.asm -l imul.lst
;gcc -o imul.exe imul.o
segment .data

segment .bss

segment .text
global _main
_main:
	mov bl,-1
	mov al,10
	imul bl
	
	mov bx,4100
	mov ax,-1
	imul bx
	
	mov ebx,0x80000000
	mov eax,0x80000000
	imul ebx
	
	mov bl,0xFF
	mov al,0x01
	mul bl
	
	mov bl,0xFF
	mov al,0x01
	imul bl
ret






