segment .data
array	dd	2,6,7,99,102,1,0

segment .bss
array2 resd	100

segment .text
global _main
_main:
;De un arreglo A, crear un arreglo B  de tal manera que cada elemento
;del arreglo B es la division entera de n / 3, 
;donde n pertenece a A y n es multiplo de 3
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



