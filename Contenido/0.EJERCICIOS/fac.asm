extern _printf, _scanf
segment .data
cad1	db	10,10,"Introducir N: ",0
cad2	db	"El factorial es: %d",10,0
fmt		db	"%d",0
segment .bss
c	resd	1
n	resd	1
segment .text
global _main
_main:
	push cad1
	call _printf
	add esp,4
	
	push n
	push fmt
	call _scanf
	add esp,8
	
	;c = fac(n);
	push dword[n]
	call mySub
	mov [c],eax
	add esp,4
	
	push dword[c]
	push cad2
	call _printf
	add esp,8
ret
;----------------------------------------------------------------------
mySub:
	;prologo
	push ebp
	mov ebp,esp
	;prologo
		mov ecx,[ebp+8]
		mov eax,1
		ciclo:
			mul ecx
		loop ciclo
	;epilogo
	mov esp,ebp
	pop ebp
	;epilogo
ret









