extern _printf, _scanf
segment .data
m1	db	"Introduzca el valor de A: ",0
m2	db	"Introduzca el valor de B: ",0
m3	db	"Introduzca el valor de C: ",0
m4	db	"Ups! Division entre cero! :(",0
m5	db	"A=%d B=%d C=%d y D=%d",0
fmt	db	"%d",0

segment .bss
a	resd	1
b	resd	1
c	resd	1
d	resd	1

segment .text
global _main
_main:
	push m1
	call _printf
	add esp,4
	
	push a
	push fmt
	call _scanf
	add esp,8
	
	push m2
	call _printf
	add esp,4
	
	push b
	push fmt
	call _scanf
	add esp,8
	
	push m3
	call _printf
	add esp,4
	
	push c
	push fmt
	call _scanf
	add esp,8
	
	push dword[c]
	push dword[b]
	push dword[a]
	call mySub
	add esp,12
	
	cmp ebx,-1
	je mostrarError
	
	mov [d],eax
	push dword[d]
	push dword[c]
	push dword[b]
	push dword[a]
	push m5
	call _printf
	add esp,20
	
	jmp finMain
	
mostrarError:
	push m4
	call _printf
	add esp,4
finMain:
ret






;----------------------------------------------------------------------------
mySub:
push ebp
mov ebp,esp
	mov esi,[ebp+8]
	sal esi,3
	
	mov eax,[ebp+12]
	neg eax
	mov ebx,8
	imul ebx
	mov edi,eax
	
	and esi,edi
	
	mov edi,[ebp+12]
	sub edi,[ebp+16]
	xor edi,3
	
	cmp edi,0
	je unError
	
	mov eax,esi
	cdq
	idiv edi
	mov ebx,0
	jmp finSub
unError:
	mov ebx,-1
finSub:
mov esp,ebp
pop ebp
ret













