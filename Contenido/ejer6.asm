extern _printf, _scanf
segment .data
arreglo	db	1,2,3,4,5
segment .bss

segment .text
global _main
_main:
;Invertir un arreglo usando la pila
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








