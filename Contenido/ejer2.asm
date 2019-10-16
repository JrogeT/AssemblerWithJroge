segment .data
arreglo 	dd	2,5,7,3,10,-6
;suma= 5 + 3 + 10 = 18 = 0x12
segment .bss
suma	resd	1

segment .text
global _main
_main:
	mov ebx,arreglo
	inc ebx
	mov ecx,3
ciclo:
	mov eax,[ebx]
	cmp eax,0
	jl	noSumar
		add [suma],eax
noSumar:
	add ebx,2
	loop ciclo
ret





