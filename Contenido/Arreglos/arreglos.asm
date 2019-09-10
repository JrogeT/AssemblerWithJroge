;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o arreglos.o arreglos.asm -l arreglos.lst
;gcc -o arreglos.exe arreglos.o
segment .data
x	db	10	;00409000
y	db	20	;00409001
arr db 	1,2,3,4,5
ar2 dw 	1,2,3,4,5
ar3 dd 	1,2,3,4,5
z	db	0xFF;00409025

;T = Num bytes que tiene el tipo de dato del array
;arr db	1,	;00409002 + (i*T)
;		2,	;00409002 + (i*T)		
;		3,	;00409002 + (i*T)
;		4,	;00409002 + (i*T)
;		5   ;00409002 + (i*T)

;ar2 dw	1,	;00409007 + (0*2) = 00409007
;		2,	;00409007 + (1*2) = 00409009
;		3,	;00409007 + (2*2) = 0040900B
;		4,	;00409007 + (3*2) = 0040900D
;		5   ;00409007 + (4*2) = 0040900F
;			PARTE BAJA DEL 5  = 00409010  FIN DEL ARRAY

;ar3 dd	1,	;00409011		  = 00409011
;		2,	;00409011 + (1*4) = 00409015
;		3,	;00409011 + (2*4) = 00409019
;		4,	;00409011 + (3*4) = 0040901D
;		5   ;00409011 + (4*4) = 00409021
;			PARTE BAJA DEL 5  = 00409024  FIN DEL ARRAY

segment .bss

segment .text
global _main
_main:

ret