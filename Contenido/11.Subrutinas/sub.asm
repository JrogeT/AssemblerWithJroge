;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o sub.o sub.asm -l sub.lst
;gcc -o sub.exe sub.o
segment .data
;Variables inicializadas
n	dd	2

segment .bss
;Variables NO inicializadas

segment .text
global _main
_main:
	;call subR=	push eip
	;			jmp subR
	push dword[n]
	call numeroPorDos
	mov ebx,eax
	add esp,4
	;add esp,(cantidad de pushes)*4
ret













;--------------------SUBRUTINAS------------------
;Crear una subrutina para retornar el numero 5
;public int numeroCinco(){
;	return 5;
;}
numeroCinco:
;prologo:
push ebp
mov ebp,esp

	mov eax,5

;epilogo:
mov esp,ebp
pop ebp
ret	;pop eip

;Crear una subrutina para retornar el valor de n*2
;public int numeroPorDos(int n){
;	return n*2;
;}
numeroPorDos:
;Prologo
push ebp
mov ebp,esp
	
	mov eax,[ebp+8]
	mov ebx,2
	mul ebx
	;eax=0x0000 0004
	
;Epilogo
mov esp,ebp
pop ebp
ret









