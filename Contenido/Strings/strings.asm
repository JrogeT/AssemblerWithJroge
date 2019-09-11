;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o strings.o strings.asm -l strings.lst
;gcc -o strings.exe strings.o
segment .data
cadena	db	"Mensaje",0
caden2  db  'Mensaje',0
caden3  db  'M','e','n','s','a','j','e',0
caden4  db  "M","e","n","s","a","j","e",0
caden5  db  'Me','n','s','aje',0

;cadena db	M,	;00409000 + (i)
;			e,	;00409000 + (i)
;			n,	;00409000 + (i)
;			s,	;00409000 + (i)
;			a,  ;00409000 + (i)
;			j,  ;00409000 + (i)
;			e,  ;00409000 + (i)
;			0   ;00409000 + (i)

segment .bss

segment .text
global _main
_main:
	;MAYUSCULAS
	mov al,[cadena+4]	;a = 0x61
	mov bl,[caden2+6]	;e = 0x65
	and al,0xDF
	and bl,0xDF
	mov [cadena+4],al	;A = 0x41
	mov [caden2+6],bl	;E = 0x45
	;MINUSCULAS
	mov al,[cadena+4]	;A = 0x41
	mov bl,[caden2+6]	;E = 0x45
	or al,0x20
	or bl,0x20
	mov [cadena+4],al	;a = 0x61
	mov [caden2+6],bl	;e = 0x65
ret




