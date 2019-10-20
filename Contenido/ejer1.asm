segment .data
n	dd	3
k	dd	3
segment .bss
prom	resd	1
segment .text
global _main
_main:
;((k*1)^3 + (k*2)^3 + (k*3)^3 + ... + (k*n)^3)/n
	mov ecx,[n]
	mov ebx,[k]
	mov esi,0
ciclo:
	mov eax,ebx
	mul ebx
	mul ebx
	add esi,eax
	add ebx,[k]
	loop ciclo
	mov eax,esi
	cdq
	div dword[n]
	mov [prom],eax
ret





