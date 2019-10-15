segment .data
cadena	db	"PROGRAMACION ENSAMBLADOR",0

segment .bss

segment .text
global _main
_main:
	mov ebx,cadena
ciclo:
	mov al,[ebx]
	cmp al,0
	je finDeCadena
	cmp al,0x20
	je noConvertir
	;or al,0x20
	add al,0x20
noConvertir:
	mov [ebx],al
	inc ebx
	jmp ciclo
finDeCadena:
ret