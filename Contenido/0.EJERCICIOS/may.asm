extern _printf, _scanf
segment .data
msj1	db	"Introduzca su cadenita: ",0
fmt		db	"%s",0
msjSI   db  "Existe una mayuscula!",0
msjNO   db  "No existe ninguna mayuscula :(",0

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
	call buscarMayuscula
	add esp,4
	
	cmp eax,1
	je siHabiaMayuscula
	jmp noHabiaMayuscula
	
siHabiaMayuscula:
	push msjSI
	call _printf
	add esp,4
	jmp miFin2
	
noHabiaMayuscula:
	push msjNO
	call _printf
	add esp,4
miFin2:
ret


















;-----------------------------------------------------------------------
buscarMayuscula:
;Prologo
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
	
	push ebx
	call miLongCad
	add esp,4
	
	mov ecx,eax
	mov ebx,[ebp+8]
ciclo:
	mov dl,[ebx]
	cmp dl,64
	je esMayuscula
	inc ebx
	loop ciclo
	
	mov eax,0
	jmp miFin
esMayuscula:
	mov eax,1
miFin:
;Epilogo
mov esp,ebp
pop ebp
ret

miLongCad:
;Prologo
push ebp
mov ebp,esp
	mov ebx,[ebp+8]
	mov eax,0
repetir:
	mov dl,[ebx]
	cmp dl,0
	je fin
	inc eax
	inc ebx
	jmp repetir
	fin:
;Epilogo
mov esp,ebp
pop ebp
ret













