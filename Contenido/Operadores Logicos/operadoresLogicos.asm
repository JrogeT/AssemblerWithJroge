;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o operadoresLogicos.o operadoresLogicos.asm -l operadoresLogicos.lst
;gcc -o operadoresLogicos.exe operadoresLogicos.o
segment .data
x	db	1 
segment .bss

segment .text
global _main
_main:
	mov ah,[x]	;AH = 0000 0001 
	mov bh,2 	;BH = 0000 0010
	or ah,bh	;AH = 0000 0011
	mov bh,4    ;BH = 0000 0100
	and ah,bh   ;AH = 0000 0000
	xor bh,bh   ;BH = 0000 0000
	mov ah,3    ;AH = 0000 0011
	mov bh,[x]	;BH = 0000 0001
	xor bh,ah	;BH = 0000 0010
	not bh 		;BH = 1111 1101
	mov eax,0	;EAX = 0x0000 0000
	not eax 	;EAX = 0xFFFF FFFF = (-1)
	neg eax		;EAX = 0x0000 0001 = (+1)
ret





