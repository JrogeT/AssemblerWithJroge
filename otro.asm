; Nombre :  Torrez Aramayo Jorge Rodrigo
; Registro : 217051367
extern _printf, _scanf
segment .data
titulo db 10,"Calculo del Maximo Comun Divisor de dos enteros",10,0
cada  db  10,"Ingresar un entero para a : ",0
cadb  db  "Ingresar un entero para b : ",0
cadfin db 10,"El maximo comun divisor de a=%d  y de b=%d   es  %d",10,0
fmt   db	"%d",0

segment .bss
a	resd	1
b	resd    1
mcd resd 	1
segment .text
global _main
_main:

	push titulo
	call _printf
	add esp,4
	
	push cada
	call _printf
	add esp,4
	
	push a
	push fmt
	call _scanf
	add esp,8
	
	push cadb
	call _printf
	add esp,4
	
	push b
	push fmt
	call _scanf
	add esp,8
	
	push dword[b]
	push dword[a]
	call _sub
	mov [mcd],eax
	add esp,8
	
	push dword[mcd]
	push dword[b]
	push dword[a]
	push cadfin
	call _printf
	add esp,16
ret
;----------------------------------------
_sub:
		push ebp
		mov ebp,esp
			mov eax,[ebp+8]
			mov ebx,[ebp+12]
		_ciclo:	
			cmp eax,ebx
			je _fin
			cmp eax,ebx
			jg _amayor
			sub ebx,eax
			jmp _rep
	_amayor:sub eax,ebx
	
	_rep:   jmp _ciclo
	
	_fin:   
		mov esp,ebp
		pop ebp
	ret