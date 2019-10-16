;Guardar el archivo
;path C:\Ensamblador\MinGW\bin
;nasm -f win32 -o jmp.o jmp.asm -l jmp.lst
;gcc -o jmp.exe jmp.o
segment .data
;Variables inicializadas

segment .bss
;Variables NO inicializadas

segment .text
global _main
_main:
	jmp etiqueta1	;SALTO AUTOMATICO
	mov eax,1
etiqueta1:
	mov eax,0
	sub eax,1
	jc et2			;SALTO SI C = 1
	mov ebx,1
et2:
	mov eax,1
	sub eax,1
	jz	et3			;SALTO SI Z = 1
	mov ecx,1
et3:		
	mov eax,1
	sub eax,2
	js et4			;SALTO SI S = 1
	mov edx,1
et4:
	;jnc			;SALTO SI C = 0
	;jnz			;SALTO SI Z = 0
	;jns			;SALTO SI S = 0

	mov ah,127
	add ah,1
	jo et5			;SALTO SI O = 1
	mov eax,1	
et5:
	;jno			;SALTO SI O = 0
ret