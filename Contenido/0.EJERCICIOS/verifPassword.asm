;nasm -f win32 -o 
extern _printf,_scanf
segment .data
msj1	db	10,"Introduzca la contrasenha: ",0
correcto	db	"Contrasenha correcta",0
InCorrecto	db	"Contrasenha incorrecta",0
fmt		db	"%s",0
pswd	db	"abc",0

segment .bss
nuevaPaswd	resb	50

segment .text
global _main
_main:
	push msj1
	call _printf
	add esp,4
	
	push nuevaPaswd
	push fmt
	call _scanf
	add esp,8
	
	push nuevaPaswd
	push pswd
	call _verifPassword
	add esp,8
	
	cmp eax,1
	je mostrarCorrecto
	
	push InCorrecto
	call _printf
	add esp,4
	jmp miFin
	
mostrarCorrecto:
	push correcto
	call _printf
	add esp,4
	
miFin:
ret
;----------------------------------------------------------------------------------
_verifPassword:
push ebp
mov ebp,esp
sub esp,8
	mov ebx,10
	mov [ebp-4],ebx
	mov esi,[ebp+8]
	mov edi,[ebp+12]
	
nextChar:
	mov dl,[esi]
	mov dh,[edi]
	cmp dl,dh
	jne noEsLaPswd
	cmp dl,0
	je siDhEsO
	inc esi
	inc edi
	jmp nextChar
	
siDhEsO:
	cmp dh,0
	je siEsLaPswd
	jmp noEsLaPswd
	
noEsLaPswd:
	mov eax,0
	jmp fuera
	
siEsLaPswd:
	mov eax,1
fuera:
mov esp,ebp
pop ebp
ret











