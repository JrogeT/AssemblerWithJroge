extern _printf,_scanf
segment .data

segment .bss

segment .text
global _main
_main:
mov eax,1
push eax
call _sub
add esp,4

ret