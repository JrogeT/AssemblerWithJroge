segment .data
cadena	db	"Hola",0
segment .bss
segment .text
global _main
_main:
	mov ebx,cadena
	mov ecx,0
ciclo:
	mov dl,[ebx]
	cmp dl,0
	je finDeCadena
	mov eax,0
	mov al,dl
	push eax	;EAX=0x0000 0041
	inc ebx
	inc ecx
	jmp ciclo
finDeCadena:
mov ebx,cadena
ciclo2:
	pop eax		;EAX=0x0000 0041
	mov [ebx],al
	inc ebx
	loop ciclo2
finDeCadena2:
ret