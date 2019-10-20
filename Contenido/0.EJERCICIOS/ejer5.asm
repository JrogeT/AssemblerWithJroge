segment .data
arreglo	dd	-1,2,-4,5,-7

segment .bss
prom	resd	1

segment .text
global _main
_main:
;Hallar el promedio de los elementos impares negativos de un arreglo
	mov ecx,5
	mov ebx,arreglo
	mov esi,0
	mov eax,0
ciclo:
	mov edi,[ebx]
	shl edi,1
	jnc noSirve
		;ES NEGATIVO
		mov edi,[ebx]
		shr edi,1
		jnc noSirve
			;ES IMPAR
			mov edi,[ebx]
			add esi,edi
			inc eax
noSirve:
	add ebx,4
	loop ciclo
	mov ebx,eax
	mov eax,esi
	cdq
	idiv ebx
	mov ecx,edx;IGNORAR
	mov ebx,edx;IGNORAR
	mov dword[prom],eax
ret






