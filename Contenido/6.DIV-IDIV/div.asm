;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o div.o div.asm -l div.lst
;gcc -o div.exe div.o
segment .data
myWord	dw 0x0104

segment .bss

segment .text
global _main
_main:
	mov ah,0x01
	mov al,0x05
	mov bl,0x1A
	div bl
	;ERROR de ejemplo
	; mov ah,0x1A
	; mov al,0x05
	; mov bl,0x1A
	; div bl

	mov dx,0x0010
	mov ax,0x4410
	div word[myWord]
	;ERROR de ejemplo
	; mov dx,0x0105
	; mov ax,0x4410
	; div word[myWord]
ret