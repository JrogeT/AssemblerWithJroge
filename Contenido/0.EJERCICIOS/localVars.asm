extern _printf,_scanf
segment .data
msj		db	"numero: %d",0

segment .bss

segment .text
global _main
_main:
mov eax,1
push eax
call _sub
add esp,4

push eax
push msj
call _printf
add esp,8
ret
;---------------------------------------------------------------------------------------------------
_sub:
push ebp
mov ebp,esp
	sub esp,8
	mov [ebp-4],4
	mov eax,[ebp-8]
mov esp,ebp
pop ebp
ret