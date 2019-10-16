segment .data
array	dd	2,6,7,99,102,1,0
;array2	= 2,33,34
segment .bss
array2 resd	100

segment .text
global _main
_main:
	mov ebx,array
	mov esi,array2
	mov ecx,7
ciclo:
	mov eax,[ebx]
	mov edi,3
	cdq
	div edi
	cmp edx,0
	jne noAgregar
		mov [esi],eax
		add esi,4
noAgregar:
	add ebx,4
	loop ciclo
ret



