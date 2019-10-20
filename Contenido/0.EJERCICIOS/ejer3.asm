segment .data
cadena	db	"PROGRAMACION ENSAMBLADOR",0

segment .bss

segment .text
global _main
_main:
;Convertir una cadena a minusculas
	mov ebx,cadena
ciclo:
	mov al,[ebx]
	cmp al,0
	je finDeCadena
	or al,0x20
	mov [ebx],al
	inc ebx
	jmp ciclo
finDeCadena:
ret