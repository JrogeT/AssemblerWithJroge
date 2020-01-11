segment .data
msj1	db "Introduzca cad: ",0
msj2	db "Introduzca sub: ",0
fmt		db	"%s",0
segment .bss
cad		resb	50
subc	resb	50

segment .text
global _main
_main:
	push msj1
	call _printf
	add esp,4
	
	push cad
	push fmt
	call _scanf
	add esp,8
	
	push msj2
	call _printf
	add esp,4
	
	push subc
	push fmt
	call _scanf
	add esp,8
	
	push cad
	push subc
	call mySub
	add esp,8
ret









;---------------------------------------------------------------
mySub:
push ebp
mov ebp,esp
	mov ebx,[ebp+12]
	mov edx,[ebp+8]
cicloCadena:
	mov dl,[ebx]
	mov dh,[edx]
	cmp dl,0
	je finalizaYNoExist
	cmp dl,dh
	jne sgtCaract
cicloIguales:
	inc ebx
	inc edx
	mov dh,[edx]
	mov dl,[ebx]
	cmp dh,0
	je	finalizaYExist
	cmp dl,0
	je finalizaYNoExist
	cmp dl,dh
	jne noEsSub
	;Si son iguales
	jmp cicloIguales
sgtCaract:
	inc ebx
	jmp cicloCadena
noEsSub:
	mov edx,[ebp+8]
	jmp cicloCadena
mov esp,ebp
pop ebp
ret









