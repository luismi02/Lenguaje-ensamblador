Section .data

msjTecla: db 'Presione una tecla '
length: equ $-msjTecla
alfa: db 'Caracter alfabetico', 0Ah
lenAlfa: equ $-alfa
num: db 'Number', 0Ah
lNum: equ $-num
especial: db 'Tecla especial', 0Ah
lenEspe: equ $-especial
  
Section .bss
res: resb 1

Section .text
global _start

_start:

;Mensaje ingrese tecla
mov eax, 4
mov ebx, 1
mov ecx, msjTecla
mov edx, length
int 80h

mov eax, 3
mov ebx, 0
mov ecx, res
mov edx, 1
int 80h

cmp byte[res], 'A'-1
jng alfabeto
cmp byte[res], 'Z'+1
jnl alfabeto
jmp imprimir

alfabeto:
cmp byte[res], 'a'-1
jng crEspecial
cmp byte[res], 'z'+1
jnl crEspecial
jmp imprimir

imprimir:
mov eax, 4
mov ebx, 1
mov ecx, alfa
mov edx, lenAlfa
int 80h
jmp salir

crEspecial:
cmp byte[res], '0'-1
jng imprimirEspecial
cmp byte[res], '9'+1
jnl imprimirEspecial
jmp imprimirNum

imprimirNum:
mov eax, 4
mov ebx, 1
mov ecx, num
mov edx, lNum
int 80h
jmp salir

imprimirEspecial:
mov eax, 4
mov ebx, 1
mov ecx, especial
mov edx, lenEspe
int 80h
jmp salir

salir:
mov eax, 1
mov ebx, 0
int 80h 