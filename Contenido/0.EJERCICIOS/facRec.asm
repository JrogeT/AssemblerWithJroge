extern _printf,_scanf
segment .data
ms	db 10,"Introduzca n: ",0
msj	db 10,"El factorial es: %d",10,0
fmt db "%d",0

segment .bss
n	resd	1

segment .text
global _main
_main:
	push ms
	call _printf
	add esp,4

	push n
	push fmt
	call _scanf
	add esp,8
	
	push dword[n]
	call _fac
	add esp,4
	
	push eax
	push msj
	call _printf
	add esp,8
ret
;-------------------------------------------------
_fac:
push ebp
mov ebp,esp
	cmp dword[ebp+8],0
	je retOne
	mov ebx,[ebp+8]
	dec ebx
	push ebx
	call _fac
	mul dword[ebp+8]
	jmp finSub
retOne:
	mov eax,1
finSub:
mov esp,ebp
pop ebp
ret