segment .data
cadena	db	"Hola",0

segment .bss

segment .text
global _main
_main:
	mov ebx,cadena
ciclo:
	mov dl,[ebx]
	cmp dl,0
	je finDeCadena
	mov eax,0
	mov al,dl
	push eax	;EAX=0x0000 0041
	inc ebx
	jmp ciclo
finDeCadena:
mov ebx,cadena
ciclo2:
	mov dl,[ebx]
	cmp dl,0
	je finDeCadena2
	pop eax	;EAX=0x0000 0041
	mov [ebx],al
	inc ebx
	jmp ciclo2
finDeCadena2:
ret