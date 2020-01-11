extern _printf, _scanf
segment .data
msj1	db	"Introduzca su cadena: ",0
msjSI	db	"Si es correo valido",0
msjNO	db  "No es correo valido",0
fmt db	"%s",0

segment .bss
cadena	resb	50

segment .text
global _main
_main:
	push msj1
	call _printf
	add esp,4

	push cadena
	push fmt
	call _scanf
	add esp,8
	
	push cadena
	call mySub
	add esp,4
	
	cmp eax,1
	je mostrarSi
	
	push msjNO
	call _printf
	add esp,4
	jmp findelfin
	
mostrarSi:
	push msjSI
	call _printf
	add esp,4
findelfin:
ret






;----------------------------------------------------------------
mySub:
;Prologo
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
	xor edi,edi
	xor esi,esi
sgt:	
	mov dl,[ebx]
	cmp dl,0
	je finMySub
	inc ebx
	;Buscar arroba
	cmp dl,64
	je arrobaExiste
	cmp dl,0x2e
	je puntoExiste
	jmp sgt
puntoExiste:
	inc edi
	jmp sgt
arrobaExiste:
	inc esi
	jmp sgt
finMySub:
	cmp esi,0
	je noEsCorreo
	cmp edi,0
	je	noEsCorreo
	mov eax,1
	jmp fin
noEsCorreo:
	mov eax,0
fin:	
;Epilogo
mov esp,ebp
pop ebp
ret








