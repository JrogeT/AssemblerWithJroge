extern _printf,_scanf
segment .data
x 	db   10
x2  db	15

segment .bss
y	resd 	1

segment .text
global _main
_main:
	mov ah,[x]
	mov bh,[x2]
	mov [x],bh
	mov [x2],ah
ret





