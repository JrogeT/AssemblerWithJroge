;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o shifts-ro.o shifts-ro.asm -l shifts-ro.lst
;gcc -o shifts-ro.exe shifts-ro.o
segment .data

segment .bss

segment .text
global _main
_main:	
	mov al,0x09
	shr al,1
	;al=9/(2^1)=9/2=4
	;NUMEROS IMPARES
	;C=1

	mov al,0x04
	shr al,1
	;al=9/(2^1)=9/2=4
	;NUMEROS PARES
	;C=0
	
	mov al,0x01	;0000 0001
	ror al,1
				;1000 0000
	rol al,2
				;0000 0010
ret








