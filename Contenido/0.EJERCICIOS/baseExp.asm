extern _printf,_scanf
segment .data
msj1	db	"Introduzca a: ",0
msj2	db	"Introduzca b: ",0
msj12	db	"El resultado es: %d",0
fmt db "%d",0

segment .bss
a	resd	1
b	resd	1

segment .text
global _main
_main:
	push msj1
	call _printf
	add esp,4
	push a
	push fmt
	call _scanf
	add esp,8
	push msj2
	call _printf
	add esp,4
	push b
	push fmt
	call _scanf
	add esp,8
	push dword[a]
	push dword[b]
	call miSub
	add esp,8
	push eax
	push msj12
	call _printf
	add esp,8
ret
;-----------------------------------------------------------------------
miSub:
push ebp
mov ebp,esp
	mov ecx,[ebp+8]
	mov esi,[ebp+12]
	mov eax,1
	cmp ecx,0
	jle Cero	;Verificar exponente negativo o cero
ciclo:imul esi
loop ciclo
Cero:
mov esp,ebp
pop ebp
ret














