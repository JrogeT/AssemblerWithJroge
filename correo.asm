extern _printf, _scanf
segment .data
msj1	db	"Introduzca su cadenita: ",0
fmt		db	"%s",0
msjSI   db  "Correo valido",0
msjNO   db  "Correo no valido :(",0

segment .bss
cadenita	resb	50

segment .text
global _main
_main:
	push msj1
	call _printf
	add esp,4
	
	push cadenita
	push fmt
	call _scanf
	add esp,8
	
	push cadenita
	call verificarCorreo
	add esp,4
	
	cmp eax,1
	je siEsCorreo
	jmp noEsCorreo
	
siEsCorreo:
	push msjSI
	call _printf
	add esp,4
	jmp miFin2
	
noEsCorreo:
	push msjNO
	call _printf
	add esp,4
miFin2:
ret

;-----------------------------------------------------------------------
verificarCorreo:
;Prologo
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
repetir:
	mov dl,[ebx]
	cmp dl,0
	je finDelCiclo

	cmp dl,64
	je	hayArroba
	inc ebx
	jmp repetir

	mov eax,0
	jmp finDelCiclo
hayArroba:
	mov eax,1
finDelCiclo:
;Epilogo
mov esp,ebp
pop ebp
ret














