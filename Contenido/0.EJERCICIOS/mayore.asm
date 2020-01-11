extern _printf,_scanf
segment .data
ms db "El mayor de todos es:%d en la pos:%d",10,0
ms2 db "El menor de todos es:%d en la pos:%d",0
fmt db "%d",0

segment .bss
arreglo	resd	15

segment .text
global _main
_main:
	mov ecx,15
	mov ebx,arreglo
ciclo:
	push ecx
	
	push ebx
	push fmt
	call _scanf
	add esp,8
	
	add ebx,4
	pop ecx
loop ciclo

	push arreglo
	call mySub
	add esp,4
	
	push edx
	push eax
	push ms
	call _printf
	add esp,12
	
	push arreglo
	call mySu2
	add esp,4
	
	push edx
	push eax
	push ms2
	call _printf
	add esp,12

ret








;-----------------------------------------------------------------------------
mySub:
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
	mov ecx,15
	mov eax,0x80000000
	mov esi,0
cicloSub:
	mov edi,[ebx]
	cmp edi,eax
	jg elMayorEsEDI
	jmp noPasaNada

elMayorEsEDI:
	mov eax,edi
	mov edx,esi
	jmp noPasaNada

noPasaNada:
	add ebx,4
	inc esi
	loop cicloSub
	
mov esp,ebp
pop ebp
ret



;------------------------------
mySub2:
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
	mov ecx,15
	mov eax,0x80000000
	mov esi,0
	push ecx
cicloSub2:
	mov edi,[ebx]
	cmp edi,eax
	jg elMayorEsEDI2
	jmp noPasaNada2

elMayorEsEDI2:
	mov eax,edi
	mov edx,esi
	jmp noPasaNada2

noPasaNada2:
	add ebx,4
	inc esi
	loop cicloSub2
	
mov esp,ebp
pop ebp
ret












