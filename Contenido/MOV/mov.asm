;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o mov.o mov.asm -l mov.lst
;gcc -o mov.exe mov.o
segment .data
variable1	db	20 
;variable1	dw	256 ;0x0100 -> 00 01

segment .bss
variable2	resb	1

segment .text
global _main
_main:
	;mover a AH lo que hay en variable1
	mov ah,[variable1] 	;mem -> reg

	;mover a variable2 lo que hay en AH	
	mov [variable2],ah 	;reg -> mem

	;mover a BH lo que hay en AH
	mov bh,ah			;reg -> reg
	
	;mover a variable2 lo que hay en variable1
	;mov word[variable2],word[variable1]; NO EXISTE
ret







