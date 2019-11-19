segment .data
a	dd	10
b	dd	20
segment .bss
c	resd	1
segment .text
global _main
_main:
	;c = suma(a,b);
	push dword[b]
	push dword[a]
	call mySub
	mov [c],eax
	add esp,8
ret
;----------------------------------------------------------------------
mySub:
	;prologo
	push ebp
	mov ebp,esp
	;prologo
		mov eax,[ebp+8]
		mov ebx,[ebp+12]
		add eax,ebx
	;epilogo
	mov esp,ebp
	pop ebp
	;epilogo
ret









