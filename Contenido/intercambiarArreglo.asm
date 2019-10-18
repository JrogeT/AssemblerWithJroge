extern _printf, _scanf
segment .data
cadena	db	10,"Hola",10,0
arreglo	db	1,2,0,3,4,5
cadena2 db	"Chau"
segment .bss

segment .text
global _main
_main:
	
	mov ecx,5
	mov ebx,0
	xor eax,eax
ciclo:
	mov al,[arreglo+ebx]
	push eax
	inc ebx
loop ciclo

	mov ecx,5
	mov ebx,0
ciclo2:
	pop eax
	mov byte[arreglo+ebx],al
	inc ebx
loop ciclo2

	push cadena
	call _printf
	add esp,4
ret








