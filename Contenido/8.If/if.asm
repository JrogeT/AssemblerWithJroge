;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o if.o if.asm -l if.lst
;gcc -o if.exe if.o
segment .data

segment .bss

segment .text
global _main
_main:
	mov al,6
	mov bl,5

	;CONDICIONES CON SIGNO Y SIN SIGNO
	; cmp al,bl
	; jz et1				;if(al==bl){saltar a et1}

	; cmp al,bl
	; jnz et1				;if(al!=bl){saltar a et1}

	;PRUEBA DE NUMEROS CS Y SS
	; mov al,0x00	;SS al=0	CS al=0
	; mov bl,0xFF	;SS bl=255	CS bl=-1
	; cmp al,bl
	; jg et1			;if(al>bl){saltar a et1}
	
	;CONDICIONES SIN SIGNO
	; cmp al,bl
	; ja et1   	;if(al>bl){saltar a et1}

	; cmp al,bl
	; jae et1		;if(al>=bl){saltar a et1}

	; cmp al,bl
	; jb et1   	;if(al<bl){saltar a et1}

	; cmp al,bl
	; jbe et1		;if(al<=bl){saltar a et1}

	;CONDICIONES CON SIGNO
	; cmp al,bl
	; jg et1			;if(al>bl){saltar a et1}
	
	; cmp al,bl
	; jge et1			;if(al>=bl){saltar a et1}

	; cmp al,bl
	; jl et1			;if(al<bl){saltar a et1}
	
	; cmp al,bl
	; jle et1			;if(al<=bl){saltar a et1}

	mov ecx,-1
et1:
	mov ecx,1
ret