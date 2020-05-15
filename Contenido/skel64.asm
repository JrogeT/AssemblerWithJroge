;Guardar el archivo
;path C:/Ensamblador/MinGW64/bin
;nasm -f win64 -o skel64.o skel64.asm -l skel64.lst
;gcc -o skel64.exe skel64.o
segment .data

segment .bss

segment .text
global main
main:

ret
