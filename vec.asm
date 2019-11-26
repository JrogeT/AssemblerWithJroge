extern _printf, _scanf
segment .data
msj	db	"Introducir N: ",0
msj2	db	"Ingrese v[%d]: ",0
fmt	db	"%d",0

segment .bss
n	resd	1
array	resd	50

segment .text
global _main
_main:
push msj
call _printf
add esp,4

push n
push fmt
call _scanf
add esp,8

mov ecx,[n]
mov ebx,array
mov eax,0
ciclo:
	push ecx
	push eax
	
	push eax
	push msj2
	call _printf	;eax,ecx,edx
	add esp,8
	
	push ebx
	push fmt
	call _scanf		;eax,ecx
	add esp,8
	
	pop eax
	inc eax
	add ebx,4
	pop ecx
loop ciclo
ret





