segment .data
arreglo 	dd	2,5,7,3,10,-6

segment .bss
suma	resd	1

segment .text
global _main
_main:
;Suma de los numeros positivos en las posiciones impares de un arreglo
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





