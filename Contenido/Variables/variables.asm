;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o variables.o variables.asm -l variables.lst
;gcc -o variables.exe variables.o
segment .data
;Variables inicializadas int x = 10;
x	db	10
x2	dw	0x000a  	; 00 0a -> 0a 00
x3	db	0b1010
x4	dw	0x1234		; 12 34 -> 34 12
x5	dd	0x12345678	; -> 78 56 34 12
x6	dw	0x234		; 23 4  -> 4 23  MAL
					; 02 34 -> 34 02 BIEN 

segment .bss
;Variables NO inicializadas int y;
y	resb	1
y2	resd	3

segment .text
global _main
_main:
;Codigo
	mov eax,1
	mov ebx,1
ret





